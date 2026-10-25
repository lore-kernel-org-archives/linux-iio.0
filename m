Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792970778;
	b=zoy/TyEkrSzrrJ1RIpQyr76NRqgS5qE1UPMBS+cYRMbyNB9C7FyynXF60ZLhlPfVwibf
	 47jjV029WVAfEZYt1/EnxXrG1bXpe3fjQPjnWzRU1ojzAwgFtm7LmXBJJBRwDECxl6S4Y
	 sb7PgKrt6LGeEOvOiyYyj9kisabGGNo1g0y9wtRdKlMPXlb7kYgx2yaK/AKwL8Ezm2wni
	 PzgWQ7z2EMGlnyDosdn398dgODaQPDBK/sXZ9yjmCV2ofWAJ7YjvjEOakqUPDdP2t5VRz
	 Npk/ve8M6zbsR5QdnMkMQ4MeM8KESm9SoFSeC+DbhP8dQ+TuGsAxTLBs4Km7a/+W8fQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792970778;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=alygFOX07meOsfoRxrw0nSclDlbf7TGpZ7tMmzr2AHI=;
	b=z00t2oKv8Cax9Z7rMlbLCydJyet23o4MfHGkjIMTig/OEbecJlAqtQQQxyf05qzFWkFO
	 lITWBpdh8wdyuLvsOqC+VDajSTC/hZiL4hFUhC3ju9gYlPbSY8i23KpvFJOhmm8ODPtBG
	 d3iEFJfIaHtyLjFPjXtnRuK1sYS8MlN8LcCPQjReaw5zt3O7aP5CXmkheKKO55j+6izmt
	 VfpHQ4E12m8fzEiIf4YGS/FxDuC5MvRKkOoILsdd7obajCtgCejfwi7Vh6+jHnGXXJokZ
	 qw73Chl2dJAwDw5q5LW+NVxt03O8Y/rE9VOeW0blLqrU6lcEFf5gph6LB9CmAUds0dg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Y/BwqL92";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B792606A31A;
	Sun, 25 Oct 2026 23:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y/BwqL92
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9938A1F01825;
	Sun, 25 Oct 2026 23:26:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792970777;
	bh=alygFOX07meOsfoRxrw0nSclDlbf7TGpZ7tMmzr2AHI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Y/BwqL92bqTjP041usi4NU+XCP97/QyVK8ROVjKaJ3Wk7DfC9ZRcIeK8v0C8lN95H
	 +0yUZKHfkSJe+lJbrrXK7G66cfFSKddqYmKArrHESqWeYhZiJMgBKvpwmNccROjfOt
	 l48Og/+Aph3c0OzYPdorABXjk9f0HPPh3fIXpR4zdwmWoC/v0Ff0Ry3Z3BhXk2YT/m
	 yA6KVuP4RPJcC9zuDq9u/uhwcBFRUQxUxGrCozg0n6oCSQCvp9QiS6EDumhBduvl+2
	 X4kquvykTybDl+1G0HDlsEuhJjl/iA73LH5wVyccrwdnxnWZIHw1mMwSupL4TBlMaN
	 rVr8n/9e2y5TA==
Date: Sun, 25 Oct 2026 23:26:08 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Stephan Costa Barros <stephanbrrs8@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Mike Looijmans <mike.looijmans@topic.nl>, Andy
 Shevchenko <andriy.shevchenko@intel.com>, Uwe =?UTF-8?B?S2xlaW5lLUvDtm5p?=
 =?UTF-8?B?Zw==?= <u.kleine-koenig@baylibre.com>, Krzysztof Kozlowski
 <krzk@kernel.org>, linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/6] iio: adc: ti-ads1298: prepare for more chip
 families
Message-ID: <20261025232608.06a5762c@jic23-hlaptop>
In-Reply-To: <20261024231335.280955-5-stephanbrrs8@gmail.com>
References: <20261024231335.280955-1-stephanbrrs8@gmail.com>
	<20261024231335.280955-5-stephanbrrs8@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Sat, 24 Oct 2026 20:13:33 -0300
Stephan Costa Barros <stephanbrrs8@gmail.com> wrote:

