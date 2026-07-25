Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19DD04908D5;
	Sat, 25 Jul 2026 21:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785016074; cv=none; b=u4uTBosIMUZv6jby+3eHjyLnXHlqEuiqxkqNqilQnALq/+wzsnoyQdXFZnFDF6KLx1zGAllJEBXwZ3x1tpaBk+UbLhHH6Ov6Op/4g7bbKaqNieVxUNxPhJGr7KbA5B20RA+QuxkLH0x/QRmXHj0/jZuNeu4i7HMaaaN/eLn6EK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785016074; c=relaxed/simple;
	bh=rPpWboDauVNyRDAzUME0YHCrm6iHn+K3LuYwwjxPpH8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l4ynHgpC4QpvWN22acZ5ST6bnsPg68YE5AbTmxgM1jmHEZMMtjimd9mZUviXNke+4x+QHpS4YnxmTXtKAl8Z33sKlR0PAPdTPagB9Fn8QsTLsbQPU+t3dlAU8RV2zOv6wKjYrjSQ+Q+OlxOnNG4Rj/M5fROkDwNe4v9e0Ujp8qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fjMRKQ/b; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fjMRKQ/b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 127C91F000E9;
	Sat, 25 Jul 2026 21:47:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785016072;
	bh=yljpGr8XdNDgzHiUIRlIF1/QmqX7UQF3WUO9jpxYZ6Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=fjMRKQ/bBkUJc8B3ZpKu5yXTuxFA6QrRDi56stCejvjNjd8XYPQTRSZx6gve8wchR
	 4UoaJ0plS4ay6JD95eXfEC4GLC5dnTcCiBXj/IWgTxaknSM0QRObBx22eBNGFcrUEo
	 TdJy4IDrTnGdJiqNk/YJa6lb+z0Lq8Jxw+9vCEJeC7s3Y2p/dyEtIVjG3vVDRAEwAF
	 EHPN58wC1XhpCueW3DZFa0DzGdPYx2ftoXiYunmJmUIzmamK5VwRSLsx1QMHfsgZAN
	 kCwbW9rbgE6ex8+G8duo8f2q1Ahc8Zkqt9a9Hzy84yyGEKnXL0rV+sj7eShtuVeWCU
	 IezPyPCX/591g==
Date: Sat, 25 Jul 2026 22:47:46 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Yu-Chun Lin <eleanor.lin@realtek.com>
Cc: <linusw@kernel.org>, <andriy.shevchenko@intel.com>, <mwalle@kernel.org>,
 <brgl@kernel.org>, <tychang@realtek.com>, <wbg@kernel.org>,
 <mathieu.dubois-briand@bootlin.com>, <nuno.sa@analog.com>,
 <Michael.Hennerich@analog.com>, <andy@kernel.org>,
 <u.kleine-koenig@baylibre.com>, <dakr@kernel.org>, <bhelgaas@google.com>,
 <o-takashi@sakamocchi.jp>, <dlechner@baylibre.com>,
 <linux-kernel@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
 <linux@analog.com>, <linux-iio@vger.kernel.org>, <cy.huang@realtek.com>,
 <james.tai@realtek.com>
Subject: Re: [PATCH v7 5/9] gpio: regmap: Add gpio_regmap_operation to
 extend reg_mask_xlate callback
Message-ID: <20260725224746.01ef9757@jic23-huawei>
In-Reply-To: <20260723034237.2501507-6-eleanor.lin@realtek.com>
References: <20260723034237.2501507-1-eleanor.lin@realtek.com>
	<20260723034237.2501507-6-eleanor.lin@realtek.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 23 Jul 2026 11:42:22 +0800
Yu-Chun Lin <eleanor.lin@realtek.com> wrote:

> Extend the reg_mask_xlate callback with an operation type parameter
> (enum gpio_regmap_operation) to allow drivers to return different
> register/mask combinations depending on the specific GPIO operation.
>=20
> Consequently, update all existing drivers utilizing the gpio-regmap
> framework (across drivers/gpio, drivers/iio, and drivers/pinctrl)
> to accommodate the new reg_mask_xlate function signature.
>=20
> Suggested-by: Linus Walleij <linusw@kernel.org>
> Signed-off-by: Yu-Chun Lin <eleanor.lin@realtek.com>
Acked-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com> # for-iio

