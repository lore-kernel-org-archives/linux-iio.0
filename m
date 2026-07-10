Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C53036A365
	for <linux-iio@vger.kernel.org>; Fri, 10 Jul 2026 17:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783705991; cv=none; b=M3MSpqwWaIS4cfVgx1AvwIqF0EzeqAROCz/1HTvgns2+oU7BX732+yfdNolfQyy54raAqHuzHf3VmBSMAFIeNIkVBqGYq0v1dWwJNSC3z7uXp7gD3y/LaQ9/3y0dNfmjE7qAIDEw179nOskw6w5k4iE0wHpW+VVpGPcDMKRgZ/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783705991; c=relaxed/simple;
	bh=OZapa3bgIo8yc+weY233lrRX3z7qkV8mFNDkYIfQ7Sw=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:In-Reply-To:
	 Subject:References; b=eBQsuznTyNWd0+EiVhCN+bEVdoQkglzSDl+MnM+wx+Pij05pjiPkZOOx3YSUBuDlQ76ev9Zg5XN/bfi8svHlYdy4++LlX3fk2vAAfsEgm7RfO/aYhQzBhYd1zBl/G9GKgzsBtHS7SEKFz/4kaW86Z5elp4seDIJWxnWE5sKW3nM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T6e4F5wR; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T6e4F5wR"
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-7eb787dec99so786946a34.0
        for <linux-iio@vger.kernel.org>; Fri, 10 Jul 2026 10:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783705988; x=1784310788; darn=vger.kernel.org;
        h=references:subject:in-reply-to:cc:to:from:message-id:date
         :content-type:mime-version:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=TfF2+32yHkCY9OgSDVX9M5VHYIrR7dh1QXXljKX3DLU=;
        b=T6e4F5wRCJvRMgH296OpMXf4vXIl1vys4UX29oGi/v/vpwd0HIf2WMgt6mL+lf0tMG
         YVTkZ0oG3e8JRxCyLiDhmFuczThc3ueXSdt8nOzrMXrZ7vVcEnspQBzMuprTeGybOqk4
         7XgFemUC4gXKA7LgsPrKwoQFtShfk335XLf35PSoVjJ17mgrAstY8BciF51qg+6Y6tj4
         /flI3vXRBZugdpAPwKe7OAw7miMo7SkjbBfm9+uMVPZD7PKMR0Mgfo4SutkD0eauex+k
         XT+fSRmut30ZJB7D98EodTYX+dz/oa+OZvLnbpGsr1S87JD6NdoWd41l6UT4Q3nGQv94
         VyRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783705988; x=1784310788;
        h=references:subject:in-reply-to:cc:to:from:message-id:date
         :content-type:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=TfF2+32yHkCY9OgSDVX9M5VHYIrR7dh1QXXljKX3DLU=;
        b=WWgsh7GYwCBCLFLWKg7JFGJmpn8tzQOoepwc/S/tu6MDuRMMLIYUzEXRFQ91FQ3VTX
         R5KQK/nypvZiwyXf1eeLFs4TphlhUTTGtLMkVgsVuIIiztpIZyd86HP/TIbVf5rQJc9s
         tNZzZq0OijmhGx3ZQRbegKke7ySeAo4x9hh3TNGcIJfNvHtOEfG4lEZcOzZvUt+utIGj
         jgCVTbtLKPOvLpMf4GX6eLzfMV8mtJFZeIOnc1R7j/0c0T4KOkZIJsB1uC7HnRTYnm43
         +yvNQtoIA6SOeb/v82uRQpNMWmmgkhBkXthK7PN/67vjGPUOaMmFzPQs+9AWFcFcHcX1
         mY9Q==
X-Forwarded-Encrypted: i=1; AFNElJ/uOnyaJyuP/1lxmcN9ToRRq0u4brBq3iz6JvKS5xyo3cQ5eYD2Hnfa2r9lizIen9ELSqD1W3gtmAE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4ogOc+TqdQ39u4cJ5K0dxkAaieUwFprAC3bs294WsOymNDvEB
	Q3cdzyBRMFTDIc+vN7LvzPYqNn65XW7B47zUlsGAzNtH0SdXoNajYjat
X-Gm-Gg: AfdE7ckWvIt2WYY1CY9zouhgtPzNgxvedFabSqGt0qTMhgIBhSnln7RyXwIBpdz5+s+
	t2J6YfqZprBpu1XwjWb4dYY263ig89AOcL6oIl3r5OjymHW/K3ZfKg0aDBLbXgd1ISLu4q3ViqC
	PNMR2wQaky724rw8z8Go1y85WPOFx0pqWJLDSQiISdOKFZGqNIeLK7aUZcb6nWXRQPIerX2Afy+
	DlL+zzxergv+UVn1Txjt3bJY3YOpD/nNEO6MkWCHkBSzx9okXGzOBaaehReasxNsj5DKmIteNZo
	EhBYEk5pUwxvtW/l9Vf8AKz6DaPfhYUjtuAqxAYNKQcp2O2txFTEZCisvlOtJGkDDDVNItYq9Z3
	RgYu7scHx0rrNm794B+pM6PEoInijODmuKM11mHk2SWncxNuJaoiJRm1aOdfTwEMMemUCHL0KAO
	dz3uHoUZJHRujc6Eo2JCBAP/ZN14ChxhuyPkbb5V8=