> The ADS1299 has the register map of the ADS129x, with other gains, data
> rates, reference and ID layout. To support it in this driver, collect
> what differs between families in a chip info structure, given as match
> data. The private structure has carried an unused chip_info pointer
> since the driver was added.
>=20
> The chip info holds:
> - the regmap configuration and the PGA gain table;
> - the data rate rules: the base shift, whether CONFIG1 has an HR bit,
>   and the oversampling ratio at DR =3D 0;
> - the internal reference, whether CONFIG3 has the VREF_4V bit, and the
>   reserved bits of CONFIG3 that must be written as 1;
> - a callback that checks the ID register and sets the channel count and
>   the name, as the ID layouts differ; bit 3 alone tells them apart.
>=20
> No functional change.
>=20
> Signed-off-by: Stephan Costa Barros <stephanbrrs8@gmail.com>
Mostly fine. A few comments in line in trying to
naming the structure elements to help with readability
and reduce need for docs around them.

Jonathan

> ---
>  drivers/iio/adc/ti-ads1298.c | 132 +++++++++++++++++++++++++----------
>  1 file changed, 96 insertions(+), 36 deletions(-)
>=20
> diff --git a/drivers/iio/adc/ti-ads1298.c b/drivers/iio/adc/ti-ads1298.c
> index b390c13ae..5ad543bdf 100644
> --- a/drivers/iio/adc/ti-ads1298.c
> +++ b/drivers/iio/adc/ti-ads1298.c
> @@ -49,8 +49,6 @@
>  #define ADS1298_REG_CONFIG1	0x01
>  #define ADS1298_MASK_CONFIG1_HR			BIT(7)
>  #define ADS1298_MASK_CONFIG1_DR			GENMASK(2, 0)
> -#define ADS1298_SHIFT_DR_HR			6
> -#define ADS1298_SHIFT_DR_LP			7
>  #define ADS1298_LOWEST_DR			0x06
> =20
>  #define ADS1298_REG_CONFIG2	0x02
> @@ -66,6 +64,7 @@
>  #define ADS1298_MASK_CONFIG3_PWR_REFBUF		BIT(7)
>  #define ADS1298_MASK_CONFIG3_RESERVED		BIT(6)
>  #define ADS1298_MASK_CONFIG3_VREF_4V		BIT(5)
> +#define ADS1298_VREF_4V_MV			4000
> =20
>  #define ADS1298_REG_LOFF	0x04
>  #define ADS1298_REG_CHnSET(n)	(0x05 + (n))
> @@ -105,6 +104,31 @@
>  #define ADS1298_SPI_RDATA_BUFFER_SIZE_MAX \
>  		ADS1298_SPI_RDATA_BUFFER_SIZE(ADS1298_MAX_CHANNELS)
> =20
> +/* What differs between the chip families the driver supports */

This is very standard naming and purpose. I'd drop the comment.
These sorts of general comments tend to become misleading as code
changes and we never remember to update them.
Keep comments for the surprising or places where they add stuff
we can't do with naming.


> +struct ads1298_chip_info {
> +	/* Checks the ID register, and sets the channel count and the name */
Given this is a=20
> +	int (*parse_id)(struct iio_dev *indio_dev, unsigned int id);
> +	const struct regmap_config *regmap_config;
> +	/* PGA gain for each value of the GAIN field of CHnSET */
> +	const u8 *gains;
> +	unsigned int num_gains;
> +	/*
> +	 * The data rate is f_CLK >> (dr_shift + DR). With an HR bit in
> +	 * CONFIG1, dr_shift is that of the high-resolution mode, and the
> +	 * low-power mode shifts one more.
> +	 */
> +	unsigned int dr_shift;

Probably spell out dr.

> +	bool has_hr;

I'd spell out hr.

> +	/* Oversampling ratio at DR =3D 0 */
> +	unsigned int osr_base;
> +	/* Internal reference, in millivolts */
> +	unsigned int vref_mv;

Rename to something that won't need the comment then drop that coment.


	unsigned int internal_vref_mV;

> +	/* CONFIG3 has the VREF_4V bit, which selects a 4 V internal reference =
*/
> +	bool has_vref_4v;

I'm lost here. If it's about the bit, then name it after the bit.
I suspect it's about internal reference that can be disabled or not?
In that case can you name it for that functionality instead?

=46rom a quick look below, seems it is about what of two modes can be
used?  If so how does that fit with just one vref_mv above?

> +	/* Reserved bits of CONFIG3 that must be written as 1 */

This one is interesting. Normally we deal with these by just using
RMW cycles on such a register.   Can we do that here?

> +	unsigned int config3_reserved;
> +};
> +


