Return-Path: <knaack.h@gmx.de>
Message-ID: <547A14AA.6020405@gmx.de>
Date: Sat, 29 Nov 2014 19:47:06 +0100
From: Hartmut Knaack <knaack.h@gmx.de>
MIME-Version: 1.0
To: Stefan Wahren <stefan.wahren@i2se.com>,
 Fabio Estevam <festevam@gmail.com>, =?UTF-8?Q?Marek_Va=c5=a1ut?=
 <marex@denx.de>
CC: =?UTF-8?Q?Kristina_Mart=c5=a1enko?=
 <kristina.martsenko@gmail.com>, Jonathan Cameron <jic23@kernel.org>,
 linux-iio@vger.kernel.org, jbe@pengutronix.de
Subject: Re: [PATCH] iio: mxs-lradc: check ranges of ts properties
References: <1416435590-13999-1-git-send-email-stefan.wahren@i2se.com> <CAOMZO5DJ7yyd47BKgm6AOAg=GGFdeswrb2NxA2krj3ATnRWPVQ@mail.gmail.com> <5479052B.2090308@gmx.de> <10217382.467571.1417260127187.JavaMail.open-xchange@oxbaltgw07.schlund.de>
In-Reply-To: <10217382.467571.1417260127187.JavaMail.open-xchange@oxbaltgw07.schlund.de>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

Stefan Wahren schrieb am 29.11.2014 um 12:22:
> Hi Hartmut,
> 
>> Hartmut Knaack <knaack.h@gmx.de> hat am 29. November 2014 um 00:28
>> geschrieben:
>>
>>
>> Fabio Estevam schrieb am 19.11.2014 um 23:42:
>>> [Adding Marek]
>> Taking a closer look on how these values are used, I wondered what the real
>> value range of the registers actually are. So, anyone with access to the data
>> sheets, please confirm.
> 
> the reference manual is public:
> 
> http://cache.freescale.com/files/dsp/doc/ref_manual/MCIMX28RM.pdf
Thanks.
> 
>> Starting with over_sample_cnt, which according to the DT bindings has a range
>> of 1...31. In mxs_lradc_setup_ts_channel(), currently line 429, the value
>> decreased by one (0...30) gets written to register 0x50 (+ 0x10 for each
>> channel) to bits 24-29. Question: What is the right value range there, 0...30
>> or 0...31?
> 
> Yes, looks like an off-by-one issue. The register range is 0..31 so i would
> assume the DT property range should be logically 1..32. But i don't have checked
> the reference manual about that.
It's NUM_SAMPLES with the description: "This bit field contains the number of conversion cycles to sum together before reporting operation
complete interrupt status. Set this field to zero for a single conversion per interrupt."
So, a range of 0...31 can be assumed.
> 
>> In the same function, line 440, the value decreased by one (0...30) is written
>> to register 0x100 into bits 11-15. Same question here: What is the right value
>> range?
It's LOOP_COUNT with the description: "This bit field specifies the number of times this delay counter will count down and then trigger its
designated targets. This is particularly useful for scheduling multiple samples of an LRADC channel set. If
this field is set to 0x0, then exactly one delay loop will be generated with exactly one event triggering the
target LRADC and/or delay channels."
So, the range is also 0...31.
>> The same behavior can be found in mxs_lradc_setup_ts_pressure() in lines 485
>> and 498.
>> For over_sample_delay, the DT bindings state a range of 1...2047. In
>> mxs_lradc_setup_ts_channel(), line 440, the value decreased by one (0...2046)
>> is written to register 0x100, bits 0-10. Question: which value range is valid
>> there? The same happens in line 498.
It's DELAY with the description: "This 11-bit field counts down to zero. At zero it triggers either a set of LRADC channel conversions or
another delay channel, or both. It can trigger up to all eight LRADCs and all four delay channels in a single
event. This counter operates on a 2KHz clock derived from crystal clock."
So, the range is 0...2047.
>> For settling_delay, the DT bindings state a range of 1...2047. In
>> mxs_lradc_setup_ts_channel(), line 458, that value is written to register
>> 0xf0, bits 0-10. Question: what value range is valid here, 1...2047 or
>> 0...2047? The same happens in line 517.
This is the same as register 0x100, so 0...2047 is the valid range.
Stefan, would you mind to change the DT documentation while you are on it?
>> Thanks,
>>
>> Hartmut
>>>
> 
> Stefan
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
