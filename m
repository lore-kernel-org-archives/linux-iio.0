Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 453D338239F
	for <linux-iio@vger.kernel.org>; Mon,  3 Aug 2026 12:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785759558; cv=none; b=aAG78bX6oMB6yktoZUwFMYqN+/c5U/3TQuZO7O7HghS7Am28yAIYQJ0Sj42u0FGD3uM7aVKuLN8A7amgypRAIZPdhPz11/27eWszW+1RnVFtZtivlmT4M8Rs6xm8W2mq5qp3EzYawasVJR7sU49NrRra9BBWrWih+11jynKHisQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785759558; c=relaxed/simple;
	bh=wc83a5AMCwuTWCZVLQMaWatrwp89sO6/4LMd25upCRQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UZnyJqlurNkve8hDDDFT/EtuoLWyapdOnXAncdINe6toqIwr13LeAm2Sj+f5/vSbow37vFdOjOF1VPnYTS435cEv+y5s77Qvmm0D9xKMZnVG7PMs48z1UQXueKR+peGNDq6SgR2OU+X5CCjScQFIGT4tLSYb8Dg2/qtBe5e/uD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dG1E5de1; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dG1E5de1"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4955de8797cso11906875e9.3
        for <linux-iio@vger.kernel.org>; Mon, 03 Aug 2026 05:19:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785759555; x=1786364355; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=He2QS3aqruPkEmo3ml3RnizkSIK2y54nrSWG7gf9bV8=;
        b=dG1E5de1mVEiPC6ViZjDcBxHWwbWv1vk4SezPqaUMvYe/R2VtKEpGr6jSLRGp+P1Fs
         lHuDELzp8F/0pcde3l7Mba9JshxvOk5X7lQ2iKngLjzVV1OiXg/7v4yy00W74yrKCO+v
         nvWj0m0AmbZ6CqXPeyweQx25siCvtAvzQ4KkBZ9hcZPZD0AuhnYvELTxni0SppWs8NSp
         rmv34xpCPKr+y+2NTGaM9NCod4vH1xg6BRESvogsnjnM3m85L7qdvMUxP93tbOmYKPVc
         789za6SpX++wPQW83jM9CR21AaUb5hRZHqKF/xpg8JOCi4aO5b8GMqGW9K0IFbXTDzz7
         HXYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785759555; x=1786364355;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=He2QS3aqruPkEmo3ml3RnizkSIK2y54nrSWG7gf9bV8=;
        b=DZs/OYoURW0UBVmThOP8tKN7z/bDF4wjNxS5i2/GwbBcIbbQSkzhiireO3/2AbzPt1
         Z8myfni1LVcvIP8W0XFSXO60IzjiTwqWmjNN0EalI/8trPbZGzsYcxsa3D+18HNsV1gi
         8yScSh81IRpHBPpoLL0isFGXs4aDNc+m730xRpd7cnCdSKmyknWnVuxX9axRLBYPlfu7
         BTbPSky8eWBGBuQuzfyU0ZB4tcbm3pF21WF5Ea+mD/jXo+Pxa+i3lvrJv8KE70WlBMhO
         +dxmHjt+QOVz0vfjcOQqH24/Pfa2iRncCMK5Vi+xQNODxNxYc6HvfXmalFjPXJLC0g/S
         RzIQ==
X-Forwarded-Encrypted: i=1; AHgh+RqbQKAwaGjdbc1zVoBiHU27X1YBaF2JbvoB8JcVZyRpbJzMwLrWU/0v0LzyonChWV4F9RJgGh+yUEE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwSJQ4vLNGaPOG2ulFXXFugUcC2NkhPs8ZnV2Zfm4+YP7rot0n
	0qrlkxzYDB5mxTaMUUWUGsx4sJPqnaeM4l+PdcrwbI/WiagTd2ii5gbN
