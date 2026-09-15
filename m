Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 695B73CE0BB
	for <linux-iio@vger.kernel.org>; Tue, 15 Sep 2026 03:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789442386; cv=none; b=EJWqaVf6F0VrDbJVD0TocQlfWsValzgdlwULm+a4DFO2eirt713SuF6w3BWaZ9J22r0YXvYCTDgh6Vv4yk/m1DDgSEF6g1bS7tzqdgH5es6BUPPaibWVEDwSAf8ROMviPlkAnZpuApV+NAWcwUlDFAa38hIyVbrzkzT5dq7COa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789442386; c=relaxed/simple;
	bh=uwpZLoRLkNBT7PMqbNXrKU1bb9r6CwQZXLWmhP5sK6k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aTZBPv9rrhwn3ynMQ37lpJsrHsa4z3/GlPbn3AsCv48HhqomwyBl6mRijiKSEXC4R8rBTZ1Lktgqn/d2ObE2OditsFDA3svl2cw/U2KctJR+/HKcZge7QZJOJ7bcUpEtGgvJr/UIGQU/i+TZLLyMB9Fyv1eFpat0GKKQXoT9Zbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QlWbliUL; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QlWbliUL"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2caced6038eso5108725ad.0
        for <linux-iio@vger.kernel.org>; Mon, 14 Sep 2026 20:19:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789442384; x=1790047184; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=mJYv8oGmScEWJOhrPjRzRavFJv92CQ9kx+j15hB8nf0=;
        b=QlWbliUL1vu+wUXeVYwerqCHh6X+P1QyQQnzkF3jN64ctVILa9NvtjL5eJQEaf1ID+
         8YvMmAr6LjT5qXgC+TmY2QLGHff1xsp6FV+5o2yfLFCXOx90VCF2MZuuIEsO8PV7IgEX
         lgMZQ61Jy6ZZyvZzEIAFcqlhTfWAKVsZ63zL0yrNsf9x6/9g+f3iZU9zdtz88HTYBox6
         wdynRD79+1UuXPvP+S/p7oMBHNdoBeDEi0B4Zck5zWhBE94o4kDqQF0rrutmVoqkIYGt
         poKmXcXSCcO/RNy3os/FdCFbdOpE5ZEq7QGSuvWl0Amv9ztOxlbET+cQArjJSlvrBlSP
         mCFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789442384; x=1790047184;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mJYv8oGmScEWJOhrPjRzRavFJv92CQ9kx+j15hB8nf0=;
        b=0kHRGbaDuUHoo+SdMJkmbSsROvag21f154iezfw8+xBsyhLGbVOYqe7R3YquJAPsqf
         O4sp4aXr9uBPRJBAYG4hseAvo/zsL5wfbTwEp5CC+MVJa7zUiq2g2F4P8n08/vq8cbRc
         sZadlIgeWMGEiOzGT864tFFT97wHMPgEDur/ZGk6UhlhUzS3o37kyBwmxrnqrJowgBMz
         iV5+dZruNSwYrtaTRKeFu+fx5/QqaquwY0SEfizJZEBpCggRNA/MVRuGix3FSY92xyeS
         s4lSwGyJJqksDU5D9QzDRESFhVbx7svIFhCuw57+gxYTaO8z47eH9NenQQf1QBZh5OOq
         AIbg==
X-Forwarded-Encrypted: i=1; AKwUvBxJR9mTtjv/7zdRpmJtFG8ko/6xK2MLz9B3ldGFNru6Zrjxpa9YuPrq2LmYGlYSLbeqQJ2rDQaQV/E=@vger.kernel.org
X-Gm-Message-State: AFuF++kxZN7vDMw+K3YqfnLQ+hx93HNyrW6anhDNNjXlBrnjvSud7lcn
	sv+QTQPl4Lpla4TEeg83B0dONNVzResoovD+IUd6NSd5fUnZ2/YvwC7u
X-Gm-Gg: AYBFou2slzn+rBeok+bgtX2YZPFZ9M7nnYSN+tfkK+qyGSRpImo6aIGpo8wd1W21Ha7
	2ui/tXQVD8BvzuYwTFRLfNMtpZFXo0pXvEf7XYFGBzZ5msRzT0Gz7uN1N3kqQw0PyJjhaKxHc/6
	vCUfsUL1Oew/b7nx8Ct2bcigg1K+yP6nyHX4d1nW3dmtDbObkOFD+QeODKUy9vkfbvcl4EBABXi
	m0D3wALVEC5dumvNaRxvklffg9Uye5jq+l8JxLqpJxlE48MXGhps4D3OdcXyVgJbBQg34SefOUl
	a8wiIhxYhrOGs2p8MQa53atncTfzEc31qYzej4G09pxMn0xf9sdHhwf3z2S7mL+jeXzY52dAvYn
	iJInxBa35dJ1cHI3+2FONJctUb9n7DwxV4VpmQwP3UedYcUerVVVUXxuDTPPKmq3kSG+1EaPEt/
	D2m0xzuNW8yyqpYFGZfVN8MCVUhDS3Wg+6p/n6QEb1fdwmNoYLtBZseA==
