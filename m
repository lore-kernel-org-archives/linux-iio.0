Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:51283 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750968AbbASHTB convert rfc822-to-8bit (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 19 Jan 2015 02:19:01 -0500
From: Juergen Borleis <jbe@pengutronix.de>
To: Kristina =?utf-8?q?Mart=C5=A1enko?= <kristina.martsenko@gmail.com>
Subject: Re: [PATCH 3/4] iio: mxs-lradc: make ADC reads not unschedule touchscreen conversions
Date: Mon, 19 Jan 2015 08:20:31 +0100
Cc: Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	"Lars-Peter Clausen" <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Marek Vasut <marex@denx.de>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Fabio Estevam <fabio.estevam@freescale.com>,
	Stefan Wahren <stefan.wahren@i2se.com>,
	"Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
	linux-iio@vger.kernel.org, devel@driverdev.osuosl.org
References: <1421454131-3501-1-git-send-email-kristina.martsenko@gmail.com> <1421454131-3501-4-git-send-email-kristina.martsenko@gmail.com>
In-Reply-To: <1421454131-3501-4-git-send-email-kristina.martsenko@gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Message-Id: <201501190820.32090.jbe@pengutronix.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Kristina,

On Saturday 17 January 2015 01:22:10 Kristina Martšenko wrote:
> Reading a channel through sysfs, or starting a buffered capture, can
> occasionally turn off the touchscreen.
> [...]

I have my old ChumbyOne around (i.MX23). How to test this buffered capture 
while using the touchscreen part of the ADC (I have never used the IIO 
before).

Regards,
Juergen

-- 
Pengutronix e.K.                              | Juergen Borleis             |
Industrial Linux Solutions                    | http://www.pengutronix.de/  |
