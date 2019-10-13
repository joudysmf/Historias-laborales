<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CrearTablaAnexos extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('anexos', function (Blueprint $table) {
            $table->bigIncrements('idanexos');

            $table->unsignedBigInteger('documento_iddocumento');
            $table->foreign('documento_iddocumento')->references('iddocumento')->on('documento');
            $table->index('documento_iddocumento');

            $table->string('ruta',255);
            $table->string('etiqueta',255);
            $table->string('tipo',255);

            $table->unsignedBigInteger('fk_funcionario');
            $table->foreign('fk_funcionario')->references('idfuncionario')->on('funcionario');
            $table->index('fk_funcionario');

            $table->dateTime('fecha');
            $table->dateTime('fecha_anexo');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('anexos');
    }
}
