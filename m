Return-Path: <stefan.wahren@i2se.com>
Date: Sat, 29 Nov 2014 12:22:07 +0100 (CET)
From: Stefan Wahren <stefan.wahren@i2se.com>
Reply-To: Stefan Wahren <stefan.wahren@i2se.com>
To: Hartmut Knaack <knaack.h@gmx.de>, Fabio Estevam <festevam@gmail.com>,
	=?UTF-8?Q?=22Marek_Va=C5=A1ut=22?= <marex@denx.de>
Cc: =?UTF-8?Q?=22Kristina_Mart=C5=A1enko=22?= <kristina.martsenko@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
	jbe@pengutronix.de
Message-ID: <10217382.467571.1417260127187.JavaMail.open-xchange@oxbaltgw07.schlund.de>
In-Reply-To: <5479052B.2090308@gmx.de>
References: <1416435590-13999-1-git-send-email-stefan.wahren@i2se.com> <CAOMZO5DJ7yyd47BKgm6AOAg=GGFdeswrb2NxA2krj3ATnRWPVQ@mail.gmail.com> <5479052B.2090308@gmx.de>
Subject: Re: [PATCH] iio: mxs-lradc: check ranges of ts properties
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

Hi Hartmut,

> Hartmut Knaack <knaack.h@gmx.de> hat am 29. November 2014 um 00:28
> geschrieben:
>
>
> Fabio Estevam schrieb am 19.11.2014 um 23:42:
> > [Adding Marek]
> Taking a closer look on how these values are used, I wondered what the real
> value range of the registers actually are. So, anyone with access to the data
> sheets, please confirm.

the reference manual is public:

http://cache.freescale.com/files/dsp/doc/ref_manual/MCIMX28RM.pdf

> Starting with over_sample_cnt, which according to the DT bindings has a range
> of 1...31. In mxs_lradc_setup_ts_channel(), currently line 429, the value
> decreased by one (0...30) gets written to register 0x50 (+ 0x10 for each
> channel) to bits 24-29. Question: What is the right value range there, 0...30
> or 0...31?

Yes, looks like an off-by-one issue. The register range is 0..31 so i would
assume the DT property range should be logically 1..32. But i don't have checked
the reference manual about that.

> In the same function, line 440, the value decreased by one (0...30) is written
> to register 0x100 into bits 11-15. Same question here: What is the right value
> range?
> The same behavior can be found in mxs_lradc_setup_ts_pressure() in lines 485
> and 498.
> For over_sample_delay, the DT bindings state a range of 1...2047. In
> mxs_lradc_setup_ts_channel(), line 440, the value decreased by one (0...2046)
> is written to register 0x100, bits 0-10. Question: which value range is valid
> there? The same happens in line 498.
> For settling_delay, the DT bindings state a range of 1...2047. In
> mxs_lradc_setup_ts_channel(), line 458, that value is written to register
> 0xf0, bits 0-10. Question: what value range is valid here, 1...2047 or
> 0...2047? The same happens in line 517.
> Thanks,
>
> Hartmut
> >

Stefan
