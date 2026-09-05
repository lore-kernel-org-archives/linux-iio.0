Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF46E322C73;
	Sat,  5 Sep 2026 23:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788651238; cv=none; b=LXIZcMI/sixZsBIAy8cLPfAT58E6G+HOGuxIi8Iy3y2TpL2qQXsSELiqsJE/JlyTW5NW2siQylyBulrDOyRH5xR65pM8MALCSlK8GUkAloV59i1f3I/kDSAO8hLxGSrqCaMBfkTX7J9CG0thYA0+YfMx3uUiz6ucw5sgvjk4irU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788651238; c=relaxed/simple;
	bh=YKT2349SLpzzR3UMHNbou8VxJZyoar4Yz08zNI18sV4=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=D0QL3/ZKs4sYkAvEhRfDQRhuORqkZbd/OSiCp8WKR2VMuOGq+yskRqplaTVev98SlZE1O0ZWpvZPERwupPE4zdf0dp7aouL5THz6pB6plGXBPKlzzU+zfoJRa29haf5ryQeqCs63/O8Z9i8F79L7+E4YPjPmL1QQegcMkitC0ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XHvyFpsv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XHvyFpsv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64DEF1F00A3F;
	Sat,  5 Sep 2026 23:33:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788651237;
	bh=CG/3VxsHakwAVe2Bd7TAMHtIUh1ll0tsSTB99LDCqvs=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=XHvyFpsv/nC6NX9MH3IwQRuM8ROU1HxxxLELhRmCnt3ESwzsakq6aRLGlwvhTlWXW
	 ZW8CwRxV/aWxM3CsKMylh/ad239/iBHlGT3QXAL9QLiPhix9n3gDJBpqVzcqY/3oPs
	 OkE0MQyfmbQ0hVCf6OTisNeM7/pa6EQl1r2Inet+igOuaYiUF6kdxzbbasntbXZ715
	 GFhic1gzaTYuKVdc+Lyx/Xj/Y301PbERLLleR6uGsBJigINeZNPDPHwq5yFHsljD/n
	 SVSI9rwBeZC3DsR6vT1l2GWCTQwiy5Rmm58A+kxY7PUhUjOMJYQxSAFw5+5g1r9MxG
	 SI3N9wy3n7CTw==
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v3 3/6] iio: adc: bcm_iproc_adc: use devm-managed clock
From: Jonathan Cameron <jic23@kernel.org>
To: mdshahid03@gmail.com
Cc: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Ray Jui <rjui@broadcom.com>, 
 Scott Branden <sbranden@broadcom.com>, 
 bcm-kernel-feedback-list@broadcom.com, linux-iio@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260905093631.48667-4-mdshahid03@gmail.com>
References: <20260905093631.48667-1-mdshahid03@gmail.com>
 <20260905093631.48667-4-mdshahid03@gmail.com>
Date: Sun, 06 Sep 2026 00:33:40 +0100
Message-Id: <178865122087.3402141.5403978234649905269.b4-review@b4>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2772;
 i=jonathan.cameron@oss.qualcomm.com; h=from:subject:message-id;
 bh=YKT2349SLpzzR3UMHNbou8VxJZyoar4Yz08zNI18sV4=;
 b=owEBfwKA/ZANAwAKAVSFNJnE9BaIAcsmYgBqnKbk1XXel73wFy3wumofhOB570UaAQYng60UB
 YAJgkTuwuiJAkUEAAEKAC8WIQRuKWazh4QGUpEmgbFUhTSZxPQWiAUCapym5BEcamljMjNAa2Vy
 bmVsLm9yZwAKCRBUhTSZxPQWiFFuD/48wMA/HTRx6bN4FNUoGd6KeTIEYLe4Vo/rOTguk8NZnLJ
 GfvjYHHOUhKm9ZFFjPZOtPWFuAOHXj11dh4hTz6ljT5KepZUrGgjbawymiDSmFvuzX0GFceQEi7
 eCAxLFHYZiNALBSPSs2ZG04pSlhHd01yqqOZgT4MlHcH/1BHLxKCNJDVR8Ut7mXpGwD9y9wI3dC
 PylVuk6jY9QpSeGfEkJ5yzlRdDZ2M084bUGjLPrGQ8SLuhQWSyriAJzejSGNSs3DMnpWofPHuLe
 yYRE3xEuSPcrpYqcDOb4g0KC0sn8yj+D+p3VHPLyyK95E5r5JE5A5TJjD1xqKDvkP2zaxJPMGh3
 moMsoGkeOLK2kMIqgAcfBl7Eg3WGJ6dyyXsObbY0TMEoXKqOKhkBanBIvCpgZgjaW5/D5RboqsZ
 uOb/NtJhBZ/ymaQvhT4oYIbnXRWxXA4ROZRdChmWysPaqHekeASZDmieOGmlSyhd/jRc7AYdDD3
 Twl83ftc5OYfA8zhi2m4AqgNx0EzLpqHyzBeP0L7cTzy/pFfb+zjY5pmXAmx7+/sAUXLwrNHF08
 uYaqVOjm6r0745f4hncrd/t+A5eoYDapTCdTY2A8TBEhLQyRY1wlp2y9EIHtyaFBZ1qIYdG1oLu
 dyyxlJ0wtMA903OFxRsaz6eQE3b6MX8793luLPA==
