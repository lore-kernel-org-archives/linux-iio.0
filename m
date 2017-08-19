Return-Path: <SRS0=cuBr=7V=metafoo.de=lars@kernel.org>
Subject: Re: Possible race in xilinx-xadc.ko
To: Anton Volkov <avolkov@ispras.ru>
Cc: jic23@kernel.org, knaack.h@gmx.de, pmeerw@pmeerw.net,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 ldv-project@linuxtesting.org, Alexey Khoroshilov <khoroshilov@ispras.ru>
References: <2545fc9f-f223-e3d9-8639-cab081ed995e@ispras.ru>
From: Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <e4315825-6adc-272c-dcd3-374f341135c8@metafoo.de>
Date: Sat, 19 Aug 2017 09:26:22 +0200
MIME-Version: 1.0
In-Reply-To: <2545fc9f-f223-e3d9-8639-cab081ed995e@ispras.ru>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-iio@vger.kernel.org>

On 08/18/2017 05:10 PM, Anton Volkov wrote:
> Hello.
> 
> While searching for races in the Linux kernel I've come across
> "drivers/iio/adc/xilinx-xadc.ko" module. Here is a question that I came up
> with while analyzing results. Lines are given using the info from Linux v4.12.
> 
> Consider the following case:
> 
> Thread 1:                    Thread 2:
> xadc_probe
>   iio_triggered_buffer_setup
>                              xadc_trigger_handler
>                              ->xadc_read_adc_reg
>                                ->_xadc_read_adc_reg
>                                  ->xadc_zynq_read_adc_reg
> ->xadc_zynq_setup                  ->xadc_zynq_update_intmsk
>    xadc->zynq_intmask = ~0            xadc->zynq_intmask &= ~mask
>    (xilinx-xadc-core.c: line 340)     (xilinx-xadc-core.c: line 152)
>    xadc_write_reg(xadc->zynq_intmask) xadc_write_reg(xadc->zynq_intmask)
> 
> Judging by the comments to iio_triggered_buffer_setup() the best practice is
> to call it after the indio_dev structure had been fully initialized. In the
> suggested case xadc_trigger_handler() interferes in the initialization
> process. Both xadc_zynq_setup() and xadc_zynq_update_intmsk() will write the
> same xadc->zynq_intmask though it should probably be different. Is this race
> feasible from your point of view?

Hi,

Thanks for the report. I don't think there is an issue here. All
iio_triggered_buffer_setup() does is store the pointer to the callback
function in the iio_poll_func structure of the device. The callback is not
live until iio_trigger_attach_poll_func() has been invoked, which can only
happen after iio_device_register() has completed.

- Lars
