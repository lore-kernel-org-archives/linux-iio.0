Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-52.csi.cam.ac.uk ([131.111.8.152]:51519 "EHLO
	ppsw-52.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756845Ab1ERQJd (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 18 May 2011 12:09:33 -0400
Message-ID: <4DD3EFE3.9070201@cam.ac.uk>
Date: Wed, 18 May 2011 17:12:19 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: Guenter Roeck
	<guenter.roeck-IzeFyvvaP7pWk0Htik3J/w@public.gmane.org>
CC: Jonathan Cameron <jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>,
	fabien.marteau@armadeus.com,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	LM Sensors <lm-sensors@lm-sensors.org>
Subject: Re: [PATCH 1/2] staging:iio:adc: as1531 driver initial conversion
 from hwmon submission.
References: <4DD26311.7070905@armadeus.com> <1305733172-18519-2-git-send-email-jic23@cam.ac.uk> <20110518160202.GC11280@ericsson.com>
In-Reply-To: <20110518160202.GC11280@ericsson.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 05/18/11 17:02, Guenter Roeck wrote:
> On Wed, May 18, 2011 at 11:39:31AM -0400, Jonathan Cameron wrote:
>> From: Fabien Marteau <fabien.marteau-d2DlULPkwbNWk0Htik3J/w@public.gmane.org>
>>
>> Signed-off-by: Jonathan Cameron <jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>
> 
> Hi Jonathan,
> 
> nice job. Thanks a lot for the effort.
> 
> [ ... ]
> 
>> +static int as1531_read_raw(struct iio_dev *indio_dev,
>> +			   struct iio_chan_spec const *chan,
>> +			   int *val,
>> +			   int *val2,
>> +			   long m)
>> +{
>> +
> Extra blank line
> 
>> +	int status = 0;
>> +	int ret_value = 0;
>> +	struct as1531_state *st = iio_priv(indio_dev);
> 
> Move it to here, maybe ?
> 
>> +	if (mutex_lock_interruptible(&st->lock))
>> +		return -ERESTARTSYS;
>> +
>> +	status = as1531_message(st->spi,
>> +				AS1531_START_BIT | chan->address |
>> +				AS1531_RANGE_0_TO_VREF | AS1531_MODE_COM |
>> +				AS1531_POWER_NORMAL,
>> +				&ret_value);
>> +	mutex_unlock(&st->lock);
>> +	if (status < 0)
>> +		goto out;
>> +	
>> +	*val = ret_value*2500/4096;
>> +
>> +	return IIO_VAL_INT;
>> +out:
>> +	mutex_unlock(&st->lock);
> 
> Mutex was unlocked above already. Maybe just return status above ?
Hmm.. Sometimes working without testing shows just how bad first versions
of code really can be ;)

Thanks for the other review as well.  Have fixed up both.


Thanks.

Jonathan 