> -static const u8 ads1298_pga_settings[] =3D { 6, 1, 2, 3, 4, 8, 12 };
> -
>  static int ads1298_get_scale(struct ads1298_private *priv,
>  			     int channel, int *val, int *val2)
>  {
> +	const struct ads1298_chip_info *info =3D priv->chip_info;
>  	unsigned int pga_idx;
>  	int ret;
>  	unsigned int regval;
> @@ -356,13 +381,16 @@ static int ads1298_get_scale(struct ads1298_private=
 *priv,
>  			return ret;
> =20
>  		*val =3D ret / MILLI; /* Convert to millivolts */
> -	} else {
> +	} else if (info->has_vref_4v) {
>  		ret =3D regmap_read(priv->regmap, ADS1298_REG_CONFIG3, &regval);
>  		if (ret)
>  			return ret;
> =20
>  		/* Reference in millivolts */
> -		*val =3D regval & ADS1298_MASK_CONFIG3_VREF_4V ? 4000 : 2400;
> +		*val =3D regval & ADS1298_MASK_CONFIG3_VREF_4V ?
> +		       ADS1298_VREF_4V_MV : info->vref_mv;

See above.  Why is vref_mv which is an internal reference not the 4V one?
Probably need clearer naming of that field.

> +	} else {
> +		*val =3D info->vref_mv;
>  	}
> =20

> -static int ads1298_init(struct iio_dev *indio_dev)
> +static int ads1298_parse_id(struct iio_dev *indio_dev, unsigned int id)
>  {
>  	struct ads1298_private *priv =3D iio_priv(indio_dev);
>  	struct device *dev =3D &priv->spi->dev;
>  	const char *suffix;
>  	unsigned int nu_ch;
> -	unsigned int val;
> -	int ret;
> -
> -	/* Device initializes into RDATAC mode, which we don't want */
> -	ret =3D ads1298_write_cmd(priv, ADS1298_CMD_SDATAC);
> -	if (ret)
> -		return ret;
> -
> -	ret =3D regmap_read(priv->regmap, ADS1298_REG_ID, &val);
> -	if (ret)
> -		return ret;
> =20
>  	/* Fill in name and channel count based on what the chip told us */
> -	nu_ch =3D FIELD_GET(ADS1298_MASK_ID_CHANNELS, val);
> +	nu_ch =3D FIELD_GET(ADS1298_MASK_ID_CHANNELS, id);
>  	/* 0, 1 and 2 are 4, 6 and 8 channels; the other codes are reserved */
>  	if (nu_ch > 2)
> -		return dev_err_probe(dev, -ENODEV, "Unknown ID: 0x%x\n", val);
> +		return dev_err_probe(dev, -ENODEV, "Unknown ID: 0x%x\n", id);
>  	indio_dev->num_channels =3D 4 + 2 * nu_ch;
> -	switch (val & ADS1298_MASK_ID_FAMILY) {
> +	switch (id & ADS1298_MASK_ID_FAMILY) {

Please use FIELD_GET() and fix the family masks to be values in the field
rather than the shifted version.  You might want to do that
as a separate precursor patch.  Looks like there may be other similar
changes in driver around fields vs value defines.


>  	case ADS1298_ID_FAMILY_ADS129X:
>  		suffix =3D "";
>  		break;
> @@ -745,19 +762,57 @@ static int ads1298_init(struct iio_dev *indio_dev)
>  		suffix =3D "r";
>  		break;
>  	default:
> -		return dev_err_probe(dev, -ENODEV, "Unknown ID: 0x%x\n", val);
> +		return dev_err_probe(dev, -ENODEV, "Unknown ID: 0x%x\n", id);
>  	}
>  	indio_dev->name =3D devm_kasprintf(dev, GFP_KERNEL, "ads129%u%s",
>  					 indio_dev->num_channels, suffix);
>  	if (!indio_dev->name)
>  		return -ENOMEM;
> =20
> -	val =3D ADS1298_MASK_CONFIG3_RESERVED; /* Must write 1 always */
> +	return 0;
> +}

