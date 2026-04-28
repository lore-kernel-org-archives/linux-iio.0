Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93D9B451076;
	Tue, 28 Apr 2026 18:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777400543; cv=none; b=Krth9uUO5GLfP3ohyjZ1OGaYRvAgBcKU3tKdVjojKPL81uPp86N8s/SVGNcecUxXYHVNzZuubXN/QLdAzhDP9Y+ejNHDfPTqCi35TTEZx5sF2pI5OkFhnSvIwQeF0YLDlzOxSH5Vugj/WCmhHEMiHByjXteo4NSK6N4MpJ0ciCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777400543; c=relaxed/simple;
	bh=7g29RszizefcEJ+ssQcc0ZidBxm0OzTICgf9qd+hhHw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oASYoOEf+vLrHrffhElKkFtWoFiUwOhqt88DosjaN18KAXvlRek74xcUtB3i4uhQYs4BQ9UA1CnsfSXGyMcAoeyKdYLAzXpOwtbLHgP1B7iSRrPnmv5OqLXLh1liFIud5BaRxEO3kkaAvTJmObPsiot5GxwscOImyZwZr80BrU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c8KKElZN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c8KKElZN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 300C2C2BCAF;
	Tue, 28 Apr 2026 18:22:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777400543;
	bh=7g29RszizefcEJ+ssQcc0ZidBxm0OzTICgf9qd+hhHw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=c8KKElZNb+Hwv2z8C92OXyFTbLs8q7lWs1yNqkPoucxitW+BisISdKGZvSfaUh26P
	 JkqhAbVMx0xJ4eyjwsIO6gZ4/vhoJ5XkwrjlZEfRTNjdBR6ZDfplwRLOG1y7GFtDcn
	 sPvK+njS/X7Q0M3yhiI/rtp6+ERuh8i8pgbOONKLo780PdnDHx6/05IlSiDIvwnJ/B
	 UOLsH7+JOxUf83sU7LqJFf4fN/o7ksab7CNJE+mxayGbl5WPYmQkeOZaFvJJDkI1P+
	 pY5919kuL0b8ZIoKevzRhoFxRUzpp6ZVa8TT8Zv/AUYnc7uSoQvx1t015M7FClTEGA
	 5akyR0wXZyJuA==
Date: Tue, 28 Apr 2026 19:22:13 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Miao Li <limiao870622@163.com>
Cc: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 waqar.hameed@axis.com, dixitparmar19@gmail.com, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Miao Li <limiao@kylinos.cn>
Subject: Re: [PATCH] iio: light: stk3310: Deal with the ps interrupt issue
 in PM
Message-ID: <20260428192213.7c5c80e5@jic23-huawei>
In-Reply-To: <20260427094313.81460-1-limiao870622@163.com>
References: <20260427094313.81460-1-limiao870622@163.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 27 Apr 2026 17:43:13 +0800
Miao Li <limiao870622@163.com> wrote:

> From: Miao Li <limiao@kylinos.cn>
Hi Miao Li

A few (possibly additional) things inline.

> 
> On the Huawei hisi platform, if the STK3311-X chip's PS interrupt

I'm curious. What HiSilicon platform is this?
Good to have that recorded as part of the description for anyone
else who encounters this bug.

> is configured in "Recommended interrupt mode", the interrupt cannot
> be triggered normally after waking from suspend or hibernation.
> 
> In this case, neither disabling and re-enabling the interrupt nor
> resetting the PS threshold register can restore the interrupt to
> normal operation.
> 
> if we disable the interrupt in suspend(), then reset the PS threshold
> register and enable the interrupt in resume(), this issue can be fixed.
Switch text to imperative. 

  If the interrupt is disabled in suspend() then rest the PS threshold
  register and enable the interrupt in resume(). This resolves the issue.

Or something like that.


> 
> Signed-off-by: Miao Li <limiao@kylinos.cn>

> @@ -504,8 +523,13 @@ static int stk3310_init(struct iio_dev *indio_dev)
>  
>  	/* Enable PS interrupts */
>  	ret = regmap_field_write(data->reg_int_ps, STK3310_PSINT_EN);
> -	if (ret < 0)
> +	if (ret < 0) {
>  		dev_err(&client->dev, "failed to enable interrupts!\n");
> +		return ret;
> +	}
> +
> +	data->ps_int_enabled = true;
> +	data->ps_thdh = STK3310_PS_MAX_VAL;
>  
>  	return ret;

return 0;


...

> @@ -681,6 +714,8 @@ static int stk3310_resume(struct device *dev)
>  {
>  	u8 state = 0;
>  	struct stk3310_data *data;
> +	__be16 buf;
> +	int ret;
>  
>  	data = iio_priv(i2c_get_clientdata(to_i2c_client(dev)));
>  	if (data->ps_enabled)
> @@ -688,7 +723,35 @@ static int stk3310_resume(struct device *dev)
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

sizeof(buf) rather than 2. here and below.

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
> +		if (ret < 0)
> +			dev_err(dev, "failed to enable ps int at resume.\n");
Keep return ret in here so we have consistent pattern with the above .
> +	}
> +
> +	return ret;
Then
	return 0;

>  }
>  
>  static DEFINE_SIMPLE_DEV_PM_OPS(stk3310_pm_ops, stk3310_suspend,

