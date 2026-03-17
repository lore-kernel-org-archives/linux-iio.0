Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6525189F43;
	Tue, 17 Mar 2026 20:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773780488; cv=none; b=KwUmZGkSy6Cfyv4fidmW+zSp6lM843bfdQ6B4sUAwCwMJOUW5yzeVCqXZU+xut9p/0MuWsSLtsZsrAmzoSpnMJioXPjy9EJh97gqMyuIJlDd+pOoByA1umcSyBJ8KEa1tIgwdpRh8IwSNWTxeFtKfreOpoUC//Fr/B22eRuqkmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773780488; c=relaxed/simple;
	bh=+HmQyqGY0VVyDwrrGXUAzDwJDupoEaQD5ifNKuol77g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nMd7iHBjRhBUCbc0Y3+4IrQ3SmBL2dCwSByEK6IIZg3t6fzAovcg6j6PtIy2UhMpZxO04eSJEjya519VdF5kpLsxVO/VJolEJp41TzX/7gMLV4EQIsAGtaro6acB75d/r9PWcU7ZnsKyyliDVsg/X9YN7bgTOUEGkBgzgljXFhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I4Gxcf5Z; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I4Gxcf5Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13F19C4CEF7;
	Tue, 17 Mar 2026 20:48:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773780487;
	bh=+HmQyqGY0VVyDwrrGXUAzDwJDupoEaQD5ifNKuol77g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=I4Gxcf5ZTAwHjB5tV2nJIw1N6hZjBgpPApHh98Q8DfuKydHckZMvPnVj2H2GoJFb0
	 4W0B20hCk1k89hnUkS3LwNLq/+kxa7WdTUJCsDSKGhsLgw38rrl0dozBeyIVJE/98e
	 vaVLxfFanX/8VO/ZEoM6UTBys6v2x2imGJtfwS+AkVo+P0iBXpwmRz5sCmOMhSmKjh
	 /BVPkMz80u8UuZx/58w5+qi3O2AjqJt8lry7Pj79mPADlmpBAwFsmuDV2RVuSFZqwL
	 tmEiuSJdbOt7YNpXuzZI/YfoD6GUuzKSTyxVHny341DurmAgMMNA63+hep/Tfe+/p2
	 2DX8mwqSIwCgA==
Date: Tue, 17 Mar 2026 20:47:57 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Rodrigo Gobbi <rodrigo.gobbi.7@gmail.com>
Cc: lanzano.alex@gmail.com, dlechner@baylibre.com, nuno.sa@analog.com,
 andy@kernel.org, gustavograzs@gmail.com, ~lkcamp/patches@lists.sr.ht,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: imu: bmi270: use dev_warn for unexpected chip id
Message-ID: <20260317204757.5ac0b63b@jic23-huawei>
In-Reply-To: <20260316232007.22887-1-rodrigo.gobbi.7@gmail.com>
References: <20260316232007.22887-1-rodrigo.gobbi.7@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 16 Mar 2026 20:11:48 -0300
Rodrigo Gobbi <rodrigo.gobbi.7@gmail.com> wrote:

> An unexpected chip id read from hardware indicates a potential
> failure for detecting id, which needs a more appropriate level
> of verbosity.
> 
> Signed-off-by: Rodrigo Gobbi <rodrigo.gobbi.7@gmail.com>

I've always been a bit flexible on the level of these warnings, but the
counter argument is that we are only not failing probe on these mismatches
to enable dt fallback compatibles. Those enable newer fully backwards
compatible parts to work on older kernels by specifying both the new
compatible and an older one. IIRC there is a similar concept in ACPI but
it's not as commonly used.

For those it is arguable we should be silent, but a compromise to help
with debugging simple 'wrong device' cases was to print a message.

Sometimes we have had device classes where reads of all 0s or all 1s
(typical failure to communicate cases) resulted in an error but all
else is accepted. That only works if we have some info from the
manufacturer that they definitely will never use those IDs (or really
strong gut feeling that they have more sense on SPI at least -
i2c at least has detectable indications of no one is replying).

