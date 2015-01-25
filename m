Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.10]:54418 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751053AbbAYXHD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 25 Jan 2015 18:07:03 -0500
From: Marek Vasut <marex@denx.de>
To: Kristina =?utf-8?q?Mart=C5=A1enko?= <kristina.martsenko@gmail.com>
Subject: Re: [PATCH v2 0/4] iio: mxs-lradc: fix interactions between the touchscreen and the ADC
Date: Sun, 25 Jan 2015 19:47:17 +0100
Cc: Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	"Lars-Peter Clausen" <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Juergen Beisert <jbe@pengutronix.de>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Fabio Estevam <fabio.estevam@freescale.com>,
	Stefan Wahren <stefan.wahren@i2se.com>,
	"Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
	linux-iio@vger.kernel.org, devel@driverdev.osuosl.org
References: <1422203302-17090-1-git-send-email-kristina.martsenko@gmail.com>
In-Reply-To: <1422203302-17090-1-git-send-email-kristina.martsenko@gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Message-Id: <201501251947.17832.marex@denx.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sunday, January 25, 2015 at 05:28:18 PM, Kristina Martšenko wrote:
> These patches fix some issues with using the touchscreen and reading
> other ADC channels at the same time.

[...]

Hi!

Thanks!

Entire series

Reviewed-by: Marek Vasut <marex@denx.de>

Best regards,
Marek Vasut
