Return-Path: <SRS0=TOo6=4C=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0423C2BA83
	for <linux-iio@archiver.kernel.org>; Fri, 14 Feb 2020 14:40:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93483222C4
	for <linux-iio@archiver.kernel.org>; Fri, 14 Feb 2020 14:40:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581691204;
	bh=lziv/SZEQ6r+Yvgnztzq03/H3mknBM/dOM2wQFVPhXQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=ArswMw+wLcAY5sNcKAxWbvATDHZaA2Jy5MSTd8B+rylf4TUZBVWwggX10fQHGLqPG
	 9BDgwJmIfBC0iMxzvZblPdW2cuQvQodh98jAnksGcgXiAqiGg/lSuPQ4EkiA3z6M+B
	 q30u6h6pAll7XS4hLe6PJ2eW/Qwmwqi201snr0dA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729399AbgBNOkE (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Fri, 14 Feb 2020 09:40:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:38444 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729359AbgBNOkE (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 14 Feb 2020 09:40:04 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E6B6F2187F;
        Fri, 14 Feb 2020 14:40:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581691203;
        bh=lziv/SZEQ6r+Yvgnztzq03/H3mknBM/dOM2wQFVPhXQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=nP3bWEej8Q5kZz79rYW92ADxhOkvzu/fpkddM5nb2u1AB0MzJ2v6KkE2GfuHtbkcv
         1IlgVm1BJ87cCaI7glCp7NRY/Vd0RFh0+HRhMfkEapVNZlrNc29C8j+e3Nm3psIiSR
         KqrXpfo+KnlwahNlKhNgWRUwn6sUHiNBntIOeEr0=
Date:   Fri, 14 Feb 2020 14:39:59 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <nuno.sa@analog.com>
Subject: Re: [PATCH v2 6/9] iio: imu: adis: Refactor adis_initial_startup
Message-ID: <20200214143959.3af07e37@archlinux>
In-Reply-To: <20200210132606.9315-6-alexandru.ardelean@analog.com>
References: <20200210132606.9315-1-alexandru.ardelean@analog.com>
        <20200210132606.9315-6-alexandru.ardelean@analog.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 10 Feb 2020 15:26:03 +0200
Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:

> From: Nuno S=C3=A1 <nuno.sa@analog.com>
>=20
> All the ADIS devices perform, at the beginning, a self test to make sure
> the device is in a sane state. Previously, the logic was that the self-te=
st
> was performed in adis_initial_startup() and if that failed a reset was do=
ne
> and then a self-test was attempted again.
>=20
> This change unifies the reset mechanism under the adis_initial_startup()
> call. A HW reset will be done if  GPIO is configured, or a SW reset
> otherwise. This should make sure that the chip is in a sane state for
> self-test. Once the reset is done, the self-test operation will be
> performed. If anything goes wrong with self-test, the driver should just
> bail/error-out (i.e. no second attempt). The chip would likely not be a in
> a sane state state if the self-test fails after a reset.
>=20
> Signed-off-by: Nuno S=C3=A1 <nuno.sa@analog.com>
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
A very small tweak in here..

Tweak made and patch applied to the togreg branch of iio.git and pushed out
as testing for the autobuilders to poke at it.

Thanks,

Jonathan

> ---
>  drivers/iio/imu/Kconfig |  1 +
>  drivers/iio/imu/adis.c  | 29 ++++++++++++++++++++++-------
>  2 files changed, 23 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/iio/imu/Kconfig b/drivers/iio/imu/Kconfig
> index 60bb1029e759..63036cf473c7 100644
> --- a/drivers/iio/imu/Kconfig
> +++ b/drivers/iio/imu/Kconfig
> @@ -85,6 +85,7 @@ endmenu
> =20
>  config IIO_ADIS_LIB
>  	tristate
> +	depends on GPIOLIB
This is needed. If we don't have GPIOLIB the gpio_get
will return NULL and we'll carry on as if one wasn't supplied in the first
place which should work fine.

As a side note, you can't do depends inside something that is selected and
expect the kernel build system to notice.  If this was actually needed
you would have gotten build errors in some configurations.


>  	help
>  	  A set of IO helper functions for the Analog Devices ADIS* device fami=
ly.
> =20
> diff --git a/drivers/iio/imu/adis.c b/drivers/iio/imu/adis.c
> index f7845a90f376..0bd6e32cf577 100644
> --- a/drivers/iio/imu/adis.c
> +++ b/drivers/iio/imu/adis.c
> @@ -7,6 +7,7 @@
>   */
> =20
>  #include <linux/delay.h>
> +#include <linux/gpio/consumer.h>
>  #include <linux/mutex.h>
>  #include <linux/device.h>
>  #include <linux/kernel.h>
> @@ -368,6 +369,10 @@ static int adis_self_test(struct adis *adis)
>   * __adis_initial_startup() - Device initial setup
>   * @adis: The adis device
>   *
> + * The function performs a HW reset via a reset pin that should be speci=
fied
> + * via GPIOLIB. If no pin is configured a SW reset will be performed.
> + * The RST pin for the ADIS devices should be configured as ACTIVE_LOW.
> + *
>   * Returns 0 if the device is operational, a negative error code otherwi=
se.
>   *
>   * This function should be called early on in the device initialization =
sequence
> @@ -375,18 +380,28 @@ static int adis_self_test(struct adis *adis)
>   */
>  int __adis_initial_startup(struct adis *adis)
>  {
> +	const struct adis_timeout *timeouts =3D adis->data->timeouts;
> +	struct gpio_desc *gpio;
>  	int ret;
> =20
> -	ret =3D adis_self_test(adis);
> -	if (ret) {
> -		dev_err(&adis->spi->dev, "Self-test failed, trying reset.\n");
> -		__adis_reset(adis);
> -		ret =3D adis_self_test(adis);
> +	/* check if the device has rst pin low */
> +	gpio =3D devm_gpiod_get_optional(&adis->spi->dev, "reset", GPIOD_ASIS);
> +	if (IS_ERR(gpio))
> +		return PTR_ERR(gpio);
> +
> +	if (gpio) {
> +		gpiod_set_value_cansleep(gpio, 1);
> +		msleep(10);
> +		/* bring device out of reset */
> +		gpiod_set_value_cansleep(gpio, 0);
> +		msleep(timeouts->reset_ms);
> +	} else {
> +		ret =3D __adis_reset(adis);
>  		if (ret)
> -			dev_err(&adis->spi->dev, "Second self-test failed, giving up.\n");
> +			return ret;
>  	}
> =20
> -	return ret;
> +	return adis_self_test(adis);
>  }
>  EXPORT_SYMBOL_GPL(__adis_initial_startup);
> =20

