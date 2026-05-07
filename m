Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1E653A9626;
	Thu,  7 May 2026 12:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778158028; cv=none; b=lQPQSVQIxu/Fx8k/m3DmyHOt+r2vRZg16IFHiEFnto+JAIu/rA/2vbbQbJ07CoF21n06LVY3FGSzo/NneUxryVUmuZ6/cqbtoDF7PGhHEBY03/BKAGQqXAJIZWL5VFMot+ty9ssEVTS3y2XTiVoU0WK9h1MedlYrNASpus+9B2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778158028; c=relaxed/simple;
	bh=1qjxeoOlGjEygDzezMr11ToWUP/SlAalI/srUI8sLV8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RuzY/Pf6UWmFGd/vJ4qKjuTnEb5VlrYk0KgEPxo+cUR8HzAiyg+s6RMOxbCjUTCbNH/PuZFDGQL9Ud/oXYhfsitW6yL3VpZaRE9coOVGPPTroXUrpmubuK9ZbUFvkWPlJB5W68GPidsYynLBnJbCSaSLIrtLetGjc0EuYSwbx9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bnb593bK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bnb593bK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7998EC2BCB2;
	Thu,  7 May 2026 12:47:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778158028;
	bh=1qjxeoOlGjEygDzezMr11ToWUP/SlAalI/srUI8sLV8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bnb593bK14cu7AyEghoaQQcZx/H/w/fZ2L+fmRva1O/f+cT6EQrnGWigJgXNKyVrS
	 nz3VfBhL4M6vjFgzttmupUJL2uTJrSXlii7+/htS1LE2lxawhlrjjGOpx9DUNQ5Y2Z
	 V6LlaueDVVlNFypCkf+ztp7Ewxdd5Z4+uMGRTCj6oNyErpOFeVRpRqcmaC1zrnNQWX
	 iGWai55MrHoKHyQLRDqAfqQ8diBQcd0bfHKM3KmAppjAMtz4C+og+jzURt0kg9a/1h
	 88bJuhNlbDLezzFewvFyDOB8n42y//y/3PscQJxjusw9s1tzoKSjo9R5SE32QrBiEx
	 ULck598eJbtjQ==
Date: Thu, 7 May 2026 13:47:01 +0100
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
Subject: Re: [PATCH v2 04/10] mfd: rz-mtu3: store &pdev->dev in local variable
Message-ID: <20260507124701.GK305027@google.com>
References: <20260410163530.383818-1-cosmin-gabriel.tanislav.xa@renesas.com>
 <20260410163530.383818-5-cosmin-gabriel.tanislav.xa@renesas.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260410163530.383818-5-cosmin-gabriel.tanislav.xa@renesas.com>

On Fri, 10 Apr 2026, Cosmin Tanislav wrote:

> &pdev->dev is accessed multiple times during probe. Store it in a local
> variable and use that to simplify the code.
> 
> Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
> ---
> 
> V2:
>  * no changes
> 
>  drivers/mfd/rz-mtu3.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)

This is fine.

> diff --git a/drivers/mfd/rz-mtu3.c b/drivers/mfd/rz-mtu3.c
> index 3be6f6c900b82..37d12030e069c 100644
> --- a/drivers/mfd/rz-mtu3.c
> +++ b/drivers/mfd/rz-mtu3.c
> @@ -311,16 +311,17 @@ static const struct mfd_cell rz_mtu3_devs[] = {
>  
>  static int rz_mtu3_probe(struct platform_device *pdev)
>  {
> +	struct device *dev = &pdev->dev;
>  	struct reset_control *rstc;
>  	struct rz_mtu3_priv *priv;
>  	struct rz_mtu3 *ddata;
>  	unsigned int i;
>  
> -	ddata = devm_kzalloc(&pdev->dev, sizeof(*ddata), GFP_KERNEL);
> +	ddata = devm_kzalloc(dev, sizeof(*ddata), GFP_KERNEL);
>  	if (!ddata)
>  		return -ENOMEM;
>  
> -	ddata->priv_data = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
> +	ddata->priv_data = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
>  	if (!ddata->priv_data)
>  		return -ENOMEM;
>  
> @@ -330,11 +331,11 @@ static int rz_mtu3_probe(struct platform_device *pdev)
>  	if (IS_ERR(priv->mmio))
>  		return PTR_ERR(priv->mmio);
>  
> -	rstc = devm_reset_control_get_exclusive_deasserted(&pdev->dev, NULL);
> +	rstc = devm_reset_control_get_exclusive_deasserted(dev, NULL);
>  	if (IS_ERR(rstc))
>  		return PTR_ERR(rstc);
>  
> -	ddata->clk = devm_clk_get(&pdev->dev, NULL);
> +	ddata->clk = devm_clk_get(dev, NULL);
>  	if (IS_ERR(ddata->clk))
>  		return PTR_ERR(ddata->clk);
>  
> @@ -347,7 +348,7 @@ static int rz_mtu3_probe(struct platform_device *pdev)
>  		mutex_init(&ddata->channels[i].lock);
>  	}
>  
> -	return devm_mfd_add_devices(&pdev->dev, 0, rz_mtu3_devs,
> +	return devm_mfd_add_devices(dev, 0, rz_mtu3_devs,
>  				    ARRAY_SIZE(rz_mtu3_devs), NULL, 0, NULL);
>  }
>  
> -- 
> 2.53.0

-- 
Lee Jones
