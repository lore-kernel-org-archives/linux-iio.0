Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:43165 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752546Ab2GIJTz (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 9 Jul 2012 05:19:55 -0400
From: Juergen Beisert <jbe@pengutronix.de>
To: Marek Vasut <marex@denx.de>
Subject: Re: [PATCH] IIO: Add basic MXS LRADC driver
Date: Mon, 9 Jul 2012 11:19:44 +0200
Cc: linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <1341368129-20468-1-git-send-email-marex@denx.de>
In-Reply-To: <1341368129-20468-1-git-send-email-marex@denx.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <201207091119.44952.jbe@pengutronix.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Marek,

Marek Vasut wrote:
> This driver is very basic. It supports userland trigger, buffer and
> raw access to channels. The support for delay channels is missing
> altogether.
>
> Signed-off-by: Marek Vasut <marex@denx.de>
> Cc: Jonathan Cameron <jic23@kernel.org>
> Cc: Wolfgang Denk <wd@denx.de>
> Cc: Juergen Beisert <jbe@pengutronix.de>
> ---
>  drivers/staging/iio/adc/Kconfig     |   12 +
>  drivers/staging/iio/adc/Makefile    |    1 +
>  drivers/staging/iio/adc/mxs-lradc.c |  619 +++++++++++++++++++++++++++++++++++
>  3 files changed, 632 insertions(+) 
>  create mode 100644 drivers/staging/iio/adc/mxs-lradc.c
>
> [...]

sorry for the delay, too much work at the same time. When I try to compile
your code I get:

drivers/staging/iio/adc/mxs-lradc.c:42:40: fatal error: linux/iio/triggered_buffer.h: No such file or directory

Regards,
Juergen

-- 
Pengutronix e.K.                              | Juergen Beisert             |
Linux Solutions for Science and Industry      | http://www.pengutronix.de/  |
