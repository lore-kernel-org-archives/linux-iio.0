Return-Path: <srinivas.pandruvada@linux.intel.com>
Message-ID: <5390BF04.4050404@linux.intel.com>
Date: Thu, 05 Jun 2014 12:03:32 -0700
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
MIME-Version: 1.0
To: Peter Meerwald <pmeerw@pmeerw.net>
CC: linux-iio@vger.kernel.org, jic23@kernel.org
Subject: Re: [PATCH] iio: Fix endianness issue in ak8975_read_axis()
References: <1401958410-21183-1-git-send-email-pmeerw@pmeerw.net> <5390A412.8070401@linux.intel.com> <alpine.DEB.2.01.1406052013270.29790@pmeerw.net>
In-Reply-To: <alpine.DEB.2.01.1406052013270.29790@pmeerw.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-ID: <linux-iio@vger.kernel.org>

On 06/05/2014 11:17 AM, Peter Meerwald wrote:
> Hello Srinivas,
>
>>> -	/* Endian conversion of the measured values. */
>>> -	raw = (s16) (le16_to_cpu(meas_reg));
>>> -
>>>    	/* Clamp to valid range. */
>>> -	raw = clamp_t(s16, raw, -4096, 4095);
>>> -	*val = raw;
>>> +	*val = clamp_t(s16, ret, -4096, 4095);
>>>    	return IIO_VAL_INT;
>>>
>>>    exit:
>>>
>> I did some experiments on little-endian platforms,  so your change
>> won't hurt on x86.
>
> good!
>
>> Don't we need to convert for big-endian platforms?
>>
>> When I trace the path for i2c, I don't see any host order
>> conversion.
>
>> order word according to SMBUS specification, low byte on the bus first
>> 	case I2C_SMBUS_WORD_DATA:
>> 		case I2C_SMBUS_PROC_CALL:
>> 			data->word = msgbuf1[0] | (msgbuf1[1] << 8);
>> 			break;
>> }
>> 	But there is no host order conversion?
>
> data->word = msgbuf1[0] | (msgbuf1[1] << 8);
> will work irrespective of host endianness
> the story would be different for
> data->word = *(short *)msgbuf1;
> which works for little-endian, but not for big-endian
>
> so: don't worry :)
Oops, my bad. You are correct.

Thanks,
Srinivas
>
> p.
>
