Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEA7B1E520A
	for <linux-iio@vger.kernel.org>; Tue, 27 Jan 2026 11:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769513916; cv=none; b=OBxxT+HgTmpERwYsXR8EWFqM5s3iSEEB8izz3AAIooAeQONwjOHi5/8HEgkFnC9psygel9nX6PNOCHg7++YK9q/zefTvOkbZHobd8kEbk3JBnY+WpJio6K+n766JM4mh9UP5HVnBvwMSfWATqAIICktOdwH1EJprqgGLyhuhEM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769513916; c=relaxed/simple;
	bh=3K9aBDr/ArfdtgOK1jMZcCRg52z6zlVpVc/LOShdI0w=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o5hZj2N4aiy7jxbfU2b4NZIvXRem3+ZZPmUovUuKBd7cL9+R/hOtju/j5Rou/4foIdqF+60yPNPxFjcjOsPZ0fwJb+AoFc4ukGe5UfVnWFZ3LTFWvW4Zo/5rGjZ8kCWYyr1J2PinGL0yObqk18k4l1AzP5rISKX//KTNjWet0Zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VeXTgXJK; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VeXTgXJK"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-47ff94b46afso48577465e9.1
        for <linux-iio@vger.kernel.org>; Tue, 27 Jan 2026 03:38:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769513913; x=1770118713; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AASlxAZ4aYaHvKBg73VpYx8embHwR8icb+WKnSC8l4A=;
        b=VeXTgXJKEOQZICQQnEWpueYYCwBUiIhJgU7y5bErDw+JS0lOYIOEucTgdh08TxhBVq
         +J/7H64ZXS7ISt9wlClbdwHG9BAinVChxTyFHeYBcQ/PTMLaGftGM0tHOu2r0lRCui9e
         k2sfvB/6bXl7/iyDdv+LURBou6/0LlsUqi/spFi1WPEZxb+0QkdIGl04YgQ6+qRd0dY2
         dV3oOn8vsykIZchwF2NBICS8yxrsbReEDdypDTgDwLy0jKxENVa8/76YX9IXgKVj4xsU
         jTRuwaaFXQR3bILjL0MdQHB5vY1JNzt19IYtz6jow+KB+3jOJJEJs0IYMOpdWVoE1JCC
         kFHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769513913; x=1770118713;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AASlxAZ4aYaHvKBg73VpYx8embHwR8icb+WKnSC8l4A=;
        b=Y9BUn/nA1dXhtYor1wjFNcvVwOVj5+prP7MoWHiBzP0BWzqEckbotwrIZ4E7g8C96n
         +DoRF1pgZLGItpqDGiTnwyGKbSuuFKCuLvUWk49/ii0XxLp494bmJStq07weZsYKw/c9
         0k1qgWFv6FtlR4WUp6zRwFtrz1Tn+MwNLQU4+2p3X7wuz+4Y1zp0ZA8IRU5LhFRXv7C0
         ej++dY/x4vQi57ckz9N6bh80XDVdhsKp8NF8PpsBxJ3heq1wkt6tBgwgNViOQ1YKpWaR
         sPEd0U0cTfOh4ldo3aUQnKNsTM8nxe1ZOgLjR3axdewKpNgfC9bQneDY2fYkAfLfxAM2
         utHw==
X-Forwarded-Encrypted: i=1; AJvYcCV687ENGJU7qsjEmaSryD0aTvVj5mLb/lHSIJY3EnwKTmZ6S5PVKoV1aidboquINWX2z58/suT195w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzpgcf9q/Mu7zm07RaBPx/i2MYOUetReiGDuHQ2uH7isVBOruvX
	AKD/o1RhFMana4FzQc9T2iiqWwSchP3zI6xHivReIRtL+iGlBeO7IM1H
