Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:50636 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751753AbdHTK0H (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 20 Aug 2017 06:26:07 -0400
Date: Sun, 20 Aug 2017 11:22:42 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc: Linus Walleij <linus.walleij@linaro.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH 2/4] iio: magnetometer: ak8974: add_device_randomness(fw
 + serial)
Message-ID: <20170820112242.3008c3f8@archlinux>
In-Reply-To: <a90b0e9c8886114903498890a0ae2c66cb19b5f3.1502977929.git.mirq-linux@rere.qmqm.pl>
References: <cover.1502977929.git.mirq-linux@rere.qmqm.pl>
        <a90b0e9c8886114903498890a0ae2c66cb19b5f3.1502977929.git.mirq-linux@rere.qmqm.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, 17 Aug 2017 15:56:11 +0200
Michał Mirosław <mirq-linux@rere.qmqm.pl> wrote:

> Mix device-specific data into randomness pool.
> 
> Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>

Hmm. I wondered about the firmware version as a source of randomness, but
will leave it in here.

Applied to the togreg branch of iio.git and pushed out as testing.

Thanks,

Jonathan

> ---
>  drivers/iio/magnetometer/ak8974.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/iio/magnetometer/ak8974.c b/drivers/iio/magnetometer/ak8974.c
> index 76091da20a0c..ab204f8560e3 100644
> --- a/drivers/iio/magnetometer/ak8974.c
> +++ b/drivers/iio/magnetometer/ak8974.c
> @@ -20,6 +20,7 @@
>  #include <linux/mutex.h>
>  #include <linux/delay.h>
>  #include <linux/bitops.h>
> +#include <linux/random.h>
>  #include <linux/regmap.h>
>  #include <linux/regulator/consumer.h>
>  #include <linux/pm_runtime.h>
> @@ -466,10 +467,12 @@ static int ak8974_detect(struct ak8974 *ak8974)
>  		ret = regmap_read(ak8974->map, AMI305_VER, &fw);
>  		if (ret)
>  			return ret;
> +		add_device_randomness(&fw, sizeof(fw));

The firmware version seems rather to guessable to really count as randomness.
presumably it would constant for a particular batch of chips.


>  		fw &= 0x7f; /* only bits 0 thru 6 valid */
>  		ret = ak8974_get_u16_val(ak8974, AMI305_SN, &sn);
>  		if (ret)
>  			return ret;
> +		add_device_randomness(&sn, sizeof(sn));

This is better.  The serial number should be hard to guess on a particular
part.

Jonathan
>  		dev_info(&ak8974->i2c->dev,
>  			 "detected %s, FW ver %02x, S/N: %04x\n",
>  			 name, fw, sn);

