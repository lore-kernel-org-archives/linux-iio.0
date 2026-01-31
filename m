Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF6B376026;
	Sat, 31 Jan 2026 16:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769876510; cv=none; b=DBnhr5PxrhudYVTNSpL8jCEJWB3smSvpZbynMjc8pkvtkHKHctClr35AbNyg+mn9xphJktB+lcGwTH0Yd4I1vPsGrz+bQdpvji+c89pa+xryGTCAgTO5d/UtXOL9N59kYiruSTK85kACRoWk1g50nYL6fh7a3XQ4N4uyUJAZLPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769876510; c=relaxed/simple;
	bh=OBCZg9KLn/ui3hSVhJykRlYumITd7LzKcJiWMbTKIjk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pvUoMbcw6WBlWF6emidAPa9eR5dUQfWq5F2E7JjmRt+gOR0bTG9py05kWz+WNLh0d+/gzubD8WsS0Qa/KDGpSaOt1yz8VbR5tJmn+IRmanh1rzty3Jrcj4BsDSJiPu2Y6R8PZC0NQto3meIadqaIM9mw1rFw7RIy9uaaBAllBko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D8qE3GC4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D8qE3GC4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F6CAC4CEF1;
	Sat, 31 Jan 2026 16:21:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769876509;
	bh=OBCZg9KLn/ui3hSVhJykRlYumITd7LzKcJiWMbTKIjk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=D8qE3GC46mgKxWZJr01qt0nROWO8dMfeDaAb74VJl1gk4I6QeG3Ue6sOAHiQeOZe8
	 67gqW3gbZp3yG990ryDkFgNomj0rMJt/Za7liylBnvbutjRU+8FxEcBRneHao5d7PL
	 rAsiowWVSbastKQjMm+Ry8XIoLYrzqe1qw+NJ1qWQE1pA3Hq6K+vB4981JsWRrTt7t
	 McztmT/+sZw4N4Q0cbnsHsfmzHeAgpeEbk3g9grmy6AH5NohThgrPgyBCrcUyOzt0e
	 XBGsXBk9d5RndJR3LIPjhFJNiCXZcZjezSxdiZ6xFppvUutzgrkqZK8V0A1q2E4arQ
	 O3SAHyhqBc7hA==
Date: Sat, 31 Jan 2026 16:21:40 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Michael Harris <michaelharriscode@gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-staging@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] staging: iio: adt7316: convert magic numbers to
 BIT() and GENMASK()
Message-ID: <20260131162140.5abb833b@jic23-huawei>
In-Reply-To: <20260130-adt7316-correct-macros-v1-2-8a71df1e42f1@gmail.com>
References: <20260130-adt7316-correct-macros-v1-0-8a71df1e42f1@gmail.com>
	<20260130-adt7316-correct-macros-v1-2-8a71df1e42f1@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Fri, 30 Jan 2026 23:38:28 -0800
Michael Harris <michaelharriscode@gmail.com> wrote:

> Improve readability by converting raw hex macros to use BIT() or GENMASK()
> instead.
>=20
> Update a few sysfs_emit() string formats to expect the unsigned long type
> given by BIT() and GENMASK() and prevent compiler errors.
>=20
> Signed-off-by: Michael Harris <michaelharriscode@gmail.com>
> ---
>  drivers/staging/iio/addac/adt7316.c | 80 ++++++++++++++++++-------------=
------
>  1 file changed, 40 insertions(+), 40 deletions(-)
>=20
> diff --git a/drivers/staging/iio/addac/adt7316.c b/drivers/staging/iio/ad=
dac/adt7316.c
> index 4173c8822fff495e8c69d9cf6c11be9e9227a8c1..0af7e18ff9684993622a26811=
0f0a17c0bff3616 100644
> --- a/drivers/staging/iio/addac/adt7316.c
> +++ b/drivers/staging/iio/addac/adt7316.c
> @@ -29,11 +29,11 @@


> @@ -88,19 +88,19 @@
>  /*
>   * ADT7316 config1
>   */
> -#define ADT7316_EN			0x1
> -#define ADT7516_SEL_EX_TEMP		0x4
> -#define ADT7516_SEL_AIN1_2_EX_TEMP_MASK	0x6
> -#define ADT7516_SEL_AIN3		0x8
> -#define ADT7316_INT_EN			0x20
> -#define ADT7316_INT_POLARITY		0x40
> -#define ADT7316_PD			0x80
> +#define ADT7316_EN			BIT(0)
Arguably its a separate change but I'd much prefer if these defines
included what register they were found in. That is things like

#define ADT7316_CONFIG1_EN
etc. It makes it a lot easier to spot mismatches in the code.

Also this define sounds like it would be general enable / disable of capture
but it seems to only be about monitoring modes.