X-Received: by 2002:a05:6830:6015:b0:7e9:c4ce:f7e5 with SMTP id 46e09a7af769-7ebd00ef930mr9343510a34.23.1783705986703;
        Fri, 10 Jul 2026 10:53:06 -0700 (PDT)
Received: from localhost (23-88-128-2.fttp.usinternet.com. [23.88.128.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7ebcb2bae7fsm7514885a34.21.2026.07.10.10.53.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jul 2026 10:53:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=bf94d117aab954e431a08de8ad5ad467a2313772f0af2049462f558603cc;
 micalg=pgp-sha384; protocol="application/pgp-signature"
Date: Fri, 10 Jul 2026 12:53:01 -0500
Message-Id: <DJV2ZZKDGQHF.1S79N3553DJ0C@gmail.com>
From: "Maxwell Doose" <m32285159@gmail.com>
To: "Taha Narimani" <tahanarimani3443@gmail.com>, <jic23@kernel.org>,
 <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
 <gregkh@linuxfoundation.org>
Cc: <dlechner@baylibre.com>, <nuno.sa@analog.com>, <andy@kernel.org>,
 <linux-iio@vger.kernel.org>, <linux-staging@lists.linux.dev>,
 <linux-kernel@vger.kernel.org>
In-Reply-To: <20260710160001.29856-2-tahanarimani3443@gmail.com>
Subject: Re: [PATCH v3] staging: iio: adc: ad7816: Use
 devm_gpiod_get_optional() for busy GPIO
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260710160001.29856-1-tahanarimani3443@gmail.com>
 <20260710160001.29856-2-tahanarimani3443@gmail.com>

--bf94d117aab954e431a08de8ad5ad467a2313772f0af2049462f558603cc
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

Hi Taha,

On Fri Jul 10, 2026 at 11:00 AM CDT
Taha Narimani <tahanarimani3443@gmail.com> wrote:

> The driver currently utilizes devm_gpiod_get() for the 'busy' line,
> which makes the GPIO mandatory. However, the busy pin is hardware-optiona=
l
> depending on the specific board configuration.
>
> Switch to devm_gpiod_get_optional() to allow boards that do not have
> this pin wired up to still probe the driver successfully. Clean up
> the redundant busy_pin conditional checks as gpiod_get_value() safely
> handles NULL descriptors. Additionally, use dev_err_probe() to prevent
> bootlog spamming during deferred probing.
>
> Fixes: 3e5971b2ddb6 ("base: original ad7816.c")

If this is a fix, then why are we making style changes?

> Signed-off-by: Taha Narimani <tahanarimani3443@gmail.com>
> ---
> Changes in v3:
>   - Removed redundant conditional check around gpiod_get_value() as sugge=
sted by Andy Shevchenko and Dan Carpenter.
>   - Switched to dev_err_probe() to avoid deferred probe spamming.
>   - Introduced local struct device *dev pointer in probe and kept the GPI=
O request on a single line for better readability.

Unless someone requested this during review this doesn't make sense.
Please see my above comment, and I'd also suggest to take a look at
Documentation/process/submitting-patches.rst.

>   - Added the missing Fixes tag requested by Jonathan Cameron.
>
>  drivers/staging/iio/adc/ad7816.c | 67 +++++++++++++-------------------
>  1 file changed, 28 insertions(+), 39 deletions(-)
>
> diff --git a/drivers/staging/iio/adc/ad7816.c b/drivers/staging/iio/adc/a=
d7816.c
> index 988eee3..807cf57 100644
> --- a/drivers/staging/iio/adc/ad7816.c
> Changes in v3:
>   - Removed redundant conditional check around gpiod_get_value() as sugge=
sted by Andy Shevchenko and Dan Carpenter.
>   - Switched to dev_err_probe() to avoid deferred probe spamming.
>   - Introduced local struct device *dev pointer in probe and kept the GPI=
O request on a single line for better readability.
>   - Added the missing Fixes tag requested by Jonathan Cameron.
>

Wrong spot for this + causes the patch to not apply. It should be below
the --- right after the list of tags.

> +++ b/drivers/staging/iio/adc/ad7816.c
> @@ -22,20 +22,20 @@
>  /*
>   * AD7816 config masks
>   */
> -#define AD7816_FULL			0x1
> -#define AD7816_PD			0x2
> -#define AD7816_CS_MASK			0x7
> -#define AD7816_CS_MAX			0x4
> +#define AD7816_FULL                     0x1
> +#define AD7816_PD                       0x2
> +#define AD7816_CS_MASK                  0x7
> +#define AD7816_CS_MAX                   0x4
> =20

Nothing changed? Seems like a stray change.

>  /*
>   * AD7816 temperature masks
>   */
> -#define AD7816_VALUE_OFFSET		6
> -#define AD7816_BOUND_VALUE_BASE		0x8
> -#define AD7816_BOUND_VALUE_MIN		-95
> -#define AD7816_BOUND_VALUE_MAX		152
> -#define AD7816_TEMP_FLOAT_OFFSET	2
> -#define AD7816_TEMP_FLOAT_MASK		0x3
> +#define AD7816_VALUE_OFFSET             6
> +#define AD7816_BOUND_VALUE_BASE         0x8
> +#define AD7816_BOUND_VALUE_MIN          -95
> +#define AD7816_BOUND_VALUE_MAX          152
> +#define AD7816_TEMP_FLOAT_OFFSET        2
> +#define AD7816_TEMP_FLOAT_MASK          0x3
> =20

Ditto.

>  /*
>   * struct ad7816_chip_info - chip specific information
> @@ -48,7 +48,7 @@ struct ad7816_chip_info {
>  	struct gpio_desc *convert_pin;
>  	struct gpio_desc *busy_pin;
>  	u8  oti_data[AD7816_CS_MAX + 1];
> -	u8  channel_id;	/* 0 always be temperature */
> +	u8  channel_id; /* 0 always be temperature */
>  	u8  mode;
>  };
> =20

Here as well.

> @@ -84,10 +84,8 @@ static int ad7816_spi_read(struct ad7816_chip_info *ch=
ip, u16 *data)
>  		gpiod_set_value(chip->convert_pin, 1);
>  	}
> =20
> -if (chip->id =3D=3D ID_AD7816 || chip->id =3D=3D ID_AD7817) {
> -		while (gpiod_get_value(chip->busy_pin))
> -			cpu_relax();
> -	}
> +	while (gpiod_get_value(chip->busy_pin))
> +		cpu_relax();
>

