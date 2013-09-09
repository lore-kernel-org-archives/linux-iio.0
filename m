Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.9]:55268 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753919Ab3IIQFV (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 9 Sep 2013 12:05:21 -0400
From: Marek Vasut <marex@denx.de>
To: Juergen Beisert <jbe@pengutronix.de>
Subject: Re: [PATCH 3/5] Staging/iio/adc/touchscreen/MXS: add i.MX23 support to the LRADC driver
Date: Mon, 9 Sep 2013 18:04:19 +0200
Cc: linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	devel@driverdev.osuosl.org, fabio.estevam@freescale.com,
	jic23@cam.ac.uk
References: <1378713801-1182-1-git-send-email-jbe@pengutronix.de> <1378713801-1182-4-git-send-email-jbe@pengutronix.de>
In-Reply-To: <1378713801-1182-4-git-send-email-jbe@pengutronix.de>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Message-Id: <201309091804.20177.marex@denx.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Dear Juergen Beisert,

> Distinguish i.MX23 and i.MX28 at runtime and do the same for both SoC at
> least for the 4 wire touchscreen.
> 
> Signed-off-by: Juergen Beisert <jbe@pengutronix.de>
> CC: linux-arm-kernel@lists.infradead.org
> CC: devel@driverdev.osuosl.org
> CC: Marek Vasut <marex@denx.de>
> CC: Fabio Estevam <fabio.estevam@freescale.com>
> CC: Jonathan Cameron <jic23@cam.ac.uk>

This patch seems to combine two things -- register access rework AND adjustment 
of the driver for MX23 touchscreen. Btw the MX23 ADC was already supported, so 
this "add i.MX23 support" commit message is not accurate.

Best regards,
Marek Vasut
