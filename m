Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:49194 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752270Ab3IPJgP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 16 Sep 2013 05:36:15 -0400
From: =?iso-8859-1?q?J=FCrgen_Beisert?= <jbe@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 5/6] Staging/iio/adc/touchscreen/MXS: add interrupt driven touch detection
Date: Mon, 16 Sep 2013 11:37:31 +0200
Cc: devel@driverdev.osuosl.org, marex@denx.de,
	fabio.estevam@freescale.com, linux-iio@vger.kernel.org,
	Torokhov <dmitry.torokhov@gmail.com>, jic23@cam.ac.uk,
	"linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
	Jonathan Cameron <jic23@kernel.org>
References: <1378887511-24530-1-git-send-email-jbe@pengutronix.de> <52359259.8010202@kernel.org> <201309161010.22151.jbe@pengutronix.de>
In-Reply-To: <201309161010.22151.jbe@pengutronix.de>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201309161137.31411.jbe@pengutronix.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Jonathan,

On Monday 16 September 2013 10:10:22 Jürgen Beisert wrote:
> [...]
> > While this driver is placed in IIO within staging at the moment, these
> > changes are definitely input related.  Hence I have cc'd Dmitry and the
> > input list.
> >
> > I am personaly a little uncomfortable that we have such a complex bit of
> > input code sat within an IIO driver but such is life.
>
> Maybe an MFD for this ADC unit would be a better way to go? Currently I
> have a different problem with this driver, because the ADC unit monitors
> the battery as well. And the charging driver from the power subsystem needs
> these values to charge the battery in a correct manner.

I would suggest:

diff --git a/drivers/staging/iio/TODO b/drivers/staging/iio/TODO
index 04c2326..c22a0ed 100644
--- a/drivers/staging/iio/TODO
+++ b/drivers/staging/iio/TODO
@@ -13,6 +13,17 @@ Would be nice
 3) Expand device set. Lots of other maxim adc's have very
    similar interfaces.
 
+MXS LRADC driver:
+This is a classic MFD device as it combines the following subdevices
+ - touchscreen controller (input subsystem related device)
+ - general purpose ADC channels
+ - battery voltage monitor (power subsystem related device)
+ - die temperature monitor (thermal management)
+
+At least the battery voltage and die temperature feature is required in-kernel
+by a driver of the SoC's battery charging unit to avoid any damage to the
+silicon and the battery.
+
 TSL2561
 Would be nice
 1) Open question of userspace vs kernel space balance when

Regards,
Juergen

-- 
Pengutronix e.K.                              | Juergen Beisert             |
Linux Solutions for Science and Industry      | http://www.pengutronix.de/  |