Can you explain why we're removing this check? There also seems to be a
spot in _probe() where the check gets removed as well.

>  	gpiod_set_value(chip->rdwr_pin, 0);
>  	gpiod_set_value(chip->rdwr_pin, 1);
> @@ -254,8 +252,8 @@ static const struct attribute_group ad7816_attribute_=
group =3D {
>   * temperature bound events
>   */
> =20
> -#define IIO_EVENT_CODE_AD7816_OTI IIO_UNMOD_EVENT_CODE(IIO_TEMP,	\
> -						       0,		\
> +#define IIO_EVENT_CODE_AD7816_OTI IIO_UNMOD_EVENT_CODE(IIO_TEMP,        =
\
> +						       0,               \
>  						       IIO_EV_TYPE_THRESH, \
>  						       IIO_EV_DIR_FALLING)
> =20

Seems like another stray change.

> @@ -351,11 +349,12 @@ static const struct iio_info ad7816_info =3D {
> =20
>  static int ad7816_probe(struct spi_device *spi_dev)
>  {
> +	struct device *dev =3D &spi_dev->dev;

Again, why are we doing style changes? This seems to be a fix instead of
a style patch.

>  	struct ad7816_chip_info *chip;
>  	struct iio_dev *indio_dev;
>  	int i, ret;
> =20
> -	indio_dev =3D devm_iio_device_alloc(&spi_dev->dev, sizeof(*chip));
> +	indio_dev =3D devm_iio_device_alloc(dev, sizeof(*chip));
>  	if (!indio_dev)
>  		return -ENOMEM;
>  	chip =3D iio_priv(indio_dev);

...

> @@ -431,7 +421,6 @@ static const struct spi_device_id ad7816_id[] =3D {
>  	{ "ad7818", ID_AD7818 },
>  	{ }
>  };
> -

Stray change.

>  MODULE_DEVICE_TABLE(spi, ad7816_id);
> =20
>  static struct spi_driver ad7816_driver =3D {


--=20
best regards,
max


--bf94d117aab954e431a08de8ad5ad467a2313772f0af2049462f558603cc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTMrEGfAFxnfnRQ/UIQghIb0dl/iQUCalExfgAKCRAQghIb0dl/
iZ0CAX43+2agHfad+6pqgKeDQ5Qi/G4AxGVSP1M5pU9xZ4anEspFjfF9On5hWe9l
GJsdU6oBgPMccTfg3SSIYoSfVCOvEboqSAT0xl4CiiXYeOx30w3pV5ErKpfcoI1a
G9NuzugpMg==
=MjO/
-----END PGP SIGNATURE-----

--bf94d117aab954e431a08de8ad5ad467a2313772f0af2049462f558603cc--
