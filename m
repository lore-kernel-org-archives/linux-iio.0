Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:38787 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753395Ab3IWHlI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 23 Sep 2013 03:41:08 -0400
From: =?iso-8859-1?q?J=FCrgen_Beisert?= <jbe@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 7/7] Staging/iio/adc/touchscreen/MXS: provide devicetree adaption
Date: Mon, 23 Sep 2013 09:42:29 +0200
Cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
	devel@driverdev.osuosl.org, marex@denx.de,
	fabio.estevam@freescale.com,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
References: <1379593369-22010-1-git-send-email-jbe@pengutronix.de> <1379593369-22010-8-git-send-email-jbe@pengutronix.de> <523D943D.705@kernel.org>
In-Reply-To: <523D943D.705@kernel.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201309230942.29417.jbe@pengutronix.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Jonathan,

On Saturday 21 September 2013 14:42:37 Jonathan Cameron wrote:
> The device tree list has moved, so I've changed the cc.
>
> Few comments inline.  Basically I'd go for longer more
> descriptive names when the abreviation isn't a really
> well known common one.
>
> Note I'm not all that familiar with device tree conventions
> so may be barking up the wrong tree ;)
>
> > [...]
> > @@ -9,13 +10,38 @@ Optional properties:
> >  - fsl,lradc-touchscreen-wires: Number of wires used to connect the
> > touchscreen to LRADC. Valid value is either 4 or 5. If this property is
> > not present, then the touchscreen is -                              
> > disabled.
>
> Do we want that lradc prefix on these other properties?

The question is, if we want to keep it. This is the currently used binding.

> > +                               disabled. 5 wires is valid for i.MX28 SoC only.
> > +- fsl,ave-ctrl: number of samples per direction to calculate an average value.
> > +                Allowed value is 1 ... 31, default is 4 
>
> This naming seems less than informative, what about fsl,average_num_samples
> of average_count (ave isn't all that obvious an abrevaition of average).

I used already existing names from
"Documentation/devicetree/bindings/input/touchscreen/stmpe.txt".

> > +- fsl,ave-delay: delay between consecutive samples. Allowed value is
> > +                 1 ... 2047. It is used if 'fsl,ave-ctrl' > 1, counts at
> > +                 2 kHz and its default is 2 (= 1 ms)
>
> fsl,average_intersample_delay (I assume any limit of device tree property
> names is longer than that?)

If the parameter description in "Documentation/devicetree/bindings" is useful,
we don't need long parameter names. If there is no useful parameter
description, we will need long names ;)

Regards,
Juergen

-- 
Pengutronix e.K.                              | Juergen Beisert             |
Linux Solutions for Science and Industry      | http://www.pengutronix.de/  |