X-Gm-Gg: AZuq6aJFhLS2iG42ofe3NUWhAuEK/lLRhLDkwZeaBspsHCJLvb5n+XbzN92tF51w2uR
	DqxOWg93AfL+IFF9o/vVbrlliyADx6Yt2ZCEsZbg2+AWYuYYWdRf+neB1mYP4OYEvzNKPNYHa3G
	c6ELL+Vg5cMYS/hZffvkUdFsap/z9hWbIa7ucqitX9qb94MzehJTsGsCaDsV4ovLPARxssOMB3Q
	EDtCMQskQvPHdoPt9pprLk2DUhuMobinT6dab/9TttRR+PpJ/FP8dfuPOLhxxeOGv3SjhvlP9Dh
	90pHJo4nolAQOMczvBtODT5RHntwyHZVWg+X4ZAsp7sBEH/+BQ7bxmv/quetOJhPcvvcQ37HD2s
	fvRd1SGRrud3uRuSouVIHXhs8KDWPdUh2prGlzzG6tIK20QV9zi2ImAKJ+qqAs+lxIYvnatEZgE
	kIfuPStVbqzqzm3PvDRkn8K/CJgP7vjZlWQmUxfAnwqCqjMxKtZHhk4Zt5SOdT4/Z3fTmfB7aJd
	GgQ
X-Received: by 2002:a05:600c:4587:b0:47d:403a:277 with SMTP id 5b1f17b1804b1-48069e24034mr18944385e9.4.1769513912960;
        Tue, 27 Jan 2026 03:38:32 -0800 (PST)
Received: from RDEALENC-L01.ad.analog.com ([24.206.116.131])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48066c428basm58082165e9.12.2026.01.27.03.38.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jan 2026 03:38:32 -0800 (PST)
From: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
X-Google-Original-From: Rodrigo Alencar <rdealenc@rdealenc-l01.ad.analog.com>
Date: Tue, 27 Jan 2026 11:37:52 +0000
To: Conor Dooley <conor@kernel.org>, rodrigo.alencar@analog.com
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, Michael Hennerich <Michael.Hennerich@analog.com>, 
	Lars-Peter Clausen <lars@metafoo.de>, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH v2 2/6] dt-bindings: iio: amplifiers: Add AD8366 support
Message-ID: <rzco2g6psoblzaaqrdnmpmhs44hl7kqusa2kuafpkjx635dug2@rtwebhwztfkd>
References: <20260126-iio-ad8366-update-v2-0-c9a4d31aeb01@analog.com>
 <20260126-iio-ad8366-update-v2-2-c9a4d31aeb01@analog.com>
 <20260126-porous-hurdle-bfc510f113bb@spud>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260126-porous-hurdle-bfc510f113bb@spud>

On 26/01/26 08:11PM, Conor Dooley wrote:
> On Mon, Jan 26, 2026 at 01:51:03PM +0000, Rodrigo Alencar via B4 Relay wrote:
> > From: Rodrigo Alencar <rodrigo.alencar@analog.com>
> > 
> > Add device tree binding documentation for amplifiers and digital
> > attenuators. This covers different device variants with similar
> > SPI control.

...

> > +properties:
> > +  compatible:
> > +    enum:
> > +      - adi,ad8366
> > +      - adi,ada4961
> > +      - adi,adl5240
> > +      - adi,adrf5720
> > +      - adi,adrf5730
> > +      - adi,adrf5731
> > +      - adi,hmc271a
> > +      - adi,hmc792a
> > +      - adi,hmc1018a
> > +      - adi,hmc1019a
> > +      - adi,hmc1119
> 
> Why do none of these devices use fallback compatibles? Please put the
> rationale in the commit message.

Will do. Each device has their own gain range/step. 

> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  vcc-supply:
> > +    description: Regulator that provides power to the device.
> > +
> > +  reset-gpios:
> > +    maxItems: 1
> > +
> > +  enable-gpios:
> > +    maxItems: 1
> 
> How come enable-gpios is optional? Is it optional on all devices?
> Do all devices support enable-gpios and/or reset-gpios?

Board designs often hardwire powerup or serial mode enable signals
to high voltage level, so there will not be a reason to add the
enable-gpio.
I went over the device datasheets and I could not find the
reason for the reset gpio. I left it there because it was being used
in the current driver implementation, and I would not like to
invalidate designs that might be currently using it. I will ask around.

-- 
Kind regards,

Rodrigo Alencar
