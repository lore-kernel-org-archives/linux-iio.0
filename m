Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33ADA420476
	for <linux-iio@vger.kernel.org>; Wed, 15 Jul 2026 13:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784120575; cv=none; b=IbLXlbqika+4CPLkrcqPnDlQ5UNnOX616k9ixjORIUFICiCEibR6QgldrQXWjbnENRwbGWWJtLK/HcB4O71lOYj1D/rWYYdu8Ifd2rNAI7WBL7BB3YeeUJmV58zXrU7ESmvoztn7CPze0QsYIlRvMHOQLXY4kDhqCclQsCaa8eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784120575; c=relaxed/simple;
	bh=N6LMn7MiHopKnkA5J0zJufKQOBomiCLsVyYHDoryQig=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LN6pO79I3dm+xaJFOdte3JXf7zHcWYOd6Z9/oFNmmVZjmXZZU8OObcipZpzqQbk5yoqxZxAz6yZDaPtz/tj+RTKUOKBoUXhWwsKDCgldKYjpEm4ckJ6DRgzaxkZdEk5Iq7xS9UvHQZAfnFxRElmvHd07r5yr4AGhtvqdzq/Y0U0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qskU76sR; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qskU76sR"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-493f45e20cdso32231525e9.2
        for <linux-iio@vger.kernel.org>; Wed, 15 Jul 2026 06:02:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784120572; x=1784725372; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QFKJnPmVhYGXGMLsUKcHXY8gMyHNPu+ws0DPBz7tk5w=;
        b=qskU76sR6uy5ICQPo8G72/iavH0pxao0P6LeXHLBaPhItLlp0ZJ7gMdQ6E/+ZDQPmm
         YqS2JJlm2h5ZDUwdiDetqrSS6E90zAL84AUnBucIx21RgzHyZWj0ItEIfWtndJOB3pJH
         scQrq53XhDBxFcytcKLVp6M7MMEGMC6w9mL0r7RcUs7v2Wmp8zMdZ2G4uYpZyrMGNpl0
         eyr3V8t8tkP7qrBNII+zTCHBW8olgxX5SUVEn8/q63ZUrWlNjtLfHE6mt7Mbaazn8Epr
         AXvps0dxN1yJXT7+nnEG0dOYQoNSQswPkQtpBmw8RmZ2RBqnAKUcP0TOjqluCwlClGqa
         zXmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784120572; x=1784725372;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QFKJnPmVhYGXGMLsUKcHXY8gMyHNPu+ws0DPBz7tk5w=;
        b=cozfvoN0MrgatPD7MakNbXWaXbIHEAbK4723eyfBu4Ngrq09cLAKOFXqDFh3hBsZ5X
         D6ifckA78JYxTBQGlcqvMms4cKp1mIEFXwg57/m7AswcAzjN1zy6BCEu8hUJH2a8UvaT
         rLJpWNeewLUnqxpirDNxCCDYvXipH8Q7bpwgyqvcS1bnaSIvCKMOZ0mTd73xJnQdXBdb
         dT+p7NWmvaA3TTcXgfMwyjCphj3mliA8s6kD4/4u1PvBIgmpYZI8b67YS0ViTeFMSBtr
         TkRvJXVGTd/FkOEgLoiLmlwagVXo5i1BJnydCwRP/6U/xXhAN41QgVT23jzZN3skDhql
         qSiA==
X-Forwarded-Encrypted: i=1; AHgh+Rov9mpxUGiHLmlTGSQnYsnC0I4WHVrneWzICCNMN08td98ND0QorhpEsLFmK4CDNVjO7o+H2Tmpeio=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQTtZh67Pw/KGpmZIdi8V/h4SuDhOs/oFKu99YG3kH0v1ltXMu
	qUOeXwLZ83TVg6ubCNHoTXUlcmHxmqKFlGfjjLqkqgJ4DFgiAao8VTtD
