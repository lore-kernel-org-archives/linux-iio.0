Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.10]:38516 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754255Ab3AKXgE (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 11 Jan 2013 18:36:04 -0500
From: Marek Vasut <marex@denx.de>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/2 V3] iio: mxs: Implement support for touchscreen
Date: Sat, 12 Jan 2013 00:36:03 +0100
Cc: linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Fabio Estevam <fabio.estevam@freescale.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Shawn Guo <shawn.guo@linaro.org>
References: <1357861431-8978-1-git-send-email-marex@denx.de> <20130111165420.GA11224@core.coreip.homeip.net>
In-Reply-To: <20130111165420.GA11224@core.coreip.homeip.net>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Message-Id: <201301120036.03499.marex@denx.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Dmitry,

> Hi Marek,
> 
> On Fri, Jan 11, 2013 at 12:43:50AM +0100, Marek Vasut wrote:
> > This patch implements support for sampling of a touchscreen into
> > the MXS LRADC driver. The LRADC block allows configuring some of
> > it's channels into special mode where they either output the drive
> > voltage or sample it, allowing it to operate a 4-wire or 5-wire
> > resistive touchscreen.

[...]

> Besides the minor nits above,
> 
> Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> 
> Thanks!

Fixed the issues and rolled V4. Thank you for the reviews and the help!

Best regards,
Marek Vasut
