<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CrearTablaFuncionario extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('funcionario', function (Blueprint $table) {
            $table->bigIncrements('idfuncionario');
            $table->string('funcionario_codigo',255)->nullable();
            $table->string('login',255);
            $table->string('nombres',255)->nullable();
            $table->string('apellidos',255)->nullable();
            $table->mediumText('firma')->nullable();
            $table->text('firma_temporal')->nullable();
            $table->text('firma_original')->nullable();
            $table->integer('estado');
            $table->datetime('fecha_ingreso')->nullable();
            $table->string('clave',255);
            $table->string('nit',100)->nullable();
            $table->string('perfil',255)->nullable();
            $table->tinyInteger('debe_firmar')->default('1');
            $table->string('tipo',1);
            $table->datetime('ultimo_pwd')->nullable();
            $table->char('mensajeria',1)->nullable();
            $table->string('email',255)->nullable();
            $table->tinyInteger('sistema')->default('1');
            $table->string('email_contrasena',255)->nullable();
            $table->string('direccion',255)->nullable();
            $table->string('telefono',255)->nullable();
            $table->datetime('fecha_fin_inactivo')->nullable();
            $table->integer('intento_login')->nullable();
            $table->text('foto_original')->nullable();
            $table->text('foto_recorte')->nullable();
            $table->integer('ventanilla_radicacion')->default('1');
            $table->integer('pertenece_nucleo')->default('0');
            $table->string('token',100)->nullable();
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('funcionario');
    }
}
