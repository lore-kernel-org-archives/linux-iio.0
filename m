Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-lb0-f180.google.com ([209.85.217.180]:33826 "EHLO
	mail-lb0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754752AbcBCH4j (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 3 Feb 2016 02:56:39 -0500
MIME-Version: 1.0
In-Reply-To: <5127664.OXcBoKUPQO@wuerfel>
References: <5127664.OXcBoKUPQO@wuerfel>
From: Matt Ranostay <mranostay@gmail.com>
Date: Tue, 2 Feb 2016 23:55:58 -0800
Message-ID: <CAKzfze8b7Q4ZHyXW=wq4K2ETFoMrfERpTci2dSAzSgCCrWpnzg@mail.gmail.com>
Subject: Re: [PATCH] iio: chemical: select IRQ_WORK for ATLAS ph sensor
To: Arnd Bergmann <arnd@arndb.de>
Cc: Jonathan Cameron <jic23@kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Reviewed-by: Matt Ranostay <mranostay@gmail.com>

On Tue, Feb 2, 2016 at 6:36 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> The newly added atlas-ph-sensor driver uses irq_work_queue, which
> may not always be enabled:
>
> ERROR: "irq_work_queue" [drivers/iio/chemical/atlas-ph-sensor.ko] undefined!
>
> This adds a 'select' statement to Kconfig to ensure it's there
> when we need it.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: 27dec00ecf2d ("iio: chemical: add Atlas pH-SM sensor support")
>
> diff --git a/drivers/iio/chemical/Kconfig b/drivers/iio/chemical/Kconfig
> index ce7cd1370f74..f73290f84c90 100644
> --- a/drivers/iio/chemical/Kconfig
> +++ b/drivers/iio/chemical/Kconfig
> @@ -10,6 +10,7 @@ config ATLAS_PH_SENSOR
>         select REGMAP_I2C
>         select IIO_BUFFER
>         select IIO_TRIGGERED_BUFFER
> +       select IRQ_WORK
>         help
>          Say Y here to build I2C interface support for the Atlas
>          Scientific OEM pH-SM sensor.
>
