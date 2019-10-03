-- phpMyAdmin SQL Dump
-- version 4.5.1
-- http://www.phpmyadmin.net
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 03-10-2019 a las 02:50:58
-- Versión del servidor: 10.1.9-MariaDB
-- Versión de PHP: 5.6.15

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `modulo_historias_laborales`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `anexo`
--

CREATE TABLE `anexo` (
  `idanexo` int(11) NOT NULL,
  `ruta` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  `etiqueta` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  `nombre` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  `extension` varchar(5) COLLATE utf8_unicode_ci NOT NULL,
  `version` int(11) NOT NULL DEFAULT '1',
  `estado` int(11) NOT NULL DEFAULT '1',
  `descripcion` varchar(200) COLLATE utf8_unicode_ci DEFAULT NULL,
  `eliminado` int(11) NOT NULL DEFAULT '0',
  `fk_anexo` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `anexos`
--

CREATE TABLE `anexos` (
  `idanexos` int(11) NOT NULL,
  `documento_iddocumento` int(11) NOT NULL,
  `ruta` varchar(200) NOT NULL,
  `etiqueta` varchar(100) NOT NULL,
  `tipo` varchar(10) NOT NULL,
  `formato` int(11) DEFAULT NULL,
  `campos_formato` int(11) DEFAULT NULL,
  `idbinario` int(11) DEFAULT NULL,
  `fecha_anexo` datetime DEFAULT NULL,
  `fecha` datetime DEFAULT NULL,
  `estado` int(11) NOT NULL DEFAULT '1',
  `version` int(11) NOT NULL DEFAULT '1',
  `fk_funcionario` int(11) DEFAULT NULL,
  `fk_anexos` int(11) NOT NULL DEFAULT '0',
  `descripcion` varchar(500) DEFAULT NULL,
  `eliminado` int(11) NOT NULL DEFAULT '0',
  `versionamiento` int(11) DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Disparadores `anexos`
--
DELIMITER $$
CREATE TRIGGER `adicionar_accion_anexo` AFTER INSERT ON `anexos` FOR EACH ROW BEGIN
DECLARE accion INT;
SET accion=(SELECT idaccion FROM accion WHERE nombre ='adicionar_anexo');
IF(accion) THEN
INSERT INTO documento_accion(documento_iddocumento,accion_idaccion,fecha) VALUES(new.documento_iddocumento,accion ,date_format(now(),'%Y-%m-%d %H:%i:%s'));
END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cargo`
--

CREATE TABLE `cargo` (
  `idcargo` int(11) NOT NULL,
  `nombre` varchar(255) NOT NULL DEFAULT '',
  `cod_padre` int(11) DEFAULT NULL,
  `estado` tinyint(2) NOT NULL DEFAULT '1',
  `codigo_cargo` int(11) DEFAULT NULL,
  `tipo` tinyint(1) NOT NULL DEFAULT '1',
  `tipo_cargo` int(11) NOT NULL DEFAULT '1',
  `pertenece_nucleo` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Disparadores `cargo`
--
DELIMITER $$
CREATE TRIGGER `tr_cargo_update` AFTER UPDATE ON `cargo` FOR EACH ROW BEGIN
  IF NEW.estado=0 THEN
    DELETE FROM permiso_serie WHERE entidad_identidad=4 AND llave_entidad=NEW.idcargo;
  END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `dependencia`
--

CREATE TABLE `dependencia` (
  `iddependencia` int(11) NOT NULL,
  `codigo` varchar(50) DEFAULT NULL,
  `nombre` varchar(255) NOT NULL DEFAULT '',
  `fecha_ingreso` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `cod_padre` int(11) DEFAULT NULL,
  `tipo` int(11) NOT NULL DEFAULT '1',
  `estado` tinyint(2) NOT NULL DEFAULT '1',
  `codigo_tabla` varchar(255) DEFAULT NULL,
  `extension` varchar(20) DEFAULT NULL,
  `ubicacion_dependencia` text,
  `logo` blob,
  `orden` varchar(255) DEFAULT NULL,
  `codigo_arbol` varchar(255) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Disparadores `dependencia`
--
DELIMITER $$
CREATE TRIGGER `tr_dependencia_update` AFTER UPDATE ON `dependencia` FOR EACH ROW BEGIN
  IF NEW.estado=0 THEN
    DELETE FROM permiso_serie WHERE entidad_identidad=2 AND llave_entidad=NEW.iddependencia;
        DELETE FROM entidad_expediente WHERE entidad_identidad=2 AND llave_entidad=NEW.iddependencia;
  END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `documento`
--

CREATE TABLE `documento` (
  `iddocumento` int(11) NOT NULL,
  `numero` varchar(255) NOT NULL,
  `serie` int(11) NOT NULL DEFAULT '0',
  `fecha` datetime NOT NULL,
  `ejecutor` varchar(255) NOT NULL,
  `descripcion` varchar(4000) DEFAULT NULL,
  `tipo_radicado` int(11) NOT NULL DEFAULT '0',
  `estado` varchar(255) DEFAULT NULL,
  `dias` varchar(255) DEFAULT NULL,
  `plantilla` varchar(255) NOT NULL,
  `activa_admin` varchar(255) NOT NULL DEFAULT '0',
  `fecha_creacion` datetime DEFAULT NULL,
  `tipo_ejecutor` varchar(255) DEFAULT NULL,
  `pantalla_idpantalla` int(11) NOT NULL DEFAULT '0',
  `paginas` int(4) DEFAULT '0',
  `municipio_idmunicipio` int(11) NOT NULL DEFAULT '0',
  `pdf` varchar(600) DEFAULT NULL,
  `pdf_hash` varchar(255) DEFAULT NULL,
  `fecha_oficio` date DEFAULT NULL,
  `oficio` varchar(20) DEFAULT NULL,
  `anexo` varchar(255) DEFAULT NULL,
  `descripcion_anexo` mediumtext,
  `almacenado` tinyint(1) NOT NULL DEFAULT '0',
  `responsable` int(11) DEFAULT '0',
  `guia` varchar(50) DEFAULT NULL,
  `guia_empresa` int(11) DEFAULT '0',
  `tipo_despacho` varchar(255) DEFAULT NULL,
  `formato_idformato` int(11) DEFAULT '0',
  `documento_antiguo` int(11) DEFAULT '0',
  `version` int(11) DEFAULT '1',
  `fecha_limite` date DEFAULT NULL,
  `ventanilla_radicacion` int(11) DEFAULT '0',
  `prioridad` int(11) NOT NULL DEFAULT '0',
  `estado_aprobacion` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 CHECKSUM=1 PACK_KEYS=1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `funcionario`
--

CREATE TABLE `funcionario` (
  `idfuncionario` int(11) NOT NULL,
  `funcionario_codigo` int(20) NOT NULL DEFAULT '0',
  `login` varchar(255) NOT NULL DEFAULT '',
  `nombres` varchar(255) DEFAULT NULL,
  `apellidos` varchar(255) DEFAULT NULL,
  `firma` mediumblob,
  `firma_temporal` mediumblob,
  `firma_original` mediumblob,
  `estado` int(11) NOT NULL DEFAULT '1',
  `fecha_ingreso` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `clave` varchar(255) NOT NULL DEFAULT '',
  `nit` varchar(100) NOT NULL,
  `perfil` varchar(255) NOT NULL DEFAULT '6',
  `debe_firmar` tinyint(1) NOT NULL DEFAULT '1',
  `tipo` varchar(1) NOT NULL DEFAULT '0',
  `ultimo_pwd` datetime DEFAULT NULL,
  `mensajeria` char(1) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `sistema` tinyint(1) NOT NULL DEFAULT '1',
  `email_contrasena` varchar(255) DEFAULT NULL,
  `direccion` varchar(255) DEFAULT NULL,
  `telefono` varchar(255) DEFAULT NULL,
  `fecha_fin_inactivo` date DEFAULT NULL,
  `intento_login` int(11) DEFAULT NULL,
  `foto_original` text,
  `foto_recorte` text,
  `foto_cordenadas` varchar(255) DEFAULT NULL,
  `ventanilla_radicacion` int(11) DEFAULT NULL,
  `pertenece_nucleo` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 PACK_KEYS=0;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `hl_ingreso_funcionario`
--

CREATE TABLE `hl_ingreso_funcionario` (
  `arl` int(11) NOT NULL,
  `celular` varchar(12) NOT NULL,
  `celular_contacto` varchar(12) NOT NULL,
  `cesantias` int(11) NOT NULL,
  `ciudad_residencia` varchar(255) NOT NULL,
  `contacto_emergencia` varchar(255) NOT NULL,
  `cual_parentesco` varchar(255) DEFAULT NULL,
  `dependencia` int(11) NOT NULL,
  `direccion_residencia` varchar(255) NOT NULL,
  `edad` varchar(255) NOT NULL,
  `encabezado` int(11) NOT NULL DEFAULT '1',
  `eps_ingres_perso` int(11) NOT NULL,
  `estado_civil` int(11) NOT NULL,
  `fecha_ingr_personal` date NOT NULL,
  `fecha_nacimiento` date NOT NULL,
  `fecha_pasado_judi` date DEFAULT NULL,
  `firma` int(11) NOT NULL DEFAULT '1',
  `hl_solicitud_personal` int(11) NOT NULL,
  `idhl_ingreso_funcionario` int(11) NOT NULL,
  `lugar_expedicion` varchar(255) NOT NULL,
  `lugar_nacimiento` varchar(255) NOT NULL,
  `nombre_completo` int(11) NOT NULL,
  `numero_libreta` varchar(11) DEFAULT NULL,
  `numero_pasado_judicial` varchar(11) DEFAULT NULL,
  `parentesco` int(11) NOT NULL,
  `pension_ingre_perso` int(11) NOT NULL,
  `rh_ingreso_pers` int(11) NOT NULL,
  `salario` varchar(255) NOT NULL,
  `sexo_ingreso_per` int(11) NOT NULL,
  `telefono` varchar(11) DEFAULT NULL,
  `telefono_contacto` varchar(12) DEFAULT NULL,
  `tipo_contrato` int(11) NOT NULL,
  `ubicacion` int(11) NOT NULL,
  `version` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `hl_solicitud_personal`
--

CREATE TABLE `hl_solicitud_personal` (
  `cargo_usuario` varchar(255) NOT NULL,
  `dependencia` int(11) NOT NULL,
  `dependencia_usuario` varchar(255) NOT NULL,
  `educacion` text NOT NULL,
  `experiencia` text NOT NULL,
  `fecha_solicitud` date NOT NULL,
  `fecha_vinculacion` date NOT NULL,
  `idhl_solicitud_personal` int(11) NOT NULL,
  `salario` int(11) NOT NULL,
  `tipo_contrato` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `perfil`
--

CREATE TABLE `perfil` (
  `idperfil` int(11) NOT NULL,
  `nombre` varchar(255) NOT NULL DEFAULT 'GENERAL'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `permiso_perfil`
--

CREATE TABLE `permiso_perfil` (
  `idpermiso_perfil` int(11) NOT NULL,
  `modulo_idmodulo` int(11) NOT NULL DEFAULT '0',
  `perfil_idperfil` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `anexo`
--
ALTER TABLE `anexo`
  ADD PRIMARY KEY (`idanexo`);

--
-- Indices de la tabla `anexos`
--
ALTER TABLE `anexos`
  ADD PRIMARY KEY (`idanexos`);

--
-- Indices de la tabla `cargo`
--
ALTER TABLE `cargo`
  ADD PRIMARY KEY (`idcargo`);

--
-- Indices de la tabla `dependencia`
--
ALTER TABLE `dependencia`
  ADD PRIMARY KEY (`iddependencia`);

--
-- Indices de la tabla `documento`
--
ALTER TABLE `documento`
  ADD PRIMARY KEY (`iddocumento`),
  ADD KEY `serie` (`serie`,`fecha`,`tipo_radicado`,`estado`),
  ADD KEY `fecha` (`fecha`),
  ADD KEY `estado` (`estado`),
  ADD KEY `ejecutor` (`ejecutor`),
  ADD KEY `pantalla_idpantalla` (`pantalla_idpantalla`);

--
-- Indices de la tabla `funcionario`
--
ALTER TABLE `funcionario`
  ADD PRIMARY KEY (`idfuncionario`),
  ADD UNIQUE KEY `login` (`login`),
  ADD UNIQUE KEY `ui_funcionario_codigo` (`funcionario_codigo`);

--
-- Indices de la tabla `hl_ingreso_funcionario`
--
ALTER TABLE `hl_ingreso_funcionario`
  ADD PRIMARY KEY (`idhl_ingreso_funcionario`);

--
-- Indices de la tabla `hl_solicitud_personal`
--
ALTER TABLE `hl_solicitud_personal`
  ADD PRIMARY KEY (`idhl_solicitud_personal`);

--
-- Indices de la tabla `perfil`
--
ALTER TABLE `perfil`
  ADD PRIMARY KEY (`idperfil`);

--
-- Indices de la tabla `permiso_perfil`
--
ALTER TABLE `permiso_perfil`
  ADD PRIMARY KEY (`idpermiso_perfil`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `anexo`
--
ALTER TABLE `anexo`
  MODIFY `idanexo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;
--
-- AUTO_INCREMENT de la tabla `anexos`
--
ALTER TABLE `anexos`
  MODIFY `idanexos` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=116;
--
-- AUTO_INCREMENT de la tabla `cargo`
--
ALTER TABLE `cargo`
  MODIFY `idcargo` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT de la tabla `dependencia`
--
ALTER TABLE `dependencia`
  MODIFY `iddependencia` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT de la tabla `documento`
--
ALTER TABLE `documento`
  MODIFY `iddocumento` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8121;
--
-- AUTO_INCREMENT de la tabla `funcionario`
--
ALTER TABLE `funcionario`
  MODIFY `idfuncionario` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT de la tabla `hl_ingreso_funcionario`
--
ALTER TABLE `hl_ingreso_funcionario`
  MODIFY `idhl_ingreso_funcionario` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT de la tabla `hl_solicitud_personal`
--
ALTER TABLE `hl_solicitud_personal`
  MODIFY `idhl_solicitud_personal` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT de la tabla `perfil`
--
ALTER TABLE `perfil`
  MODIFY `idperfil` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;
--
-- AUTO_INCREMENT de la tabla `permiso_perfil`
--
ALTER TABLE `permiso_perfil`
  MODIFY `idpermiso_perfil` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1613;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