X-Developer-Key: i=jonathan.cameron@oss.qualcomm.com; a=openpgp;
 fpr=6E2966B387840652912681B154853499C4F41688

> Convert the ADC clock to use devm-managed APIs to simplify
> resource cleanup.
> 
> Signed-off-by: Mohammad Shahid <mdshahid03@gmail.com>

Hi,

One thing that should have been in this patch has ended up in the
next one.  Whilst minor this just passed the level of what I'd
normally tidy up whilst applying.  So I will be looking for a v4
after this has had time for others to comment on v3.

Breaking changes up into a series of minor changes is a bit of an
art form and often takes a couple of passes to get perfect.  It is
worth doing though as keeps each change nice an easy to review on
their own.

Thanks,

Jonathan

>
> diff --git a/drivers/iio/adc/bcm_iproc_adc.c b/drivers/iio/adc/bcm_iproc_adc.c
> index e54f613d266a..3bbf814d4c8f 100644
> --- a/drivers/iio/adc/bcm_iproc_adc.c
> +++ b/drivers/iio/adc/bcm_iproc_adc.c
> @@ -109,7 +109,6 @@ do { \
>  
>  struct iproc_adc_priv {
>  	struct regmap *regmap;
> -	struct clk *adc_clk;
>  	struct mutex mutex;
>  	int  irqno;
>  	int chan_val;
> @@ -510,6 +509,7 @@ static int iproc_adc_probe(struct platform_device *pdev)
>  	struct iproc_adc_priv *adc_priv;
>  	struct iio_dev *indio_dev = NULL;
>  	struct device *dev = &pdev->dev;
> +	struct clk *adc_clk;
>  	int ret;
>  
>  	indio_dev = devm_iio_device_alloc(dev, sizeof(*adc_priv));
> @@ -529,10 +529,9 @@ static int iproc_adc_probe(struct platform_device *pdev)
>  		return dev_err_probe(dev, PTR_ERR(adc_priv->regmap),
>  				     "failed to get handle for tsc syscon\n");
>  
> -	adc_priv->adc_clk = devm_clk_get(dev, "tsc_clk");
> -	if (IS_ERR(adc_priv->adc_clk))
> -		return dev_err_probe(dev, PTR_ERR(adc_priv->adc_clk),
> -				     "failed getting clock tsc_clk\n");
> +	adc_clk = devm_clk_get_enabled(dev, "tsc_clk");
> +	if (IS_ERR(adc_clk))
> +		return dev_err_probe(dev, PTR_ERR(adc_clk), "failed to enable clock\n");
>  
>  	adc_priv->irqno = platform_get_irq(pdev, 0);
>  	if (adc_priv->irqno < 0)
> @@ -550,10 +549,6 @@ static int iproc_adc_probe(struct platform_device *pdev)
>  	if (ret)
>  		return ret;
>  
> -	ret = clk_prepare_enable(adc_priv->adc_clk);
> -	if (ret)
> -		return dev_err_probe(dev, ret, "failed to enable clock\n");
> -
>  	ret = iproc_adc_enable(indio_dev);
>  	if (ret)
>  		goto err_adc_enable;
> @@ -575,19 +570,15 @@ static int iproc_adc_probe(struct platform_device *pdev)
>  err_clk:
>  	iproc_adc_disable(indio_dev);
>  err_adc_enable:
> -	clk_disable_unprepare(adc_priv->adc_clk);

This gets tidied up in the next patch, but ideal would have been
to replace the goto err_adc_enable;  with a return ret in this patch
(the one that enables that change) and remove the label here.

-- 
Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
