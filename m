Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DFFA30C34A;
	Sun, 26 Apr 2026 14:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777214619; cv=none; b=TCxSOgixmsZMGe/0RHWGp4ugcl2gUsToAVkDXBQAIsJ57LQUiKm5Dida49MNT/zbVztTZtvY42WiqtowTHfFqEmQKGbRMbS1nPBGa9338fY9e3EWwJU8x8GE6vkgzhuIMY4XYgAeSZSuIilPAW1EUYYnj8s57cYrB6XYsLr7t00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777214619; c=relaxed/simple;
	bh=ZyE3twHSqLx2JDo9mwpaXSUcbJQKpK/gGLQPIjMkBb0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o5J/UgfVxxYtXY6nlzIcS/9sAg8Si7DO5s3jEsJAc3X+h8fAKtXnpC9bg9zPnD17Ena0Ig7VPdK1XOOwksI3NLD1RujdWHBHNXaL93PhVP+25P5p58qxRD1KtwMNOFf2HePASWlu9HNV3QS/vgsdRAWZSZynnC9aiQyalWz0aCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y5BT//1W; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y5BT//1W"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61796C2BCAF;
	Sun, 26 Apr 2026 14:43:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777214619;
	bh=ZyE3twHSqLx2JDo9mwpaXSUcbJQKpK/gGLQPIjMkBb0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Y5BT//1WgMHbUDK3KgcLBdHfXOJ7Zj7F4+FLYqwCOYN66OnWZejRlk1uH84kd7xhg
	 32VMS1zn9fJ/QHzIFeFEaoLstRO0aYu9CuKDFSEvYH8QbGhCbjipyixVlgJPvT7X8o
	 NYF1DNzCfW1q7icD171Chx20YrhCmxrd05YAy+/WylyjSWwLUXyqcj0eyRI+TVsXpV
	 EFpLkrODiy3kr+2lRSpV2mmcE0sEmCM1DPukf0HYiMybF808nN5DtxE8QA7InRN2qW
	 PaSTYFCpTC2leajjH7i2YoL6j6D+lXjoqrTugkpb0j8cGS3ECNF1X/kBDtrsoFgHiN
	 OgcIZ7sFhZgJg==
Date: Sun, 26 Apr 2026 15:43:30 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andrey Skvortsov <andrej.skvortzov@gmail.com>
Cc: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Jonathan Marek <jonathan@marek.ca>, Brian
 Masney <masneyb@onstation.org>, Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v3 1/3] iio: imu: inv_mpu6050: fix unbalanced
 regulator_disable calls, when probe fails
Message-ID: <20260426154330.0a29236e@jic23-huawei>
In-Reply-To: <20260426112334.3938774-2-andrej.skvortzov@gmail.com>
References: <20260426112334.3938774-1-andrej.skvortzov@gmail.com>
	<20260426112334.3938774-2-andrej.skvortzov@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 26 Apr 2026 14:23:32 +0300
Andrey Skvortsov <andrej.skvortzov@gmail.com> wrote:

> During a probe functions after all regulators are enabled, runtime pm
> is enabled. Before probe function finishes, runtime pm triggers and
> disables vddio regulator. When probe function fails after that,
> inv_mpu_core_disable_regulator_action tries to disable already
> disabled by runtime pm vddio regulator causing following backtrace:
> 
>   inv-mpu6050-i2c 1-0068: trigger probe fail -19
>   WARNING: drivers/regulator/core.c:3244 at _regulator_disable+0x2ac/0x600
>   Call trace:
>    _regulator_disable+0x2ac/0x600 (P)
>    regulator_disable+0xac/0x148
>    inv_mpu_core_disable_regulator_vddio_action+0x3c/0xb0 [inv_mpu6050]
>    devm_action_release+0x4c/0x88
>    release_nodes+0xd8/0x178
>    devres_release_group+0x214/0x3c8
>    i2c_device_probe+0x6fc/0x9b0
>   ...
>   inv-mpu6050-i2c 1-0068: Failed to disable vddio regulator: -5
> 
> vddio state is handled in two places: pm_runtime and
> inv_mpu_core_disable_regulator_vddio_action devm action.
> inv_mpu_core_disable_regulator_vddio_action has to check, whether
> regulator is disabled by pm_runtime already. But this information is
> available only after pm_runtime state is initialized by
> pm_runtime_set_active during a probe. So
> inv_mpu_core_disable_regulator_vddio_action has to be called only
> after pm_runtime is properly initialized. To handle cases, when probe
> fails before pm_runtime is enabled, explicitly disable regulators
> in error paths.
Why not drag pm_runtime_set_active() earlier?  Whilst we currently
check for an error on that call I'm not sure there is any reason
to do so.  It's a narrow set of conditions than can cause such an
error. 

