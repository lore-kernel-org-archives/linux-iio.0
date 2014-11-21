Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.24]:64311 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750938AbaKUTia (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 21 Nov 2014 14:38:30 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Karol Wrona <k.wrona@samsung.com>
Cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
	Kyungmin Park <kyungmin.park@samsung.com>
Subject: Re: [PATCH v2 1/5] misc: sensorhub: Add sensorhub driver
Date: Fri, 21 Nov 2014 20:38:25 +0100
Message-ID: <3489864.y2krC9T9rK@wuerfel>
In-Reply-To: <1416593957-19788-2-git-send-email-k.wrona@samsung.com>
References: <1416593957-19788-1-git-send-email-k.wrona@samsung.com> <1416593957-19788-2-git-send-email-k.wrona@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Friday 21 November 2014 19:19:13 Karol Wrona wrote:
> Sensorhub  is MCU dedicated to collect data and manage several sensors.
> Sensorhub is a spi device which provides a layer for IIO devices. It provides
> some data parsing and common mechanism for sensorhub sensors.
> 
> Adds common sensorhub library for sensorhub driver and iio drivers
> which uses sensorhub MCU to communicate with sensors.
> 
> Signed-off-by: Karol Wrona <k.wrona@samsung.com>
> Acked-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
>  drivers/misc/Kconfig                   |    1 +
>  drivers/misc/Makefile                  |    1 +
>  drivers/misc/sensorhub/Kconfig         |   13 +
>  drivers/misc/sensorhub/Makefile        |    6 +
>  drivers/misc/sensorhub/ssp.h           |  279 +++++++++++
>  drivers/misc/sensorhub/ssp_dev.c       |  828 ++++++++++++++++++++++++++++++++
>  drivers/misc/sensorhub/ssp_spi.c       |  653 +++++++++++++++++++++++++
>  include/linux/iio/common/ssp_sensors.h |   79 +++

You seem to provide infrastructure for other drivers here, so I don't think
drivers/misc is a good place. Have you considered making this a regular
mfd driver? If that doesn't fit, is there possibly some place in the iio
framework for this kind of driver?

	Arnd
