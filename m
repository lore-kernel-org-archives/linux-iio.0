Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:42746 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751062Ab3IPINM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 16 Sep 2013 04:13:12 -0400
From: =?iso-8859-1?q?J=FCrgen_Beisert?= <jbe@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 4/6] Staging/iio/adc/touchscreen/MXS: add i.MX23 support to the LRADC touchscreen driver
Date: Mon, 16 Sep 2013 10:14:27 +0200
Cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
	devel@driverdev.osuosl.org, marex@denx.de,
	fabio.estevam@freescale.com, jic23@cam.ac.uk
References: <1378887511-24530-1-git-send-email-jbe@pengutronix.de> <1378887511-24530-5-git-send-email-jbe@pengutronix.de> <523590E1.6030309@kernel.org>
In-Reply-To: <523590E1.6030309@kernel.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201309161014.27482.jbe@pengutronix.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Jonathan,

On Sunday 15 September 2013 12:50:09 Jonathan Cameron wrote:
> On 09/11/13 09:18, Juergen Beisert wrote:
> > Distinguish i.MX23 and i.MX28 at runtime and do the same for both SoC at
> > least for the 4 wire touchscreen.
> >
> > Note: support for the remaining LRADC channels is not tested on an
> > i.MX23 yet.
>
> An ominous comment. Are you likely to test them soon?

Sorry, currently no i.MX28 hardware available. Someone out here with an i.MX28 
based system with a touchscreen to test? 

> Minor code layout comment inline but otherwise I'm just looking for an
> ack from Marek.
>
> > [...]
> >  static u32 mxs_lradc_drive_pressure(struct mxs_lradc *lradc)
> >  {
> > +	if (lradc->soc == IMX23_LRADC)
> > +		return LRADC_CTRL0_MX23_YP | LRADC_CTRL0_MX23_XM;
> >  	return LRADC_CTRL0_MX28_YPPSW | LRADC_CTRL0_MX28_XNNSW;
>
> Whilst it obviously doesn't actually matter, having an else
> in there would make the code more consistent so personally
> I would prefer it to be there.

I can change it. Anyone here with objections against such a change?

Regards
Juergen

-- 
Pengutronix e.K.                              | Juergen Beisert             |
Linux Solutions for Science and Industry      | http://www.pengutronix.de/  |