> ---
> Changes in v7:
> - Move value_xlate changes into patch 6.
> - Add background context to kernel-doc comment for
> 'enum gpio_regmap_operation'.
> ---
>  drivers/gpio/gpio-104-idi-48.c        |  7 +++--
>  drivers/gpio/gpio-i8255.c             |  4 +--
>  drivers/gpio/gpio-idio-16.c           |  6 ++--
>  drivers/gpio/gpio-max7360.c           |  1 +
>  drivers/gpio/gpio-pcie-idio-24.c      |  6 ++--
>  drivers/gpio/gpio-regmap.c            | 31 +++++++++++++++------
>  drivers/iio/adc/ad7173.c              |  8 +++---
>  drivers/iio/addac/stx104.c            |  6 ++--
>  drivers/pinctrl/bcm/pinctrl-bcm63xx.c |  1 +
>  drivers/pinctrl/pinctrl-tps6594.c     |  1 +
>  include/linux/gpio/regmap.h           | 40 +++++++++++++++++++++++++--
>  11 files changed, 81 insertions(+), 30 deletions(-)
>=20
> diff --git a/drivers/gpio/gpio-104-idi-48.c b/drivers/gpio/gpio-104-idi-4=
8.c
> index ba73ee9c0c29..fb017569cfa8 100644
> --- a/drivers/gpio/gpio-104-idi-48.c
> +++ b/drivers/gpio/gpio-104-idi-48.c
> @@ -36,9 +36,10 @@ MODULE_PARM_DESC(irq, "ACCES 104-IDI-48 interrupt line=
 numbers");
>  #define IDI48_IRQ_STATUS 0x7
>  #define IDI48_IRQ_ENABLE IDI48_IRQ_STATUS
> =20
> -static int idi_48_reg_mask_xlate(struct gpio_regmap *gpio, unsigned int =
base,
> -				 unsigned int offset, unsigned int *reg,
> -				 unsigned int *mask)
> +static int idi_48_reg_mask_xlate(struct gpio_regmap *gpio,
> +				 enum gpio_regmap_operation op,
> +				 unsigned int base, unsigned int offset,
> +				 unsigned int *reg, unsigned int *mask)
>  {
>  	const unsigned int line =3D offset % 8;
>  	const unsigned int stride =3D offset / 8;
> diff --git a/drivers/gpio/gpio-i8255.c b/drivers/gpio/gpio-i8255.c
> index 953018bfa2b1..541a348447cd 100644
> --- a/drivers/gpio/gpio-i8255.c
> +++ b/drivers/gpio/gpio-i8255.c
> @@ -67,8 +67,8 @@ static int i8255_ppi_init(struct regmap *const map, con=
st unsigned int base)
>  	return regmap_write(map, base + I8255_PORTC, 0x00);
>  }
> =20
> -static int i8255_reg_mask_xlate(struct gpio_regmap *gpio, unsigned int b=
ase,
> -				unsigned int offset, unsigned int *reg,
> +static int i8255_reg_mask_xlate(struct gpio_regmap *gpio, enum gpio_regm=
ap_operation op,
> +				unsigned int base, unsigned int offset, unsigned int *reg,
>  				unsigned int *mask)
>  {
>  	const unsigned int ppi =3D offset / I8255_NGPIO;
> diff --git a/drivers/gpio/gpio-idio-16.c b/drivers/gpio/gpio-idio-16.c
> index 4fbae6f6a497..9ac967c6b430 100644
> --- a/drivers/gpio/gpio-idio-16.c
> +++ b/drivers/gpio/gpio-idio-16.c
> @@ -66,9 +66,9 @@ static int idio_16_handle_mask_sync(const int index, co=
nst unsigned int mask_buf
>  	return 0;
>  }
> =20
> -static int idio_16_reg_mask_xlate(struct gpio_regmap *const gpio, const =
unsigned int base,
> -				  const unsigned int offset, unsigned int *const reg,
> -				  unsigned int *const mask)
> +static int idio_16_reg_mask_xlate(struct gpio_regmap *const gpio, enum g=
pio_regmap_operation op,
> +				  const unsigned int base, const unsigned int offset,
> +				  unsigned int *const reg, unsigned int *const mask)
>  {
>  	unsigned int stride;
> =20
> diff --git a/drivers/gpio/gpio-max7360.c b/drivers/gpio/gpio-max7360.c
> index 07eda49f375b..6755d58c4534 100644
> --- a/drivers/gpio/gpio-max7360.c
> +++ b/drivers/gpio/gpio-max7360.c
> @@ -93,6 +93,7 @@ static int max7360_set_gpos_count(struct device *dev, s=
truct regmap *regmap)
>  }
> =20
>  static int max7360_gpio_reg_mask_xlate(struct gpio_regmap *gpio,
> +				       enum gpio_regmap_operation op,
>  				       unsigned int base, unsigned int offset,
>  				       unsigned int *reg, unsigned int *mask)
>  {
> diff --git a/drivers/gpio/gpio-pcie-idio-24.c b/drivers/gpio/gpio-pcie-id=
io-24.c
> index 80c0ba0afa67..b99f4863443d 100644
> --- a/drivers/gpio/gpio-pcie-idio-24.c
> +++ b/drivers/gpio/gpio-pcie-idio-24.c
> @@ -225,9 +225,9 @@ static int idio_24_set_type_config(unsigned int **con=
st buf, const unsigned int
>  	return ret;
>  }
> =20
> -static int idio_24_reg_mask_xlate(struct gpio_regmap *const gpio, const =
unsigned int base,
> -				  const unsigned int offset, unsigned int *const reg,
> -				  unsigned int *const mask)
> +static int idio_24_reg_mask_xlate(struct gpio_regmap *const gpio, enum g=
pio_regmap_operation op,
> +				  const unsigned int base, const unsigned int offset,
> +				  unsigned int *const reg, unsigned int *const mask)
>  {
>  	const unsigned int out_stride =3D offset / IDIO_24_NGPIO_PER_REG;
>  	const unsigned int in_stride =3D (offset - 24) / IDIO_24_NGPIO_PER_REG;
> diff --git a/drivers/gpio/gpio-regmap.c b/drivers/gpio/gpio-regmap.c
> index 658b892b624c..1cc9c03ade99 100644
> --- a/drivers/gpio/gpio-regmap.c
> +++ b/drivers/gpio/gpio-regmap.c
> @@ -40,9 +40,10 @@ struct gpio_regmap {
>  	struct regmap_irq_chip_data *irq_chip_data;
>  #endif
> =20
> -	int (*reg_mask_xlate)(struct gpio_regmap *gpio, unsigned int base,
> -			      unsigned int offset, unsigned int *reg,
> -			      unsigned int *mask);
> +	int (*reg_mask_xlate)(struct gpio_regmap *gpio,
> +			      enum gpio_regmap_operation op,
> +			      unsigned int base, unsigned int offset,
> +			      unsigned int *reg, unsigned int *mask);
> =20
>  	void *driver_data;
>  };
> @@ -56,6 +57,7 @@ static unsigned int gpio_regmap_addr(unsigned int addr)
>  }
> =20
>  static int gpio_regmap_simple_xlate(struct gpio_regmap *gpio,
> +				    enum gpio_regmap_operation __maybe_unused op,
>  				    unsigned int base, unsigned int offset,
>  				    unsigned int *reg, unsigned int *mask)
>  {
> @@ -71,7 +73,7 @@ static int gpio_regmap_simple_xlate(struct gpio_regmap =
*gpio,
>  static int gpio_regmap_get(struct gpio_chip *chip, unsigned int offset)
>  {
>  	struct gpio_regmap *gpio =3D gpiochip_get_data(chip);
> -	unsigned int base, val, reg, mask;
> +	unsigned int base, val, reg, mask, dir_mask;
>  	int ret;
> =20
>  	/* we might not have an output register if we are input only */
> @@ -80,7 +82,18 @@ static int gpio_regmap_get(struct gpio_chip *chip, uns=
igned int offset)
>  	else
>  		base =3D gpio_regmap_addr(gpio->reg_set_base);
> =20
> -	ret =3D gpio->reg_mask_xlate(gpio, base, offset, &reg, &mask);
> +	ret =3D gpio->reg_mask_xlate(gpio, GPIO_REGMAP_GET_OP, base, offset, &r=
eg, &dir_mask);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D regmap_read(gpio->regmap, reg, &val);
> +	if (ret)
> +		return ret;
> +
> +	if (val & dir_mask)
> +		ret =3D gpio->reg_mask_xlate(gpio, GPIO_REGMAP_OUT, base, offset, &reg=
, &mask);
> +	else
> +		ret =3D gpio->reg_mask_xlate(gpio, GPIO_REGMAP_IN, base, offset, &reg,=
 &mask);
>  	if (ret)
>  		return ret;
> =20
> @@ -103,7 +116,7 @@ static int gpio_regmap_set(struct gpio_chip *chip, un=
signed int offset,
>  	unsigned int reg, mask, mask_val;
>  	int ret;
> =20
> -	ret =3D gpio->reg_mask_xlate(gpio, base, offset, &reg, &mask);
> +	ret =3D gpio->reg_mask_xlate(gpio, GPIO_REGMAP_SET_OP, base, offset, &r=
eg, &mask);
>  	if (ret)
>  		return ret;
> =20
> @@ -133,7 +146,7 @@ static int gpio_regmap_set_with_clear(struct gpio_chi=
p *chip,
>  	else
>  		base =3D gpio_regmap_addr(gpio->reg_clr_base);
> =20
> -	ret =3D gpio->reg_mask_xlate(gpio, base, offset, &reg, &mask);
> +	ret =3D gpio->reg_mask_xlate(gpio, GPIO_REGMAP_SET_OP, base, offset, &r=
eg, &mask);
>  	if (ret)
>  		return ret;
> =20
> @@ -183,7 +196,7 @@ static int gpio_regmap_get_direction(struct gpio_chip=
 *chip,
>  		return -ENOTSUPP;
>  	}
> =20
> -	ret =3D gpio->reg_mask_xlate(gpio, base, offset, &reg, &mask);
> +	ret =3D gpio->reg_mask_xlate(gpio, GPIO_REGMAP_GET_DIR_OP, base, offset=
, &reg, &mask);
>  	if (ret)
>  		return ret;
> =20
> @@ -237,7 +250,7 @@ static int gpio_regmap_set_direction(struct gpio_chip=
 *chip,
>  		return -ENOTSUPP;
>  	}
> =20
> -	ret =3D gpio->reg_mask_xlate(gpio, base, offset, &reg, &mask);
> +	ret =3D gpio->reg_mask_xlate(gpio, GPIO_REGMAP_SET_DIR_OP, base, offset=
, &reg, &mask);
>  	if (ret)
>  		return ret;
> =20
> diff --git a/drivers/iio/adc/ad7173.c b/drivers/iio/adc/ad7173.c
> index 9ee65d63c525..f78e758706ed 100644
> --- a/drivers/iio/adc/ad7173.c
> +++ b/drivers/iio/adc/ad7173.c
> @@ -560,8 +560,8 @@ static int ad4111_openwire_event(struct iio_dev *indi=
o_dev,
>  	return ret;
>  }
> =20
> -static int ad7173_mask_xlate(struct gpio_regmap *gpio, unsigned int base,
> -			     unsigned int offset, unsigned int *reg,
> +static int ad7173_mask_xlate(struct gpio_regmap *gpio, enum gpio_regmap_=
operation op,
> +			     unsigned int base, unsigned int offset, unsigned int *reg,
>  			     unsigned int *mask)
>  {
>  	*mask =3D AD7173_GPO_DATA(offset);
> @@ -569,8 +569,8 @@ static int ad7173_mask_xlate(struct gpio_regmap *gpio=
, unsigned int base,
>  	return 0;
>  }
> =20
> -static int ad4111_mask_xlate(struct gpio_regmap *gpio, unsigned int base,
> -			     unsigned int offset, unsigned int *reg,
> +static int ad4111_mask_xlate(struct gpio_regmap *gpio, enum gpio_regmap_=
operation op,
> +			     unsigned int base, unsigned int offset, unsigned int *reg,
>  			     unsigned int *mask)
>  {
>  	*mask =3D AD4111_GPO01_DATA(offset);
> diff --git a/drivers/iio/addac/stx104.c b/drivers/iio/addac/stx104.c
> index 7bdf2cb94176..6207eb2fac74 100644
> --- a/drivers/iio/addac/stx104.c
> +++ b/drivers/iio/addac/stx104.c
> @@ -349,9 +349,9 @@ static const struct iio_chan_spec stx104_channels_dif=
f[] =3D {
>  	STX104_IN_CHAN(6, 1), STX104_IN_CHAN(7, 1)
>  };
> =20
> -static int stx104_reg_mask_xlate(struct gpio_regmap *const gpio, const u=
nsigned int base,
> -				 unsigned int offset, unsigned int *const reg,
> -				 unsigned int *const mask)
> +static int stx104_reg_mask_xlate(struct gpio_regmap *const gpio, enum gp=
io_regmap_operation op,
> +				 const unsigned int base, unsigned int offset,
> +				 unsigned int *const reg, unsigned int *const mask)
>  {
>  	/* Output lines are located at same register bit offsets as input lines=
 */
>  	if (offset >=3D 4)
> diff --git a/drivers/pinctrl/bcm/pinctrl-bcm63xx.c b/drivers/pinctrl/bcm/=
pinctrl-bcm63xx.c
> index a4aa4146b530..b41a3d16aabe 100644
> --- a/drivers/pinctrl/bcm/pinctrl-bcm63xx.c
> +++ b/drivers/pinctrl/bcm/pinctrl-bcm63xx.c
> @@ -19,6 +19,7 @@
>  #define BCM63XX_DATA_REG	0x0c
> =20
>  static int bcm63xx_reg_mask_xlate(struct gpio_regmap *gpio,
> +				  enum gpio_regmap_operation op,
>  				  unsigned int base, unsigned int offset,
>  				  unsigned int *reg, unsigned int *mask)
>  {
> diff --git a/drivers/pinctrl/pinctrl-tps6594.c b/drivers/pinctrl/pinctrl-=
tps6594.c
> index 456a3cfc8de9..937fc9cb54b7 100644
> --- a/drivers/pinctrl/pinctrl-tps6594.c
> +++ b/drivers/pinctrl/pinctrl-tps6594.c
> @@ -346,6 +346,7 @@ static struct tps6594_pinctrl tps6594_template_pinctr=
l =3D {
>  };
> =20
>  static int tps6594_gpio_regmap_xlate(struct gpio_regmap *gpio,
> +				     enum gpio_regmap_operation op,
>  				     unsigned int base, unsigned int offset,
>  				     unsigned int *reg, unsigned int *mask)
>  {
> diff --git a/include/linux/gpio/regmap.h b/include/linux/gpio/regmap.h
> index eb3931fbbad0..ececc287d519 100644
> --- a/include/linux/gpio/regmap.h
> +++ b/include/linux/gpio/regmap.h
> @@ -13,6 +13,40 @@ struct regmap;
>  #define GPIO_REGMAP_ADDR_ZERO ((unsigned int)(-1))
>  #define GPIO_REGMAP_ADDR(addr) ((addr) ? : GPIO_REGMAP_ADDR_ZERO)
> =20
> +/**
> + * enum gpio_regmap_operation - Operation type for reg_mask_xlate callba=
ck
> + *
> + * Traditionally, the operation type was inferred from the base register.
> + * However, that approach does not always work =E2=80=94 for example, wh=
en all control
> + * bits of a single GPIO reside in the same register. This enum allows t=
he
> + * reg_mask_xlate callback to explicitly distinguish between operation t=
ypes.
> + * The user is free to choose which method to use.
> + *
> + * Value operations:
> + * @GPIO_REGMAP_GET_OP: Mask for reading direction to detect if GPIO is =
input or
> + *			output. Used in gpio_regmap_get() to determine the GPIO
> + *			direction.
> + * @GPIO_REGMAP_IN: Mask for reading input value. Used when GPIO is conf=
igured as
> + *			input.
> + * @GPIO_REGMAP_OUT: Mask for reading output value. Used when GPIO is co=
nfigured as
> + *			output.
> + *
> + * Output operations:
> + * @GPIO_REGMAP_SET_OP: Mask for setting GPIO output value.
> + *
> + * Direction operations:
> + * @GPIO_REGMAP_GET_DIR_OP: Mask for reading GPIO direction (input/outpu=
t).
> + * @GPIO_REGMAP_SET_DIR_OP: Mask for setting GPIO direction (input/outpu=
t).
> + */
> +enum gpio_regmap_operation {
> +	GPIO_REGMAP_GET_OP,
> +	GPIO_REGMAP_SET_OP,
> +	GPIO_REGMAP_GET_DIR_OP,
> +	GPIO_REGMAP_SET_DIR_OP,
> +	GPIO_REGMAP_IN,
> +	GPIO_REGMAP_OUT,
> +};
> +
>  /**
>   * struct gpio_regmap_config - Description of a generic regmap gpio_chip.
>   * @parent:		The parent device
> @@ -104,9 +138,9 @@ struct gpio_regmap_config {
>  	unsigned long regmap_irq_flags;
>  #endif
> =20
> -	int (*reg_mask_xlate)(struct gpio_regmap *gpio, unsigned int base,
> -			      unsigned int offset, unsigned int *reg,
> -			      unsigned int *mask);
> +	int (*reg_mask_xlate)(struct gpio_regmap *gpio, enum gpio_regmap_operat=
ion,
> +			      unsigned int base, unsigned int offset,
> +			      unsigned int *reg, unsigned int *mask);
> =20
>  	int (*init_valid_mask)(struct gpio_chip *gc,
>  			       unsigned long *valid_mask,

