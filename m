Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793465160;
	b=A703oIoIkJ3UJR1mJ+8l99TTBo0e0m+eQD1WB7yctZtKSDTalwGqYsH4zxvxViwz+yFE
	 707BEvlEJ0Rtpfm+L5oeImmyOC9hUk9TzSuFhBSIsnx49Ggr5yaCyCNDzDf8XYglarkdT
	 7AdxkHO8AVx0Dn01khVSS8jEUrwA5v6YTyjiPnC4Y8+Y8KPSnQ3aFO6sr44JBZ9oXMdNW
	 mRjMq1bIv3c4vDhz9BknZr1JWc3RJMSPnbE8zKwB2Hd95Ud1akzhcSzHmbM7zgxBI7PJx
	 6Z9++NQHEXI5tFMFg3YorflCYtgWYe+YKxF8jlJEkbCibpQiKrske+7n9sINxgMF3HA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793465160;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:X-Developer-Signature:
	 X-Developer-Key:Content-Transfer-Encoding;
	bh=hTXeoSKTVzHEW1kPTbHv+Kktw2puKXk0b7Qro+KEm+c=;
	b=snQKamAKqZDZjazw+cyB1f7TzE39RHc6n4C0DIvFZMnUdU6KuYPJdvW5kYwbJFwkb3B9
	 KtmmsWjmHXtVIvAqVA9mYaShrK1m5bjvTEYXStUZ3OKUxF6ZO4jlCKgVkpwTOZXHTSX7G
	 O6C8Dx/z/zSt3X9MxsidUo763erP4cD+jB+3QQ/Dk/K6m9gQ47948FUpAonaknS88mS19
	 bptjHsYI405pS7Wkw9wyk+SFTxQGjDSYCCX0iKvthBATQxAns/n7v89kWK1HsS+5L8tf+
	 KLyLY+Ob7vdgcPS/XHOuVbEg57ep4+a5SjbhokkSbk2/vNoNiE9u8b0ydZwwafwFIKQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D0ElWLx3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1B58606A31A;
	Sat, 31 Oct 2026 16:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D0ElWLx3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDC021F000C1;
	Sat, 31 Oct 2026 16:45:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793465159;
	bh=hTXeoSKTVzHEW1kPTbHv+Kktw2puKXk0b7Qro+KEm+c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=D0ElWLx34fCE5ymTGz/GBdq98JdzZqC6vGCg1K6QeOD18bYSiFkpZ23FAj4Q+fdxT
	 3AiOUmPbUwlkrS/pXsZcabumjIqIn7j+90qK4Zl+zJDFeRy+DHMnhRtChZbxqr5PmJ
	 Q6mOSvx9l9EIRPVIJMbuI0N7FSnSaIOPI0ufxG+0dvU0IQmvRnx1wHpIJ+LOvCC9UA
	 8+m86Q8rLMwD9IaqWQIpILo6Lkeo4m0uCRNoMfBtmCOTdNtl9k2G33FV6ujNl/hJNM
	 UPMgNDWbA6sbhCR96Wdh6QPdwEsXS6zWwuDqbszXNoFLei7sNpT/HDz67+KsyyQeXc
	 FG7iNx95TWzZA==
From: William Breathitt Gray <wbg@kernel.org>
To: phucduc.bui@gmail.com
Cc: William Breathitt Gray <wbg@kernel.org>,
	David Lechner <david@lechnology.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] counter: ti-eqep: Fix runtime PM error handling in probe
Date: Sat, 31 Oct 2026 12:45:50 -0400
Message-ID: <20261031164551.3637340-1-wbg@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20260922032146.321006-1-phucduc.bui@gmail.com>
References: <20260922032146.321006-1-phucduc.bui@gmail.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2301; i=wbg@kernel.org; h=from:subject; bh=3EHHVwVlO/+PMF2usbbzvuEb8CxOpddWk5KMXEWtetQ=; b=owGbwMvMwCW21SPs1D4hZW3G02pJDFnPpKULZjPy8SjO7XgW4pfW7ry8Z3GsgZbL3QV9GWw/L qfOKm3tKGVhEONikBVTZOk1P3v3wSVVjR8v5m+DmcPKBDKEgYtTACZy4zHDX/mLDtIzI3Ie7K9g nfpF6sW94ByPtkLFMz9V/hjdz9/JdpiR4WRjkK6o1A9HvpDUDWdkFHdNylxvH7+xt9zlsG2Ws6E rHwA=
X-Developer-Key: i=wbg@kernel.org; a=openpgp; fpr=8D37CDDDE0D22528F8E89FB6B54856CABE12232B
Content-Transfer-Encoding: 8bit

On Tue, Sep 22, 2026 at 10:21:46AM +0700, phucduc.bui@gmail.com wrote:
> From: bui duc phuc <phucduc.bui@gmail.com>
> 
> pm_runtime_get_sync() errors were not checked, and if
> devm_clk_get_enabled() failed afterwards, the function returned without
> calling pm_runtime_put_sync()/pm_runtime_disable(), leaking the runtime PM
> usage count.
> 
> Switch to pm_runtime_resume_and_get() and add proper error unwinding via
> goto labels so every failure path after pm_runtime_enable() is cleaned up
> correctly.
> 
> Fixes: f213729f6796 ("counter: new TI eQEP driver")
> Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>

Hello,

This patch looks similar to another we're considering for ti-eqep.[^1]
Perhaps you can provide a review or comment in that discussion thread so
we can address this issue together.

William Breathitt Gray

[^1]: https://lore.kernel.org/all/20260529095834.2561-1-sozdayvek@gmail.com/

> ---
>  drivers/counter/ti-eqep.c | 27 +++++++++++++++++++--------
>  1 file changed, 19 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/counter/ti-eqep.c b/drivers/counter/ti-eqep.c
> index 0dda3f2b14c7..698a9920f20d 100644
> --- a/drivers/counter/ti-eqep.c
> +++ b/drivers/counter/ti-eqep.c
> @@ -544,20 +544,31 @@ static int ti_eqep_probe(struct platform_device *pdev)
>  	 * domain.
>  	 */
>  	pm_runtime_enable(dev);
> -	pm_runtime_get_sync(dev);
> +	err = pm_runtime_resume_and_get(dev);
> +	if (err < 0) {
> +		dev_err_probe(dev, err, "failed to enable runtime PM\n");
> +		goto err_runtime_disable;
> +	}
> 
>  	clk = devm_clk_get_enabled(dev, NULL);
> -	if (IS_ERR(clk))
> -		return dev_err_probe(dev, PTR_ERR(clk), "failed to enable clock\n");
> +	if (IS_ERR(clk)) {
> +		err = PTR_ERR(clk);
> +		dev_err_probe(dev, err, "failed to enable clock\n");
> +		goto err_runtime_put;
> +	}
> 
>  	err = counter_add(counter);
> -	if (err < 0) {
> -		pm_runtime_put_sync(dev);
> -		pm_runtime_disable(dev);
> -		return err;
> -	}
> +	if (err < 0)
> +		goto err_runtime_put;
> 
>  	return 0;
> +
> +err_runtime_put:
> +	pm_runtime_put_sync(dev);
> +err_runtime_disable:
> +	pm_runtime_disable(dev);
> +
> +	return err;
>  }
> 
>  static void ti_eqep_remove(struct platform_device *pdev)
> --
> 2.43.0
> 
