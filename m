Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4098C3FE652;
	Sun, 20 Sep 2026 23:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789948276; cv=none; b=qDMWQcTs6FTb4nkoBXUGvSh4b36b64oSHegI+ZVhKcEv8eIKfkZg62/d6r70lBa3G1wxnF7FKYDALP08NFh7uJ2Rw47jeOPFevdLOvn0rk4BxGLvSqY10vew58yp09HwLZASkkCetTaSpsaq7kOhzWF19+vP1dFuxaWyVuq7tgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789948276; c=relaxed/simple;
	bh=5wyEokmJOZob3H/bvewpsSmfaS9CFMgigKaBU4XF8iQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T/JAz1Tqw7Gr4nmxGWOXujq/5qBOetwSXf6emzekTdmK2h9urfF7x3tDflqbM2W3zQHPi+7/tKpwuNPV73B7Q/Jmef6ev7JPUMfrLbbwaK2veI7/iNJT8ihI7CWi0y3eJYhZ1g/9r/Va9lizV3XDeH8bMo3LXvmm2MF2ODmTRxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GJARvgMF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GJARvgMF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CD9C1F000FF;
	Sun, 20 Sep 2026 23:51:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789948273;
	bh=DUn3vhHN71JeeVcxPYwrVdGZ1UKD3XNnIBUR0wuoigQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=GJARvgMFIwURKFRj2u6sSv636AGbLXmeDGy4Tl0ohXTTVfLvWeYJSaKLvRNBK9CiG
	 FTPwVlxSzIns0JHYtE16O+y7X/S5XGA0vJI5ndL8ZUqkr/UKCAjp1jmDoCyTr8TEag
	 O5KlpAL1Qv2Jiefu/yz+8grqBBrMb4g/Jn4fKPhE8WScZjvzk4QkOc3OIzdLeYN21V
	 jY9QLJu5XcrdwYuU2W9cqTBNQUHO2hJSSFhKR9YrQ7iQuu7yReT/vKCAaGX2EkyQaV
	 Z30uBs8Koyu7N59RMXtO3OTMWLxKFhWt6B2HAlOebFjKK2kUeY1G1JPwIPRBs6Tf1P
	 9+7rtVfGQBIEA==
Date: Mon, 21 Sep 2026 00:51:05 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Kanak Shilledar <kanak.shilledar@axis.com>
Cc: Henrik Grimler <henrik.grimler@axis.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 "Jean-Baptiste Maneyrol" <jean-baptiste.maneyrol@tdk.com>, Joshua Crofts
 <joshua.crofts1@gmail.com>, Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
 Chris Morgan <macromorgan@hotmail.com>, <kernel@axis.com>,
 <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 4/5] iio: imu: inv_icm42607: Implement MREGx register
 access
Message-ID: <20260921005105.1b992fc8@jic23-hlaptop>
In-Reply-To: <20260917-b4-inv_icm42370p-v4-4-fd9373f123c9@axis.com>
References: <20260917-b4-inv_icm42370p-v4-0-fd9373f123c9@axis.com>
	<20260917-b4-inv_icm42370p-v4-4-fd9373f123c9@axis.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 17 Sep 2026 15:38:19 +0200
Kanak Shilledar <kanak.shilledar@axis.com> wrote:

> The device supports indirect register access to different banks. A
> specific routine needs to be followed when accessing the registers in
> another bank as documented in the datasheet (section 13). This is
> required for accessing registers configured via the user and
> implementing buffer support. The implementation is inspired from the
> icm45600 driver. The banks are defined based on their initial bank
> access code which are written to the BLK_SEL_* regs. However, there is a
> variation for MREG1 as User Bank 0 and MREG1 both share the same 0x00,
> so User Bank 1 has 0x00 and MREG1 has 0x01. When MREG1 register is
> accessed, then BLK_SEL_* is written with 0x00 instead of 0x01.

I was kind of expecting to see use of the regmap_ranges stuff
which is there for banked registers.  Looks like you need
more complex handling.

