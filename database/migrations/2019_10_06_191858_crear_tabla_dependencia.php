<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CrearTablaDependencia extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('dependencia', function (Blueprint $table) {
            $table->bigIncrements('iddependencia');
            $table->string('codigo',50)->nullable;
            $table->string('nombre',255);
            $table->datetime('fecha');
            $table->integer('cod_padre')->nullable;
            $table->integer('tipo')->default('1');
            $table->tinyInteger('estado')->default('1');
            $table->string('codigo_tabla',255)->nullable;
            $table->string('extension',20)->nullable;
            $table->text('ubicacion_dependencia')->nullable;
            $table->string('logo',255)->nullable;
            $table->string('orden',255)->nullable;
            $table->string('codigo_arbol',255);
            $table->string('descripcion',500)->nullable;
            $table->string('sigla',45);
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
        Schema::dropIfExists('dependencia');
    }
}
