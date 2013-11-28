Return-Path: <shawn.guo@linaro.org>
Date: Thu, 28 Nov 2013 10:01:44 +0800
From: Shawn Guo <shawn.guo@linaro.org>
To: Jonathan Cameron <jic23@kernel.org>
CC: Otavio Salvador <otavio@ossystems.com.br>, Fugang Duan
	<fugang.duan@freescale.com>, "sachin.kamat@linaro.org"
	<sachin.kamat@linaro.org>, Frank Li <Frank.Li@freescale.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v2 2/3] iio:adc:imx: add Freescale Vybrid vf610 adc driver
Message-ID: <20131128020142.GA5850@S2101-09.ap.freescale.net>
References: <1385430172-16642-1-git-send-email-B38611@freescale.com>
 <1385430172-16642-3-git-send-email-B38611@freescale.com>
 <20131126072058.GM30476@S2101-09.ap.freescale.net>
 <9848F2DB572E5649BA045B288BE08FBE01895AF4@039-SN2MPN1-023.039d.mgd.msft.net>
 <20131126080343.GO30476@S2101-09.ap.freescale.net>
 <CAP9ODKqSnhJPFjmVRim290h7dnBPcDwtLoJQHXY9NLPCDMBjpg@mail.gmail.com>
 <9848F2DB572E5649BA045B288BE08FBE018988A3@039-SN2MPN1-023.039d.mgd.msft.net>
 <CAP9ODKqQAmCfTjrWdMB6enM-x_pZhf0K5FOtb6H9uQhBUC_6gw@mail.gmail.com>
 <6d35aa36-cfbd-4df5-af2f-cf0deccaf43c@email.android.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <6d35aa36-cfbd-4df5-af2f-cf0deccaf43c@email.android.com>
List-ID: <linux-iio@vger.kernel.org>

On Wed, Nov 27, 2013 at 06:54:22AM +0000, Jonathan Cameron wrote:
> >>>I know this is not my call but I would prefer it had a imx-adc and in
> >the
> >>>Kconfig help you explain clearly which SoCs it will/support. It will
> >be strange
> >>>to have i.MX6SLX using a VF610 ADC :-(
> >>
> >> i.MX6SLX ADC IP inherit VF610 ADC IP. The VF610 ADC support hardware
> >trigger from PDB (The Programmable Delay Block), but i.MX6SLX don't
> >support hardware trigger.
> >> So, for the driver feature expander, there have difference for VF610
> >and i.MX6SLX. VF610 use the compatible "vf610-adc", i.MX6SLX use
> >"imx-adc".
> >
> >I see; but the source code will be vf610_adc.c; I'd expect it to be
> >imx_adc.c
> Firstly imx-adc is not going to work. Imx6-adc would be fine.  If you go with simply Imx-adc you are implying it will work with ALL
>  imx ADC IP. That is already untrue as this is the second driver for an ADC on an imx chip. Secondly convention is that naming goes
>  with the first supported part.

I'm all for this idea, and vf610_adc is perfectly fine to be used in
naming.  But we indeed need to update Kconfig prompt and help text to
make it clear that the driver also supports i.MX6SLX when that happens.

Shawn

> Having said that I don't care that strongly if everyone wants imx6-adc.