> 
> Datasheet: https://www.invensense.tdk.com/en-us/products/3-axis/icm-42370-p
> Datasheet: https://www.lcsc.com/product-detail/C5129967.html
> Assisted-by: LLM
> Signed-off-by: Kanak Shilledar <kanak.shilledar@axis.com>
A few things inline.

Jonathan

> ---
> LLM was used to implement the mreg back switching support.
> ---
>  drivers/iio/imu/inv_icm42607/inv_icm42607.h      | 167 ++++++++++-------
>  drivers/iio/imu/inv_icm42607/inv_icm42607_core.c | 218 ++++++++++++++++++++---
>  drivers/iio/imu/inv_icm42607/inv_icm42607_i2c.c  |   5 +
>  drivers/iio/imu/inv_icm42607/inv_icm42607_spi.c  |   5 +
>  4 files changed, 312 insertions(+), 83 deletions(-)
> 
> diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607.h b/drivers/iio/imu/inv_icm42607/inv_icm42607.h
> index ca5f59eb436c0..1db005623740f 100644
> --- a/drivers/iio/imu/inv_icm42607/inv_icm42607.h
> +++ b/drivers/iio/imu/inv_icm42607/inv_icm42607.h
> @@ -167,31 +167,59 @@ struct inv_icm42607_sensor_state {
>  	int filter;
>  };
>  
> -/* Virtual register addresses: @bank on MSB (4 upper bits), @address on LSB */
> +/*
> + * Virtual register addresses: bank id in the upper byte, register address in
> + * the lower byte. Bank 0 is directly addressable on the bus. MREG banks are
> + * reached through the BLK_SEL/MADDR/M indirect access window, one byte per
> + * transaction (datasheet section 13, no burst support).
> + *
> + * MREG1 programs BLK_SEL = 0x00, which collides with the direct bank, so it
> + * gets the distinct virtual id 0x01. MREG2 and MREG3 virtual ids match their
> + * BLK_SEL values.
> + */
> +#define INV_ICM42607_REG_BANK_MASK			GENMASK(15, 8)
> +#define INV_ICM42607_REG_ADDR_MASK			GENMASK(7, 0)
> +
> +#define INV_ICM42607_BANK0				0x0000

You are using upper bits as a field and defining a mask to access them.
As such I'd define these as values in that filed. Eg. 0x00, 0x01, 0x28, and 0x50

> +#define INV_ICM42607_MREG1				0x0100
> +#define INV_ICM42607_MREG2				0x2800


> diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c b/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c
> index 114e7afcda391..9d572b3ffb15b 100644
> --- a/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c
> +++ b/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c
> @@ -23,58 +23,223 @@
>  
>  #include "inv_icm42607.h"
>  
> -static bool inv_icm42607_is_readable_reg(struct device *dev, unsigned int reg)

Why is this patch dropping the is_readable  / is_writeable checks?
Those are relevant to the debug interfaces etc.