If you have that between the regulator enable and registering the
devm action I think that would mean you don't need to manually clean
up the regulators.

Maybe I'm missing something.

J

> 
> Signed-off-by: Andrey Skvortsov <andrej.skvortzov@gmail.com>
> Fixes: 07c12b1c007c ("iio: imu: mpu6050: add support for regulator framework")
> ---
> 
> Changes in v3:
>  - make patch to be the first patch of the patchset for easier backporting
>  - update commit message to fix Andy's comment
>  - don't move pm_runtime_set_active from pm_runtime initialization,
>    move activation of inv_mpu_core_disable_regulator_action instead
> 
> Changes in v2:
>  - minimize call trace in commit message
>  - include specific driver name in patch subject
> 
>  drivers/iio/imu/inv_mpu6050/inv_mpu_core.c | 25 ++++++++++++----------
>  1 file changed, 14 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> index 5796896d54cd8..49fdf33adec99 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> @@ -1862,6 +1862,7 @@ static int inv_mpu_core_disable_regulator_vddio(struct inv_mpu6050_state *st)
>  static void inv_mpu_core_disable_regulator_action(void *_data)
>  {
>  	struct inv_mpu6050_state *st = _data;
> +	struct device *dev = regmap_get_device(st->map);
>  	int result;
>  
>  	result = regulator_disable(st->vdd_supply);

> @@ -1869,7 +1870,8 @@ static void inv_mpu_core_disable_regulator_action(void *_data)
>  		dev_err(regmap_get_device(st->map),
>  			"Failed to disable vdd regulator: %d\n", result);
>  
> -	inv_mpu_core_disable_regulator_vddio(st);
> +	if (!pm_runtime_status_suspended(dev))
> +		inv_mpu_core_disable_regulator_vddio(st);
>  }
>  
>  static void inv_mpu_pm_disable(void *data)
> @@ -1976,23 +1978,15 @@ int inv_mpu_core_probe(struct regmap *regmap, int irq, const char *name,
>  		return result;
>  	}
>  
> -	result = devm_add_action_or_reset(dev, inv_mpu_core_disable_regulator_action,
> -				 st);
> -	if (result) {
> -		dev_err(dev, "Failed to setup regulator cleanup action %d\n",
> -			result);
> -		return result;
> -	}
> -
>  	/* fill magnetometer orientation */
>  	result = inv_mpu_magn_set_orient(st);
>  	if (result)
> -		return result;
> +		goto error_vddio_off;
>  
>  	/* power is turned on inside check chip type*/
>  	result = inv_check_and_setup_chip(st);
>  	if (result)
> -		return result;
> +		goto error_vddio_off;
>  
>  	result = inv_mpu6050_init_config(indio_dev);
>  	if (result) {
> @@ -2018,6 +2012,12 @@ int inv_mpu_core_probe(struct regmap *regmap, int irq, const char *name,
>  	result = pm_runtime_set_active(dev);
>  	if (result)
>  		goto error_power_off;
> +
> +	result = devm_add_action_or_reset(dev, inv_mpu_core_disable_regulator_action,
> +					  st);
> +	if (result)
> +		return dev_err_probe(dev, result,
> +				     "Failed to setup regulator cleanup action\n");
>  	pm_runtime_get_noresume(dev);
>  	pm_runtime_enable(dev);
>  	pm_runtime_set_autosuspend_delay(dev, INV_MPU6050_SUSPEND_DELAY_MS);
> @@ -2114,6 +2114,9 @@ int inv_mpu_core_probe(struct regmap *regmap, int irq, const char *name,
>  
>  error_power_off:
>  	inv_mpu6050_set_power_itg(st, false);
> +error_vddio_off:
> +	inv_mpu_core_disable_regulator_vddio(st);
> +	regulator_disable(st->vdd_supply);
>  	return result;
>  }
>  EXPORT_SYMBOL_NS_GPL(inv_mpu_core_probe, "IIO_MPU6050");

