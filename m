Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B185B30F803
	for <linux-iio@vger.kernel.org>; Wed, 14 Oct 2026 03:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791947893; cv=none; b=KtdYAEEYAoOmjLg0bMuW+gqrLSxiNAfgaEdle4SAeUzLzzuzHGf7fpZBcw689XUJ+/ofjxmBlUQKqxUC46LP7hwKoWBtEBtbLEslWDH+H+SD3Gqy/mWFwNDPPfviGoZ5Q+vrZK2Us5O+BXNJzksMQjO0lmTUPzPHBJ0eiVbjffU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791947893; c=relaxed/simple;
	bh=BTWZgvMFDLsqE29q4K9SrpqPAwz/Ao9gpQ4HurHPP8U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ica0K5UDAx8rhDoXjS+YzMLBk7gl4bfCPwjWig8FcgfUxhfWfJcNzeG3nkj2YjpY7QXi5fu+uMxalt4tVaDGG2y6a8e1C4OWq4Jg05lboXxHEMW/9R65I1yxL598p5rkfBq37OnvVLbS0uhrvxb5OOzaCyXq22xhGt/wwHRuMoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VvqXcrS8; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VvqXcrS8"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-3856d6fbcb3so2130835a91.2
        for <linux-iio@vger.kernel.org>; Tue, 13 Oct 2026 20:18:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791947892; x=1792552692; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6PYUavPGXHain40lEWS6IBxjBfzIOfqYPMFChcw+Uek=;
        b=VvqXcrS8rTM8MhK6n3aOXX5kDdMJiCUAyE/1S9ATnLmDBvXYDDBuKOrcKAlvf+GsqQ
         gosTWGX3LRmk8X1FPNSZn+WqjyC6U7JDEOv0xJ34VVDKsWDxs9xf3Cz2lL+GdBOrTQP3
         MTJUjwI/leHuSI2s/PR83TjPeEiowFXCBLnSX/48vSAW2otlLuOREAyQhZEbNI9q3N4G
         WLP9DhCLArlh/t8c+9VkEkxFJEgeS+1mXO99Ox/+GYDxE8iL0WkkGcWMH/mwD3W4EC3V
         K0T0uu3wdFPLcl0iJWfenTjoFiciBPC0NNiJCXgqVnq65GwNJF4QwY8R5nmksA2UfWC3
         hELQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791947892; x=1792552692;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6PYUavPGXHain40lEWS6IBxjBfzIOfqYPMFChcw+Uek=;
        b=VUtOYzQ81Tdo3qC8rKF5iROmkW4BHkpzAizZSx8IzefHzRkTLAkyLJGXu1FJyTl49k
         b/0CjUxk+5N2Jv3fq9W1U3prLjZt4A9X4LhNhmf2oHS5s6HxEzMpBeHiiZGHUmvApkBU
         O88WxDs9XhIPwEu1A2xHWRl1F1HYkQVFZaMFe6x51qAPbyXOPoINImsr8pxtXc8Vn9Yp
         FFCmIpMn/O8tvyO5i9d7X94sZvE1AYk24ofc1A7EAPkS4aFddxlO9F7yrGn4XZ3lFupx
         ykvA/LnYk88PG/l0FvQk1vDfFxyQuxtaUkFpfR9cFkLSvTparyFRpzN9WPUPHLPjLOS2
         UeBQ==
X-Forwarded-Encrypted: i=1; AKwUvBxUa/tSG1dRYJxIf7MDpU+imDHjpTdt9jhkqvQyGOZaFQ4ReVy8+bFLa4jV1PJChjOXvIUV04MQMbs=@vger.kernel.org
X-Gm-Message-State: AFq9FYKLCAGIv54OrRKlhdHV3pX1VduPXjxG8+bGX+Y9v3i+R/Eu7+b6
	AGBXhXtjT50XrzOV211SRpuUAXCJHiII/G9+NkQHtHcx0Zbg/fauL33E
