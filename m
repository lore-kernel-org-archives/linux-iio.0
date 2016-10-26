Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:45718 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752886AbcJZKpv (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 26 Oct 2016 06:45:51 -0400
Subject: Re: [PATCH V1]iio: adc: spmi-vadc: Changes to support different
 scaling
To: Sricharan <sricharan@codeaurora.org>, linux-iio@vger.kernel.org,
        jic23@kernel.org
References: <1477373226-29587-1-git-send-email-rphani@codeaurora.org>
 <00c001d22ec1$142a2d80$3c7e8880$@codeaurora.org>
 <241f4520-92da-5aff-7f4f-9487d6082906@codeaurora.org>
 <001c01d22f72$25990c10$70cb2430$@codeaurora.org>
Cc: linux-arm-msm@vger.kernel.org, smohanad@codeaurora.org,
        mgautam@codeaurora.org, 'Hartmut Knaack' <knaack.h@gmx.de>,
        'Lars-Peter Clausen' <lars@metafoo.de>,
        'Peter Meerwald-Stadler' <pmeerw@pmeerw.net>,
        'Julia Lawall' <Julia.Lawall@lip6.fr>,
        'open list' <linux-kernel@vger.kernel.org>
From: "Phani A, Rama Krishna" <rphani@codeaurora.org>
Message-ID: <dfc205f9-172f-3407-272f-dcef8cacfc4d@codeaurora.org>
Date: Wed, 26 Oct 2016 16:15:42 +0530
MIME-Version: 1.0
In-Reply-To: <001c01d22f72$25990c10$70cb2430$@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Sricharan,

On 26-Oct-16 3:47 PM, Sricharan wrote:
> Hi Ramakrishna,
>
> [snip..]
>
>>>> +	u32 i = 0;
>>>> +
>>>> +	if (!pts)
>>>> +		return -EINVAL;
>>>> +
>>>> +	/* Check if table is descending or ascending */
>>>> +	if (tablesize > 1) {
>>>> +		if (pts[0].x < pts[1].x)
>>>> +			descending = 0;
>>>> +	}
>>>> +
>>>> +	while (i < tablesize) {
>>>> +		if ((descending == 1) && (pts[i].x < input)) {
>>>
>>>          Just if (descending) instead of (descending == 1) and so on for the below as well
>>
>> 	Will change in next patch.
>>
>>>
>>>> +			/* table entry is less than measured*/
>>>> +			 /* value and table is descending, stop */
>>>> +			break;
>>>> +		} else if ((descending == 0) &&
>>>> +				(pts[i].x > input)) {
>>>> +			/* table entry is greater than measured*/
>>>> +			/*value and table is ascending, stop */
>>>> +			break;
>>>> +		}
>>>> +		i++;
>>>> +	}
>>>> +
>>>> +	if (i == 0) {
>>>> +		*output = pts[0].y;
>>>> +	} else if (i == tablesize) {
>>>> +		*output = pts[tablesize - 1].y;
>>>> +	} else {
>>>> +		/* result is between search_index and search_index-1 */
>>>> +		/* interpolate linearly */
>>>> +		*output = (((s32)((pts[i].y - pts[i - 1].y) *
>>>> +			(input - pts[i - 1].x)) /
>>>> +			(pts[i].x - pts[i - 1].x)) +
>>>> +			pts[i - 1].y);
>>>> +	}
>>>
>>>                hmm, so for descending, input - pts[i -1].x is negative and
>>>                we are adding that to pts[i-1].y, is that correct ?
>>
>> 		The formula used is to interpolate between two points 	using linear
>> interpolation.
>
>  Right, agree. my question can be ignored.
>
> [snip..]
>
>>>> #define VADC_CHAN_TEMP(_dname, _pre)					\
>>>> -	VADC_CHAN(_dname, IIO_TEMP, BIT(IIO_CHAN_INFO_PROCESSED), _pre)	\
>>>> +	VADC_CHAN(_dname, IIO_TEMP,	\
>>>> +		BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_PROCESSED), \
>>>> +		_pre)	\
>>>>
>>>> #define VADC_CHAN_VOLT(_dname, _pre)					\
>>>> -	VADC_CHAN(_dname, IIO_VOLTAGE,					\
>>>> -		  BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),	\
>>>> +	VADC_CHAN(_dname, IIO_VOLTAGE,				\
>>>> +		  BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_PROCESSED),\
>>>> 		  _pre)							\
>>>>
>>>   For this and the below changes to VADC_CHAN_VOLT to TEMP, why is that done ?
>>>    Now both macros are setting the same flags.
>>
>> 	For Voltage channels IIO_VOLTAGE is needed where as for Temperature
>> channels IIO_TEMP is needed.
>>
>>>
>>>> /*
>>>> @@ -637,12 +811,11 @@ struct vadc_channels {
>>>> 	VADC_CHAN_TEMP(DIE_TEMP, 0)
>>>> 	VADC_CHAN_VOLT(REF_625MV, 0)
>>>> 	VADC_CHAN_VOLT(REF_1250MV, 0)
>>>> -	VADC_CHAN_VOLT(CHG_TEMP, 0)
>>>> +	VADC_CHAN_TEMP(CHG_TEMP, 0)
>>>> 	VADC_CHAN_VOLT(SPARE1, 0)
>>>> 	VADC_CHAN_VOLT(SPARE2, 0)
>>>> 	VADC_CHAN_VOLT(GND_REF, 0)
>>>> 	VADC_CHAN_VOLT(VDD_VADC, 0)
>>>> -
>
> And also looks like the deletion of these and below
> new lines are unnecessary ?

Agree, Will retain these new lines in next patch V2.
>
> Regards,
>  Sricharan
>

Thanks,
Ramakrishna
