Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5F0A2D839C
	for <linux-iio@vger.kernel.org>; Wed,  3 Jun 2026 14:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780495843; cv=none; b=s4gWSnpc4DqfyMOuEgcZ7zr4KSHPkSGpW0owYyKkKpo1XA6qSomWSBDDSoC++4ShiVezsoHJ3+hYxE37eLhSOXL3+g5iSdqBs9TwrJ+XRf35KSQM6zIioJGfQw7SvmzhovQ0v2a6XMp2+QbuQXQz3RokTVXyuACGjdZf5q105as=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780495843; c=relaxed/simple;
	bh=Wsqebf9WrjFQdgwRqy5yFQGUTloZSCm7NH3pE60b+qA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fUs0VZ+mueVDc8UKDJ1/5IKMTY2+RLLpPgLKKfLosPgZQLH7yUsn4PvyrLMd1Eg7IanlKD1vnexBySplF3xPF+ehtdxziASkNRCx06Wnqn9Rel5+JuNi3uN70DclnGmnHTwXmkOftdSqracA1swQX7I10bREG9byAYbtaTEcIBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P6mX16lC; arc=none smtp.client-ip=74.125.82.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P6mX16lC"
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-304545f5206so17291640eec.0
        for <linux-iio@vger.kernel.org>; Wed, 03 Jun 2026 07:10:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780495841; x=1781100641; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=W+Nsk+vqXIyBd7fxqKZqUNL8HC5XArruDYOxkLJDrxI=;
        b=P6mX16lC9WYAN6OdLoY3aojdeY8rapdYV029YnqCmvlCD60P4ttZIDWxgYobZm1IqZ
         ZZs56eCfrzAkbv5TmUpG25ZmJB7bWgNiwxyKuQn0fEbAnTQ6qRpNzpbLQQ/IH40Jy3dg
         cFyFx91vE1+ggtwqJHolc15JZz0DN2ZiZLkEY44auMWte0HqBTjNwmUKW6UBrDSgVBoN
         2y3kY0o4ofm7kWapIEco+yZRExSZVux8Ho4xcMI472tVQ27WiiffcxgvmylTmhGfGt6+
         Q/ZSuEtXy418QT+7psPHbvzz4uskYOw5i0WyVe7dWUpmCmuoITlryH5UAjW2FkRN+HGw
         L0Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780495841; x=1781100641;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W+Nsk+vqXIyBd7fxqKZqUNL8HC5XArruDYOxkLJDrxI=;
        b=qNChjJKhSpCfOvHeYJoG7Lp/wWF3ffdvYOG5ZtmhYKOv/P3+CXsEQOUIY6VpI21mVx
         TjesI/30rse+3ndbptl5S+PsN/SKj2y2uVboAK6Y/R7X3hJIBtrEDZe20gfNC4HInSWE
         LsPPwm/GwX+Y7fh2popFAWfdH0asMxjNEt0RbFeM/NBkEW7kgs8Hz2OIGm6L9eYDrY2c
         yN+4nUTPFdTugeosFJgujoGIQ14q9Qbk10G1fbMGkNOg19oVNop5n5+WCkm5e/JHJcNJ
         mbvz9TRG2mAd7Cj42BsR0ibbzOpJkoEnlte8wm04i0FQOkTmNdsncgOXHRKawRvpPGD+
         V+2w==
X-Forwarded-Encrypted: i=1; AFNElJ9YfK19XFWMyocPXOMtUP2o1cHsIQ1nxkVeTPjCTtKMDxTafh0Ub+r7TgxqDyCHSCW5WHmWlU73Bo0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIau21jn941J5voubjinPMjN2GVpyTJ8Fj9TN2zJgfj4IycTE2
	sv7wQ8c3XY6a8QOz/syyLvmLYs7Oql/IjJxttFldrBjdeRvUaCitdagf
