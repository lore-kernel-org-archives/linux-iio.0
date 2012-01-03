Return-Path: <jic23@cam.ac.uk>
References: <1325525123-31158-1-git-send-email-jic23@kernel.org> <1325525123-31158-3-git-send-email-jic23@kernel.org> <4F02CE57.9040202@metafoo.de>
In-Reply-To: <4F02CE57.9040202@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Subject: Re: [PATCH 2/6] staging:iio:dds:ad9834 unwind use of is_visible for attrs.
From: Jonathan Cameron <jic23@cam.ac.uk>
Date: Tue, 03 Jan 2012 17:12:52 +0000
To: Lars-Peter Clausen <lars@metafoo.de>,Jonathan Cameron <jic23@kernel.org>
CC: linux-iio@vger.kernel.org,pirmin.duss@flytec.ch
Message-ID: <a5618d61-5b87-489f-8a2c-df7815c879e9@email.android.com>
List-ID: <linux-iio@vger.kernel.org>



Lars-Peter Clausen <lars@metafoo.de> wrote:

>On 01/02/2012 06:25 PM, Jon=
athan Cameron wrote:
>> Trivial usecase in which just having two different =
attr
>> groups covers all options.  Slightly more code, but a simpler
>> to=
 follow result.
>> 
>
>>  static int __devinit ad9834_probe(struct spi_devi=
ce *spi)
>>  {
>>  	struct ad9834_platform_data *pdata =3D spi->dev.platfor=
m_data;
>> @@ -344,7 +347,10 @@ static int __devinit ad9834_probe(struct
>s=
pi_device *spi)
>>  	st->reg =3D reg;
>>  	indio_dev->dev.parent =3D &spi->=
dev;
>>  	indio_dev->name =3D spi_get_device_id(spi)->name;
>> -	indio_dev-=
>info =3D &ad9834_info;
>> +	if ((st->devid =3D=3D ID_AD9833) || (st->devid=
 =3D=3D ID_AD9837))
>
>Maybe use a switch statement.
Good idea
>
>> +		indi=
o_dev->info =3D &ad9833_info;
>> +	else
>> +		indio_dev->info =3D &ad9834_i=
nfo;
>>  	indio_dev->modes =3D INDIO_DIRECT_MODE;
>>  
>>  	/* Setup defaul=
t messages */
>
>--
>To unsubscribe from this list: send the line "unsubscr=
ibe linux-iio" in
>the body of a message to majordomo@vger.kernel.org
>More=
 majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Sent fr=
om my Android phone with K-9 Mail. Please excuse my brevity.
