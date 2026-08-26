Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57CAA322B8F
	for <linux-iio@vger.kernel.org>; Wed, 26 Aug 2026 03:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787715164; cv=none; b=TBFVZrRJw4pHjAOcg9GHr0D+A3Zvqztxf8Xxzr6HbWznqBdlVT9B0RQ3VnpFa2VMSY52huT5Yz5BdwwMQrIuPna8VIea9Ujdrkb6/qOLAn2KxGoa7FyYJ4tXKqGgHWI9Y3QREgC57pO8wQBxVjqfcu7CS/BM/7oGjvNhkGBSOQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787715164; c=relaxed/simple;
	bh=/tidK7EFSXd1f8/6rRN5hP4BQOVrw3yxiN6pjEp3dIk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oCPU1yQC3KPk7k1YvQ2UlmMLMvzLeg7vMaK1Uhc6JKPvSUqKAySajLIQxzTV7ZzqjC1WXqkn498jgvIqU0AesOJB70T1AkoOVR/jVQORevBVIVFHPaPvnJzBHy7yuvid4M5EMSo3M1iMP3MrWlFOHxKxmOpfVd9AgywdOBNwKzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WPl1nLUx; arc=none smtp.client-ip=209.85.217.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WPl1nLUx"
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-782af6c753cso387593137.3
        for <linux-iio@vger.kernel.org>; Tue, 25 Aug 2026 20:32:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787715162; x=1788319962; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Mu2NyNe4pBuXTFj+pt/gkLlRBQQ7TS/+O1WH+QLtskU=;
        b=WPl1nLUxw+05/OhVNMwgbN19ZYEg++PlTnqqzoLMwFeMJPD96UO8D5bnVT0XP/FNM+
         rZODN0mqWGu5fcUEf/AxGxQsO6XK7AvUB11YuDGQoYyix07oo2WXFQE5XSmw5GATKWKd
         Tfc7AKTvnVX1kOEUcvM075+7xE2Oz/mW06Rmo9q/Fc90wjSRy6mg6HftsGbSlHo7l4UI
         TBsM2xn2flbeHvEvRUoB3SFKPTwl9FRzS7QAV7JQ0hynvRQ806/aoBd6UjuArEc49Ebt
         aTjNtRGC6zqIhOmEKVufPASuppwSZW12EEXjBsj8/d++DodvvHTamYn2JG4gBYXwiPqa
         9ysQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787715162; x=1788319962;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Mu2NyNe4pBuXTFj+pt/gkLlRBQQ7TS/+O1WH+QLtskU=;
        b=TK5vkdEwYyz3ZPG2qf91xIkZ5r9FzC8qv4TX4Gr36QtI3Ng44EL33roWiaPckCQB88
         O19o9TBzf/oU6HTH4v6xCJRCl6g9VbkIssGcwHWJM8KIQtgJU9MWTjAA9Lef+6jbgsnp
         Zz4qaOokO/+fNlz9QuVZHToz5DxWjIuKVUj7gkN+Pspy8tXW46KanEcA5qCoX4HLVFgB
         uARsrZWqVqzdNWBnw2ivf/bfkOhSlyUHjMfdnxiVx1TSlNY1WGbh2Fecfzs6nZQUZGxw
         d8llTlcRCqRFaFammpqON2wCDsVGds3xjR7LkO3DEK78h6rMz8vTT3Jl/lZs0CqVxUJ0
         m6bg==
X-Forwarded-Encrypted: i=1; AHgh+RqqTV5NRHipmEGU2gpJVRprU++xYrkFBDK6Ov1r/WsXbRS2dl5oxY5gTOxJAgIALrLhcN3UjHW8RBU=@vger.kernel.org
X-Gm-Message-State: AFuF++mfhb7FRsJsFg9+fkPSDn0B4VFY84GOEsXpRr+XPvvov63vLTDt
	7s+W3gmqDEy2RPyZDA9Tu+RPf9qYX6CRWgzf8OGKPRK3BgEhT+YMvnD7
X-Gm-Gg: AR+sD10xs59jPuhcif7pyNP+XWgJotMP0lfC3we3wemVngwm9EZb4v/9XlPdE0Bnt9V
	nb1sbkN3H6XJnfqlnzxiSiENcfSvbyawY7n7im2iXXUSZ7JwZ4zJyIfkJaFdokR8NAQT3dO+1/y
	JDLQjVdoRpB3O7SaGcWGo4rUQdqdgEGLWwN+hCzhq3g8A6gP6GJGlDE2ay97TkYMJdS/JmyH53I
	wvJ8AnzowNtyGvnKuHUy4Xs2JbeiCy5+hvb+3WiKdX/ZnEbqySRuxcDzycZBZN6/B3/RptqA2aZ
	VjYhOa1pQDzPPGosX19ksxl7L1IVSjPpYIZlgRbOToYjlvl7tL6kMc92XkYnQbji1MJamv3PHiF
	raCmpt4h5gXDCqFATnCwR47ftn4VRs6qQFR3/U8WEi2iLfP+b0yZzB5q0TINePrIsuZgs6i1ond
	cjuBxtQROCqqJd7xcGO1pmH351euIN+bZ+RuGi/j3VCx5NnP3DOtEVM5S0knyQU6VuTGecHw==
