Received: from mail-yx2-f42.google.com (mail-yx2-f42.google.com [74.125.224.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45EFF34CFC2
	for <linux-iio@vger.kernel.org>; Mon, 21 Sep 2026 04:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789964474; cv=none; b=d3TzjqgGX6lLo+rudWTEhIrOLrtcPWqZgShaYRDXvkAs5Bz/UD+7xv4TuHTEN2232xJVwh62u9WY612fa5IGm4UKbkWs6b3mbO6PVAyQQWHXWT1Vaelvu4Zpb6fqmrxU0p7JGTGhsJGYNR+u2iGqjvDUm+ZEgQCDMdDg0rpxDZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789964474; c=relaxed/simple;
	bh=P4g9wk0r+w0bkacik7EVO4K1hKVv0sivx3BRd2XSMF8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bzYuC8q8EoIDSNJNAMuNuf5x8UkmhGd7lsmtWlfe02dcwC9K/UkRJ2N0UvGrDo3TDEUj/OM45K+vyvb7LuCAQCpI00iJJ0OVIgXmQ2JYRYhWk+lzdrjbMH10pK9BG0UVhrFhIeCXVgWGWc2Pr8JMqdx7yLuJ755U981BKsw2HlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fL9ov4Ul; arc=none smtp.client-ip=74.125.224.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fL9ov4Ul"
Received: by mail-yx2-f42.google.com with SMTP id 00721157ae682-89666ee9b3bso14593467b3.0
        for <linux-iio@vger.kernel.org>; Sun, 20 Sep 2026 21:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789964472; x=1790569272; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xQ0elthYnoZqHxAMp2dBpGepvqv2PKVVkk0yksLm1/o=;
        b=fL9ov4Ulfyn2XFcj4T1WWuw+8E14TK9Eo6osoTvhRwZ336xAuo4MVWaCe36CRzGSFt
         6y9k28Bz8mVxOhzmI773OBs5a5RkB1sxQ6Vx866kMNw8oyg5JdQp0M1m8M6v9WJG3Mf0
         jcPLLbzT525+2/ctquQRqzutXC1ElP88DUMvaWzNwdjk6gAnG2om3gQx5xm+IOvYY/mh
         oQo5hKfwp6DFSMTAnynKXEXkJ1gRUseq5m4g7ZOt2nah9NO62UunFFeO22GHFOnwXWH+
         KeRzNpk8QQTTaspFyv0zkclSBtpJhbggcyq2kYWHiRAarigGsTMHTQ0TzMertUbXJk65
         EWnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789964472; x=1790569272;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xQ0elthYnoZqHxAMp2dBpGepvqv2PKVVkk0yksLm1/o=;
        b=1IgaYIe2pxlGjxQWw1j++N8BQtpNsiFXBa2ssu3w+c5+jTthfcAm+7jeXdig1RbkqL
         AcCGCO0+pjI3t3mazfdXNusVPaVfLVS7t8QEueFj/lvJ+0ziyxXWD29PR7UZYOAOuFYm
         guvUzA/z9kU8oI3RpLPFgRbRGzQu+eoG6+gJAWtPboiDVAF5FLnWI8W/OTymAhOo8oYC
         ub05U3eQ/6HwD8ViTgYu4Wt5KnIK7CIiPg4XE0k1VX5Z87iKqgB6VU6bBK4ctoQ9E3RB
         lyYKYRaDLzxx+x+dqgJ+te7Zz10i9N4FXIGlsb1WjnzbGGSxrwDFZ6YTdX43Ghx7a0iH
         mnKw==
X-Forwarded-Encrypted: i=1; AKwUvBzP0x5BqQZ+/2BYCCNtJAijHdF4808C/ppY5mf3Rh7W7FViFGezSIxsvWRrN4yNwY9XC7opK3Vx4g4=@vger.kernel.org
X-Gm-Message-State: AFuF++nAKjlY3Zd4x/xajKVe5KuVssol35YGEF5Uq6s49RhaBcd8LoUJ
	xwiITf6dOsLb3NfY1K2idDaPe21yUFvX5ilqZdFI6+/b4uQzN79iz/Z3
X-Gm-Gg: AYBFou1p/CBYCyO88YSm7UP/Ilymu4WZnVf8QgCH6zX3NH3GmbZyBogCkBL1PCVQrAG
	KT13749gES6chvLSkaH8W/KR3QT71zdjgET6ncHJlDT/hEHCK1lL+SuejlO6C0NC/LTNWVgUrkC
	BaZaBwAqUn5NJPF5gFijqi13kZwLqhsvdrDmh5Vpwe0L/qrsuEot5Fjn9QzgSma6Fc79ZtGiDMM
	EQOHsTbRDxbe7BPh+/4xOtfmtda/Vnhg17u1txGKs0Jm5eees9vfc+zMqMIHzerRAZDS3avBKZ1
	GWd3uy2nNtfxrCC8S3yX8iumMD3eSA0pCC5rju6blxi9UJ9nPd42NehSdY+YoQyqd1ZY1CzbFy+
	gadew7W7/kP9BcDPLp2WNmXtwYhq/1CNDvRq2zx0b1xwm71qj8jZBo2AeOuJPQ2d1EYpFxmLjBn
	5lvTTYdIw3/7SaIdqshl+a4py0iFV9cgnUqZcCgYT88B6EjaksEqSDTi0HaL4nc/FN
X-Received: by 2002:a05:690c:f05:b0:89a:63da:cbde with SMTP id 00721157ae682-89a63dacce0mr24128807b3.36.1789964472278;
        Sun, 20 Sep 2026 21:21:12 -0700 (PDT)
Received: from gmail.com ([2600:1700:5431:250::3e])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-89a48aa9036sm21828867b3.44.2026.09.20.21.21.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2026 21:21:10 -0700 (PDT)
Date: Sun, 20 Sep 2026 21:21:08 -0700
From: Chang Yu <marcus.yu.56@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Chang Yu <marcus.yu.56@gmail.com>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shi Hao <i.shihao.999@gmail.com>,
	Joshua Crofts <joshua.crofts1@gmail.com>,
	"Jose A. Perez de Azpillaga" <azpijr@gmail.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/2] iio: light: add AS7343 multi-spectral sensor
 driver
Message-ID: <arCwtKsOW4iTimCO@gmail.com>
References: <20260919235145.48273-1-marcus.yu.56@gmail.com>
 <20260919235145.48273-3-marcus.yu.56@gmail.com>
 <178986397173.706584.14464234266525982696.b4-review@b4>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <178986397173.706584.14464234266525982696.b4-review@b4>

On Sun, Sep 20, 2026 at 01:26:11AM +0100, Jonathan Cameron wrote:
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
> > 
> > Datasheet: https://look.ams-osram.com/m/5f2d27fff9a874d2/original/AS7343-14-Channel-Multi-Spectral-Sensor.pdf
> > Signed-off-by: Chang Yu <marcus.yu.56@gmail.com>
> 
> FWIW I believe the sashiko feedback autosuspend is incorrect, but
> probably good to sanity check that by proving device and just checking
> the calls in dd.c are sufficient to put it to sleep after the auto
> suspend time.
> 
Yep. Did a quick test on hardware. Autosuspend kicks in correctly
without any user space initiated reads.

