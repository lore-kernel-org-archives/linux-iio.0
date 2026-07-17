Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3A9D3CB2E5
	for <linux-iio@vger.kernel.org>; Fri, 17 Jul 2026 06:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784271102; cv=none; b=H7pi/O9zW4Z7sfXrt15HemMTyV0Uhawgo34a24B+euNLdnwKZMmjTFoXL5gu2svyBnLrjJFM3co3Qq3/FWKFLnVbT/hLsSGft2Xkwy8bFj1S9bFoTv92T3aBpaLmvUBNzV+ojaE3b6arvfFaB2VUvchoyKAKbIbNwzAhpEEiGKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784271102; c=relaxed/simple;
	bh=lcV4Pb2mh+fAEOpbU3PIl3OXS7WicGJvoP7zaEWxSq8=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aglZ7ZlfH9bQ236wzsf1Bjih/kXfL9EO2CNPVBhFwrz9A5Bmq8KrPTfN97KLfVu3q61vQoo6OU+Ku52eUjYptyaTqCYvBf8IYhGXTMm30wVWl2F/k9EIQVNnudwMIDODHtFzkAdqoj0SSl9STMn0S82dEtK6d4m7wDuCRlHGjaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XcaLHxgy; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XcaLHxgy"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-47defd0c1c5so3162164f8f.3
        for <linux-iio@vger.kernel.org>; Thu, 16 Jul 2026 23:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784271099; x=1784875899; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9UY5ZnEeTRAKjye0Gd13pSYVq2II1CClrTvBqjd8pp4=;
        b=XcaLHxgyidntXUvzNa1qRyxKEE4O0AG8smjjjp+uh2vrhFVwGt9uFYDNAesjiQjwNy
         WpVS+waPgleDiTb5umUv4zr8E/uQK+n4XiwcJtPMf2+MNjTm1/ZXxZEXCHj4xHPPW1Em
         cvDcwF4E677cAilZ8zd9mWbe6TOjryl/SkyDAR6X4GFwHHuT5WKFYtAXWfRtAo6E6SzN
         XcaOh5vixp/Q/i/qNil5JhK6Rhi6k7hyEpt66O1AyU8fWWUrYWDjZnR4qc/MLpvoRhdh
         nLXq63ofwvfPFo3e6fMEbtRZmfWDLOzShi0wF+YngyJDUO7pzbvde8Pim/W+GF7jn1P1
         mKsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784271099; x=1784875899;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9UY5ZnEeTRAKjye0Gd13pSYVq2II1CClrTvBqjd8pp4=;
        b=b6K0mAmJbTM/n/nz5zWHrIH/Vfswot+Sv9RUnnxyIn5ji+QbsJuPHOhw7FwMwjW6v7
         qW8Qa1R4jChpWcGS37KuRfWez5DTJ01niLm3R9q0EaSTg6xnJjOeKRMujrj+DH9oKqS6
         zRgDO5WwscvUPKeQcKZe2PMoAOxdt6VMl1bF1FnpTPxL5534zGjFoRlg97brRDJwse9D
         u8f/DHz/UEr77kFUJIF2DGYqjzliLXkLa5m2TtT3YGgweJYqPXQsk5oGwEZ6CQi40pFX
         5EI+MpHQNGH2cBOhrgUa4frokIkTKiK2Mh/qBSJb5N5Hn+t/v5Z9BBij2QaY7d0OJaxh
         +LlA==
X-Forwarded-Encrypted: i=1; AHgh+Roy0Ear7KTa8xDugchV4XKJeWAEjbytVnDmxJikTASR6fiUdP5AnhPo00IWK/+IfXlXbW6DlAQNXYo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQxlDNrSTi4o1UMd8Al2RmEqmgnsk6hsOfX/v6gvLHQpMxTLG5
	HY4Q+WjJ/VFwhdS7U5LtLW4Nrg+5zTm7fOD1oe5ijq9s8POOZTT55W2Q
X-Gm-Gg: AfdE7cki/Ro6snJ9xDOtiGNK6WXcKYccFOjhjplMyJ+fBNoTmZ8a8SNYIAaxXpx0M8f
	Dwpjs6w9tg+KmwFCu6rK6wFMDTSJagiru7NQ7pQbaNdTlZLLMy2Fp+JxO8k2zsnxTR3Vrk85iVm
	X4hWDGdn9O+sdO7BUBWFa+Q76ir58qCo5Q/k8ILfZ12naER5Tu8jTflOP/XAnyG07z00eOkXuN9
	0mLhmVgdmJD2oox9Hdp015YaSUTwNXZACcHdPXfF+q2/mjMv2a/RKMULLlYCQap4h5SDzsNb230
	mVslYVH3HSAos/C7vTO6VWKmhM6wT+WoQygzH3R++nELE83QEUskiJgZDNVSdZuBE8XgW/4IVgA
	Ht4xG5qlF9iSciwcwuhvlE+Fjq8jjoJw7YSV76VrzjForwe1WoJUWqLZ2StFcOAeE0w+oIsu2tD
	OXmsrTMb7v8H4qRZbS0klNavButkoFlN+6U0sh0WoL8j6o/8ZVO4K973txuudROFKu6+6BmA8Ap
	LL/gQ==
X-Received: by 2002:a05:6000:4b14:b0:47e:aa3f:f822 with SMTP id ffacd0b85a97d-47f6233be35mr1797439f8f.53.1784271098535;
        Thu, 16 Jul 2026 23:51:38 -0700 (PDT)
Received: from RDEALENC-L01.ad.analog.com (24.206.116.103.netskope-rdns.com. [24.206.116.103])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f63e49acesm1136427f8f.6.2026.07.16.23.51.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 23:51:37 -0700 (PDT)
From: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
X-Google-Original-From: Rodrigo Alencar <rodrigo.alencar@analog.com>
Date: Fri, 17 Jul 2026 07:51:35 +0100
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Michael Auchter <michael.auchter@ni.com>, linux@analog.com, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, Michael Hennerich <Michael.Hennerich@analog.com>, 
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, sashiko-bot@kernel.org
Subject: Re: [PATCH v8 2/8] iio: dac: ad5686: missing NULL check on match data
Message-ID: <ondynh4kmchzugk2l24klamrcaje3qxnhgiks7gnc46wwwvo35@hysk2zaimb2e>
References: <20260716-ad5686-new-features-v8-0-ebb0051af5e5@analog.com>
 <20260716-ad5686-new-features-v8-2-ebb0051af5e5@analog.com>
 <alkmAcDvSXr_COc_@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alkmAcDvSXr_COc_@ashevche-desk.local>

On 16/07/26 21:42, Andy Shevchenko wrote:
> On Thu, Jul 16, 2026 at 01:14:18PM +0100, Rodrigo Alencar via B4 Relay wrote:
> 
> > Verify that chip_info pointer is not NULL. If a user binds the driver
> > using driver_override via sysfs with a device name not present in the
> > id_table or of_match_table, match data will be NULL.
> 
> ...
> 
> >  	struct iio_dev *indio_dev;
> >  	int ret, i;
> 
> 
> Move an assignment here as well.
> 
> 	chip_info = ...

assignment? this is an input param validation

> 
> > +	if (!chip_info)
> > +		return -ENODEV;

-- 
Kind regards,

Rodrigo Alencar
