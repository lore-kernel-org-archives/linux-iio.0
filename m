Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F402A38424B
	for <linux-iio@vger.kernel.org>; Fri, 24 Apr 2026 08:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777018122; cv=none; b=dLhOTQ1/gfGL1Kj4xRd0opOA/nLpW9ZuAWlfEuXVUN8VzEO6uWmKXT6goJrUnqjT4eVw4IwxS/aBs5DqX3sXu/CBIynNcyAozzOg5VtIcFlaQlm4PWGdHTSzcJbtFbHwyvkv/I5LFuwjTC7twm7JG2DhhV9XSVqbLebfwRDWTIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777018122; c=relaxed/simple;
	bh=7FiijmYu3Dj8mlC564v1KV2nBi9KBlwe5DUSdSCtYYc=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JXTBDCr6txp60FLltz5+w2iVqF6mtq21H6brb5kkDRMnuHIU0DzmprhLRhT5yIL7JoPiVu2BcAzQaldu4AdCXXMcAvnzRc3fJcZIsAiDQtcKvN2NGHuSQ2xaaTdQmNeZBo+T2ZUNyjp9cbFLyLSdNEG2dijKnMDqXFTon3Bl7eI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UJ38r0Kx; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UJ38r0Kx"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4852a9c6309so69421475e9.0
        for <linux-iio@vger.kernel.org>; Fri, 24 Apr 2026 01:08:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777018118; x=1777622918; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qyquCGe5ofz0hi3dMWSPP6IFFimcOu7be/w7dUl/RaE=;
        b=UJ38r0Kx7SEdEShhcakqmlL9+v5z+oG5vq50iW1JlKxQQXQQ4RpUPhjJKUv0s+K4US
         hsI+zIl98wSflLz1EoWNlwD+iifrIqlv6Pf0kvQZ0goZhNRc8Ftl2J48NGTUdsruwbm6
         KPV4sRYa4fKdsWcBHV5DlsV9L53DIwmIetEEPAj60L172ljUVIt6GJueakiJQSlCM09u
         soVBbHll8XNBhzOZT9czd2BwCTVFNJ8CLm4uR7uFM0K7HSvuym4jW6mXg9EQxpV4dj+g
         3+lgCaHN1ZgUnKO93Ydjwewy7sOYY8y99YliOOxtxkGhUJ51PBBWsCrxkVD/MAaozOfi
         xsOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777018118; x=1777622918;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qyquCGe5ofz0hi3dMWSPP6IFFimcOu7be/w7dUl/RaE=;
        b=i9QDYW9wl+BwBNxIxh85GNa9wGSa/aQltjhY3oE9l/awz3kFXmOaJjGEkO3RDhnGgb
         wUgdlGv3XP11QzFa9wtq+pj9LCbUgIQ1h4XaUqtuhAuG4RA6OnBcxurg+G7HLXbTrnnI
         ySPZvwl0Wp8DEEkP7TADW8/ycjVvjpes4ceMJXQBlr/sm6xcm/hVhVPyClZmLUz1qOzt
         /c3WIG5mk5+9ze2YjhPYpnIpBXGb/e7Ho6G5NwZuNorCRdQiTci1cjKcE/0Elom9/k2n
         X9G9zOO1+IWpm7UDLrDgwIYJnnzubtuNVV5o4PS/WCGb+oolFyLA3KHd/Y87AGbHZ0EF
         Jn+A==
X-Forwarded-Encrypted: i=1; AFNElJ+khUTVySpwkROFhgjOMC6MvX08lvcDL9GuFtrUxuvlZD9WzXbjEdxv5TVxujUICeAKH4KwIQ+S+mY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwG3l9hO8rg8duXr2u+l4T45WwAVbqHsz0ct5fntp7qMbGsJlB3
	9q+49/I8kPMXFRbMrQqMttysjs1owDpt08coCrQc27nj3tCaWzFO7YGX8UNRtYxC