> +#define ADT7516_SEL_EX_TEMP		BIT(2)
That's not a mask.  It is a value and it should clearly placed
in the relevant field, so you can do things like
FIELD_PREP(ADT7516_SEL_AIN1_2_EX_TEMP_MASK, ADT7516...TEMP)
So it should take the value 2 =3D=3D b10 not BIT(2).

> +#define ADT7516_SEL_AIN1_2_EX_TEMP_MASK	GENMASK(2, 1)
I'd put the masks before the values.=20

> +#define ADT7516_SEL_AIN3		BIT(3)
> +#define ADT7316_INT_EN			BIT(5)
> +#define ADT7316_INT_POLARITY		BIT(6)
> +#define ADT7316_PD			BIT(7)
> =20
>  /*
>   * ADT7316 config2
>   */
> -#define ADT7316_AD_SINGLE_CH_MASK	0x3
> -#define ADT7516_AD_SINGLE_CH_MASK	0x7
> +#define ADT7316_AD_SINGLE_CH_MASK	GENMASK(1, 0)
> +#define ADT7516_AD_SINGLE_CH_MASK	GENMASK(2, 0)
>  #define ADT7316_AD_SINGLE_CH_VDD	0
>  #define ADT7316_AD_SINGLE_CH_IN		1
>  #define ADT7316_AD_SINGLE_CH_EX		2
> @@ -108,54 +108,54 @@
>  #define ADT7516_AD_SINGLE_CH_AIN2	3
>  #define ADT7516_AD_SINGLE_CH_AIN3	4
>  #define ADT7516_AD_SINGLE_CH_AIN4	5
> -#define ADT7316_AD_SINGLE_CH_MODE	0x10
> -#define ADT7316_DISABLE_AVERAGING	0x20
> -#define ADT7316_EN_SMBUS_TIMEOUT	0x40
> +#define ADT7316_AD_SINGLE_CH_MODE	BIT(4)
> +#define ADT7316_DISABLE_AVERAGING	BIT(5)
> +#define ADT7316_EN_SMBUS_TIMEOUT	BIT(6)
As commented on previous patch I'd prefer a full register definition
even if a few bits aren't used. Makes it easier to spot when they
are being accidentally cleared.

> =20
>  /*
>   * ADT7316 config3
>   */
> -#define ADT7316_ADCLK_22_5		0x1
> -#define ADT7316_DA_HIGH_RESOLUTION	0x2
> -#define ADT7316_DA_EN_VIA_DAC_LDAC	0x8
> -#define ADT7516_AIN_IN_VREF		0x10
> -#define ADT7316_EN_IN_TEMP_PROP_DACA	0x20
> -#define ADT7316_EN_EX_TEMP_PROP_DACB	0x40
> +#define ADT7316_ADCLK_22_5		BIT(0)
> +#define ADT7316_DA_HIGH_RESOLUTION	BIT(1)
> +#define ADT7316_DA_EN_VIA_DAC_LDAC	BIT(3)
> +#define ADT7516_AIN_IN_VREF		BIT(4)
> +#define ADT7316_EN_IN_TEMP_PROP_DACA	BIT(5)
> +#define ADT7316_EN_EX_TEMP_PROP_DACB	BIT(6)
> =20
>  /*
>   * ADT7316 DAC config
>   */
> -#define ADT7316_DA_2VREF_CH_MASK	0xF
> -#define ADT7316_DA_EN_MODE_MASK		0x30
> +#define ADT7316_DA_2VREF_CH_MASK	GENMASK(3, 0)
> +#define ADT7316_DA_EN_MODE_MASK		GENMASK(5, 4)
>  #define ADT7316_DA_EN_MODE_SHIFT	4
>  #define ADT7316_DA_EN_MODE_SINGLE	0x00
>  #define ADT7316_DA_EN_MODE_AB_CD	0x10
>  #define ADT7316_DA_EN_MODE_ABCD		0x20
>  #define ADT7316_DA_EN_MODE_LDAC		0x30
> -#define ADT7316_VREF_BYPASS_DAC_AB	0x40
> -#define ADT7316_VREF_BYPASS_DAC_CD	0x80
> +#define ADT7316_VREF_BYPASS_DAC_AB	BIT(6)
> +#define ADT7316_VREF_BYPASS_DAC_CD	BIT(7)
> =20
>  /*
>   * ADT7316 LDAC config
>   */
> -#define ADT7316_LDAC_EN_DA_MASK		0xF
> -#define ADT7316_DAC_IN_VREF		0x10
> -#define ADT7516_DAC_AB_IN_VREF		0x10
> -#define ADT7516_DAC_CD_IN_VREF		0x20
> +#define ADT7316_LDAC_EN_DA_MASK		GENMASK(3, 0)
> +#define ADT7316_DAC_IN_VREF		BIT(4)
> +#define ADT7516_DAC_AB_IN_VREF		BIT(4)
> +#define ADT7516_DAC_CD_IN_VREF		BIT(5)
>  #define ADT7516_DAC_IN_VREF_OFFSET	4
Try and get rid of separate shifts / offsets.  (I think this
is just a shift?)  Replace them with use of FIELD_GET()/ FIELD_PREP() and
the mask.

