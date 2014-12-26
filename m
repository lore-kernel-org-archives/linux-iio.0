Return-Path: <stefan.wahren@i2se.com>
Date: Fri, 26 Dec 2014 21:50:37 +0100 (CET)
From: Stefan Wahren <stefan.wahren@i2se.com>
Reply-To: Stefan Wahren <stefan.wahren@i2se.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: kristina.martsenko@gmail.com, kernel@pengutronix.de, pawel.moll@arm.com,
	knaack.h@gmx.de, ijc+devicetree@hellion.org.uk, robh+dt@kernel.org,
	galak@codeaurora.org, festevam@gmail.com, mark.rutland@arm.com,
	linux-iio@vger.kernel.org, marex@denx.de, devicetree@vger.kernel.org
Message-ID: <1377154085.658607.1419627037868.JavaMail.open-xchange@oxbaltgw05.schlund.de>
In-Reply-To: <549D2905.4050801@kernel.org>
References: <1419250476-2393-1-git-send-email-stefan.wahren@i2se.com> <1419250476-2393-3-git-send-email-stefan.wahren@i2se.com> <549D2905.4050801@kernel.org>
Subject: Re: [PATCH 2/2] iio: mxs-lradc: check ranges of ts properties
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

Hi Jonathan,

> Jonathan Cameron <jic23@kernel.org> hat am 26. Dezember 2014 um 10:23
> geschrieben:
>
> [...]
> >
> > - lradc->over_sample_delay = 2;
> > - ret = of_property_read_u32(lradc_node, "fsl,ave-delay", &adapt);
> > - if (ret == 0)
> > + if (of_property_read_u32(lradc_node, "fsl,ave-delay", &adapt)) {
> > + lradc->over_sample_delay = 2;
> > + } else {
> > + if (adapt < 2 || adapt > LRADC_DELAY_DELAY_MASK+1) {
> please run checkpatch.pl over these. Should be spaces around the +

i'm afraid my checkpatch.pl doesn't find this issue. I'll fix it in the next
version.

Stefan
