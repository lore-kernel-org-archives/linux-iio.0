Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF7FB3AB29C;
	Thu,  7 May 2026 12:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778157550; cv=none; b=Rbic3yCWRMPyYa+32C0ri1HMmHJ8V553N8hq2EsqBA3n1kLXQAX+wQExYbDpHEBlsJtFcpjEj4OkHwFsSDtAmN/ARjC/f6879gHvXwmjdwUI/D21bCaR3QcRfhQBoyEMuc6flMqEZAxAcd1QizwTBNHVwPRev6k002BZNMkxr5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778157550; c=relaxed/simple;
	bh=ZRoerlwEnzlnNkH9tTetVKXXmZ5mHTFiMjf1xYjx6jM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HEFGuhS+5T/Y4mF1jZXEdjSVr0DK3Kmgg7XYKPXPoNH95gwQtR/WXUi0KGvHNXZcj2O/OG8CgsPLe9jA2tP6OZYlJQeMhv6EZYabDptn1LiU3+7WohWmIdQL+hqAZkJVCeZtbxImSY32ykhBj3rAV520PvTX582+MhrU+BmQECQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qcv4v1bH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qcv4v1bH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04848C2BCC4;
	Thu,  7 May 2026 12:39:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778157549;
	bh=ZRoerlwEnzlnNkH9tTetVKXXmZ5mHTFiMjf1xYjx6jM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Qcv4v1bHfWBgMevqFCqAQOdpI90mi+npBfY7W8swT2Ju6lQnLsuIvctXCQbxVzjlr
	 49NXik3IE4zybYGODcxm3cp8pGzYf26ZJVP73VGSmTCkvrL3HOJRRnFszMempQ9p+g
	 v/Vp9enMEG55eV/JqeX1dyY0vlfsSCnt4oSQuH6/vKbTuywg8O7/cXGzUtuNfeB9HC
	 //278odiUWL2x8pd3LvMLSmL9wHrVEJfAv9aZUUk+OaG7PcTlt73VozO95Y+qvFozl
	 YEzLEzt3qxpE9EVf2CrwKtcKkgE8IczTApLwxDKWVNYWYYtExLLsAHJ39wwQTit6MB
	 Lt6uH0sxibB4A==
Date: Thu, 7 May 2026 13:39:03 +0100
From: Lee Jones <lee@kernel.org>
To: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>, linux-iio@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH v2 02/10] mfd: rz-mtu3: use device-managed reset deassert
Message-ID: <20260507123903.GI305027@google.com>
References: <20260410163530.383818-1-cosmin-gabriel.tanislav.xa@renesas.com>
 <20260410163530.383818-3-cosmin-gabriel.tanislav.xa@renesas.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260410163530.383818-3-cosmin-gabriel.tanislav.xa@renesas.com>

On Fri, 10 Apr 2026, Cosmin Tanislav wrote:

> Replace devm_reset_control_get_exclusive() and the manual
> reset_control_deassert()/reset_control_assert() with handling by
> devm_reset_control_get_exclusive_deasserted().
> 
> While at it, remove struct rz_mtu3_priv::rstc and use a local variable
> for it as it is not needed inside rz_mtu3_reset_assert().
> 
> Rename rz_mtu3_reset_assert() to rz_mtu3_mfd_remove() to accurately
> describe its usage since it no longer calls reset_control_assert().
> 
> Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
> ---
> 
> V2:
>  * no changes
> 
>  drivers/mfd/rz-mtu3.c | 23 +++++++----------------
>  1 file changed, 7 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/mfd/rz-mtu3.c b/drivers/mfd/rz-mtu3.c
> index 9cdfef610398f..6b9c6831dffa9 100644
> --- a/drivers/mfd/rz-mtu3.c
> +++ b/drivers/mfd/rz-mtu3.c
> @@ -21,7 +21,6 @@
>  
>  struct rz_mtu3_priv {
>  	void __iomem *mmio;
> -	struct reset_control *rstc;
>  	spinlock_t lock;
>  };
>  
> @@ -301,13 +300,9 @@ void rz_mtu3_disable(struct rz_mtu3_channel *ch)
>  }
>  EXPORT_SYMBOL_GPL(rz_mtu3_disable);
>  
> -static void rz_mtu3_reset_assert(void *data)
> +static void rz_mtu3_mfd_remove(void *data)

Remove any mention of "mfd".

>  {
> -	struct rz_mtu3 *mtu = dev_get_drvdata(data);
> -	struct rz_mtu3_priv *priv = mtu->priv_data;
> -
>  	mfd_remove_devices(data);

Why not use devm_mfd_add_devices() instead?

> -	reset_control_assert(priv->rstc);
>  }
>  
>  static const struct mfd_cell rz_mtu3_devs[] = {
> @@ -321,6 +316,7 @@ static const struct mfd_cell rz_mtu3_devs[] = {
>  
>  static int rz_mtu3_probe(struct platform_device *pdev)
>  {
> +	struct reset_control *rstc;

This shouldn't go above the main device data structs.

>  	struct rz_mtu3_priv *priv;
>  	struct rz_mtu3 *ddata;
>  	unsigned int i;
> @@ -340,15 +336,14 @@ static int rz_mtu3_probe(struct platform_device *pdev)
>  	if (IS_ERR(priv->mmio))
>  		return PTR_ERR(priv->mmio);
>  
> -	priv->rstc = devm_reset_control_get_exclusive(&pdev->dev, NULL);
> -	if (IS_ERR(priv->rstc))
> -		return PTR_ERR(priv->rstc);
> +	rstc = devm_reset_control_get_exclusive_deasserted(&pdev->dev, NULL);
> +	if (IS_ERR(rstc))
> +		return PTR_ERR(rstc);
>  
>  	ddata->clk = devm_clk_get(&pdev->dev, NULL);
>  	if (IS_ERR(ddata->clk))
>  		return PTR_ERR(ddata->clk);
>  
> -	reset_control_deassert(priv->rstc);
>  	spin_lock_init(&priv->lock);
>  	platform_set_drvdata(pdev, ddata);
>  
> @@ -361,14 +356,10 @@ static int rz_mtu3_probe(struct platform_device *pdev)
>  	ret = mfd_add_devices(&pdev->dev, 0, rz_mtu3_devs,
>  			      ARRAY_SIZE(rz_mtu3_devs), NULL, 0, NULL);
>  	if (ret < 0)
> -		goto err_assert;
> +		return ret;
>  
> -	return devm_add_action_or_reset(&pdev->dev, rz_mtu3_reset_assert,
> +	return devm_add_action_or_reset(&pdev->dev, rz_mtu3_mfd_remove,
>  					&pdev->dev);
> -
> -err_assert:
> -	reset_control_assert(priv->rstc);
> -	return ret;
>  }
>  
>  static const struct of_device_id rz_mtu3_of_match[] = {
> -- 
> 2.53.0

-- 
Lee Jones
