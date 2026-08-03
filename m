Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49972231830;
	Mon,  3 Aug 2026 00:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785716864; cv=none; b=fkOBRDqNvwquUjBd3N4dFYyZxOLhSGXtam6vzgpYxJB1jzgQsoVh7cyL4EvzrOk4PCT6YH7Pck7dyhsFFUpaVokt6RmJcaw7rL80vrdC/L7B1mRVpuIUytbuUqnbJ+8pd0v+kDS3nvd09N8FiDdCfMaoKZ+CcKultnlU/4vhKmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785716864; c=relaxed/simple;
	bh=mp88gHt5d4dy6iz0OeSB1olGJRkwo2VPphDbdI8+rLI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hC3ayeTrpOYhNK2Ce3f2h7NYsSvc689kONK/uNIqbEN5iuQVR2jI0oo0BB31+bQutzqi4g2BccwbYtHo25q/oulcNpg4jgHYTfgmBhcA6wh7GMDHRr/BhU4hDwyONnBjp6uLF0qsPM9rRRa0frVypKhntZK50fNnpBLqOrh1foQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jLP2Y9fn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jLP2Y9fn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF50F1F000E9;
	Mon,  3 Aug 2026 00:27:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785716862;
	bh=tqOT/xy2dSQP6NEFGjBJhWcm09ei+VNOGl7bDPZhhjQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=jLP2Y9fnmpY8l/+xvAquvyUmhRdKbt/o65Ab0oMTYAJbPjHnul9rnXQIkB1smBrX0
	 Q5Bl5nkizkz/hAtzTVtL0PQbG9AnW2K99ty/SsqAtu0BDDAQKbMNq/Y+kgbm/kL+2A
	 KZjL0acSj/0G6JHgIqmB6GeLG/GBcPZjJY1ggDpje6kiLknjt+B9jT7ZkFoNcP08Ci
	 wYvMURP550pEJ3o6OYG7Yd8s2c/b/fxJRr+3Cv00NSDLFF0efCF5psNb8L3RBsqo0F
	 QILHOhjm17Y0of1Lk1rYHkHYmw4ypwCvCmt2eUOLGXqK9iAd3OKS8lsrl78AYmm3Qs
	 24ZmyzkalH3jA==
Date: Mon, 3 Aug 2026 01:27:38 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Nikhil Gautam <nikhilgtr@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] iio: light: gp2ap002: Fix regulator leaks in
 runtime resume error path
Message-ID: <20260803012738.2abf14db@jic23-huawei>
In-Reply-To: <20260722162247.8229-4-nikhilgtr@gmail.com>
References: <20260722162247.8229-1-nikhilgtr@gmail.com>
	<20260722162247.8229-4-nikhilgtr@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 22 Jul 2026 21:52:47 +0530
Nikhil Gautam <nikhilgtr@gmail.com> wrote:

> If enabling vio fails, vdd is left enabled; if re-initializing the
> sensor fails, both regulators are left enabled.
> 
> unwind previously enabled regulators on failure, mirroring the error
> handling already used in probe.
> 
> Fixes: 97d642e23037c ("iio: light: Add a driver for Sharp GP2AP002x00F")
> Signed-off-by: Nikhil Gautam <nikhilgtr@gmail.com>
I'm already carrying this fix via a patch from Laxman,
so dropping this one.


Applied 1 and 2 but there was some noise due to other changes near this
code so please take a look.

Applied to the fixes-togreg branch of iio.git

Thanks

Jonathan

> ---
>  drivers/iio/light/gp2ap002.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/light/gp2ap002.c b/drivers/iio/light/gp2ap002.c
> index e8ba9c00dabb..430336b51f83 100644
> --- a/drivers/iio/light/gp2ap002.c
> +++ b/drivers/iio/light/gp2ap002.c
> @@ -677,7 +677,7 @@ static int gp2ap002_runtime_resume(struct device *dev)
>  	ret = regulator_enable(gp2ap002->vio);
>  	if (ret) {
>  		dev_err(dev, "failed to enable VIO regulator in resume path\n");
> -		return ret;
> +		goto out_disable_vdd;
>  	}
>  
>  	msleep(20);
> @@ -685,13 +685,19 @@ static int gp2ap002_runtime_resume(struct device *dev)
>  	ret = gp2ap002_init(gp2ap002);
>  	if (ret) {
>  		dev_err(dev, "re-initialization failed\n");
> -		return ret;
> +		goto out_disable_vio;
>  	}
>  
>  	/* Re-activate the IRQ */
>  	enable_irq(gp2ap002->irq);
>  
>  	return 0;
> +
> +out_disable_vio:
> +	regulator_disable(gp2ap002->vio);
> +out_disable_vdd:
> +	regulator_disable(gp2ap002->vdd);
> +	return ret;
>  }
>  
>  static DEFINE_RUNTIME_DEV_PM_OPS(gp2ap002_dev_pm_ops, gp2ap002_runtime_suspend,

