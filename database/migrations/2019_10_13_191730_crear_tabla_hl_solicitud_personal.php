<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CrearTablaHlSolicitudPersonal extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('hl_solicitud_personal', function (Blueprint $table) {
            $table->bigIncrements('idhl_solicitud_personal');
            $table->string('anexos',255)->nullable();
            $table->string('cargo_usuario',255);
            $table->integer('dependencia');
            $table->string('dependencia_usuario',255);
            $table->string('documento_iddocumento',255);
            $table->text('educacion');
            $table->text('experiencia');
            $table->datetime('fecha_solicitud');
            $table->datetime('fecha_vinculacion');
            $table->text('formacion');
            $table->text('justificacion_solicitud');
            $table->integer('salario');
            $table->integer('tipo_contrato');
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
        Schema::dropIfExists('hl_solicitud_personal');
    }
}
