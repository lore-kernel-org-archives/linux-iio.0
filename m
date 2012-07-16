Return-Path: <Michael.Hennerich@analog.com>
Message-ID: <5003E3B1.909@analog.com>
Date: Mon, 16 Jul 2012 11:49:37 +0200
From: Michael Hennerich <michael.hennerich@analog.com>
Reply-To: <michael.hennerich@analog.com>
MIME-Version: 1.0
To: Peter Meerwald <pmeerw@pmeerw.net>
CC: "jic23@kernel.org" <jic23@kernel.org>, "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>, "device-drivers-devel@blackfin.uclinux.org"
	<device-drivers-devel@blackfin.uclinux.org>, "fengguang.wu@intel.com"
	<fengguang.wu@intel.com>
Subject: Re: [PATCH] iio: staging: ad7298_ring: Fix maybe-uninitialized warning
References: <1342428125-31577-1-git-send-email-michael.hennerich@analog.com> <alpine.DEB.2.01.1207161124570.18056@pmeerw.net>
In-Reply-To: <alpine.DEB.2.01.1207161124570.18056@pmeerw.net>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
List-ID: <linux-iio@vger.kernel.org>

On 07/16/2012 11:26 AM, Peter Meerwald wrote:
>> drivers/staging/iio/adc/ad7298_ring.c:97:37: warning: 'time_ns' may
>> be used uninitialized in this function [-Wmaybe-uninitialized]
>> diff --git a/drivers/staging/iio/adc/ad7298_ring.c b/drivers/staging/iio/adc/ad7298_ring.c
>> index fd1d855..506016f 100644
>> --- a/drivers/staging/iio/adc/ad7298_ring.c
>> +++ b/drivers/staging/iio/adc/ad7298_ring.c
>> @@ -76,7 +76,7 @@ static irqreturn_t ad7298_trigger_handler(int irq, void *p)
>>   	struct iio_dev *indio_dev = pf->indio_dev;
>>   	struct ad7298_state *st = iio_priv(indio_dev);
>>   	struct iio_buffer *ring = indio_dev->buffer;
>> -	s64 time_ns;
>> +	s64 time_ns = 0;
>>   	__u16 buf[16];
>>   	int b_sent, i;
> I'd rather suggest
> s64 time_ns = iio_get_time_ns();
>
> and simplify the if (indio_dev->scan_timestamp) block
>
> p.
Well - calling a function to initialize a variable which isn't being 
used anywhere doesn't make more sense.

IMHO a more adequate fix would be to remove the timestamp argument from 
store_to(),
since it isn't used anywhere.

-- 
Greetings,
Michael

--
Analog Devices GmbH      Wilhelm-Wagenfeld-Str. 6      80807 Muenchen
Sitz der Gesellschaft: Muenchen; Registergericht: Muenchen HRB 40368;
Geschaeftsfuehrer:Dr.Carsten Suckrow, Thomas Wessel, William A. Martin,
Margaret Seif