X-Gm-Gg: AYBFou1MgqtXqWWlrniESoUS7vRPCA8z+MPb/oTMhbH06QvOGOyj29df/mq+VsSUwL+
	wkg6rBh2d47Q/QwqEn15GctPRqJcZXFBCySwFs6hir1s90JSLUHWFN6mZzjDO7kU8ssog5QLkFt
	eZJ6Dc3LkjsxAX7Eqtm+eUWlm6pK0TGXeNGY/xxMZptYrC4PbX0tAw0eIFrVMfT8t3zEh7AjC4H
	TmpvEsi5h+n2VM+M/2Y+mepxNBtoZwanS9X92Vk48ug3V6xtgPS/ACz1zjzcZoAXmX2EVpe5AwN
	SXtdIjab6BQVt2zvuswJtmwN4Lu6RWRMh7iC96Ba7uvPdSTRTQv8o5q5c1P4Ft8qcjrOFGzbxD2
	1OqScf9U3/bKvYCoY80AQb6055qT1r+hD2zEVLpf5iL4mOICBDGj6EcwQNxxdNmgjB0irFUgS2L
	N0PhunZt6FEeBOIUz+cuuvpfEH2Cohek+6LHtrosM4FowsGVjmsTmku/SUhPn+DfiiDEa5NgZh
X-Received: by 2002:a17:90a:c10e:b0:3ab:2d17:51c8 with SMTP id 98e67ed59e1d1-3ab3a29028cmr12418582a91.8.1791947892009;
        Tue, 13 Oct 2026 20:18:12 -0700 (PDT)
Received: from localhost ([104.156.230.40])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ac5f280fecsm2365730a91.13.2026.10.13.20.18.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 20:18:10 -0700 (PDT)
Date: Wed, 14 Oct 2026 11:17:55 +0800
From: Chang Yu <marcus.yu.56@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Chang Yu <marcus.yu.56@gmail.com>, Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joshua Crofts <joshua.crofts1@gmail.com>,
	Shi Hao <i.shihao.999@gmail.com>,
	"Jose A. Perez de Azpillaga" <azpijr@gmail.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 2/2] iio: light: add AS7343 multi-spectral sensor
 driver
Message-ID: <as70Y0biw0XMjwL6@zephyrus-g14.localdomain>
References: <20261013115639.167433-1-marcus.yu.56@gmail.com>
 <20261013115639.167433-3-marcus.yu.56@gmail.com>
 <as5b_jzx5CG_UoZS@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <as5b_jzx5CG_UoZS@ashevche-desk.local>

On Tue, Oct 13, 2026 at 07:27:42PM +0300, Andy Shevchenko wrote:
> On Tue, Oct 13, 2026 at 07:56:39PM +0800, Chang Yu wrote:
> > Add a driver for the AMS AS7343 14-channel multi-spectral sensor.
> > 
> > The AS7343 is a 14-channel spectral sensor featuring 11 visible
> > channels, 1 near-infrared channel, 1 clear channel (VIS), and 1
> > flicker detection channel.
> > 
> > The driver exposes 12 spectral channels (11 visible light and 1
> > near-infrared) via sysfs. Runtime PM is implemented to stop
> > measurements when the device is suspended or torn down. Power is
> > never cut (PON=1 always) to preserve register values.
> > 
> > Future patches will add configurable gain and integration time,
> > interrupt support, buffered reads, VIS channel, and flicker
> > detection.
> 
> ...
> 
> > +/*
> > + * Integration time is calculated as (ATIME + 1) * ((ASTEP + 1) * 2.78us).
> > + * ATIME must be between 0 and 255, inclusive
> > + * ASTEP must be between 0 and 65534, inclusive
> 
> Haven't noticed before, but is it indeed 65534 and not 65535 here (or 255 and
> not 254 above)? Haven't checked datasheet, please double check.
> 
Per the datasheet 0 <= ASTEP <= 65534 (65535 was explicitly marked as "do not
use"), and since ASTEP = n - 1, we have 1 <= n <= 65535. Similary
0 <= ATIME <= 255, ATIME = step - 1, so 1 <= step <= 256.

So I think the numbers here are correct.
