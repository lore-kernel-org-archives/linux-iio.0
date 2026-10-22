Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792664197;
	b=1L9QzKyerLwYwxBKrye630sEyfA7OsYyJyiQukhMkDdeGdivdMk3eiHFE/vooUtiIXcQ
	 pFaRYfPNRjuZ+gvXEQzyXnLngqGylCYmDiPPoYUZMU2Sz0l8d8boL8uObYwtcpxEOtNba
	 anAyuWPxng8qAARnoIW4SepwSkbDmdhMHXSucRu6AJjbkiA8omSpWOkRBhPMRwPWZA+2t
	 VzePvK+VgkjhWqvm+i5FVs1jiYerzpt3q3IVKNQ7k6UGeYZcZ4VD33xY8QghJH/39XQkm
	 21njRDX0kC3LpTUk5PqcQ/BvA7rGKzA1OvI0+tpELXUV1kS/ABXNS7wcHOt5nVdZMQA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792664197;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:Date:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=yIJA+LY/J4smL2e8nhrsDvE/0PSgaY5RU2DGHQx94co=;
	b=if5kjovV+cA7atAOJpWINwrb2e+ZqJs/ooENfuhBHvEZIsMyG2MF9iJFT+dguOpqpDCd
	 jc/uxMVLYDXYOCRszLkigB/kOAS84fLLsf71m4CCWqn4R/9RZxDU5Fen/fhwTW133ew3t
	 wkTf1ObBQdIaZ8cpeB4bJDmLkfHk/ReUaVTphoLpIGFTElYWOb9+F1oatj3JuPJpYwvKk
	 wg+LhboKs99njCFrMg4REMVLYKGq5sQmXXELSzb32QbM4lga3/GkDuUnlw8BavwYrMBEd
	 BzleeWnSFpP5PM+YjKGEx1Ncul7Yxosl2gDkFsnGCMRIhoNkQYyp2qS6ot3EPLq2k2Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=RM051wzi;
	arc=none smtp.remote-ip=209.85.160.50
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D91A4606A31D
	for <linux-iio@vger.kernel.org>; Thu, 22 Oct 2026 10:16:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D91A4606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=RM051wzi
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-4877837890fso822735fac.2
        for <linux-iio@vger.kernel.org>; Thu, 22 Oct 2026 03:16:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792664196; x=1793268996; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=yIJA+LY/J4smL2e8nhrsDvE/0PSgaY5RU2DGHQx94co=;
        b=RM051wziSHHDi6dz68xoW8UAdkq3DP+jAGVZKwRbd7iXLQNpTebA2mMgPq4WW3cKhE
         MKBPOdsWNAcwzLghxviDIoZ65bXBlBNEiG1Qp+Hg9ZlPX8hC9MpoTAF0PdF2OSj+3Aci
         sQ2tm/u/NFEyy3oKkHa22rxNB9n3lacrosAtOAfqUQp/0AKLXm5l+xFsKHVduXH+Netq
         DcbM1n86H7K40d7HRxPiWj+4EiwWijWbUeoX8Csx1vOwp5W/iTVoI1H+dUnZ/gruemmW
         uGdWsJNtv6G1eH3jKwJx7Fi0xx/4rYBPhpHqHFpQhkenhGCOPb+bvvwQAe3XijN98sSI
         RIjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792664196; x=1793268996;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yIJA+LY/J4smL2e8nhrsDvE/0PSgaY5RU2DGHQx94co=;
        b=i4j+2NRUPPBeUEXvlN7dzfmU5MAm38HlfszrVKz7QSrB+X5dQQ3end+o8+1mR+LwP5
         txoNZrWyxjY7zISYdKBhjRpB9kjL9GkcPkalvrYDoPGgidhpdaRssGpHDlX1BrlNwfRK
         toX6Df9kmexvTLe8NY2YdTumZAuMToEPurSwf6Bs1REbOPbnhxD4wDxvAGKB20NJI5+p
         DUnPQQlWKt/4oKBlxGG95HdGaefOexJX1YPZAlgec8Y1m/moDCJrEE+QHR3P0F6SAojQ
         B4MrFP7lwmbCoJ+pbAU2bdzm0X2GHDUULjbB3vcwn70w4GK6Gn9iQa4QDjQ4OB3vzwpf
         6t7Q==
