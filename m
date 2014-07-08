Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:35105 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754281AbaGHUHt (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Tue, 8 Jul 2014 16:07:49 -0400
Message-ID: <53BC5018.7020006@kernel.org>
Date: Tue, 08 Jul 2014 21:10:00 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Hartmut Knaack <knaack.h@gmx.de>, linux-iio@vger.kernel.org
CC: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 3/6] staging:iio:ad7291 fix ad7291_threshold_reg()
References: <53BBD0CD.3030203@gmx.de>
In-Reply-To: <53BBD0CD.3030203@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 08/07/14 12:06, Hartmut Knaack wrote:
> ad7291_threshold_reg() should return the register number of a threshold
> register, and thus be safe without handling a default case.
Whilst the code is bug free without those defaults currently I'd rather keep them
there to suppress the warnings we will get without them...

Also without an explanation, please don't stick 'fix' in the title - makes
my fingers want to send it to stable.

Warning wise...
e.g. with gcc4.9 on x86_64 I get the following tiny output ;)

   CC [M]  drivers/staging/iio/adc/ad7291.o
drivers/staging/iio/adc/ad7291.c: In function ‘ad7291_threshold_reg’:
drivers/staging/iio/adc/ad7291.c:170:2: warning: enumeration value ‘IIO_CURRENT’ not handled in switch [-Wswitch]
   switch (chan->type) {
   ^
drivers/staging/iio/adc/ad7291.c:170:2: warning: enumeration value ‘IIO_POWER’ not handled in switch [-Wswitch]
drivers/staging/iio/adc/ad7291.c:170:2: warning: enumeration value ‘IIO_ACCEL’ not handled in switch [-Wswitch]
drivers/staging/iio/adc/ad7291.c:170:2: warning: enumeration value ‘IIO_ANGL_VEL’ not handled in switch [-Wswitch]
drivers/staging/iio/adc/ad7291.c:170:2: warning: enumeration value ‘IIO_MAGN’ not handled in switch [-Wswitch]
drivers/staging/iio/adc/ad7291.c:170:2: warning: enumeration value ‘IIO_LIGHT’ not handled in switch [-Wswitch]
drivers/staging/iio/adc/ad7291.c:170:2: warning: enumeration value ‘IIO_INTENSITY’ not handled in switch [-Wswitch]
drivers/staging/iio/adc/ad7291.c:170:2: warning: enumeration value ‘IIO_PROXIMITY’ not handled in switch [-Wswitch]
drivers/staging/iio/adc/ad7291.c:170:2: warning: enumeration value ‘IIO_INCLI’ not handled in switch [-Wswitch]
drivers/staging/iio/adc/ad7291.c:170:2: warning: enumeration value ‘IIO_ROT’ not handled in switch [-Wswitch]
drivers/staging/iio/adc/ad7291.c:170:2: warning: enumeration value ‘IIO_ANGL’ not handled in switch [-Wswitch]
drivers/staging/iio/adc/ad7291.c:170:2: warning: enumeration value ‘IIO_TIMESTAMP’ not handled in switch [-Wswitch]
drivers/staging/iio/adc/ad7291.c:170:2: warning: enumeration value ‘IIO_CAPACITANCE’ not handled in switch [-Wswitch]
drivers/staging/iio/adc/ad7291.c:170:2: warning: enumeration value ‘IIO_ALTVOLTAGE’ not handled in switch [-Wswitch]
drivers/staging/iio/adc/ad7291.c:170:2: warning: enumeration value ‘IIO_CCT’ not handled in switch [-Wswitch]
drivers/staging/iio/adc/ad7291.c:170:2: warning: enumeration value ‘IIO_PRESSURE’ not handled in switch [-Wswitch]
drivers/staging/iio/adc/ad7291.c:170:2: warning: enumeration value ‘IIO_HUMIDITYRELATIVE’ not handled in switch [-Wswitch]
drivers/staging/iio/adc/ad7291.c:179:2: warning: enumeration value ‘IIO_EV_INFO_ENABLE’ not handled in switch [-Wswitch]
   switch (info) {
   ^
drivers/staging/iio/adc/ad7291.c:188:1: warning: control reaches end of non-void function [-Wreturn-type]
  }
  ^
drivers/staging/iio/adc/ad7291.c: In function ‘ad7291_threshold_reg.isra.5’:
drivers/staging/iio/adc/ad7291.c:45:31: warning: ‘offset’ may be used uninitialized in this function [-Wmaybe-uninitialized]
  #define AD7291_HYST(x)   ((x) * 3 + 0x6)
                                ^
drivers/staging/iio/adc/ad7291.c:168:15: note: ‘offset’ was declared here
   unsigned int offset;
                ^


>
> Signed-off-by: Hartmut Knaack <knaack.h@gmx.de>
> ---
> diff --git a/drivers/staging/iio/adc/ad7291.c b/drivers/staging/iio/adc/ad7291.c
> index f5d29ef..b868c64 100644
> --- a/drivers/staging/iio/adc/ad7291.c
> +++ b/drivers/staging/iio/adc/ad7291.c
> @@ -174,8 +174,6 @@ static unsigned int ad7291_threshold_reg(const struct iio_chan_spec *chan,
>   	case IIO_TEMP:
>   		offset = 8;
>   		break;
> -	default:
> -	    return 0;
>   	}
>
>   	switch (info) {
> @@ -186,10 +184,7 @@ static unsigned int ad7291_threshold_reg(const struct iio_chan_spec *chan,
>   			return AD7291_DATA_LOW(offset);
>   	case IIO_EV_INFO_HYSTERESIS:
>   		return AD7291_HYST(offset);
> -	default:
> -		break;
>   	}
> -	return 0;
>   }
>
>   static int ad7291_read_event_value(struct iio_dev *indio_dev,
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

