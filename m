Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 313672ECEAE
	for <linux-iio@vger.kernel.org>; Tue, 28 Apr 2026 08:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777365534; cv=none; b=EEfMkgTeoLONuYMBA0/X9edO8ESEfete/LbVeOczXh4t7DhCcqEIHlmEJt0k9Ad0Pm3jZXUNdxVLLi2RIdAZMghii5WnjKAD1T34pwnxZ+Z8Q9Eb3OthRlbE+QvlB8b1oeLCDCUzHKXy8J6YfizY9UUX/gCrtqBTE9Ib3JGepgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777365534; c=relaxed/simple;
	bh=i8cNe2bFSrRhvGyMu+xJd0eiViOt25sRua9gg/gI+RU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QM8zldbbZkgkTLmz6QwRFAo2ZIzU92nFVtt/ledAlS00pZlp6WlEVodJ9yJbK2T9sye8RuTJPS7AX5qs0NMKjCgMKt+cAhnpZ6uC1VNyYVEnzbgJ00mpLCDqFImXsAtMQD06dnCL2b0joB/8+PpWw45NveUAxylOQPo/b21cjec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T+Tm+6q8; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T+Tm+6q8"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-488b0e1b870so189889425e9.2
        for <linux-iio@vger.kernel.org>; Tue, 28 Apr 2026 01:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777365532; x=1777970332; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WC7zZ8VAa3K/6Sv1hAwfns6FqrYF808SVAq5ZPB5JYI=;
        b=T+Tm+6q8O57pAbvKPFKPGCkgTL9lSL093uLS2ursxqQreFBln//6MAdk9NfImuLbjI
         wQn9c21Nq6i6c123fXakDO3bt3egPAhgccSVbjRzukUFDI2Yf61HveZY9LOyvUyd8j5z
         K+Gloa3l2d4FtTeXFIQq4eEJy09DU6V62iKpwE40w+H6q1pRlPXy6lO36FvfN4PL6678
         JAAnGyBLhpfXbu8RxnnvSBkQVUUlrq84aNYZQZ26YkfSzBF33V/A4i2lLpN1zqDGXH1m
         mQt5YhaW7UcRUIqdNj7qrB0PuPwN8Gpex0D0cQvK+sPhYIGE0610ji5/+ZGqGXCWYahc
         iLrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777365532; x=1777970332;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WC7zZ8VAa3K/6Sv1hAwfns6FqrYF808SVAq5ZPB5JYI=;
        b=PgOS8wUNQ8MoKj4CTZasf2NuE85ttEQcgsW3NEShogtbEMw+Q1O4ub12YdNHMDVo4E
         C+D09IwJUgLXP0v7586K0srtuQPPakK8B+zbrKaGLW1WcLoP7hVRBEGSlKBJSeKl6TMR
         xwhWe+CPGe2PyBzSWPVT/yvM/oMtQP2C/tk/n81boOAE0c8Zd0QXf2EY6GLXoZkFEt+U
         vXmEIvnyjNJ4wtuies4mKD+hT55yh+CpUDZ+g2dXzo7I/DvZt712Q6w9fTNWtq9D8fBa
         5UNPRBZYllcDL6JPtq14nmjrKGhe9kZO4WaDvyEqwigXmu/qVuQpaGCQlxFVnBGUpcdL
         eLUw==
X-Forwarded-Encrypted: i=1; AFNElJ8dV/jDtme9ImtytK8qpyUlOUX3gXqQ/A+FwcvA4SVJ3vEbvhR93beXsminwKtzMamxaIPaEFufOV8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+zpr8cxkfAQ4YRQVOwMb2+8z6iJ25cPvpDv7ROL/JkdKbuoGw
	GC18IiuguhM+1LYTEQGWjR2cTvE8iEaj/8ym00AZS3GAWEwYjIiAfNOZ
X-Gm-Gg: AeBDieujA3kf7fVLbtVAiowyFistITPmR3eshwYpcG/Zzv1J6UzUCLsPFZlV/0pClyp
	G5TuARfoItHRBksWfB0t5BxjDP0uTd26cC0/9rro+0aAgHpFAWXEiZhhlrcCl7d7DK9T3W3uxSs
	3BL1y6tdf4psC/AwVV0oNTiWudlGEAB0E7SVLpdL6089Mo5QW0+IpNJov+fihQrU+VAxB3i4/Fb
	D2RXG8Kq4avVMCscYIyEt6OdSsCXje7UWES+Om8wWtkkUHMp9nr9yX7qs1Oy57A9lzgDtLlHeF4
	jVViZw0a92aDnLbK9WGc47Pt1VRRiG5aZ8Tuw3/TTxueY56TORFNjPf9nLZnJMptsjB8Hof80g7
	xHSNtLY+UenuJu24CE6v5ykc2eUjaHg+ixdIOdaxB2n4e2kUsJbE0P5LmHlwj8ilG8BHt0mHp5d
	QnstoUf0wkIizQGh8G7VPi4VU=
X-Received: by 2002:a05:600c:8b2f:b0:485:3b9e:caa7 with SMTP id 5b1f17b1804b1-48a77b19d6fmr35263695e9.23.1777365531329;
        Tue, 28 Apr 2026 01:38:51 -0700 (PDT)
Received: from pc ([196.235.239.18])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a773b9b5dsm44928965e9.7.2026.04.28.01.38.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 01:38:50 -0700 (PDT)
Date: Tue, 28 Apr 2026 09:38:47 +0100
From: Salah Triki <salah.triki@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Crt Mori <cmo@melexis.com>, Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: mlx90614: fix missing GPIO direction return value
 checks
Message-ID: <afByF-0BV1szTbzE@pc>
References: <20260427215800.28082-1-salah.triki@gmail.com>
 <afBpBNLucHg25So0@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <afBpBNLucHg25So0@ashevche-desk.local>

On Tue, Apr 28, 2026 at 11:00:04AM +0300, Andy Shevchenko wrote:
> On Mon, Apr 27, 2026 at 10:58:00PM +0100, Salah Triki wrote:
> > The functions gpiod_direction_output() and gpiod_direction_input() can
> > fail, but their return values were previously ignored.
> > 
> > If an error occurs during the GPIO configuration, the function should
> > abort the wake-up sequence and return the error code. More importantly,
> > failing to check these values could lead to the I2C bus remaining
> > locked if an error occurs after i2c_lock_bus() is called.
> > 
> > Add return value checks and ensure the I2C bus is properly unlocked
> > via a goto label in case of failure.
> 
> ...
> 
> > -	gpiod_direction_output(data->wakeup_gpio, 0);
> > +
> > +	ret = gpiod_direction_output(data->wakeup_gpio, 0);
> > +	if (ret)
> > +		goto out_unlock;
> > +
> >  	msleep(chip_info->wakeup_delay_ms);
> > -	gpiod_direction_input(data->wakeup_gpio);
> > +
> > +	ret = gpiod_direction_input(data->wakeup_gpio);
> > +	if (ret)
> > +		goto out_unlock;
> 
> While technically it sounds correct, the potential problem here is that you may
> fail this in case CONFIG_GPIOLIB=n. Is this GPIO optional?
> What may happen if GPIO is not optional, but for some reason setting it fails?
> 
> TL;DR:
> I am not sure about this patch. At least I'm not comfortable to take it without
> testing on real HW.
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 

Thank you for your feedback. Since I don't have the physical hardware to 
perform the necessary tests and ensure there are no regressions, I agree
that it is safer to drop this patch. I don't want to risk breaking the 
driver for a minor cleanup.

Best regards,
--
Salah Triki
