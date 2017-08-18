Return-Path: <SRS0=R6fR=7U=ispras.ru=avolkov@kernel.org>
From: Anton Volkov <avolkov@ispras.ru>
Subject: Possible race in xilinx-xadc.ko
To: lars@metafoo.de
Cc: jic23@kernel.org, knaack.h@gmx.de, pmeerw@pmeerw.net,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 ldv-project@linuxtesting.org, Alexey Khoroshilov <khoroshilov@ispras.ru>
Message-ID: <2545fc9f-f223-e3d9-8639-cab081ed995e@ispras.ru>
Date: Fri, 18 Aug 2017 18:10:32 +0300
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-iio@vger.kernel.org>

Hello.

While searching for races in the Linux kernel I've come across
"drivers/iio/adc/xilinx-xadc.ko" module. Here is a question that I came 
up with while analyzing results. Lines are given using the info from 
Linux v4.12.

Consider the following case:

Thread 1:                    Thread 2:
xadc_probe
   iio_triggered_buffer_setup
                              xadc_trigger_handler
                              ->xadc_read_adc_reg
                                ->_xadc_read_adc_reg
                                  ->xadc_zynq_read_adc_reg
->xadc_zynq_setup                  ->xadc_zynq_update_intmsk
    xadc->zynq_intmask = ~0            xadc->zynq_intmask &= ~mask
    (xilinx-xadc-core.c: line 340)     (xilinx-xadc-core.c: line 152)
    xadc_write_reg(xadc->zynq_intmask) xadc_write_reg(xadc->zynq_intmask)

Judging by the comments to iio_triggered_buffer_setup() the best 
practice is to call it after the indio_dev structure had been fully 
initialized. In the suggested case xadc_trigger_handler() interferes in 
the initialization process. Both xadc_zynq_setup() and 
xadc_zynq_update_intmsk() will write the same xadc->zynq_intmask though 
it should probably be different. Is this race feasible from your point 
of view?

Thank you for your time.

-- Anton Volkov
Linux Verification Center, ISPRAS
web: http://linuxtesting.org
e-mail: avolkov@ispras.ru
