<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CrearTablaDocumento extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('documento', function (Blueprint $table) {
            $table->bigIncrements('iddocumento');
            $table->string('numero',255);
            $table->integer('serie')->unsigned();
            $table->datetime('fecha');
            $table->string('ejecutor',255);
            $table->string('descripcion',4000)->nullable();
            $table->integer('tipo_radicado')->unsigned();
            $table->string('estado',255)->nullable();
            $table->string('dias',255)->nullable();
            $table->string('plantilla',255);
            $table->string('activa_admin',255);
            $table->datetime('fecha_creacion')->nullable();
            $table->string('tipo_ejecutor',255)->nullable();
            $table->integer('pantalla_idpantalla')->unsigned();
            $table->integer('paginas')->nullable()->unsigned();
            $table->integer('municipio_idmunicipio')->unsigned();
            $table->string('pdf',600)->nullable();
            $table->string('pdf_hash',255)->nullable();
            $table->date('fecha_oficio')->nullable();
            $table->string('oficio',20)->nullable();
            $table->string('anexo',255)->nullable();
            $table->text('descripcion_anexo')->nullable();
            $table->integer('almacenado')->unsigned();
            $table->integer('responsable')->nullable()->unsigned();
            $table->string('guia',50)->nullable();
            $table->integer('guia_empresa')->nullable()->unsigned();
            $table->string('tipo_despacho',255)->nullable();
            $table->integer('formato_idformato')->nullable()->unsigned();
            $table->integer('documento_antiguo')->nullable()->unsigned();
            $table->integer('version')->nullable()->unsigned();
            $table->date('fecha_limite')->nullable();
            $table->integer('ventanilla_radicacion')->nullable()->unsigned();
            $table->integer('prioridad')->unsigned();
            $table->string('estado_aprobacion',45)->nullable();
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
        Schema::dropIfExists('documento');
    }
}