> +static int inv_icm42607_mclk_get(struct regmap *map, bool *idle_set)
>  {
> -	switch (reg) {
> -	case INV_ICM42607_REG_MCLK_RDY ... INV_ICM42607_REG_INT_CONFIG:
> -	case INV_ICM42607_REG_TEMP_DATA1 ... INV_ICM42607_REG_TMST_FSYNCL:
> -	case INV_ICM42607_REG_APEX_DATA4 ... INV_ICM42607_REG_INTF_CONFIG1:
> -	case INV_ICM42607_REG_INT_STATUS_DRDY ... INV_ICM42607_REG_FIFO_DATA:
> -	case INV_ICM42607_REG_WHOAMI:
> -		return true;
> +	unsigned int val;
> +	int ret;
> +
> +	*idle_set = false;
> +
> +	ret = regmap_read(map, INV_ICM42607_REG_MCLK_RDY, &val);
> +	if (ret)
> +		return ret;
> +
> +	if (val & INV_ICM42607_MCLK_RDY_BIT)
> +		return 0;
> +
> +	/*
> +	 * Clock isn't running: we're either in Sleep mode or in Accel LP mode
> +	 * running on WUOSC. Force the RC oscillator on via IDLE and wait for
> +	 * MCLK_RDY. Datasheet gives 10us (accel startup) to 200us (accel
> +	 * transition from OFF) for this to complete.
> +	 */
> +	ret = regmap_set_bits(map, INV_ICM42607_REG_PWR_MGMT0,
> +			      INV_ICM42607_PWR_MGMT0_IDLE);
> +	if (ret)
> +		return ret;
> +
> +	*idle_set = true;
> +
> +	ret = regmap_read_poll_timeout(map, INV_ICM42607_REG_MCLK_RDY, val,
> +				       val & INV_ICM42607_MCLK_RDY_BIT, 10, 200);
> +	if (ret) {
> +		regmap_clear_bits(map, INV_ICM42607_REG_PWR_MGMT0,
> +				  INV_ICM42607_PWR_MGMT0_IDLE);
> +		*idle_set = false;
>  	}
>  
> -	return false;
> +	return ret;
>  }


>  
> +static int inv_icm42607_mreg_write(struct regmap *map, unsigned int reg,
> +				   const u8 *data, size_t count)
> +{
> +	bool idle_set;
> +	u8 blk_sel;
> +	int ret;
> +
> +	/* MREG access is one byte per transaction, no burst support. */
> +	if (count != 1)
> +		return -EINVAL;
> +
> +	ret = inv_icm42607_blk_sel(reg, &blk_sel);
> +	if (ret)
> +		return ret;
> +
> +	ret = inv_icm42607_mclk_get(map, &idle_set);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_write(map, INV_ICM42607_REG_BLK_SEL_W, blk_sel);
> +	if (ret)
> +		goto out;
> +
> +	ret = regmap_write(map, INV_ICM42607_REG_MADDR_W,
> +			   FIELD_GET(INV_ICM42607_REG_ADDR_MASK, reg));
> +	if (ret)
> +		goto out;
> +
> +	ret = regmap_write(map, INV_ICM42607_REG_M_W, *data);
> +	if (ret)
> +		goto out;
> +
> +	fsleep(INV_ICM42607_MREG_ACCESS_DELAY_US);
> +
> +	/* Restore direct access. */
> +	ret = regmap_write(map, INV_ICM42607_REG_BLK_SEL_W, 0);
> +out:
> +	inv_icm42607_mclk_put(map, idle_set);
> +
> +	return ret;
> +}
> +
> +static int inv_icm42607_read(void *context, const void *reg_buf, size_t reg_size,
> +			     void *val_buf, size_t val_size)
> +{
> +	unsigned int reg = be16_to_cpup(reg_buf);
> +	struct regmap *map = context;
> +
> +	if ((reg & INV_ICM42607_REG_BANK_MASK) != INV_ICM42607_BANK0)

Use FIELD_GET() to extract the field.  Means we don't have to figure out
where the bits are - that does require the values to be defined as
values of that field though.  Ideally you also then use FIELD_PREP()
for that part of the register addresses defines. 

> +		return inv_icm42607_mreg_read(map, reg, val_buf, val_size);
> +
> +	return regmap_bulk_read(map, FIELD_GET(INV_ICM42607_REG_ADDR_MASK, reg),
> +				val_buf, val_size);
> +}
> +
> +static int inv_icm42607_write(void *context, const void *data, size_t count)
> +{
> +	unsigned int reg = be16_to_cpup(data);

u16 perhaps?  What is guaranteeing alginment of data?  Maybe get_unaligned_be16()
is more appropriate.

> +	struct regmap *map = context;
> +	const u8 *d = data;
> +
> +	if ((reg & INV_ICM42607_REG_BANK_MASK) != INV_ICM42607_BANK0)
As above.
> +		return inv_icm42607_mreg_write(map, reg, d + 2, count - 2);
> +
> +	return regmap_bulk_write(map, FIELD_GET(INV_ICM42607_REG_ADDR_MASK, reg),
> +				 d + 2, count - 2);
> +}

