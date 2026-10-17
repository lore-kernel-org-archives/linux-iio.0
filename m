Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7191931B828;
	Sat, 17 Oct 2026 18:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792262377; cv=none; b=RCEyZdf1IV+T7tiu/cTOjFiaex1wqbHlGiQFmp47UU3LM6V/7Q8mBZQfvIJ7syvBp8Snta6tiDoYer8uGVuQiDogGklqQCDyRtPUHtsJmapRC/zdI0hSITx9+0m8lzbhHwt/hRu7r+T8GawK68g61fnjR8nH4JwTvYsVA8gUzGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792262377; c=relaxed/simple;
	bh=QiL16Zl2SSdiOlxnCfPNYhNmN7h6vHcmmdNb4/yM5GA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WLDIuC648+m4SpHkMsUgdxQzT1ByPaCt3uZhL51Ot8wcCvT3OMFNpYUfQFyYfQSXKP6LbFLE1IO+IQ+rlg9NGTe86tEFHKlQd4jgHGHfre+9l1EOCiiS3IFY4+qmtFxA/nrfZpf2w8lgV+pw7phze3tCLaYJarYjg7ray6w2/yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aJley54W; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aJley54W"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AD321F000C4;
	Sat, 17 Oct 2026 18:39:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792262376;
	bh=+kpb7sJgU9MLwUtO242t+UILHZlgnaHirthlLcE4U8E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=aJley54WCYa6MzJSeof7ppApot1BLkAAOFy94yH0/lFBAidr8OEVpDpgCNnjsjgRr
	 OZ5f2NU4PJfj79rHfmmp+9aAhwVq7nSttDqNu1PZ5h/y0gFFnTjYUiVfDCDLPPfybc
	 MHG96+amM/saIenlMHZp4jRlPJ5fPbPuGVdJbxgJIYR8o/KEU2NyP2dGC58dwUWj97
	 23s7aaSBC8LEJsjncd5y0MvUfszQf2Rijhtuph0zgmhrpm4ZpT56Pvo9Wrzt/hasE6
	 WbliM7MDGwemcWvtWKArt9ktQH4o9kPlwkANz4nsBSiRz+WLEs6f1g7G0mYnX5qllC
	 CHc4EQMc9qIPw==
Date: Sat, 17 Oct 2026 19:39:29 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Marcelo Schmitt <marcelo.schmitt@analog.com>
Cc: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux@analog.com>, <nuno.sa@analog.com>,
 <dlechner@baylibre.com>, <andy@kernel.org>, <Michael.Hennerich@analog.com>,
 <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
 <corbet@lwn.net>, <skhan@linuxfoundation.org>,
 <marcelo.schmitt1@gmail.com>, Andy Shevchenko <andriy.shevchenko@intel.com>
Subject: Re: [PATCH v5 05/15] iio: adc: ad4134: Serialize single-read
 operations
Message-ID: <20261017193929.12ce61bc@jic23-hlaptop>
In-Reply-To: <fadebc9f9fd6fe3924d086bdd7f549555dc069bb.1792200021.git.marcelo.schmitt@analog.com>
References: <cover.1792200021.git.marcelo.schmitt@analog.com>
	<fadebc9f9fd6fe3924d086bdd7f549555dc069bb.1792200021.git.marcelo.schmitt@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 16 Oct 2026 22:57:47 -0300
Marcelo Schmitt <marcelo.schmitt@analog.com> wrote:

> Protect single-sample read operations from going wrong if two or more of
> them run concurrently. Serialize the data read operation so to avoid
> single-sample read requests disrupting each other.

Why isn't this a fix (with appropriate fixes tag)?
If nothing else comes up and you agree it should have one just
reply to this email with it.

Otherwise LGTM

>=20
> Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> ---
>  drivers/iio/adc/ad4134.c | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/iio/adc/ad4134.c b/drivers/iio/adc/ad4134.c
> index dc2b32c73a3a..dc4d801490db 100644
> --- a/drivers/iio/adc/ad4134.c
> +++ b/drivers/iio/adc/ad4134.c
> @@ -7,6 +7,7 @@
>  #include <linux/array_size.h>
>  #include <linux/bitfield.h>
>  #include <linux/bitops.h>
> +#include <linux/cleanup.h>
>  #include <linux/clk.h>
>  #include <linux/crc8.h>
>  #include <linux/delay.h>
> @@ -15,6 +16,7 @@
>  #include <linux/export.h>
>  #include <linux/gpio/consumer.h>
>  #include <linux/module.h>
> +#include <linux/mutex.h>
>  #include <linux/regmap.h>
>  #include <linux/regulator/consumer.h>
>  #include <linux/reset.h>
> @@ -98,6 +100,11 @@ struct ad4134_state {
>  	struct regmap *regmap;
>  	unsigned long sys_clk_hz;
>  	struct gpio_desc *odr_gpio;
> +	/*
> +	 * Synchronize access to device state fields and ensure atomicity of
> +	 * consecutive register access operations.
> +	 */
> +	struct mutex sync_lock;
>  	int refin_mv;
>  	/*
>  	 * DMA (thus cache coherency maintenance) requires the transfer buffers
> @@ -257,7 +264,9 @@ static int ad4134_read_raw(struct iio_dev *indio_dev,
>  	int ret;
> =20
>  	switch (info) {
> -	case IIO_CHAN_INFO_RAW:
> +	case IIO_CHAN_INFO_RAW: {
> +		guard(mutex)(&st->sync_lock);
> +
>  		gpiod_set_value_cansleep(st->odr_gpio, 1);
>  		/*
>  		 * For slave mode gated DCLK (data sheet page 11), the minimum
> @@ -276,6 +285,7 @@ static int ad4134_read_raw(struct iio_dev *indio_dev,
>  			return ret;
> =20
>  		return IIO_VAL_INT;
> +	}
>  	case IIO_CHAN_INFO_SCALE:
>  		*val =3D st->refin_mv;
>  		*val2 =3D AD4134_CHAN_PRECISION_BITS - 1;
> @@ -445,6 +455,10 @@ static int ad4134_probe(struct spi_device *spi)
>  	fsleep(AD4134_RESET_TIME_US);
>  	crc8_populate_msb(ad4134_spi_crc_table, AD4134_SPI_CRC_POLYNOM);
> =20
> +	ret =3D devm_mutex_init(dev, &st->sync_lock);
> +	if (ret)
> +		return ret;
> +
>  	st->regmap =3D devm_regmap_init(dev, NULL, st, &ad4134_regmap_config);
>  	if (IS_ERR(st->regmap))
>  		return dev_err_probe(dev, PTR_ERR(st->regmap),

