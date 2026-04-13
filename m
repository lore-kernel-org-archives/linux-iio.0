Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4667131D371;
	Mon, 13 Apr 2026 19:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776109065; cv=none; b=vGhHzixcrOk5p6fDhnmG85GzTufpoDqa7Ftq0Aabg8qYfQSk+4hPeaYGIR40XwtVsBdD7PnDQM1G7n7mC8S+ZzcISM0lJ8oM31ewSpmsbKcVNZ61wUkGl+MQap7GERBJM8t3ToNh18UHhFXzTyLunJtLSr7ul7WGzTa/QT4RHYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776109065; c=relaxed/simple;
	bh=En1ttawX0jEssZolW/p6qsjQd/8okr4Vj7g0UZWFEJs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RYxZlOZ9sW0YQ/+dhK57cHD0SBz/lcq/qY9C6sXq8Mos+6Ra6nNdkbiW5gWO7NTHHXQL2U4UHPM2EuPZ9wszIRJSay3jzUpiE1fzHZebVwXVe5/mj1jJHQHbLMV52ozIMRJHn2KWxjRKWbXZNWSjezxz4tOEV4UQVnzYnoleD10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s2SgMvhu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s2SgMvhu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3886C2BCAF;
	Mon, 13 Apr 2026 19:37:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776109065;
	bh=En1ttawX0jEssZolW/p6qsjQd/8okr4Vj7g0UZWFEJs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=s2SgMvhuxySjPJZd7ZigYv5bHj2NMwwXq1GSnQlGHDh6GL0/X01mvYX9Ei+wZsVG4
	 hnC0kFpKXYlz3LGxSZiFTHIL85dJlmaVWWKBeMhaPX9xoUD+Wxv3KHDDf+8IS+Uc1X
	 d5QBBH1GW1G56bxnd8t9lIj0SvXk9RqdK/6LWd2SlJXnzQC15FGA69ZoIR9YGtOGp0
	 JcIqsmdt97FAm9UUrSDJTauHrnI2XNjlDavZ99fnYTf/p1Wq5fVh2rpbcV1E2S4sg2
	 R3XW1XOYHIKxVkuleDFQkoeuBMwQ/3C5smlH1g3yTm5MkRdApHbwY/2oy8720bQoIX
	 Lk7g0N07986Yw==
Date: Mon, 13 Apr 2026 20:37:34 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Chris Morgan <macroalpha82@gmail.com>
Cc: linux-iio@vger.kernel.org, andy@kernel.org, nuno.sa@analog.com,
 dlechner@baylibre.com, jean-baptiste.maneyrol@tdk.com,
 linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
 heiko@sntech.de, conor+dt@kernel.org, krzk+dt@kernel.org, robh@kernel.org,
 andriy.shevchenko@intel.com, Chris Morgan <macromorgan@hotmail.com>
Subject: Re: [PATCH V3 7/9] iio: imu: inv_icm42607: Add Interrupt and Wake
 on Movement for icm42607
Message-ID: <20260413203734.3f07a095@jic23-huawei>
In-Reply-To: <20260330195853.392877-8-macroalpha82@gmail.com>
References: <20260330195853.392877-1-macroalpha82@gmail.com>
	<20260330195853.392877-8-macroalpha82@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 30 Mar 2026 14:58:51 -0500
Chris Morgan <macroalpha82@gmail.com> wrote:

> From: Chris Morgan <macromorgan@hotmail.com>
> 
> Add support for wake on movement for the icm42607 driver.
> 
> At this point the driver is usable as an accelerometer/temperature
> driver, so add the necessary Makefile and Kconfig changes as well.
> 
> Signed-off-by: Chris Morgan <macromorgan@hotmail.com>l
A few comments on this one.

> diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607.h b/drivers/iio/imu/inv_icm42607/inv_icm42607.h
> index 56bb09e2c304..f5f1b5fea183 100644
> --- a/drivers/iio/imu/inv_icm42607/inv_icm42607.h
> +++ b/drivers/iio/imu/inv_icm42607/inv_icm42607.h

...

>
>  struct iio_dev *inv_icm42607_accel_init(struct inv_icm42607_state *st)
> diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c b/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c
> index 62a1371b0c4a..4ac3af52c1b8 100644
> --- a/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c
> +++ b/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c

> +
> +int inv_icm42607_disable_wom(struct inv_icm42607_state *st)
> +{
> +	int ret;
> +
> +	/* disable WoM interrupt */
> +	ret = regmap_clear_bits(st->map, INV_ICM42607_REG_INT_SOURCE1,
> +				INV_ICM42607_INT_SOURCE1_WOM_INT1_EN);
> +	if (ret)
> +		return ret;
> +
> +	/* disable WoM hardware */
> +	return regmap_clear_bits(st->map, INV_ICM42607_REG_WOM_CONFIG,
> +				 INV_ICM42607_WOM_CONFIG_EN);

regmap_set_bits()

> +}
> +
> +

As below.

>  int inv_icm42607_debugfs_reg(struct iio_dev *indio_dev, unsigned int reg,

> +
> +/**
> + * inv_icm42607_irq_init() - initialize int pin and interrupt handler
> + * @st:		driver internal state
> + * @irq:	irq number
> + * @irq_type:	irq trigger type
> + * @open_drain:	true if irq is open drain, false for push-pull
> + *
> + * Returns 0 on success, a negative error code otherwise.
> + */
> +static int inv_icm42607_irq_init(struct inv_icm42607_state *st, int irq,
> +				int irq_type, bool open_drain)
> +{
> +	struct device *dev = regmap_get_device(st->map);
> +	unsigned int val = 0;
> +	int ret;
> +
> +	switch (irq_type) {
> +	case IRQF_TRIGGER_RISING:
> +	case IRQF_TRIGGER_HIGH:
> +		val = INV_ICM42607_INT_CONFIG_INT1_ACTIVE_HIGH;
> +		break;
> +	default:
> +		val = INV_ICM42607_INT_CONFIG_INT1_ACTIVE_LOW;
> +		break;
> +	}
> +
> +	switch (irq_type) {
> +	case IRQF_TRIGGER_LOW:
> +	case IRQF_TRIGGER_HIGH:
> +		val |= INV_ICM42607_INT_CONFIG_INT1_LATCHED;
> +		break;
> +	default:
> +		break;
> +	}
> +
> +	if (!open_drain)
> +		val |= INV_ICM42607_INT_CONFIG_INT1_PUSH_PULL;
> +
> +	ret = regmap_write(st->map, INV_ICM42607_REG_INT_CONFIG, val);
> +	if (ret)
> +		return ret;
> +
> +	irq_type |= IRQF_ONESHOT;
> +	return devm_request_threaded_irq(dev, irq, inv_icm42607_irq_timestamp,
> +					 inv_icm42607_irq_handler, irq_type,
> +					 st->name, st);
> +}
> +
> +

Trivial but single line is always enough (in IIO anyway)

>  static int inv_icm42607_enable_vddio_reg(struct inv_icm42607_state *st)
