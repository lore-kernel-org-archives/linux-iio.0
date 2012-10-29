Return-Path: <lars@metafoo.de>
Message-ID: <508E3833.50003@metafoo.de>
Date: Mon, 29 Oct 2012 09:02:59 +0100
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Axel Lin <axel.lin@ingics.com>
CC: Maxime Ripard <maxime.ripard@free-electrons.com>,
 Jonathan Cameron <jic23@kernel.org>,
 linux-iio@vger.kernel.org
Subject: Re: iio: at91_adc.c build error
References: <1351425686.12461.1.camel@phoenix>
In-Reply-To: <1351425686.12461.1.camel@phoenix>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On 10/28/2012 01:01 PM, Axel Lin wrote:
> hi Lars-Peter,
> 
> Seems there is no devm_kcalloc API available at this moment (in linux-next tree).
> 
> I got below build error:
> drivers/iio/adc/at91_adc.c: In function 'at91_adc_channel_init':
> drivers/iio/adc/at91_adc.c:126: error: implicit declaration of function 'devm_kcalloc'
> drivers/iio/adc/at91_adc.c:127: warning: assignment makes pointer from integer without a cast
> drivers/iio/adc/at91_adc.c: In function 'at91_adc_trigger_init':
> drivers/iio/adc/at91_adc.c:272: warning: assignment makes pointer from integer without a cast
> drivers/iio/adc/at91_adc.c: In function 'at91_adc_probe_dt':
> drivers/iio/adc/at91_adc.c:455: warning: assignment makes pointer from integer without a cast
> make[3]: *** [drivers/iio/adc/at91_adc.o] Error 1
> make[2]: *** [drivers/iio/adc] Error 2
> make[1]: *** [drivers/iio] Error 2
> make: *** [drivers] Error 2

Ok, now I feel stupid...

Do you want to sent a revert or should I do it?

- Lars
