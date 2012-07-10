Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:44787 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754561Ab2GJJVH (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 10 Jul 2012 05:21:07 -0400
From: Juergen Beisert <jbe@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] IIO: Add basic MXS LRADC driver
Date: Tue, 10 Jul 2012 11:20:52 +0200
Cc: Marek Vasut <marex@denx.de>, linux-iio@vger.kernel.org
References: <1341368129-20468-1-git-send-email-marex@denx.de> <201207091119.44952.jbe@pengutronix.de> <201207091203.09371.marex@denx.de>
In-Reply-To: <201207091203.09371.marex@denx.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <201207101120.52892.jbe@pengutronix.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Marek,

> > When I try to compile
> > your code I get:
> >
> > drivers/staging/iio/adc/mxs-lradc.c:42:40: fatal error:
> > linux/iio/triggered_buffer.h: No such file or directory
>
> You need this patches:
>     iio:kfifo_buf Take advantage of the fixed record size used in IIO
>     iio: kfifo - add poll support.
>
> And use latest -next.

Thanks for the hints. Now it compiles and the driver seems to work.

One thing I do not understand: It does not matter what channel I read 
('in_voltage*_raw'), only interrupt 16 ('mxs-lradc-channel0') counts up. 
Intended?
Or did I a mistake by adding interrupt numbers "<13 14 15 16 17 18 19 20 21 22 
23 24 25>" to the corresponding device tree entry?

Regards,
Juergen

-- 
Pengutronix e.K.                              | Juergen Beisert             |
Linux Solutions for Science and Industry      | http://www.pengutronix.de/  |