X-Gm-Gg: AeBDies6Umr2sZaTCj7WPCmeNlvetFIGDvls8doSUOsL3F5ToEMlutbhM1CYwV1BK9B
	9M2xpw7SnR3WCBhKFIRLX+oe3o59Vg5Zj/f7YXtDkD8dun9X0HWZMKboO7qlKKBoB6yXS3UrVK4
	nytAUeJAOShFicZSCvonXO5vs2b7CikYrWVUP3ixZH/ndYmA7dx1rXVAecWlxnmdm1Uu7G4+Sec
	vHrX9SXsZvNzKFXQsenEgfD3TfFYxT5yFcv9HObFSdZIQVfF/BAiuxsl3YGNv0ERD10S+n/TLtP
	VE08/3EmZxa1nwwmxtPxPXx1H5YdAAOny9aPmvd5ve2To6QXoJ31Jkzt/YOFf8m3pqwumqaI9+N
	aRvqUUzuo/5bBeFxNX2Fdkm0yx3+RghGC0y2LvDnw6OpJnxMRAwXBqntWWIx9lExo7GqX8x6gHu
	/VfQV6evzeOH0RF3VuDh7NjJ5xqiKlnl/N0rYhVDqcJI/gYfsaV8ktQw1MrOxChw75RD3dOk+rH
	+JwN+PmjgfSKbETEb9wV988928HfucObxGsWT8rJKP9zR6qiHtiVcFxu5jZCQ==
X-Received: by 2002:a05:600c:3006:b0:487:1108:48b8 with SMTP id 5b1f17b1804b1-488fb739f86mr239225625e9.2.1777018118104;
        Fri, 24 Apr 2026 01:08:38 -0700 (PDT)
Received: from RDEALENC-L01.ad.analog.com (24.206.116.103.netskope-rdns.com. [24.206.116.103])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fc18bccfsm521542255e9.8.2026.04.24.01.08.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2026 01:08:37 -0700 (PDT)
From: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
X-Google-Original-From: Rodrigo Alencar <rdealenc@rdealenc-l01.ad.analog.com>
Date: Fri, 24 Apr 2026 09:08:30 +0100
To: Jonathan Cameron <jic23@kernel.org>, 
	Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Cc: rodrigo.alencar@analog.com, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Michael Auchter <michael.auchter@ni.com>, linux-hardening@vger.kernel.org, 
	Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>
Subject: Re: [PATCH 14/22] iio: dac: ad5686: add support for missing power
 supplies
Message-ID: <mr2roj56empkjsfmeptr4iemblzca4myxohcieobk7bx5ikpy4@5a2j52x7x7lo>
References: <20260422-ad5313r-iio-support-v1-0-ed7dca001d1b@analog.com>
 <20260422-ad5313r-iio-support-v1-14-ed7dca001d1b@analog.com>
 <20260423190524.12ef4acb@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260423190524.12ef4acb@jic23-huawei>

On 26/04/23 07:05PM, Jonathan Cameron wrote:
> On Wed, 22 Apr 2026 15:45:48 +0100
> Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org> wrote:
> 
> > From: Rodrigo Alencar <rodrigo.alencar@analog.com>
> > 
> > Get optional regulators for vdd, vlogic and vref input power pins. vdd is
> > the input power supply, while vlogic powers the digital side. vref is
> > replacing vcc, which is being deprecated, but still supported. The value
> > of vref_mv is checked so that a device without internal voltage reference
> > cannot proceed without an explicit supply. Error report uses
> > dev_err_probe(), which helps debugging an init issue.

...

> > -	ret = devm_regulator_get_enable_read_voltage(dev, "vcc");
> > +	ret = devm_regulator_get_enable_optional(dev, "vdd");
> > +	if (ret && ret != -ENODEV)
> > +		return dev_err_probe(dev, ret, "failed to enable vdd supply\n");
> vdd is very rarely optional.  Can we not rely on the stub regulator
> that will be provided if there isn't one in DT?

Corret, vdd should not be optional, but I havent made it required in the dt-binding
doc. Should I be concerned on breaking existing dts in the driver implementation?

> > +
> > +	ret = devm_regulator_get_enable_optional(dev, "vlogic");
> Also doesn't sound very optional.

The same way, that is not required in the dt-binding doc. Also, there are different
packaging for the same device, on which vlogic is internally connected to vdd and only
vdd is exposed. Some board designs may also do the same externally.

> > +	if (ret && ret != -ENODEV)
> > +		return dev_err_probe(dev, ret, "failed to enable vlogic supply\n");
> > +
> > +	ret = devm_regulator_get_enable_read_voltage(dev, "vref");
> > +	if (ret == -ENODEV) /* vcc-supply is deprecated, but supported still */
> > +		ret = devm_regulator_get_enable_read_voltage(dev, "vcc");
> >  	if (ret < 0 && ret != -ENODEV)
> > -		return ret;
> > +		return dev_err_probe(dev, ret, "failed to read vref voltage\n");
> >  

-- 
Kind regards,

Rodrigo Alencar
