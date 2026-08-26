Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1F23299922
	for <linux-iio@vger.kernel.org>; Wed, 26 Aug 2026 03:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787715311; cv=none; b=UU5nwOxcQiqplKo+FMk78Rd0I4qpMM6o42eRsXgeA88LhtLTfh8NprdKKgMrsIqM1xLiR3Vq/pz5Xada7Y47JACI3qDiuTNMs2npdpMaAX4vbEU3bf+DAD6rwbqROtOrOfsx34wfuwCAxTWNy7t7GwIXkji3iDHT6+1SdvCZ7Ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787715311; c=relaxed/simple;
	bh=KlZ5r0TGY/d3yFQvd+ac+DNpJPMoDwNE6F2poWE8s1U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YG9fR0B+kYb7LcDn9kGZ2d+UOlQpgaWdhgCaG3ZdziMbV39A4ik5lYykR02QRtmbkXMwKtuTrccjYi87by7uTG8qjIYMllmF7W0FcdCnCiprtMmi0vnydJ7asvr32OuVBMcX5qWMC0+zFllwjCz/imSH3YpiJKDZ4DBoH9z10gU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nT1DRw1K; arc=none smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nT1DRw1K"
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-5bf959b820cso428311e0c.3
        for <linux-iio@vger.kernel.org>; Tue, 25 Aug 2026 20:35:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787715309; x=1788320109; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=MDoKigPjvswwl+8EcyWhXKw2z+QvC5L4RMofPPBGe0Q=;
        b=nT1DRw1K7FxbQmhFWuzCocfSyO3HahVlu2skVR3zq0YYSAj7F4gKSeZLI6iNQsXbzq
         XLteEdus1vJaB1hCh4naWZvJlIxDqukE7Kz4BXrxXrOqyxa2mlc5SlvUj7xALVK+A6mA
         I44CPbiuZnRt8emxhFKc7PPVx9b7S/3WQrkmiR8N2t8CYNcVEzGIcjrjjtHa8Y8hrqp5
         EAXxazI1iA3/zWKIQvr9q8LJaNYN/MOt5zsEazQvqy8+DtAHrlXyOp2hjhjPHuRWpo6I
         YlkqV2/LWYuYsahPJ0wwmYmduAQ5mLnjlCPDlYws7rnf7HeLtIb6z6XmO8qGSH7+Of11
         QcJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787715309; x=1788320109;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MDoKigPjvswwl+8EcyWhXKw2z+QvC5L4RMofPPBGe0Q=;
        b=ECm6gUvLmjxe7FiDeZSqXeoglsWHZHeE73ZWJtqmDkM9+cMwHk0ykqMgtkFc2oVR/Y
         QTqxszq1mLlmjhdFnFMjxsLL1H/S215NGjEU1ePlo8eWlyDB7exy4keKGTUorW+YQLJ+
         bgxfJFLQj0zT66BoKg07kMKGbWW33R/uhL9ml5AfgAVsIP+8p1IMsrGMVATTU/2bu8Ta
         Q8yzxF2ZmjBwh3J0bNcUstQsbfcqkQueEzW4XUtJ7rb6PsBGlM0HAEFOKP4YAM+XsD9D
         YYQ+F49eZ0iPS12QIEBX1jTJyfFrs7spsdEFP3/Cf9wu9x1DSsD4UAjgNmJ9CImpOfZE
         fyzQ==
X-Forwarded-Encrypted: i=1; AHgh+RrHi17skQMbBmOecJvJQJdEL5B9ntSRs2sb8Twt2LcSmuC6u9CVRSYnB1QfWYdSSeDGkGyM2PJ9Dzs=@vger.kernel.org
X-Gm-Message-State: AFuF++lny+px5oA4JQzkgFlmwi0nfuCg6zIvQCwil9e5UAn/VY7iSOxt
	0GHG7F4nLTK3kwUVlGhxkooYvAg2kD0HfOqLEjNHE8IqMrcPf8Vg8DlDBSv31g==
X-Gm-Gg: AR+sD12T3NOy1rz2+8dsD4sZsVyUznmaieBMXBBsQPWikmlxiPP1ua028QjiM0dtUhd
	8XQ02HTKKXRlWA7M0pK/xoWVPGfp5JM4tGlEF7ePKYSpKGhq/vT5kd8pY1mTY21a9yJb65oKxJw
	yT5QyMNDMYKYDS9IvSfn7OYgnf0cOB30h8k/tcK326NaX3HQRBoSJtdb5LOrAmQeplh/6l92S89
	eVQhjkJtUBghcBA7TZ9fS9tXcstZU7jtV7fKtrGfm7y/F4LVhQG+sAH2tRNitRSuowB4+xzW0Iw
	5plbtQ7HI38brCzEJMRm5TAWV1HKvDErN/o/JucwPu6/YMaR/wOICE4VFgR2/xgwxB9j/Xf+R+m
	ulE6fPl+NXm/qz5vUoLIMy1BOzwjFiAEGcOOaUuhsdNz3huW/VTeIY3N/UeEiGoXKZILSchNCvg
	E1rzpW6bF/PjIiMIjwoECtwFbiRpDpzURW6dKU5fDKq+JVA0e08JWe+jLJqBbySFj4/8bN
X-Received: by 2002:a05:6122:507:b0:5bf:8c77:e89a with SMTP id 71dfb90a1353d-5c65ba76c6dmr1360903e0c.2.1787715308746;
        Tue, 25 Aug 2026 20:35:08 -0700 (PDT)
Received: from localhost ([2804:30c:97d:e800:9454:1179:18df:ab33])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5c660014355sm588803e0c.9.2026.08.25.20.35.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 20:35:07 -0700 (PDT)
Date: Wed, 26 Aug 2026 00:35:49 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: mdshahid03@gmail.com
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>,
	bcm-kernel-feedback-list@broadcom.com, linux-iio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 3/3] iio: adc: bcm_iproc_adc: use devm-managed mutex
 initialization
Message-ID: <ao5fFfdqPn5DyFJt@debian-BULLSEYE-live-builder-AMD64>
References: <20260825172155.250484-1-mdshahid03@gmail.com>
 <20260825172155.250484-4-mdshahid03@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260825172155.250484-4-mdshahid03@gmail.com>

On 08/25, mdshahid03@gmail.com wrote:
> From: Mohammad Shahid <mdshahid03@gmail.com>
> 
> Use devm_mutex_init() to tie the mutex lifetime to the device and
> improve debugging when CONFIG_DEBUG_MUTEXES is enabled.
> 
> Signed-off-by: Mohammad Shahid <mdshahid03@gmail.com>
> ---
Reviewed-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>

Though note the device driver currently lacks an include to mutex.h.

>  drivers/iio/adc/bcm_iproc_adc.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/bcm_iproc_adc.c b/drivers/iio/adc/bcm_iproc_adc.c
> index 1464c60bc83e..9b299e2c3e0c 100644
> --- a/drivers/iio/adc/bcm_iproc_adc.c
> +++ b/drivers/iio/adc/bcm_iproc_adc.c
> @@ -530,7 +530,9 @@ static int iproc_adc_probe(struct platform_device *pdev)
>  	adc_priv = iio_priv(indio_dev);
>  	platform_set_drvdata(pdev, indio_dev);
>  
> -	mutex_init(&adc_priv->mutex);
> +	ret = devm_mutex_init(dev, &adc_priv->mutex);
> +	if (ret)
> +		return ret;
>  
>  	init_completion(&adc_priv->completion);
