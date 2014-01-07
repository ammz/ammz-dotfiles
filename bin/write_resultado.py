#!/usr/bin/env python
# -*- coding: utf-8 -*-

from xml.etree import ElementTree as ET
import sys
import os

# Directorio que contiene los xml a tratar
path = sys.argv[1]
print "\n" + path + "\n"


def enumerarutas(path=path):
    """Devuelve una lista con las rutas de todos los ficheros en un directorio

    Arguments:
    - `path`:
    """
    rutas_ficheros = []
    for dirpath, dirnames, filenames in os.walk(path):
        for file in filenames:
            fullpath = os.path.join(dirpath, file)
            rutas_ficheros.append(fullpath)
    return rutas_ficheros


def enumeraficheros(path=path):
    """Devuelve una lista con las rutas de todos los ficheros en un directorio

    Arguments:
    - `path`:
    """

    nombres_ficheros = []
    for dirpath, dirnames, filenames in os.walk(path):
        for file in filenames:
            nombres_ficheros = file
    return nombres_ficheros


def procesa_xml(fichero):
    """Procesa cada fichero xml y devuelve un diccionario con los campos seleccionados

    Arguments:
    - `fichero`:
    """
    print "Procesando fichero: %s" % fichero
    
    parser = ET.XMLParser(encoding="utf-8")

    e = ET.parse(fichero)

    datos = {'Referencia Interna': './header/reference_nr',
             'Marca': './object/characteristics/mmt/make/description',
             'Año': './object/characteristics/manufactured/year',
             'Cambio': './object/characteristics/gears/operation',
             'Combustible': './object/characteristics/fuel',
             'Modelo': './object/characteristics/mmt/model/description',
             'Versión': './object/characteristics/mmt/type/description',
             'Versión única (mes)': './object/characteristics/manufactured/month',
             'Seminuevo': './object',
             'Km': './object/status/totalmileage/value',
             'Matrícula': './object/identification',
             'Color exterior': './object/characteristics/exterior_colour',
             'Carrocería / Nº puertas': './object/characteristics/doors',
             'Potencia (CV)': './object/characteristics/engine/power/hp',
             'Precio': './agreement/fixedPriceForPortal/amount',
             'Precio profesional': './agreement/bookvalue/amount?',
             'Extras': './object/accessories/accessory/description',
             'Rutas Imágenes': './object/pictures/picture',
             'Garantía': './object',
             'Financiación': './object',
             'Date': './header/date',
             'Time': './header/time',
             'Acción': './header/actiontype',
    }

    record = {}
    extras = []

    for key, value in datos.items():
        if key == 'Extras':
            for d in e.findall(value):
                extras.append(d.text)
            record[key] = extras
        else:
            record[key] = e.findtext(value)

    row = '<tr><td style="border: 1px solid; background-color: #ccc;">%s:</td><td style="border: 1px solid;">%s</td></tr>'

    for key, value in datos.items():
        if key == "Acción":
            vaccion = (row)  % (key, e.findtext(value))
        if key == "Referencia Interna":
            vreferencia = (row)  % (key, e.findtext(value))
            rreferencia = e.findtext(value)
        if key == "Marca":
            vmarca = (row)  % (key, e.findtext(value))
        elif key == "Año":
            vyear = (row)  % (key, e.findtext(value))
        elif key == "Cambio":
            vcambio = (row)  % (key, e.findtext(value))
        elif key == "Combustible":
            vcombustible = (row)  % (key, e.findtext(value))
        elif key == "Modelo":
            vmodelo = (row)  % (key, e.findtext(value))
        elif key == "Versión":
            vversion = (row)  % (key, e.findtext(value))
        elif key == "Versión única (mes)":
            vversion2 = (row)  % (key, e.findtext(value))
        elif key == "Seminuevo":
            vseminuevo = (row)  % (key, e.findtext(value))
        elif key == "Km":
            vkm = (row)  % (key, e.findtext(value))
        elif key == "Matrícula":
            vmatricula = (row)  % (key, e.findtext(value))
            rmatricula = e.findtext(value)
        elif key == "Color exterior":
            vcolor = (row)  % (key, e.findtext(value))
        elif key == "Carrocería / Nº puertas":
            vpuertas = (row)  % (key, e.findtext(value))
        elif key == "Potencia (CV)":
            vpotencia = (row)  % (key, e.findtext(value))
        elif key == "Precio":
            vprecio = (row)  % (key, e.findtext(value))
        elif key == "Precio profesional":
            vprecio2 = (row)  % (key, e.findtext(value))
        elif key == "Garantía":
            vgarantia = (row)  % (key, e.findtext(value))
        elif key == "Financiación":
            vfinanciacion = (row)  % (key, e.findtext(value))
        elif key == "Date":
            vdate = e.findtext(value)
        elif key == "Time":
            vtime = e.findtext(value)
            vtime = vtime.replace(':','_')
        elif key == "Extras":
            extra = []
            for d in e.findall(value):
                a = d.text
                if a:
                    extra.append('<tr><td colspan="2">' + a.encode('utf-8') + '</td></tr>')
        elif key == "Rutas Imágenes":
            fotos = []
            for d in e.iterfind(value):
                if list(d)[1].text == "F":
                    for a in list(d):
                        if a.tag == 'image':
                            fotos.append('<tr><td colspan="2"><a href="' +  a.text + '">' + a.text + '</a></td></tr>')
        else:
            pass

    return dict(vreferencia=vreferencia, vmarca=vmarca, vyear=vyear, vcambio=vcambio,
                vcombustible=vcombustible, vmodelo=vmodelo, vversion=vversion, vversion2=vversion2,
                vseminuevo=vseminuevo, vkm=vkm, vmatricula=vmatricula, rmatricula=rmatricula,
                vcolor=vcolor, vpuertas=vpuertas, vprecio=vprecio, vprecio2=vprecio2,
                vgarantia=vgarantia, vfinanciacion=vfinanciacion, extra=extra, fotos=fotos,
                vdate=vdate, vtime=vtime, vpotencia=vpotencia, vaccion=vaccion, rreferencia=rreferencia)


