Return-Path: <stefan.wahren@i2se.com>
Date: Mon, 8 Dec 2014 20:40:56 +0100 (CET)
From: Stefan Wahren <stefan.wahren@i2se.com>
Reply-To: Stefan Wahren <stefan.wahren@i2se.com>
To: =?UTF-8?Q?=22Kristina_Mart=C5=A1enko=22?= <kristina.martsenko@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>
Cc: Fabio Estevam <festevam@gmail.com>, jbe@pengutronix.de,
	linux-iio@vger.kernel.org,
	=?UTF-8?Q?=22Marek_Va=C5=A1ut=22?= <marex@denx.de>
Message-ID: <1734429765.15308.1418067656122.JavaMail.open-xchange@oxbaltgw01.schlund.de>
In-Reply-To: <470431665.466653.1417354172281.JavaMail.open-xchange@oxbaltgw09.schlund.de>
References: <1416435590-13999-1-git-send-email-stefan.wahren@i2se.com> <CAOMZO5DJ7yyd47BKgm6AOAg=GGFdeswrb2NxA2krj3ATnRWPVQ@mail.gmail.com> <5479052B.2090308@gmx.de> <10217382.467571.1417260127187.JavaMail.open-xchange@oxbaltgw07.schlund.de> <547A14AA.6020405@gmx.de> <547B094A.4000508@gmail.com> <470431665.466653.1417354172281.JavaMail.open-xchange@oxbaltgw09.schlund.de>
Subject: Re: [PATCH] iio: mxs-lradc: check ranges of ts properties
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

> Stefan Wahren <stefan.wahren@i2se.com> hat am 30. November 2014 um 14:29
> geschrieben:
>
>
> Phew, i underestimated the consequences of my patch.
>
> @Jonathan: could you please drop or revert my patch, before Greg catchs i=
t?
>
> > Kristina Mart=C5=A1enko <kristina.martsenko@gmail.com> hat am 30. Novem=
ber 2014
> > um
> > 13:10 geschrieben:
> >
> >
> > On 29/11/14 20:47, Hartmut Knaack wrote:
> > > Stefan Wahren schrieb am 29.11.2014 um 12:22:
> > >>> Hartmut Knaack <knaack.h@gmx.de> hat am 29. November 2014 um 00:28
> > >>> geschrieben:
> > >>> Fabio Estevam schrieb am 19.11.2014 um 23:42:
> > >>>> [Adding Marek]
> > >>> Taking a closer look on how these values are used, I wondered what =
the
> > >>> real
> > >>> value range of the registers actually are. So, anyone with access t=
o the
> > >>> data
> > >>> sheets, please confirm.
> > >>
> > >> the reference manual is public:
> > >>
> > >> http://cache.freescale.com/files/dsp/doc/ref_manual/MCIMX28RM.pdf
> >
> > [...]
>
> Sorry for being so inprecise, we need to care of both SoCs. The reference
> manual
> for the i.MX23 is here:
>
> http://cache.freescale.com/files/dsp/doc/ref_manual/IMX23RM.pdf
>
> >
> > >>> For over_sample_delay, the DT bindings state a range of 1...2047. I=
n
> > >>> mxs_lradc_setup_ts_channel(), line 440, the value decreased by one
> > >>> (0...2046)
> > >>> is written to register 0x100, bits 0-10. Question: which value rang=
e is
> > >>> valid
> > >>> there? The same happens in line 498.
> > > It's DELAY with the description: "This 11-bit field counts down to ze=
ro.
> > > At
> > > zero it triggers either a set of LRADC channel conversions or
> > > another delay channel, or both. It can trigger up to all eight LRADCs=
 and
> > > all four delay channels in a single
> > > event. This counter operates on a 2KHz clock derived from crystal clo=
ck."
> > > So, the range is 0...2047.
> >
> > There's also a "Note" on pages 2664-2665 of the reference manual:
> >
> > "The DELAY fields in HW_LRADC_DELAY0, HW_LRADC_DELAY1, HW_LRADC_DELAY2,
> > and HW_LRADC_DELAY3 must be non-zero; otherwise, the LRADC will not
> > trigger the delay group."
> >
> > So 0 isn't valid, leaving the actual range at 1..2047.
>
> Thanks for pointing out. It would be wise to add this "note" into the dri=
ver.
>
> >
> > >>> For settling_delay, the DT bindings state a range of 1...2047. In
> > >>> mxs_lradc_setup_ts_channel(), line 458, that value is written to
> > >>> register
> > >>> 0xf0, bits 0-10. Question: what value range is valid here, 1...2047=
 or
> > >>> 0...2047? The same happens in line 517.
> > > This is the same as register 0x100, so 0...2047 is the valid range.
> >
> > Yeah, 1..2047 again.
> >
> > Note that we subtract 1 from over_sample_delay before writing it to a
> > register, so its DT range would be 2..2048. But we don't subtract
> > anything from settling_delay, so its DT range would be 1..2047. Probabl=
y
> > would be nicer to subtract 1 from neither (or both?), and have the DT
> > ranges be the same.
>
> Substracting unsigned values isn't good. But breaking DT compatibly also.
>
> >
> > > Stefan, would you mind to change the DT documentation while you are o=
n it?
>
> No problem, but these changes need at least a test with a touchscreen and=
 i
> don't have any.
>
> >
> > Kristina
>
> Stefan

ping ...
