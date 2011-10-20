Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-092.synserver.de ([212.40.185.92]:1092 "HELO
	smtp-out-087.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with SMTP id S1751692Ab1JTGx7 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 20 Oct 2011 02:53:59 -0400
Message-ID: <4E9FC598.10306@metafoo.de>
Date: Thu, 20 Oct 2011 08:54:16 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Dan Carpenter <dan.carpenter@oracle.com>
CC: Greg Kroah-Hartman <gregkh@suse.de>, devel@driverdev.osuosl.org,
	drivers@analog.com,
	Michael Hennerich <michael.hennerich@analog.com>,
	linux-iio@vger.kernel.org, Jonathan Cameron <jic23@cam.ac.uk>,
	device-drivers-devel@blackfin.uclinux.org
Subject: Re: [PATCH 2/4] staging:iio:dac:ad5791: Allow asymmetrical reference
 voltages
References: <1319039272-19496-1-git-send-email-lars@metafoo.de> <1319039272-19496-2-git-send-email-lars@metafoo.de> <20111019210429.GF24215@longonot.mountain>
In-Reply-To: <20111019210429.GF24215@longonot.mountain>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/19/2011 11:04 PM, Dan Carpenter wrote:
> On Wed, Oct 19, 2011 at 05:47:50PM +0200, Lars-Peter Clausen wrote:
>> @@ -225,6 +226,7 @@ static int ad5791_read_raw(struct iio_dev *indio_dev,
>>  			   long m)
>>  {
>>  	struct ad5791_state *st = iio_priv(indio_dev);
>> +	u64 val64;
>>  	int ret;
>>  
>>  	switch (m) {
>> @@ -234,12 +236,16 @@ static int ad5791_read_raw(struct iio_dev *indio_dev,
>>  			return ret;
>>  		*val &= AD5791_DAC_MASK;
>>  		*val >>= chan->scan_type.shift;
>> -		*val -= (1 << (chan->scan_type.realbits - 1));
>>  		return IIO_VAL_INT;
>>  	case (1 << IIO_CHAN_INFO_SCALE_SHARED):
>>  		*val = 0;
>>  		*val2 = (st->vref_mv * 1000) >> chan->scan_type.realbits;
>>  		return IIO_VAL_INT_PLUS_MICRO;
>> +	case (1 << IIO_CHAN_INFO_OFFSET_SHARED):
>> +		val64 = (((u64)st->vref_neg_mv) << chan->scan_type.realbits);
>> +		do_div(val64, st->vref_mv);
>> +		*val = -val64;
>> +		return IIO_VAL_INT;
> 
> Why does iio use switch over a bitfield?  If the values are mutually
> exclusive then why not just use an enum?
> 

I wondered the very same and couldn't find a good explanation. I wanted to
write a small RFC today converting the core and maybe 2-3 drivers to use the
unshifted variants to see what Jonathan thinks about it.

> Hm...  "m" stands for mask and it gets created using the
> IIO_UNMOD_EVENT_CODE() macro or sometimes it's just one bit at a
> time copied from &chan->info_mask...  Odd.
> 

IIO_UNMOD_EVENT_CODE is only used for events which use a different callback
function, so for the read_raw/write_raw callbacks we currently only ever
pass one channel info type at a time.

- Lars
