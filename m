Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4C8A19CC0C
	for <linux-iio@vger.kernel.org>; Sun, 31 May 2026 17:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780249814; cv=none; b=OHzs7X6hAKDV7h1mSMmAtwYc4Bkco8be3YicpEEQwixwkfmIYhu8shfZiMoiPOX6Kzu1dNPzD7aPGWb1EOwYTWwMDGuE69XIC1ifHkG8hTWNsl1HQNr79z/iC58KTri3OCyptN5Zx5SaE98JU7VZDgHUFVkRmf56BITt1fFsrYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780249814; c=relaxed/simple;
	bh=Ie0tdeKKKC/qHnGi11ij9dSjb3ov2da91DTC1L1Uk+s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZlUE4hExfBOO3472PTedgj8WuU1J37b9ZCxESmKXm1dFAghlYdKXBhVLBNvQnekYECxmVbxCs3yjY8TCGBW4DDFqZd76stCOkSx88DYKVOnzajOFlocV6LtFngBFU1Uhrgv5pOs0RGT/S/GeeduffIHfbdw101uyxN7L8fOaqDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h1mrxMoL; arc=none smtp.client-ip=209.85.221.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h1mrxMoL"
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-59e2b96e3d3so590396e0c.2
        for <linux-iio@vger.kernel.org>; Sun, 31 May 2026 10:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780249812; x=1780854612; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6aOFqOE0+3SonSNESP6o8ztUwdkx135+fxitVMjtx9E=;
        b=h1mrxMoLAmQ2dO0cA4asbP/CzA6Cu7dCrACCVcda4AFRM6CgxFyaVJzh7cz7Jc0GbS
         gPLW4PF/75wN6UlMT2MnZPOSCb+SqPtgWhEPEiZJha4reZOY+uTDESmdDD7RJzd0/o/t
         3emzwO0deCWK7HySUmYcLKDo6Ck7KdsmSGEKloly5Q5adYoY5kyLDhAPvQPhBPrawXF1
         QmzJePN1Z5wNuU6RE6Oo1oj9eL30KorW8IuUpLfD8DrQlTDmHf80wXn+YGPrs7MoJpgl
         Vgw4NyjsWWIUuc8Oi2YBkhZlZjmHdQ0ffh30BgdePwpB92EYcnWoQ/0fS43JCNH7smMY
         Btcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780249812; x=1780854612;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6aOFqOE0+3SonSNESP6o8ztUwdkx135+fxitVMjtx9E=;
        b=C+h8cD6i1Zz6DKHyhHDmSR9WumhqI6b0pVm3EbUzZUjuBb0s2DV3yObo76WK35g2iC
         HjfE7e9AygiXG/wUyIT2DkASGH15RS4TOGuudS7VIQVuMX+D2ZT35TpTcW0MILq4rm0u
         KB/LrzMSKJnzMWysYW+f8ovV6qxg9YZFBqEF68/KxGbr4K8zm4LruOHL/BgmMU7AX/2+
         JN+alChdoWg1KtFzUE/iz9Z5phJK8NqRlOancjhXsi1ON7Ag8nWxolmH1PzBfZ3qSykj
         uBy01dqPmi8bCRWJxf9HUiqP1E2zEyqjpOyydtVn1yerUPPVgdbCn8Xng/aw9FLO78CE
         fWBg==
X-Forwarded-Encrypted: i=1; AFNElJ/zhw1+e4h/e3IzfuvYQk1YZw2Einr39wHLksSi4qrDQQtoKpFy49XcPDwA9Edhi7NWM6muDO1CRGU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx117zim04KbW5U2Ll3lqbHoRlI+qtNDHrGtRpYiUMj32HsqC/e
	lhZBZbRiEIDa2j2IDFn6GzEmayWyb0QXcDWf5V8/LITrrcyTh4EIxSEw
X-Gm-Gg: Acq92OG7Tw/w/WoADqNusFV9woOru372r2FSvv+zFyJGkteHEw7gx2VLHUmLN0MWIHa
	LMGSX5RfWwiW8HqEglkOtkdj1+BNPDzrH6jfPqcOy/80QWnsnwIv+B5DgTlF+xVnkFrnaCu6vlc
	WnC5M57zLYKO4ww+/slET0uiWaSeh+XM0VRa6knhM/fTUexL3Q1qsv5iELwRezjkKi43GPeTzlr
	BTdFIQlXkGwBBXj+PiJV6Ec8hR7bitbe89vChdhHcwKHRBYUz033dW6iV+yoblYEhOdHgeTPnP7
	pfd+XZbvo5KOV8Fg1QpEQ8jrNaR2buefXM/lMmKuhE+e4pbcHFzeUBONgSZhttQpm338vZUhyTi
	DHpuS7vykNwOTCs4eJqoVsckx/Ji5h/WzTfxg0TuabHEa/c8QNOMSD6p+87p9ZBUNSWbgTMOUTN
	PFXjQDYffHYMdQxdvwCa4UTYHftPnDGLNi7Q1rlI1Svrk=
X-Received: by 2002:a05:6122:6b8a:10b0:5a0:1bcb:acec with SMTP id 71dfb90a1353d-5a01bcbb86bmr611736e0c.13.1780249811860;
        Sun, 31 May 2026 10:50:11 -0700 (PDT)
Received: from localhost ([2804:30c:1f02:6000:8b59:7c96:762e:9faa])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-59b02af204esm4634282e0c.5.2026.05.31.10.50.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 May 2026 10:50:11 -0700 (PDT)
Date: Sun, 31 May 2026 14:50:33 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: Wadim Mueller <wafgo01@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Maxwell Doose <m32285159@gmail.com>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/3] dt-bindings: iio: flow: add Sensirion SLF3S
 liquid flow sensor
Message-ID: <ahx06cIPIoH4rQ3J@debian-BULLSEYE-live-builder-AMD64>
References: <20260530205435.37326-1-wafgo01@gmail.com>
 <20260530205435.37326-3-wafgo01@gmail.com>
 <ahxzpBcqN6o6q4a4@debian-BULLSEYE-live-builder-AMD64>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ahxzpBcqN6o6q4a4@debian-BULLSEYE-live-builder-AMD64>

...
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 06a8c7457..222a03b6d 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -24187,6 +24187,14 @@ S:	Maintained
> >  F:	Documentation/ABI/testing/sysfs-bus-iio-chemical-sgp40
> >  F:	drivers/iio/chemical/sgp40.c
> >  
> > +SENSIRION SLF3S LIQUID FLOW SENSOR DRIVER
> > +M:	Wadim Mueller <wafgo01@gmail.com>
> > +R:	Maxwell Doose <m32285159@gmail.com>
> > +L:	linux-iio@vger.kernel.org
> > +S:	Maintained
> > +F:	Documentation/devicetree/bindings/iio/flow/sensirion,slf3s.yaml
> > +F:	drivers/iio/flow/slf3s.c
> The driver file is added in patch 2 so the above line would be introduced in the
> second patch.
The patch adding the driver is actually patch number 3. Anyways, add the line
for the driver file only in the patch that adds that file to the kernel.

> 
> With the MAINTAINERS entry adjustment,
> Reviewed-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