Anyhow, generally I let the original author pick if they want
dev_info() or dev_warn(),  Maybe we should have a rule on it, but
then we get into questions on whether making it more noisy (e.g.
dev_warn()) might be perceived as a minor regression and get users
calling up the help desk after a kernel upgrade.

So my feeling is probably to leave this one alone though I'm open
to a wider discussion.

Jonathan


> ---
> I was exploring Bosch BMI270 driver and noticed a possible dev_info usage that might
> not be appropriate it regarding its verbosity level. Let's consider that probe definition
> at [1], used by [2] spi version and [3] i2 version.
> The i2c or spi callers will fill chip_info and then, probe will try to validate it at _init function:
> 
> // drivers/iio/imu/bmi270/bmi270_core.c
> int bmi270_core_probe(struct device *dev, struct regmap *regmap,
> 		      const struct bmi270_chip_info *chip_info)          
>     data->chip_info = chip_info;
> ...
> 	ret = bmi270_chip_init(data);
> ....
> 
> static int bmi270_chip_init(struct bmi270_data *data)
> {
> 	int ret;
> 
> 	ret = bmi270_validate_chip_id(data);
> 	if (ret)
>         return ret;
> ....
> 
> from init, chipid will be read from hardware but if the value is not expected with
> the one from the caller, i2c or spi, it will trigger a dev_info and not a warning:
> 
> // valid ids for i2c and spi
> #define BMI260_CHIP_ID_VAL				0x27
> #define BMI270_CHIP_ID_VAL				0x24
> 
> static int bmi270_validate_chip_id(struct bmi270_data *data)
> {
> 	int chip_id;
> 	int ret;
> 	struct device *dev = data->dev;
> 	struct regmap *regmap = data->regmap;
> 
> 	ret = regmap_read(regmap, BMI270_CHIP_ID_REG, &chip_id);
> 	if (ret)
> 		return dev_err_probe(dev, ret, "Failed to read chip id");
> 
> ....
> 	if (chip_id != data->chip_info->chip_id)
> 		dev_info(dev, "Unexpected chip id 0x%x", chip_id);
> 
> 	if (chip_id == bmi260_chip_info.chip_id)
> 		data->chip_info = &bmi260_chip_info;
> 	else if (chip_id == bmi270_chip_info.chip_id)
> 		data->chip_info = &bmi270_chip_info;
> 
> 	return 0;
> }
> 
> The chip_info will be correct due the caller matching DT or ACPI before, and here,
> driver is only double-checking the value at hardware and printing if it is not matching.
> Printing as info can be confusing, since this is more like a warning than info. 
> I don't have the hw here to test it, but I'm suggesting to just change the level
> of that msg.
> Tks and regards.
> 
> [1] https://github.com/torvalds/linux/blob/2d1373e4246da3b58e1df058374ed6b101804e07/drivers/iio/imu/bmi270/bmi270_core.c#L1599
> [2] https://github.com/torvalds/linux/blob/2d1373e4246da3b58e1df058374ed6b101804e07/drivers/iio/imu/bmi270/bmi270_spi.c#L65
> [3] https://github.com/torvalds/linux/blob/2d1373e4246da3b58e1df058374ed6b101804e07/drivers/iio/imu/bmi270/bmi270_i2c.c#L32
> ---
>  drivers/iio/imu/bmi270/bmi270_core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/imu/bmi270/bmi270_core.c b/drivers/iio/imu/bmi270/bmi270_core.c
> index 2ad230788532..a2f90ac22873 100644
> --- a/drivers/iio/imu/bmi270/bmi270_core.c
> +++ b/drivers/iio/imu/bmi270/bmi270_core.c
> @@ -1473,7 +1473,7 @@ static int bmi270_validate_chip_id(struct bmi270_data *data)
>  		return -ENODEV;
>  
>  	if (chip_id != data->chip_info->chip_id)
> -		dev_info(dev, "Unexpected chip id 0x%x", chip_id);
> +		dev_warn(dev, "Unexpected chip id 0x%x", chip_id);
>  
>  	if (chip_id == bmi260_chip_info.chip_id)
>  		data->chip_info = &bmi260_chip_info;

