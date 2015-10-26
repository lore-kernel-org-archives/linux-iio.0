Return-Path: <stefan@agner.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Date: Mon, 26 Oct 2015 09:21:57 -0700
From: Stefan Agner <stefan@agner.ch>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Sanchayan Maity <maitysanchayan@gmail.com>, b38611@freescale.com,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: vf610_adc: Fix division by zero error
In-Reply-To: <562CC926.1080700@kernel.org>
References: <0dafb77d1c3f7cd1b6de59a619b45a80c00169d5.1445240424.git.maitysanchayan@gmail.com>
 <562CC926.1080700@kernel.org>
Message-ID: <12382712f0a1fb27f5e7f7915f8ac6be@agner.ch>
List-ID: <linux-iio@vger.kernel.org>

On 2015-10-25 05:20, Jonathan Cameron wrote:
> On 19/10/15 08:43, Sanchayan Maity wrote:
>> In case the fsl,adck-max-frequency property is not present in
>> the device tree, a division by zero error results during the
>> probe call on kernel boot (see below). This patch fixes it and
>> also restores device tree compatibility in case kernels are
>> booting with old device trees without this property specified.
>>
>> [    1.063229] Division by zero in kernel.
>> [    1.067152] CPU: 0 PID: 1 Comm: swapper Not tainted
>> 4.3.0-rc5-00212-gcc88cef #37
>> [    1.074650] Hardware name: Freescale Vybrid VF5xx/VF6xx (Device Tree)
>> [    1.081135] Backtrace:
>> [    1.083694] [<800134a4>] (dump_backtrace) from [<8001369c>]
>> (show_stack+0x18/0x1c)
>> [    1.091340]  r7:00000008 r6:8e0ae210 r5:00000000 r4:8e299800
>> [    1.097146] [<80013684>] (show_stack) from [<80297b1c>]
>> (dump_stack+0x24/0x28)
>> [    1.104483] [<80297af8>] (dump_stack) from [<80013608>]
>> (__div0+0x1c/0x20)
>> [    1.111421] [<800135ec>] (__div0) from [<802968b4>] (Ldiv0+0x8/0x10)
>> [    1.117865] [<80424350>] (vf610_adc_probe) from [<803153b4>]
>> (platform_drv_probe+0x4c/0xac)
>> [    1.126311]  r10:00000000 r9:8076a5ec r8:00000000 r7:fffffdfb
>> r6:807cc67c r5:8e0ae210
>> [    1.134319]  r4:807f6c54
>> [    1.136915] [<80315368>] (platform_drv_probe) from [<803138bc>]
>> (driver_probe_device+0x20c/0x2f8)
>> [    1.145882]  r7:807cc67c r6:00000000 r5:8e0ae210 r4:807f6c54
>> [    1.151657] [<803136b0>] (driver_probe_device) from [<80313a3c>]
>> (__driver_attach+0x94/0x98)
>> [    1.160190]  r9:8076a5ec r8:00000098 r7:00000000 r6:8e0ae244
>> r5:807cc67c r4:8e0ae210
>> [    1.168112] [<803139a8>] (__driver_attach) from [<80311cb8>]
>> (bus_for_each_dev+0x70/0xa4)
>> [    1.176383]  r7:00000000 r6:803139a8 r5:807cc67c r4:00000000
>> [    1.182159] [<80311c48>] (bus_for_each_dev) from [<80313318>]
>> (driver_attach+0x24/0x28)
>> [    1.190260]  r6:807bb568 r5:8e2a5b00 r4:807cc67c
>> [    1.194996] [<803132f4>] (driver_attach) from [<80312f50>]
>> (bus_add_driver+0x1a4/0x21c)
>> [    1.203113] [<80312dac>] (bus_add_driver) from [<803142a8>]
>> (driver_register+0x80/0x100)
>> [    1.211275]  r7:8e2a7dc0 r6:807a8160 r5:80789e14 r4:807cc67c
>> [    1.217075] [<80314228>] (driver_register) from [<803152f8>]
>> (__platform_driver_register+0x5c/0x64)
>> [    1.226216]  r5:80789e14 r4:807a8160
>> [    1.229877] [<8031529c>] (__platform_driver_register) from
>> [<80789e30>] (vf610_adc_driver_init+0x1c/0x20)
>> [    1.239556] [<80789e14>] (vf610_adc_driver_init) from [<800095f8>]
>> (do_one_initcall+0x94/0x1dc)
>> [    1.248365] [<80009564>] (do_one_initcall) from [<8076ae34>]
>> (kernel_init_freeable+0x13c/0x1e0)
>> [    1.257155]  r10:80794830 r9:8076a5ec r8:00000098 r7:807d5780
>> r6:807d5780 r5:00000006
>> [    1.265153]  r4:807a0ee8
>> [    1.267753] [<8076acf8>] (kernel_init_freeable) from [<80590ef0>]
>> (kernel_init+0x18/0xf0)
>> [    1.276021]  r10:00000000 r9:00000000 r8:00000000 r7:00000000
>> r6:00000000 r5:80590ed8
>> [    1.284015]  r4:807d5780
>> [    1.286615] [<80590ed8>] (kernel_init) from [<8000f878>]
>> (ret_from_fork+0x14/0x3c)
>> [    1.294278]  r5:80590ed8 r4:00000000
>>
>> Signed-off-by: Sanchayan Maity <maitysanchayan@gmail.com>
> I'd like an ack from Fugang on this as I'm less than entirely
> sure what the current logic is doing!

I introduced adck_rate along wiht the fsl,adck-max-frequency device tree
property to make sure the ADC operates within its specification. It is
actually also necessary to (re-)calculate the proper adck_rate even when
the fsl,adck-max-frequency property is set. Anyway, moving the
calculation before the first use is the right thing to do. From my side:

Acked-by: Stefan Agner <stefan@agner.ch>

A minor nit below:

> 
> Jonathan
>> ---
>>  drivers/iio/adc/vf610_adc.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/iio/adc/vf610_adc.c b/drivers/iio/adc/vf610_adc.c
>> index 6bf4c20..bf4f3d8 100644
>> --- a/drivers/iio/adc/vf610_adc.c
>> +++ b/drivers/iio/adc/vf610_adc.c
>> @@ -193,6 +193,8 @@ static inline void vf610_adc_calculate_rates(struct vf610_adc *info)
>>  		adc_feature->clk_div = 8;
>>  	}
>>
>> +	adck_rate = ipg_rate / info->adc_feature.clk_div;
>> +

There is a local pointer variable to adc_feature, so this could look
somewhat shorter:

adck_rate = ipg_rate / adc_feature->clk_div;

--
Stefan

>>  	/*
>>  	 * Determine the long sample time adder value to be used based
>>  	 * on the default minimum sample time provided.
>> @@ -217,7 +219,6 @@ static inline void vf610_adc_calculate_rates(struct vf610_adc *info)
>>  	 * BCT (Base Conversion Time): fixed to 25 ADCK cycles for 12 bit mode
>>  	 * LSTAdder(Long Sample Time): 3, 5, 7, 9, 13, 17, 21, 25 ADCK cycles
>>  	 */
>> -	adck_rate = ipg_rate / info->adc_feature.clk_div;
>>  	for (i = 0; i < ARRAY_SIZE(vf610_hw_avgs); i++)
>>  		info->sample_freq_avail[i] =
>>  			adck_rate / (6 + vf610_hw_avgs[i] *
>>
