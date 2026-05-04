Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E233233F5BF;
	Mon,  4 May 2026 15:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777908872; cv=none; b=pNatkTVHmxxCnVQfnBcz3GoS0kddP3NpQSWJsVpD16KCw4PgpguPC3CQzDInntym49RWqzJi28p24/+FoQo0kU/B1KvMVOkgF5mOCIV3aeD2FVR71cqj3uNkyTDetPTtaW137CKUGND2TWjcAV0ijpP+sRcACiqy8/4sYY7wIeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777908872; c=relaxed/simple;
	bh=UvI1pqXZS5mWQeeaWX1604GLy2I99FgsqtE7lgewDk4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iXc7FpL9qnAkwuBMnAGLGwQRR/9Vb9s7BpaRely7j9Jhed800H9+tR18uqMzz5vVBmbqQ4KVMU1zycSf0rOegb7vbejMicElNoBgfwopaN8+0W5v9KebgTu0lERUmmCXaQc/zdHW289DaeyxR+9HIlrbUL0R5MoD2gayiQ2ey4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TyPowhZA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TyPowhZA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E35EC2BCB8;
	Mon,  4 May 2026 15:34:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777908871;
	bh=UvI1pqXZS5mWQeeaWX1604GLy2I99FgsqtE7lgewDk4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=TyPowhZAon9Bv0hCYwptwuonNqMK/2UIpLqwDpmotJ6LejputVjaaN2TYjsGd7FIv
	 z/+98f57LLvWWRrZDpxKIqhws70QlGzE9CcZiXMDMlT0EluIaOz98l6r+cy88xOLwN
	 RUQMAPM50XEezbgq92LVCFXYJ/qZ3wo4/f18DU8x8BuYo8VzJIBBsm4MgGRWK3hOn5
	 SRsWDfYgag/6XKZGFNKLwCfIT2DaWE/WquvEKvkKosP4NcoJJ0ZK3poNKWnikpWXl1
	 KTwRghKc1NiQEU5x5A6c8oJP/+XeM6maSWHommpa+hfqJlrUGD+pvqU16JXzVv1pyV
	 l+Im+d7YeCnew==
Date: Mon, 4 May 2026 16:34:23 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Miao Li <limiao870622@163.com>
Cc: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 waqar.hameed@axis.com, dixitparmar19@gmail.com, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Miao Li <limiao@kylinos.cn>
Subject: Re: [PATCH v4 1/3] iio: light: stk3310: Deal with the ps interrupt
 issue in PM
Message-ID: <20260504163423.33dcf4e1@jic23-huawei>
In-Reply-To: <20260504030408.105762-2-limiao870622@163.com>
References: <20260504030408.105762-1-limiao870622@163.com>
	<20260504030408.105762-2-limiao870622@163.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  4 May 2026 11:04:06 +0800
Miao Li <limiao870622@163.com> wrote:

> From: Miao Li <limiao@kylinos.cn>
> 
> On the Inspur HS326 laptop(which integrated with HiSilicon M900
> processor), if the STK3311-X chip's PS interrupt is configured
> in "Recommended interrupt mode", the interrupt cannot be triggered
> normally after waking from suspend or hibernation.
> 
> In this case, neither disabling and re-enabling the interrupt nor
> resetting the PS threshold register can restore the interrupt to
> normal operation.
> 
> If the interrupt is disabled in suspend() then reset the PS threshold
> register and enable the interrupt in resume(). This resolves the issue.
> 
> Signed-off-by: Miao Li <limiao@kylinos.cn>

Hi Miao Li,

This to me feels like something we should backport and is
sort of a fix.  For now I'm going to queue it via the slow path (for next
merge window) but you want me to drag it into the fixes branch to hit
sooner please reply with a Fixes tag to indicate when this code was
added.  I'd guess the second ever patch to the driver that added
threshold support, but I haven't checked.

So for now series applied to the testing branch of iio.git.

Note I made two tweaks - see below.


