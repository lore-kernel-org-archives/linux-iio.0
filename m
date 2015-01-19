Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.10]:56641 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751066AbbASH56 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 19 Jan 2015 02:57:58 -0500
From: Marek Vasut <marex@denx.de>
To: Juergen Borleis <jbe@pengutronix.de>
Subject: Re: [PATCH 3/4] iio: mxs-lradc: make ADC reads not unschedule touchscreen conversions
Date: Mon, 19 Jan 2015 08:57:49 +0100
Cc: Kristina =?utf-8?q?Mart=C5=A1enko?=
	<kristina.martsenko@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	"Lars-Peter Clausen" <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Fabio Estevam <fabio.estevam@freescale.com>,
	Stefan Wahren <stefan.wahren@i2se.com>,
	"Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
	linux-iio@vger.kernel.org, devel@driverdev.osuosl.org
References: <1421454131-3501-1-git-send-email-kristina.martsenko@gmail.com> <1421454131-3501-4-git-send-email-kristina.martsenko@gmail.com> <201501190820.32090.jbe@pengutronix.de>
In-Reply-To: <201501190820.32090.jbe@pengutronix.de>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Message-Id: <201501190857.50107.marex@denx.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Monday, January 19, 2015 at 08:20:31 AM, Juergen Borleis wrote:
> Hi Kristina,

Hi all,

> On Saturday 17 January 2015 01:22:10 Kristina Martšenko wrote:
> > Reading a channel through sysfs, or starting a buffered capture, can
> > occasionally turn off the touchscreen.
> > [...]
> 
> I have my old ChumbyOne around (i.MX23). How to test this buffered capture
> while using the touchscreen part of the ADC (I have never used the IIO
> before).

Last time I checked there was drivers/staging/iio/Documentation/generic_buffer.c 
, but you can also wait for a more precise advice from Kristina . Hope it helps
at least a bit ;-)

Best regards,
Marek Vasut
