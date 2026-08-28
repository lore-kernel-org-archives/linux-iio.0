Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0F8D3AFD1F
	for <linux-iio@vger.kernel.org>; Fri, 28 Aug 2026 09:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787909753; cv=none; b=T9rVa46PpctpSkYqTD3k7O+lPqda6rZH9YaUg1mKA1bshR8T6v+pJJPBIqfFsZigex/OrhkJtsnQRxSNkkplgdIUj9TUVU6dUAOgswrB9y16yAzGsrq+1g1tOBUM8bVRT8QQGey3iAqay6SW97D+1iWWCI5/nfKcB+mMYoECRi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787909753; c=relaxed/simple;
	bh=TALOrbmNVabspWfRaGv64vu6hD+Bv94mCfARw0OxHgM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SL5/gvaaWUZm3eHTnzBXssGRZGUX8MVPmkSz3KyROZjPR00c5aQUvEG3k/pPs+dPaumH0ANTcJWRiF4h6MI5DlGa3UxqqfICyRWXB4HE4TGBlSd9DtAK0Tbq0xwoObE0dCXO3ezgSc9abjz6uZiSRtV4EfkWjK/p3pj/ui8vG5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gIN8r/kD; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gIN8r/kD"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4998b5a63e2so7011415e9.1
        for <linux-iio@vger.kernel.org>; Fri, 28 Aug 2026 02:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787909746; x=1788514546; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8+teJGumSEtzE5yE/4xiLp6Nr2szYZ1P4IJfEUhRobY=;
        b=gIN8r/kDGMsWwk98Ucu/8jUkrIWxONe1ItJVBJBJCXXNljLYKe0YgafWY5K8jaHi0l
         sDhVCmNLg1r4R/iaIP9TqJid/vpxyy3ldwS6SGJ7xs9v3V4h7qzxc3pYcyFVKfZP7N7Q
         2a4FwMjhfLTCubPHFBzO+jO3Jqbz4Obg6mYAtXhTPK2M+IBFZ1OU5CMFndePPBRNHJ0C
         oUDGtBDrzsVCLMaKpsrxaOj9mhV7Q2V38rQMfIrxhUOJBrzWnSGre/1jpTGqMh0lvZ9g
         olJsJzC4y1nJQnCaIOnKSMDCovikfd46vJifxDWKuQEjLBc7XY5W3aRJeSNc2/G7KARu
         T5ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787909746; x=1788514546;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8+teJGumSEtzE5yE/4xiLp6Nr2szYZ1P4IJfEUhRobY=;
        b=aPT5qXq03SWWUrNMdlnlLC5VJQmv2mpLe0Q70UT5Z6A+pyCMmDwg5TjM62wveq/UlE
         /b2asOZX7mTTKfn4yae391T0dHHa2tvleuId32zjpNjjar3cIvRb47yj2ip2/lxZQaCy
         R3b+St6SUAHXSRMNgVeMmNF3nI/tbn+vv5RIDJ/2JvDu1voQoI2IEOaxmWsdijGnmYL7
         FWRXmkiiTXNETfRWpgyakdf2PWaLD0Naqpg9Jg6mPNQhwjgBHWDXUeuL226T5emWQYhf
         Gt9M7D63d7QZadIsCcVFeIFvc/NT5k01pDSFhHr/RjTrk1QoQcgYsPv+ykFVbqsWeEnY
         IrmQ==
X-Forwarded-Encrypted: i=1; AHgh+Rr0WuWvbZGMN+s0cajbC8hhRmC58uvJi5b+8TAQeFpK/hzENSsVbHK/Jy6AFEVPI7bp14ty3FsvLmE=@vger.kernel.org
X-Gm-Message-State: AFuF++n5u32ncebFsrkJKyHwtBvOeLE3JW1G9ZVZXwQNhi4GeKFIjlNa
	g6C2m96WsWqmrG+OnG/9wVmryatZDrZBrkiZUitG1rkMlkiGB4xJfz4f