X-Gm-Gg: AR+sD10Vs95RcGOjX3eOs5kwF6iy5NlUz3zoS4/pM400qdRArsZh5BaqICrm57ssvos
	EX/ViPQ7RG+0b5Fn5HMd/kOaOKnQdQ0XTRInYg2b+J8zMvSVf80/cHxJ0DO/3RdKqo3yrJkm9/2
	8uLP/tVpGdhU3zDt4BAlf9v3bFVxyZ9VZKykoyY5iSEq59dKTg065raq6MkaxJAxjYlTW51M1kS
	GLMEHrx+DwblRMNieT/OxUR4bfEQpsCG/UpY8dowxQX0IXNOweRG3PBsBQui8cIzxIhgeXsl5Jg
	bq1VAo5Pz5jQNE08pt2R5cRmm5/wkbpAYfohBWx+3G9yTlJS2rKqDYFm5xqG2fmcX/i5kYpME9q
	9W0bn/FXd1yuZy+zrMj7bkyHCV1eDGnkIBmNuvwjIBnLZ1XmhJqWzlYYVD/0zVNR1FUntKT+B+Y
	+O/OM4mR5M+A0v/rMJSwjObGu4byb5ekDfotZ7epOdR/j6ZtqXLWarWjwVjCiK/XMO5EX60k+rT
	pRVzuUHBYuSHX8pB9be6QWcp4IVqjBl4uoM0VXG4cFHSVS3Mb5JWenxa7sRjiG4+MSe9Bnd/wyM
	2p+mfEebEJ+fOj1+Cz1JBtFIYoE+qF9NzeBxmpBPZnHg3Nw9yOQJtf6Ip0RKhCJp7LIFsUOO1qg
	xcSWbWPS8cMZQ12TNxAPhzE6KfOvDofwAA85SgGO0v3EV5MY7y7HGOhtnU+aD7ISwmn0o82c=
X-Received: by 2002:a05:600c:4454:b0:493:bd2a:93bb with SMTP id 5b1f17b1804b1-4980c64b6cdmr223317955e9.3.1785759555358;
        Mon, 03 Aug 2026 05:19:15 -0700 (PDT)
Received: from localhost (90-182-112-124.rcp.o2.cz. [90.182.112.124])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49807b7afe6sm213206215e9.0.2026.08.03.05.19.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 05:19:15 -0700 (PDT)
Date: Mon, 3 Aug 2026 14:19:10 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: mdshahid03@gmail.com
Cc: Jonathan Cameron <jic23@kernel.org>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, Joshua Crofts
 <joshua.crofts@broadcom.com>, Broadcom internal kernel list
 <bcm-kernel-feedback-list@broadcom.com>, David Lechner
 <dlechner@baylibre.com>, linux-arm-kernel@lists.infradead.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, Nuno
 =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>, Ray Jui <rjui@broadcom.com>,
 Scott Branden <sbranden@broadcom.com>
Subject: Re: [PATCH v4 1/3] iio: adc: bcm_iproc_adc: Remove redundant probe
 error messages
Message-ID: <20260803141910.00000263@gmail.com>
In-Reply-To: <20260801090953.61603-2-mdshahid03@gmail.com>
References: <20260801090953.61603-1-mdshahid03@gmail.com>
	<20260801090953.61603-2-mdshahid03@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat,  1 Aug 2026 14:39:51 +0530
mdshahid03@gmail.com wrote:

> From: Mohammad Shahid <mdshahid03@gmail.com>
> 
> devm_request_threaded_irq() already logs an error when the request
> fails, making the explicit dev_err() redundant.
> 
> Similarly, iproc_adc_enable() already reports failures, making the
> additional dev_err() in the probe path redundant.
> 
> Remove both duplicate messages.
> 
> Signed-off-by: Mohammad Shahid <mdshahid03@gmail.com>
> ---
>  drivers/iio/adc/bcm_iproc_adc.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/iio/adc/bcm_iproc_adc.c b/drivers/iio/adc/bcm_iproc_adc.c
> index cf4738b16e62..7c2e2770cd61 100644
> --- a/drivers/iio/adc/bcm_iproc_adc.c
> +++ b/drivers/iio/adc/bcm_iproc_adc.c
> @@ -551,10 +551,8 @@ static int iproc_adc_probe(struct platform_device *pdev)
>  				iproc_adc_interrupt_handler,
>  				iproc_adc_interrupt_thread,
>  				IRQF_SHARED, "iproc-adc", indio_dev);
> -	if (ret) {
> -		dev_err(&pdev->dev, "request_irq error %d\n", ret);
> +	if (ret)
>  		return ret;
> -	}
>  
>  	ret = clk_prepare_enable(adc_priv->adc_clk);
>  	if (ret) {
> @@ -564,10 +562,8 @@ static int iproc_adc_probe(struct platform_device *pdev)
>  	}
>  
>  	ret = iproc_adc_enable(indio_dev);
> -	if (ret) {
> -		dev_err(&pdev->dev, "failed to enable adc %d\n", ret);
> +	if (ret)
>  		goto err_adc_enable;
> -	}
>  
>  	indio_dev->name = "iproc-static-adc";
>  	indio_dev->info = &iproc_adc_iio_info;

This is good.

Side note - I noticed that you added the email joshua.crofts@broadcom.com to the
Cc list, however I don't work at Broadcom - there must've been a mixup when you
were Ccing people as I only use the address this meesage is sent from.

Thanks.

-- 
Kind regards,
Joshua Crofts