X-Received: by 2002:a05:6102:c48:b0:77d:a23d:ae70 with SMTP id ada2fe7eead31-782c3b0ffa0mr1308304137.14.1787715162180;
        Tue, 25 Aug 2026 20:32:42 -0700 (PDT)
Received: from localhost ([2804:30c:97d:e800:9454:1179:18df:ab33])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-97cbe0f633esm703861241.5.2026.08.25.20.32.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 20:32:40 -0700 (PDT)
Date: Wed, 26 Aug 2026 00:33:23 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: mdshahid03@gmail.com
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>,
	bcm-kernel-feedback-list@broadcom.com, linux-iio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/3] iio: adc: bcm_iproc_adc: use
 devm_add_action_or_reset()
Message-ID: <ao5eg99l_FNHDosp@debian-BULLSEYE-live-builder-AMD64>
References: <20260825172155.250484-1-mdshahid03@gmail.com>
 <20260825172155.250484-3-mdshahid03@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260825172155.250484-3-mdshahid03@gmail.com>

On 08/25, mdshahid03@gmail.com wrote:
> From: Mohammad Shahid <mdshahid03@gmail.com>
> 
> Replace the manual ADC and clock cleanup in probe error paths
> and remove() with devm_add_action_or_reset().
> 
> Register cleanup actions immediately after enabling the clock and
> ADC so that the resources are automatically released on probe
> failure and device removal.
> 
> This also allows the cleanup labels to be removed and the
> iio_device_register() failure path to return directly.
> 
> Signed-off-by: Mohammad Shahid <mdshahid03@gmail.com>
> ---
...
> +static void iproc_adc_clk_disable(void *data)
> +{
> +	struct clk *clk = data;
> +
> +	clk_disable_unprepare(clk);
> +}
> +
The above callback is not needed with devm_clk_get_enabled(). See comment below.

>  static int iproc_adc_read_raw(struct iio_dev *indio_dev,
>  			  struct iio_chan_spec const *chan,
>  			  int *val,
> @@ -551,9 +565,17 @@ static int iproc_adc_probe(struct platform_device *pdev)
>  	if (ret)
>  		return dev_err_probe(dev, ret, "failed to enable clock\n");
>  
> +	ret = devm_add_action_or_reset(dev, iproc_adc_clk_disable, adc_priv->adc_clk);
> +	if (ret)
> +		return ret;
> +
Hmm, the whole clock get/add_action/enable sequence can be replaced by
devm_clk_get_enabled(). Unless the ADC needs to clear IPROC_ADC_AUXIN_SCAN_ENA
before tsc_clk gets enabled. Otherwise, the update can be done with fewer
LOC by calling devm_clk_get_enabled(). Also, since adc_clk is only used during
device probe, it can be declared as a local variable rather than a field of
struct iproc_adc_priv. So, in addition to updating to devm interfaces, patch 2
can reduce struct iproc_adc_priv size by keeping adc_clk as a local variable of
iproc_adc_probe().

>  	ret = iproc_adc_enable(indio_dev);
>  	if (ret)
> -		goto err_adc_enable;
> +		return ret;
> +
> +	ret = devm_add_action_or_reset(dev, iproc_adc_disable_action, indio_dev);
> +	if (ret)
> +		return ret;
>  
>  	indio_dev->name = "iproc-static-adc";
>  	indio_dev->info = &iproc_adc_iio_info;
> @@ -562,29 +584,18 @@ static int iproc_adc_probe(struct platform_device *pdev)
>  	indio_dev->num_channels = ARRAY_SIZE(iproc_adc_iio_channels);
>  
>  	ret = iio_device_register(indio_dev);
> -	if (ret) {
> -		dev_err(&pdev->dev, "iio_device_register failed:err %d\n", ret);
> -		goto err_clk;
> -	}
> +	if (ret)
> +		return dev_err_probe(dev, ret, "iio_device_register failed\n");
This looks good, and can become even more concise with iio_device_register().
In addition to patch 2 (clk and adc) and patch 3 (mutex) device managed patches,
add a patch 4 updating from iio_device_register() to devm_iio_device_register().
With that, all device resources shall be released on device detach and
iproc_adc_remove() won't be needed anymore.

>  
>  	return 0;
>  
> -err_clk:
> -	iproc_adc_disable(indio_dev);
> -err_adc_enable:
> -	clk_disable_unprepare(adc_priv->adc_clk);
> -
> -	return ret;
>  }
>  
>  static void iproc_adc_remove(struct platform_device *pdev)
>  {
>  	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
> -	struct iproc_adc_priv *adc_priv = iio_priv(indio_dev);
>  
>  	iio_device_unregister(indio_dev);
> -	iproc_adc_disable(indio_dev);
> -	clk_disable_unprepare(adc_priv->adc_clk);
>  }
