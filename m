Return-Path: <jic23@cam.ac.uk>
Message-ID: <4E773BA1.4060007@cam.ac.uk>
Date: Mon, 19 Sep 2011 13:54:57 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@cam.ac.uk>
CC: michael.hennerich@analog.com, linux-iio@vger.kernel.org,
 device-drivers-devel@blackfin.uclinux.org, drivers@analog.com
Subject: Re: [PATCH] iio: adc: Replace, rewrite ad7745 from scratch.
References: <1316184432-22349-1-git-send-email-michael.hennerich@analog.com> <4E77334A.1000207@cam.ac.uk>
In-Reply-To: <4E77334A.1000207@cam.ac.uk>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

On 09/19/11 13:19, Jonathan Cameron wrote:
> 
> One quick nitpick on submission format:
> Please put version in the email subject
> [PATCH V3] iio:...
> 
> That way it's easy to spot which one to bother reading ;)
> 
> On 09/16/11 15:47, michael.hennerich@analog.com wrote:
>> From: Michael Hennerich <michael.hennerich@analog.com>
>>
>> The existing ad7745 driver didn't conform with the IIO spec for such devices.
>> It was way simpler to rewrite the existing driver, than actually fixing it.
>>
>> Changes since V1:
>>
>> Fix file header description.
>> Fix erroneous defines.
>> Pin channels to expected places in the iio_chan_spec array, to avoid magic numbers.
>> Use msleep instead of busy waiting mdelay.
>> Fix indention style.
>> Drop _bias and use _offset attribute.
>>
>> Changes since V2:
>> Increase accuracy of cap scale.
>> Fix channel spec for VIN.
> Some formatting nitpicks. I'll fix them up.
Coccicheck gave me a missaligned code error as well whilst I was doing
final checks...

>> +		case IIO_VOLTAGE:
>> +			if (chan->channel == 1) /* supply_raw*/
>> +				*val = *val * 6;
>> +				break;

Indent wrong above.  Fixed up.