def prepara_directorio(path):
    """Comprueba si existe el directorio 'resultado' o lo crea si no existe
    
    Arguments:
    - `path`:
    """
    current_dir = os.getcwd()
    result_dir = current_dir + "/resultado"

    if 'resultado' in os.listdir(current_dir):
        pass
    else:
        os.mkdir(result_dir)


def ficheros_filtrados():
    """Selecciona los nombres de los ficheros que se van a generar y comprueba que se procese el último xml

    Arguments:
    - `path`:
    """
    ficheros_procesados = []
    for ruta_fichero in enumerarutas():
        p = procesa_xml(ruta_fichero)
        imagen_fichero = [ruta_fichero, p['rmatricula'], p['vdate'], p['vtime']]
        ficheros_procesados.append(imagen_fichero)
    return ficheros_procesados


def genera_html(fichero):
    """
    """
    p = procesa_xml(fichero)

    # Comprobamos si existe el directorio 'resultado' o lo creamos
    current_dir = os.getcwd()
    result_dir = current_dir + "/resultado-" + path

    if 'resultado-' + path in os.listdir(current_dir):
        pass
    else:
        print "resultado-" + path
        os.mkdir(result_dir)

    # Seleccionamos el nombre para el fichero resultante
    nombre_fichero = p['rreferencia'] + "-" + p['rmatricula'] + "-" + p['vdate'] + "-" + p['vtime'] + ".html"

    ruta_fichero = result_dir + "/" + nombre_fichero

    # Creamos el fichero
    f = open(ruta_fichero, 'wb')

    hueco = '<tr><td colspan="2" style="height: 130px; border: 1px solid;"></td></tr>'

    f.write('<!DOCTYPE html>\n<html lang="es">\n')
    f.write('<head><title>AMMZ</title>\n<meta charset="utf-8"/>\n</head><body>')
    f.write('<table style="border: 1px solid; width: 800px;">')

    f.write(p['vaccion'])
    f.write(p['vreferencia'])
    f.write(p['vdate'] +" - ")
    f.write(p['vtime'])
    f.write(p['vmarca'])
    f.write(p['vyear'])
    f.write(p['vcambio'])
    f.write(p['vcombustible'])
    f.write(p['vmodelo'])
    f.write(p['vversion'])
    f.write(p['vversion2'])
    f.write(p['vseminuevo'])
    f.write(p['vkm'])
    f.write(p['vmatricula'])
    f.write(p['vcolor'])
    f.write(p['vpuertas'])
    f.write(p['vprecio'])
    f.write(p['vprecio2'])
    f.write(p['vpotencia'])

    f.write('<tr><td colspan="2" style="border: 1px solid; background-color: #ccc;">Servicios Adicionales:</td></tr>')
    f.write(p['vgarantia'])
    f.write(p['vfinanciacion'])

    f.write('<tr><td colspan="2" style="border: 1px solid; background-color: #ccc;">Extras:</td></tr>')
    n = m = len(p['extra'])
    while n>0:
        n = n - 1
        f.write(p['extra'][m-n-1])

    f.write('<tr><td colspan="2" style="border: 1px solid; background-color: #ccc; ">Información Adicional:</td></tr>')
    f.write(hueco)
    f.write('<tr><td colspan="2" style="border: 1px solid; background-color: #ccc; ">Información Privada:</td></tr>')
    f.write(hueco)
    f.write('<tr><td colspan="2" style="border: 1px solid; background-color: #ccc; ">Información para profesional:</td></tr>')
    f.write(hueco)

    f.write('<tr><td colspan="2" style="border: 1px solid; background-color: #ccc; ">Rutas Imágenes:</td></tr>')
    i = j = len(p['fotos'])
    while i>0:
        i = i - 1
        imagen = unicode(p['fotos'][j-i-1])
        f.write(imagen.encode('utf-8'))

    f.write('</table')
    f.write('</body></html>')

    f.close()

    print "Se ha creado el fichero %s" % ruta_fichero 


if __name__ == '__main__':
    for fichero in enumerarutas():
        genera_html(fichero)
