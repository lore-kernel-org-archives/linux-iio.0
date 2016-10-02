Return-Path: <lars@metafoo.de>
Subject: Re: [Outreachy kernel] [PATCH] iio: imu: bmi160: bmi160_core: Fix
 sparse warning
To: Alison Schofield <amsfield22@gmail.com>,
 sayli karnik <karniksayli1995@gmail.com>
References: <20161001110418.GA25515@sayli-HP-15-Notebook-PC>
 <20161002050032.GA14117@d830.WORKGROUP>
Cc: outreachy-kernel@googlegroups.com, Jonathan Cameron <jic23@kernel.org>,
 Hartmut Knaack <knaack.h@gmx.de>, Peter Meerwald-Stadler
 <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org
From: Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <e4800421-2dc9-2460-470b-a043d198f469@metafoo.de>
Date: Sun, 2 Oct 2016 17:53:08 +0200
MIME-Version: 1.0
In-Reply-To: <20161002050032.GA14117@d830.WORKGROUP>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-iio@vger.kernel.org>

On 10/02/2016 07:00 AM, Alison Schofield wrote:
[...]
>> ---
>>  drivers/iio/imu/bmi160/bmi160_core.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/iio/imu/bmi160/bmi160_core.c b/drivers/iio/imu/bmi160/bmi160_core.c
>> index e0251b8..5355507 100644
>> --- a/drivers/iio/imu/bmi160/bmi160_core.c
>> +++ b/drivers/iio/imu/bmi160/bmi160_core.c
>> @@ -398,7 +398,8 @@ static irqreturn_t bmi160_trigger_handler(int irq, void *p)
>>  	struct iio_poll_func *pf = p;
>>  	struct iio_dev *indio_dev = pf->indio_dev;
>>  	struct bmi160_data *data = iio_priv(indio_dev);
>> -	s16 buf[16]; /* 3 sens x 3 axis x s16 + 3 x s16 pad + 4 x s16 tstamp */
>> +	__le16 buf[16];
>> +	/* 3 sens x 3 axis x __le16 + 3 x __le16 pad + 4 x __le16 tstamp */
>>  	int i, ret, j = 0, base = BMI160_REG_DATA_MAGN_XOUT_L;
>>  	__le16 sample;
> 
> Wondering about this option below.  Data was read into an __le16, so that
> was good diligence on drivers part.  Seems we can use le16_to_cpu() for the
> conversion into the buf.
> 
> --- a/drivers/iio/imu/bmi160/bmi160_core.c
> +++ b/drivers/iio/imu/bmi160/bmi160_core.c
> @@ -408,7 +408,7 @@ static irqreturn_t bmi160_trigger_handler(int irq, void *p)
>  				       &sample, sizeof(__le16));
>  		if (ret < 0)
>  			goto done;
> -		buf[j++] = sample;
> +		buf[j++] = le16_to_cpu(sample);
>  	}

This conversion is usually skipped on purpose and delayed until it is
actually needed by the user. The IIO channel is accordingly marked that it
will produce LE data.