> ---
>  drivers/iio/light/stk3310.c | 72 ++++++++++++++++++++++++++++++++++---
>  1 file changed, 67 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iio/light/stk3310.c b/drivers/iio/light/stk3310.c
> index a75a83594..86cc6e8ec 100644
> --- a/drivers/iio/light/stk3310.c
> +++ b/drivers/iio/light/stk3310.c
> @@ -117,6 +117,9 @@ struct stk3310_data {
>  	struct mutex lock;
>  	bool als_enabled;
>  	bool ps_enabled;
> +	bool ps_int_enabled;
> +	uint32_t ps_thdl;
> +	uint32_t ps_thdh;
>  	uint32_t ps_near_level;
>  	u64 timestamp;
>  	struct regmap *regmap;
> @@ -296,8 +299,15 @@ static int stk3310_write_event(struct iio_dev *indio_dev,
>  
>  	buf = cpu_to_be16(val);
>  	ret = regmap_bulk_write(data->regmap, reg, &buf, 2);
> -	if (ret < 0)
> +	if (ret < 0) {
>  		dev_err(&client->dev, "failed to set PS threshold!\n");
> +		return ret;
> +	}
> +
> +	if (reg == STK3310_REG_THDH_PS)
> +		data->ps_thdh = val;
> +	else
> +		data->ps_thdl = val;
>  
>  	return ret;

return 0;

>  }
> @@ -331,8 +341,14 @@ static int stk3310_write_event_config(struct iio_dev *indio_dev,
>  	/* Set INT_PS value */
>  	mutex_lock(&data->lock);
>  	ret = regmap_field_write(data->reg_int_ps, state);
> -	if (ret < 0)
> +	if (ret < 0) {
>  		dev_err(&client->dev, "failed to set interrupt mode\n");
> +		mutex_unlock(&data->lock);
> +		return ret;
> +	}
> +
> +	data->ps_int_enabled = state;
> +
>  	mutex_unlock(&data->lock);
>  
>  	return ret;

return 0;

> @@ -504,10 +520,15 @@ static int stk3310_init(struct iio_dev *indio_dev)
>  
>  	/* Enable PS interrupts */
>  	ret = regmap_field_write(data->reg_int_ps, STK3310_PSINT_EN);
> -	if (ret < 0)
> +	if (ret < 0) {
>  		dev_err(&client->dev, "failed to enable interrupts!\n");
> +		return ret;
> +	}
>  
> -	return ret;
> +	data->ps_int_enabled = true;
> +	data->ps_thdh = STK3310_PS_MAX_VAL;
> +
> +	return 0;
>  }
>  
>  static bool stk3310_is_volatile_reg(struct device *dev, unsigned int reg)
> @@ -671,9 +692,18 @@ static void stk3310_remove(struct i2c_client *client)
>  static int stk3310_suspend(struct device *dev)
>  {
>  	struct stk3310_data *data;
> +	int ret;
>  
>  	data = iio_priv(i2c_get_clientdata(to_i2c_client(dev)));
>  
> +	if (data->ps_int_enabled) {
> +		ret = regmap_field_write(data->reg_int_ps, 0x0);
> +		if (ret < 0) {
> +			dev_err(dev, "failed to disable ps int at suspend.\n");
> +			return ret;
> +		}
> +	}
> +
>  	return stk3310_set_state(data, STK3310_STATE_STANDBY);
>  }
>  
> @@ -681,6 +711,8 @@ static int stk3310_resume(struct device *dev)
>  {
>  	u8 state = 0;
>  	struct stk3310_data *data;
> +	__be16 buf;
> +	int ret;
>  
>  	data = iio_priv(i2c_get_clientdata(to_i2c_client(dev)));
>  	if (data->ps_enabled)
> @@ -688,7 +720,37 @@ static int stk3310_resume(struct device *dev)
>  	if (data->als_enabled)
>  		state |= STK3310_STATE_EN_ALS;
>  
> -	return stk3310_set_state(data, state);
> +	ret = stk3310_set_state(data, state);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (data->ps_thdl != 0x0) {
> +		buf = cpu_to_be16(data->ps_thdl);
> +		ret = regmap_bulk_write(data->regmap, STK3310_REG_THDL_PS, &buf, 2);
> +		if (ret < 0) {
> +			dev_err(dev, "failed to set reg THDL_PS at resume.\n");
> +			return ret;
> +		}
> +	}
> +
> +	if (data->ps_thdh != STK3310_PS_MAX_VAL) {
> +		buf = cpu_to_be16(data->ps_thdh);
> +		ret = regmap_bulk_write(data->regmap, STK3310_REG_THDH_PS, &buf, 2);
> +		if (ret < 0) {
> +			dev_err(dev, "failed to set reg THDH_PS at resume.\n");
> +			return ret;
> +		}
> +	}
> +
> +	if (data->ps_int_enabled) {
> +		ret = regmap_field_write(data->reg_int_ps, STK3310_PSINT_EN);
> +		if (ret < 0) {
> +			dev_err(dev, "failed to enable ps int at resume.\n");
> +			return ret;
> +		}
> +	}
> +
> +	return 0;
>  }
>  
>  static DEFINE_SIMPLE_DEV_PM_OPS(stk3310_pm_ops, stk3310_suspend,

