<?php

namespace Tests\Unit;

use PHPUnit\Framework\TestCase;
use Illuminate\Foundation\Testing\RefreshDatabase;

class ExampleTest extends TestCase
{

    use refreshDatabase;

    /** @test */
    public function test_example()
    {

        // added a comment a
        $this->assertTrue(true);
    }
}