A precursor patch doing that might make this patch easier to
read as all the shifts would likely be gone.

> -#define ADT7516_DAC_IN_VREF_MASK	0x30
> +#define ADT7516_DAC_IN_VREF_MASK	GENMASK(5, 4)
> =20
>  /*
>   * ADT7316 INT_MASK2
>   */
> -#define ADT7316_INT_MASK2_VDD		0x10
> +#define ADT7316_INT_MASK2_VDD		BIT(4)
> =20
>  /*
>   * ADT7316 value masks
>   */
> -#define ADT7316_T_VALUE_SIGN		0x400
> +#define ADT7316_T_VALUE_SIGN		BIT(10)

=46rom a quick glance, these are all 2's complement.
As such, using sign_extend32() or similar would be much nicer
than the custom sign manipulation in here and the need for
this macro would probably go away.

>  #define ADT7316_T_VALUE_FLOAT_OFFSET	2
> -#define ADT7316_T_VALUE_FLOAT_MASK	0x2
> +#define ADT7316_T_VALUE_FLOAT_MASK	BIT(1)
The usage of these is also rather strange and more about
a fixed point maths conversion than anything related to registers.
I'd expect that to get cleaned up by reporting temperature as _raw
and providing an appropriate scale.

> =20
>  /*
>   * Chip ID
> @@ -167,7 +167,7 @@
>  #define ID_ADT7517		0x12
>  #define ID_ADT7519		0x14
> =20
> -#define ID_FAMILY_MASK		0xF0
> +#define ID_FAMILY_MASK		GENMASK(7, 4)
>  #define ID_ADT73XX		0x0
>  #define ID_ADT75XX		0x10
> =20
> @@ -192,9 +192,9 @@ struct adt7316_chip_info {
>   * Logic interrupt mask for user application to enable
>   * interrupts.
>   */
> -#define ADT7316_VDD_INT_MASK		0x100
> -#define ADT7316_TEMP_INT_MASK		0x1F
> -#define ADT7516_AIN_INT_MASK		0xE0
> +#define ADT7316_VDD_INT_MASK		BIT(8)
> +#define ADT7316_TEMP_INT_MASK		GENMASK(4, 0)
> +#define ADT7516_AIN_INT_MASK		GENMASK(7, 5)
>  #define ADT7316_TEMP_AIN_INT_MASK	\
>  	(ADT7316_TEMP_INT_MASK)
> =20
> @@ -783,7 +783,7 @@ static ssize_t adt7316_show_DAC_2Vref_ch_mask(struct =
device *dev,
>  	struct iio_dev *dev_info =3D dev_to_iio_dev(dev);
>  	struct adt7316_chip_info *chip =3D iio_priv(dev_info);
> =20
> -	return sysfs_emit(buf, "0x%x\n",
> +	return sysfs_emit(buf, "0x%lx\n",
>  		chip->dac_config & ADT7316_DA_2VREF_CH_MASK);
Is the compiler complaining about these? It really should be able to tell t=
hat the masks
are small enough that the original can always print the right thing.

>  }
> =20
> @@ -1023,7 +1023,7 @@ static ssize_t adt7316_show_DAC_internal_Vref(struc=
t device *dev,
>  	struct adt7316_chip_info *chip =3D iio_priv(dev_info);
> =20
>  	if ((chip->id & ID_FAMILY_MASK) =3D=3D ID_ADT75XX)
> -		return sysfs_emit(buf, "0x%x\n",
> +		return sysfs_emit(buf, "0x%lx\n",
>  			(chip->ldac_config & ADT7516_DAC_IN_VREF_MASK) >>
>  			ADT7516_DAC_IN_VREF_OFFSET);
>  	return sysfs_emit(buf, "%d\n",
> @@ -1146,7 +1146,7 @@ static ssize_t adt7316_show_ad(struct adt7316_chip_=
info *chip,
>  		sign =3D '-';
>  	}
> =20
> -	return sysfs_emit(buf, "%c%d.%.2d\n", sign,
> +	return sysfs_emit(buf, "%c%d.%.2ld\n", sign,
>  		(data >> ADT7316_T_VALUE_FLOAT_OFFSET),
>  		(data & ADT7316_T_VALUE_FLOAT_MASK) * 25);
I mention this above.  This calculation is odd.  I'd just expect the maths =
to be done
with a multiplier, probably 100 such that the 1/4 per bit after the decimal=
 point
gets buried in that and you can do a simple % 100 here to get the decimal p=
laces.

I've asked for a couple of different types of change in here. It is likely
that some of them should be in separate patches.

Thanks,

Jonathan

>  }
>=20


