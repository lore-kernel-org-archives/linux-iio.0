Return-Path: <kristina.martsenko@gmail.com>
Message-ID: <547B094A.4000508@gmail.com>
Date: Sun, 30 Nov 2014 14:10:50 +0200
From: =?windows-1252?Q?Kristina_Mart=9Aenko?=
 <kristina.martsenko@gmail.com>
MIME-Version: 1.0
To: Hartmut Knaack <knaack.h@gmx.de>,
 Stefan Wahren <stefan.wahren@i2se.com>
CC: Fabio Estevam <festevam@gmail.com>, =?windows-1252?Q?Marek_Va=9Aut?=
 <marex@denx.de>, Jonathan Cameron <jic23@kernel.org>,
 linux-iio@vger.kernel.org, jbe@pengutronix.de
Subject: Re: [PATCH] iio: mxs-lradc: check ranges of ts properties
References: <1416435590-13999-1-git-send-email-stefan.wahren@i2se.com> <CAOMZO5DJ7yyd47BKgm6AOAg=GGFdeswrb2NxA2krj3ATnRWPVQ@mail.gmail.com> <5479052B.2090308@gmx.de> <10217382.467571.1417260127187.JavaMail.open-xchange@oxbaltgw07.schlund.de> <547A14AA.6020405@gmx.de>
In-Reply-To: <547A14AA.6020405@gmx.de>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-iio@vger.kernel.org>

On 29/11/14 20:47, Hartmut Knaack wrote:
> Stefan Wahren schrieb am 29.11.2014 um 12:22:
>>> Hartmut Knaack <knaack.h@gmx.de> hat am 29. November 2014 um 00:28
>>> geschrieben:
>>> Fabio Estevam schrieb am 19.11.2014 um 23:42:
>>>> [Adding Marek]
>>> Taking a closer look on how these values are used, I wondered what the real
>>> value range of the registers actually are. So, anyone with access to the data
>>> sheets, please confirm.
>>
>> the reference manual is public:
>>
>> http://cache.freescale.com/files/dsp/doc/ref_manual/MCIMX28RM.pdf

[...]

>>> For over_sample_delay, the DT bindings state a range of 1...2047. In
>>> mxs_lradc_setup_ts_channel(), line 440, the value decreased by one (0...2046)
>>> is written to register 0x100, bits 0-10. Question: which value range is valid
>>> there? The same happens in line 498.
> It's DELAY with the description: "This 11-bit field counts down to zero. At zero it triggers either a set of LRADC channel conversions or
> another delay channel, or both. It can trigger up to all eight LRADCs and all four delay channels in a single
> event. This counter operates on a 2KHz clock derived from crystal clock."
> So, the range is 0...2047.

There's also a "Note" on pages 2664-2665 of the reference manual:

"The DELAY fields in HW_LRADC_DELAY0, HW_LRADC_DELAY1, HW_LRADC_DELAY2,
and HW_LRADC_DELAY3 must be non-zero; otherwise, the LRADC will not
trigger the delay group."

So 0 isn't valid, leaving the actual range at 1..2047.

>>> For settling_delay, the DT bindings state a range of 1...2047. In
>>> mxs_lradc_setup_ts_channel(), line 458, that value is written to register
>>> 0xf0, bits 0-10. Question: what value range is valid here, 1...2047 or
>>> 0...2047? The same happens in line 517.
> This is the same as register 0x100, so 0...2047 is the valid range.

Yeah, 1..2047 again.

Note that we subtract 1 from over_sample_delay before writing it to a
register, so its DT range would be 2..2048. But we don't subtract
anything from settling_delay, so its DT range would be 1..2047. Probably
would be nicer to subtract 1 from neither (or both?), and have the DT
ranges be the same.

> Stefan, would you mind to change the DT documentation while you are on it?

Kristina
