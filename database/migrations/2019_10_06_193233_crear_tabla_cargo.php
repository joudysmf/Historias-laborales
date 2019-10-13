<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CrearTablaCargo extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('cargo', function (Blueprint $table) {
            $table->bigIncrements('idcargo');
            $table->string('nombre',255);
            $table->integer('cod_padre');
            $table->tinyInteger('estado')->default('1');
            $table->integer('codigo_cargo')->nullable;
            $table->tinyInteger('tipo')->default('1');
            $table->integer('tipo_cargo');
            $table->integer('pertenece_nucleo');
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
        Schema::dropIfExists('cargo');
    }
}