X-Gm-Gg: AR+sD13RVY3B1hw1s5XJIXK8Ls2I3KeHxZzE1uhDSzBWXoFvcJcxGmxoXaWlUNWxmxD
	q6WgUPob6yZEcjExKQP22ippnzBErBpKj8fF/Ixx0g4u+Ke/g2bzTDVgu9IU3FLqMD3RE4jn2QN
	Y3YMH5a8ck9wiCV+I/xrcw5anhKnbKA1uN8E0hgzd4zUST91hz7cfhdiHol5Chm3bNe/jZrbZ7g
	83kswUtO2h/NYw6052StrOVi4Nu+jHpBXopzd5dzGW8NQbD3o//oS578xa+RP59dLMRHJxcC57X
	dHOVlRj9N93xzmBYM/+/Bn8hLAlUidGMMtFiCND7FlOD+6IOb5mEqNeDA60Y1MUdFR4WCzplXAy
	TbE+vvZKk6M9erFz3qPzubLjXuvM+gkPc88GU37Cr7dw/SsKqYx8e6tZEYNOSsexlNgwXtLdkMR
	B1Cf5gLpTZjSCc7meDLMQEJy1qi4sPO0eP+wvvTPNfFIABKUpiURRt/IC23HkaFSOYcEXXBEBvx
	vSyfU5qU7xUuqU8JpzJu1YTx5kc9SOOYq2BUHaEhxy4bicKwuTjiEKSxCRz1tHkHDzPzGSuIuC2
	/J8YB2Rv8v8YMofeQVzZWciAyxRCs4TEJ/OaWAM0qbJ9lN2s49/z1Ul0nmFt7rGHBUnAvNY4/C2
	I6rFCxtQm1qsYanTNuxYC0Ni6DVkUPxAFqn4/qnpeXBAQ6ss/lp0I2ftM0xwA/GK1j+E1kBs5J+
	0SJwMP
X-Received: by 2002:a05:600c:4fc5:b0:49b:72e4:6223 with SMTP id 5b1f17b1804b1-49b91c2bcddmr63229085e9.7.1787909745986;
        Fri, 28 Aug 2026 02:35:45 -0700 (PDT)
Received: from localhost (90-182-112-124.rcp.o2.cz. [90.182.112.124])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482fbb284cbsm2800194f8f.30.2026.08.28.02.35.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2026 02:35:45 -0700 (PDT)
Date: Fri, 28 Aug 2026 11:35:44 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: "Li Youhong" <dayou5941@163.com>
Cc: biju.das.jz@bp.renesas.com, wbg@kernel.org, linux-iio@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org, Li Youhong <liyouhong@kylinos.cn>
Subject: Re: [PATCH] counter: rz-mtu3-cnt: check clk_prepare_enable() return
 value
Message-ID: <20260828113544.00000aa4@gmail.com>
In-Reply-To: <20260828071123.179670-1-dayou5941@163.com>
References: <20260828071123.179670-1-dayou5941@163.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 28 Aug 2026 15:11:23 +0800
"Li Youhong" <dayou5941@163.com> wrote:

> From: Li Youhong <liyouhong@kylinos.cn>
> 
> The driver ignored clk_prepare_enable() failures during probe and
> runtime resume.  Propagate the error so probe does not continue with
> the clock disabled and resume does not report success falsely.
> 
> Signed-off-by: Li Youhong <liyouhong@kylinos.cn>
> ---
>  drivers/counter/rz-mtu3-cnt.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/counter/rz-mtu3-cnt.c b/drivers/counter/rz-mtu3-cnt.c
> index 7bfb6979193c..6f746cf598c0 100644
> --- a/drivers/counter/rz-mtu3-cnt.c
> +++ b/drivers/counter/rz-mtu3-cnt.c
> @@ -817,9 +817,7 @@ static int rz_mtu3_cnt_pm_runtime_resume(struct device *dev)
>  {
>  	struct clk *const clk = dev_get_drvdata(dev);
>  
> -	clk_prepare_enable(clk);
> -
> -	return 0;
> +	return clk_prepare_enable(clk);
>  }
>  
>  static DEFINE_RUNTIME_DEV_PM_OPS(rz_mtu3_cnt_pm_ops,
> @@ -861,7 +859,10 @@ static int rz_mtu3_cnt_probe(struct platform_device *pdev)
>  
>  	mutex_init(&priv->lock);
>  	platform_set_drvdata(pdev, priv->clk);
> -	clk_prepare_enable(priv->clk);
> +	ret = clk_prepare_enable(priv->clk);
> +	if (ret)
> +		return ret;
> +
>  	pm_runtime_set_active(&pdev->dev);
>  	pm_runtime_enable(&pdev->dev);
>  	ret = devm_add_action_or_reset(&pdev->dev, rz_mtu3_cnt_pm_disable, dev);

This is fine, but any pm_runtime_get*() function called in this driver
would return a negative error code if clk_prepare_enable() fails. You
should definitely add checks whether any pm_runtime_get*() functions
succeeded, otherwise subsequent reads/writes will produce garbage.

-- 
Kind regards,
Joshua Crofts