X-Gm-Gg: Acq92OGIQ59uMtU48l87a4q8jH47jaTPBDvEua/ysFpowE4BklaEwmECrplFKjarMvC
	NZ8bu86jou8nRoU/mscWpSjrPLvIv9x2xJuP6f+UlOhSe+KfdzChrxsDHx8OUr7PkkcYwv2O49V
	tPN/hW59IRg+UUpkUjqTm396GR6sexEa5St+QnezRzk62lVl9oTrJo855me1IVO8kcuEdGZ4RFq
	C+fl3jFET81YzScks3w5HmPdvqN7pFdnRr3UR8u/ogtLRRRlTMrYimzQnmVORynWe/WmFcETBCN
	gTLnLN2fKjx/k9lqEacm1O0i+IvK6xeMAAxGbt4pCSd5hAYIC4I6HJeVbwAB/VQyDFrzskdBAp8
	+YgWjhGtyagA4o0nU7m4GsrWAmeoQZ6u6yB7SRRPOhcj4KgLNaLsRkp+yLT+vzzu2phm8q/Wnsc
	1e9Kd/XkGSIfaHD9hyNei+N9glruFuVrcvnB1RcrUdfAZRAWGMEXo1vg==
X-Received: by 2002:a05:693c:25c4:b0:304:cc9c:35ae with SMTP id 5a478bee46e88-3074fa3b7abmr1608250eec.4.1780495840722;
        Wed, 03 Jun 2026 07:10:40 -0700 (PDT)
Received: from localhost ([2804:30c:1f02:6000:8b59:7c96:762e:9faa])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3074db525a1sm2453217eec.1.2026.06.03.07.10.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 07:10:39 -0700 (PDT)
Date: Wed, 3 Jun 2026 11:11:06 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Marcelo Schmitt <marcelo.schmitt@analog.com>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	jic23@kernel.org, nuno.sa@analog.com, Michael.Hennerich@analog.com,
	dlechner@baylibre.com, andy@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, pop.ioan-daniel@analog.com
Subject: Re: [PATCH v2 0/4] iio: adc: Add support for LTC2378 and similar ADCs
Message-ID: <aiA1-tAnRjYQu2EO@debian-BULLSEYE-live-builder-AMD64>
References: <cover.1779976379.git.marcelo.schmitt@analog.com>
 <ah_e4ovBsXQ-BVcw@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ah_e4ovBsXQ-BVcw@ashevche-desk.local>

On 06/03, Andy Shevchenko wrote:
> On Thu, May 28, 2026 at 12:02:53PM -0300, Marcelo Schmitt wrote:
> > This patch series adds support for LTC2378 and similar low noise, low power,
> > high speed, successive approximation register (SAR) ADCs. These ADCs are similar
> > among each other, varying mainly on the amount of precision bits, maximum sample
> > rate, and input configuration (either fully differential or pseudo-differential).
> > 
> > The initial support patch enables single-shot sample read with a GPIO connected
> > to the CNV pin.
> > 
> > The second support patch enables high-speed data captures with SPI offloading.
> > The setup is similar to AD4030, with a specialized PWM generator being used both
> > for SPI offload triggering and conversion start signaling.
> > 
> > The last support patch enables running buffered data captures without SPI offloading.
> > 
> > Some structures and variables are introduced earlier to reduce diff in latter patches.
> > 
> > The initial version of the LTC2378 driver was developed by Ioan-Daniel. Though,
> > despite of the many changes I made to the code, I've kept him as module author
> > to provide credit for his work.
> 
> No datasheet link, no explanation why the brand new driver is needed.
> No need to resend, just answer the above questions.

Hello Andy, thank you for having a look at this set.

In short, this new driver is needed for supporting LTC2378-20 and similar ADCs.
Even though these parts are somewhat similar to AD4000, the available HDL for
high speed sample rate mode is different and the wiring configuration is also
different. Because of that, I think cramming LTC2378 support into AD4000 driver
might not be a good idea. I'll add a note about that in v3 together with
datasheet links.

There are some good points that Jonathan and sashiko raised in v2 and I'm still
working out a solution for some of them. Will share a v3 after tackling out the
remaining issues.

Thanks,
Marcelo

> 
> > Link to v1: https://lore.kernel.org/linux-iio/cover.1779117444.git.marcelo.schmitt1@gmail.com/
> 
> -- 
> With Best Regards,
> Andy Shevchenko