X-Forwarded-Encrypted: i=1; AKwUvBws+cv4qQ+KnSuO7ZEs6FC4koJ1Os4bgIDowQ9e9rh83ZASrW/TxMgg8LKeUNDg7sGw31iSEMACa4c=@vger.kernel.org
X-Gm-Message-State: AFq9FYKK+9sxf+cTJA1g80Ho3Z6zXP5R6aHUH4Aqp99+Mzl8XVIeuoRA
	JMUsXhgb/EB88CfN9wlBNo4iWyU1+9DedPILzny7cQjJw2m7QVnz14LO
X-Gm-Gg: AYBFou265wuX1SxASBS/YjApS8p+B/4f/jWh/MRPF/5hWBO+OpBSyEertH8Y+mAkca4
	L36M/KL1KJULUbnJ02mrUsAHF+ioyhDdAj+5DCXJwbmeOV3aaXiskFH5/1IboCOw679mPC80lqC
	QnI0gWwSQo/4LcT482HMdKrjIAEuv9rb/UT2xBStroJ7yI7Nv+fley3c5UNQCziZeBRJLoQGVLu
	VK52shW2ApVJ0Y2O/Ta8AUMqv1EALOGPCxjCUQotvADTHOCCgGPSEbacdj61ga/LFWTvDEDKQjR
	8SrMLCAend8JfPYFnERchat3qwJLgrr/gHQbcMYKritWcCwyHrIDtGgVmAOociZoo8auYx0Aa5u
	IVIWzIrKV7hexG7M9qFtDOmenAeuQONPcilx50Rr2InHA75qO0tm804GkbtTOLH4gy0MQ1FO/Py
	qF3jrl+vgJHephVYF+6OGijXi9zUm0/Rnz0r3udKJWaRDt/nCcn9V7rbNdYJK3Fg5K0K+iVMEaq
	kDs9b1yUNRzBawZP43TsBJWuTLKvjSpi4TFDTHp0mzRNBWdJRR5kRZZiuyYs0ivL49euScboPoD
	XHXPylSIMKP2EGBUKstdCOPGB3fUd8mfan2el9O81LvdHDktr/3I
X-Received: by 2002:a05:6808:1715:b0:4dd:18c7:5448 with SMTP id 5614622812f47-5535babba3fmr3335289b6e.56.1792664195793;
        Thu, 22 Oct 2026 03:16:35 -0700 (PDT)
Received: from RDEALENC-L01.ad.analog.com (158.95.44.30.netskope-rdns.com. [158.95.44.30])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4a7d8ec2584sm3950553fac.9.2026.10.22.03.16.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 03:16:34 -0700 (PDT)
From: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
X-Google-Original-From: Rodrigo Alencar <rodrigo.alencar@analog.com>
Date: Thu, 22 Oct 2026 07:16:26 -0300
To: Arnav Kapoor <kapoorarnav43@gmail.com>, 
	Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com, 
	andy@kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: core: fix signed integer overflow in
Message-ID: <d6aqsd2i6pyqj3wydjksgtg2zoght5i2fvunlftsko7urpyw3u@k2huwktmvcql>
References: <20261021225306.623361-1-kapoorarnav43@gmail.com>
 <atm2WhX9KDkbUIPk@ashevche-desk.local>
 <20261022082448.275582-1-kapoorarnav43@gmail.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261022082448.275582-1-kapoorarnav43@gmail.com>

On 22/10/26 13:54, Arnav Kapoor wrote:
> (Resending with the list Cc'd, sorry for the duplicate, Andy.)
> 
> On Thu, Oct 22, 2026 at 10:08:10AM +0300, Andy Shevchenko wrote:
> > This needs a Fixes tag, otherwise it probably won't needed as Rodrigo working
> > towards tons of improvements in this area.
> 
> Will add:
> 
> Fixes: 6807d7211327 ("iio: Factor out fixed point number parsing into its own function")
> 
> > OTOH, Rodrigo's test cases might be good as part of this fix as well.
> 
> As far as I can see, Rodrigo's tests in the E notation RFC exercise
> kstrtodec64() in lib/test-kstrtox.c, so they won't cover the current
> parser. I'd rather keep the fix small for backporting and send KUnit
> cases for iio_str_to_fixpoint() as a separate patch, if that's OK.

The current parser is being dropped in the E notation series, so that
overflow concerns are handled differently. iio_str_to_fixpoint() is being
tested there indirectly with tests on iio_write_channel_info(), maybe not
is thorough as it should, but it tries to focus on different format types
and coverage. Dedicated parsing tests with different inputs are handled
in lib/test-kstrtox.c. With that, not sure you need a KUnit test for the
current parser. Only small fix meant for backporting would make sense to me.

-- 
Kind regards,

Rodrigo Alencar
