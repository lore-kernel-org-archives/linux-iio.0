Return-Path: <jic23@kernel.org>
Message-ID: <4FE8C533.2000107@kernel.org>
Date: Mon, 25 Jun 2012 21:08:19 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Maxime Ripard <maxime.ripard@free-electrons.com>
CC: Lars-Peter Clausen <lars@metafoo.de>,
 Jonathan Cameron <jic23@cam.ac.uk>,
 linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio:adc:at91: Relase mutex on error path in at91_adc_read_raw
References: <1340631780-14685-1-git-send-email-lars@metafoo.de> <4FE87D04.4080008@free-electrons.com>
In-Reply-To: <4FE87D04.4080008@free-electrons.com>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

On 06/25/2012 04:00 PM, Maxime Ripard wrote:
> Hi Lars,
>=20
> You can add my
> Acked-By: Maxime Ripard <maxime.ripard@free-electrons.com>
>=20
> Thanks,
> Maxime
>=20
> Le 25/06/2012 15:43, Lars-Peter Clausen a =E9crit :
>> This issue was reported by the mini_lock.cocci coccinelle semantic pat=
ch.
>>
>> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Acked-by: Jonathan Cameron <jic23@kernel.org>
>> ---
>>  drivers/iio/adc/at91_adc.c |    6 ++++--
>>  1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/iio/adc/at91_adc.c b/drivers/iio/adc/at91_adc.c
>> index 6a08469..f61780a 100644
>> --- a/drivers/iio/adc/at91_adc.c
>> +++ b/drivers/iio/adc/at91_adc.c
>> @@ -349,9 +349,11 @@ static int at91_adc_read_raw(struct iio_dev *idev=
,
>>  						       st->done,
>>  						       msecs_to_jiffies(1000));
>>  		if (ret =3D=3D 0)
>> -			return -ETIMEDOUT;
>> -		else if (ret < 0)
>> +			ret =3D -ETIMEDOUT;
>> +		if (ret < 0) {
>> +			mutex_unlock(&st->lock);
>>  			return ret;
>> +		}
>> =20
>>  		*val =3D st->last_value;
>> =20
>=20
>=20