X-Received: by 2002:a17:903:2446:b0:2d8:d4d2:d13a with SMTP id d9443c01a7336-2dd7655b5f3mr29130825ad.22.1789442384487;
        Mon, 14 Sep 2026 20:19:44 -0700 (PDT)
Received: from gmail.com ([2600:1700:5431:250::3e])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33ba4e9b359sm29297802eec.14.2026.09.14.20.19.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 20:19:43 -0700 (PDT)
Date: Mon, 14 Sep 2026 20:19:42 -0700
From: Chang Yu <marcus.yu.56@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Chang Yu <marcus.yu.56@gmail.com>, Andy Shevchenko <andy@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shi Hao <i.shihao.999@gmail.com>,
	"Jose A. Perez de Azpillaga" <azpijr@gmail.com>,
	Joshua Crofts <joshua.crofts1@gmail.com>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/2] dt-bindings: iio: light: add as7343
Message-ID: <aqi5TjKT8I2JqpVI@gmail.com>
References: <20260912013912.51887-1-marcus.yu.56@gmail.com>
 <20260912013912.51887-2-marcus.yu.56@gmail.com>
 <20260913015652.029475d2@jic23-hlaptop>
 <aqX90oniPRdsu5jp@gmail.com>
 <20260913035132.1fb50e6e@jic23-hlaptop>
 <aqYWbWoBYaDJA9h-@gmail.com>
 <20260913181457.4bb2ebbc@jic23-hlaptop>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260913181457.4bb2ebbc@jic23-hlaptop>

On Sun, Sep 13, 2026 at 06:14:57PM +0100, Jonathan Cameron wrote:
> On Sat, 12 Sep 2026 20:20:13 -0700
> Chang Yu <marcus.yu.56@gmail.com> wrote:
> 
> > On Sun, Sep 13, 2026 at 03:51:32AM +0100, Jonathan Cameron wrote:
> > > On Sat, 12 Sep 2026 18:35:14 -0700
> > > Chang Yu <marcus.yu.56@gmail.com> wrote:
> > >   
> > > > Hi Jonathan,
> > > > 
> > > > A quick comment inline.
> > > > 
> > > > On Sun, Sep 13, 2026 at 01:56:52AM +0100, Jonathan Cameron wrote:  
> > > > > On Fri, 11 Sep 2026 18:39:11 -0700
> > > > > Chang Yu <marcus.yu.56@gmail.com> wrote:
> > > > >     
> > > > > > +    description:
> > > > > > +      The driver current for the external LED connected to the LDR pin.
> > > > > > +    minimum: 4000
> > > > > > +    maximum: 258000
> > > > > > +    multipleOf: 2000
> > > > > > +    default: 12000
> > > > > > +
> > > > > > +  sync-gpios:
> > > > > > +    description: |
> > > > > > +      Optional GPIO pin that can be used either as a synchronization input to
> > > > > > +      start/stop measurement or as an external start/stop signal for
> > > > > > +      synchronizing with the connected LED.    
> > > > > 
> > > > > So the datasheet starts referring to using this for some level of sync
> > > > > but then only actually treats it as as a gpio (maybe I'm missing something).
> > > > > Any idea what that stuff about start/stop is talking about?
> > > > > 
> > > > > The only thing I can find about this is the device diagram in figure 13 that has the GPIO
> > > > > wired to the led driver and the automatic measurement engine.
> > > > >     
> > > > That's what I got from the datasheet as well. They don't describe how to
> > > > use the GPIO pin to perform synchronizations at all.
> > > > 
> > > > The adafruit arduino driver
> > > > (https://github.com/adafruit/Adafruit_AS7343/blob/main/Adafruit_AS7343.cpp)
> > > > is slightly more helpful - the GPIO in output mode signals when the
> > > > spectral measurement starts. Unfortunately no information about input
> > > > mode.  
> > > 
> > > There is no separate control?  If so we can't use it as a GPIO as whilst
> > > there is a control to set the state it will randomly get overwritten if
> > > we do such a read. So to me sounds like that is there for testing the
> > > connection and similar usecases only and we should not expose this as
> > > a GPIO. Maybe input is possible but that may also have side effects.
> > > So I'd be tempted to drop it from the binding - with some description
> > > of why it is not there in the patch description.
> > >   
> > 
> > Agreed. What does this mean for the LED then? For all intents and purposes
> > it's controlled by only 1 register. It may have some interactions with the
> > GPIO but since they are completely undocumented so we might as well consider
> > them non-existent. IMO it probably doesn't warrant a LED subnode and
> > led-max-microamp is enough. Maybe DT folks can also comment on that.
> 
> Agreed, given software is controlling the current we need that and there
> isn't a lot more we can do.  I guess you have the Adafruit board. Are the
> pins wired out so you can perhaps see what happens in practice?
> 

Luckily the adafruit board comes with an LED already wired to the pin. Some
quick testing shows the LED register (LED_ACT, LED_DRIVE) does work.
Unfortunately the GPIO remains a mystery but I guess that's the best I can
do for now.
