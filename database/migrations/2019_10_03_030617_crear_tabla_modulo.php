<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CrearTablaModulo extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('modulo', function (Blueprint $table) {
            $table->bigIncrements('idmodulo');
            $table->integer('pertenece_nucleo')->default('0');
            $table->string('nombre',255);
            $table->string('tipo',255)->default('3');
            $table->string('imagen',11)->nullable();
            $table->string('etiqueta',11);
            $table->text('enlace');
            $table->integer('cod_padre')->nullable();
            $table->tinyInteger('orden')->default('1');
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
        Schema::dropIfExists('modulo');
    }
}