X-Gm-Gg: AfdE7cl4flv2xkvh+fxJuO+hiyXUbvtBtNlmE92rsud7nxxvxS5VPfBsegyO0JEgHIb
	PejfbC4YkVi9LbRJg19Jo5r9l30/Zv5pLE+CB6wvsvJouwquWkHQ38sjz0xMuc+40BAFOkkgoSq
	eBmTm7G9Gn/heUKrDE1A3hRHzszQg2PjHzhAnefr6ES0ZYVkTvE4Rj2z39SC01mzL4Mh6hrk7+1
	eOo0gi3sid6htRxwLRxtxLAsyOj0LryHNUQkI9GoMpY6gZ/bNzKO+pO9+X/MQdnSdEKU8ZNhcPP
	bEyDHR0iND86jRfI4ZfnZ7vkI0NZxiQ0JSjnOrEQM/pMSmZbyz4COxiOODWvdpmZdd/wgOaKOoy
	gEsCYFPAMyhWQl6LVQKAMHom0lovRPf+pscfnU4+IKFTFscGEMd/Wz85cj5zkGAFeGYQ5XTssG+
	KJL5z+eQpiZ01pglpTxlV7ySdt+GtB40QOtUl0s9/yv83CFAvFPoxwRNmbvuTLKnNZ2vejn/Pih
	XlJFZWNST9TRtWMM5biBN1SFR3aRUuiUP+aNj8zto2bZfKi0lA5nqFD/5gVfnb7BAuOlFTAqYpu
	zZFNKNMiHiemWCdiJuRUIqzS9/JFcmhTUM7Y3rYncW0XO+DLC3SBYMBzWzEB452EfRN4t+ctwZh
	L0mWXs9c3w0tMNBnFXlK3A4o=
X-Received: by 2002:a05:600c:64c5:b0:493:be3e:cc3 with SMTP id 5b1f17b1804b1-49539824f8amr62710375e9.21.1784120572059;
        Wed, 15 Jul 2026 06:02:52 -0700 (PDT)
Received: from localhost (90-182-112-124.rcp.o2.cz. [90.182.112.124])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4950a32a2casm219530045e9.12.2026.07.15.06.02.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 06:02:51 -0700 (PDT)
Date: Wed, 15 Jul 2026 15:02:50 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Esben Haabendal <esben@geanix.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen
 <lars@metafoo.de>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Martin Kepplinger
 <martink@posteo.de>, Sean Nyekjaer <sean@geanix.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Martin Kepplinger
 <martin.kepplinger@theobroma-systems.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] iio: accel: mma8452: Optimize struct mm8452_data
 member orders
Message-ID: <20260715150250.00002307@gmail.com>
In-Reply-To: <20260715-mma8452-open-drain-v2-3-95be9f5f4795@geanix.com>
References: <20260715-mma8452-open-drain-v2-0-95be9f5f4795@geanix.com>
	<20260715-mma8452-open-drain-v2-3-95be9f5f4795@geanix.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 15 Jul 2026 14:33:29 +0200
Esben Haabendal <esben@geanix.com> wrote:

> Reorder struct mma8452_data members to avoid holes.
> 
> Signed-off-by: Esben Haabendal <esben@geanix.com>
> ---
>  drivers/iio/accel/mma8452.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
> index fdf7364d7fed..537263085215 100644
> --- a/drivers/iio/accel/mma8452.c
> +++ b/drivers/iio/accel/mma8452.c
> @@ -108,11 +108,7 @@ struct mma8452_data {
>  	struct i2c_client *client;
>  	struct mutex lock;
>  	struct iio_mount_matrix orientation;
> -	u8 ctrl_reg1;
> -	u8 data_cfg;
> -	bool open_drain;
>  	const struct mma_chip_info *chip_info;
> -	int sleep_val;
>  	struct regulator *vdd_reg;
>  	struct regulator *vddio_reg;
>  
> @@ -121,6 +117,11 @@ struct mma8452_data {
>  		__be16 channels[3];
>  		aligned_s64 ts;
>  	} buffer;
> +
> +	int sleep_val;
> +	u8 ctrl_reg1;
> +	u8 data_cfg;
> +	bool open_drain;
>  };
>  
>   /**
> 

LGTM.

Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>

-- 
Kind regards

CJD
