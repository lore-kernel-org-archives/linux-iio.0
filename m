Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.karo-electronics.de ([81.173.242.67]:60413 "EHLO
	mail.karo-electronics.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753395Ab3IWJ0M (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 23 Sep 2013 05:26:12 -0400
Message-ID: <21056.2292.381138.583291@ipc1.ka-ro>
Date: Mon, 23 Sep 2013 11:25:08 +0200
From: =?utf-8?Q?Lothar_Wa=C3=9Fmann?= <LW@KARO-electronics.de>
To: =?utf-8?Q?J=C3=BCrgen?= Beisert <jbe@pengutronix.de>
Cc: linux-arm-kernel@lists.infradead.org, Marek Vasut <marex@denx.de>,
	linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
	fabio.estevam@freescale.com, jic23@cam.ac.uk
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Subject: Re: [PATCHv5] staging/iio/adc: change the MXS touchscreen driver
 implementation
In-Reply-To: <201309230955.58828.jbe@pengutronix.de>
References: <1379593369-22010-1-git-send-email-jbe@pengutronix.de>
	<201309230155.04914.marex@denx.de>
	<201309230955.58828.jbe@pengutronix.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi,

Jürgen Beisert writes:
> Hi Marek,
> 
> Seems the very first touch detection does not work. A colleague just told me, 
> we have an i.MX28 based hardware here and maybe a touchscreen from a different 
> platform which maybe can be used with the i.MX28 platform. Stay tuned...
> 
> > btw. the touchscreen connection on M28EVK is pretty much the same as on
> > MX28EVK.
> 
> I think the touchscreen connection on MX28EVK is exactly the same as on 
> MX28EVK! ;) (/me needs more coffee as well)
> 
Just tested the touchscreen driver on our TX28 module and I could not
find any problems.


Lothar Waßmann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstraße 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Geschäftsführer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info@karo-electronics.de
___________________________________________________________
