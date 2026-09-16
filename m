Received: from mail-yx2-f12.google.com (mail-yx2-f12.google.com [74.125.224.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0161435839C
	for <linux-iio@vger.kernel.org>; Wed, 16 Sep 2026 04:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789531475; cv=none; b=sKEYMbHH9JkmBLXNYOQHuzxanoufjgjlc2xfVdnx+RXkpMaqT0vn7ihkdqi85lKKHg7FgBH/WDDmYNAaW961Lj6gyQsnme+57LC+ntsnNtiUgRAF2Wa0lSkDuHAfgCFiJwso6ejYT6DCzk3kWCMCcpyCbPy5EGHqv90FlL2OciE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789531475; c=relaxed/simple;
	bh=pFUGxOy07w0o07fjVXXzMtNN+/VmE3D4fzrpoP43jnM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JNmLkH4ie99yHX3gyJh4RE6SWKO0uyqrOpSfYGLkxubzku86QuDbW7Z+77HtBDP9uFHsJ+iVYJsbZqyT7JrdUyZweU7DXU4M8NAw9l0moqbs2HZScGh63kekD7U/mD9LjSbSTnnXU2BMyitx9P4GWW2E1sKBVugrIvL+p05EZsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lfeMDP2Z; arc=none smtp.client-ip=74.125.224.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lfeMDP2Z"
Received: by mail-yx2-f12.google.com with SMTP id 956f58d0204a3-66e4ab222dfso507087d50.0
        for <linux-iio@vger.kernel.org>; Tue, 15 Sep 2026 21:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789531473; x=1790136273; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=X7b6jjSFuw36SK7ohBBpAIm4B8ggMmh+imIFRF1b+cs=;
        b=lfeMDP2ZAzCfR0ysSNTzQrs7tQFS61YSzbeQkxI25xGpU33XyJ8JI6+HMhHAo+laZD
         M8xN1welHtzZGJsu910khF/QUsp1UsnJ12nujIRyB+MtXYI+V9csMJQxkyym9Zf9rIpg
         mOeeiPZA6BY2zwU296Nhm94F5p6sttFEn8opIhulxwMlt/OWeIpReiWdy9B6EihOEtrU
         jWFQiCP/rxTv7vloi1X4Ai2CFZjvNYIXVV4S/ZGQSu72Ydrj+KRqloJ7JAizYdze988d
         jhTZH9KVAKOIh+l9JosUoqOk4V5OGtoLPXYWDHmHmwIjan96unpqFAL8fll2t/ruNq5C
         +ZOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789531473; x=1790136273;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=X7b6jjSFuw36SK7ohBBpAIm4B8ggMmh+imIFRF1b+cs=;
        b=JgLQRoy6szx4woPJ9ZD4fFZPaWoLCrIZ47ztIt2NVD5Ysz8pKr3WSbagINVbnpMkqd
         k4+an8hXRu/1lrEuSQYHAmYxyKqkAJIc8jWBcJdJHClF3Pl1Q19FP4Xnlo/Iu8enA5L4
         mN9gmoZ6e06D0VAgUmwDwsrM8py78X10ZiymAZfQ7QFRFiM4pn6qTigSI4wzhpKbAZkV
         PBduuaj21us/apMaRvYiowCr5mBw2dNusLoSST1w8B1OuEORs1rPBt9sunavQ7EmP44W
         c6fhv5wSy4RxIUwycdEKWd9VP40ON3LbOQXFybcxdp2oqbo5a34ofqgTD3f/4mUr+X4G
         8yaw==
X-Forwarded-Encrypted: i=1; AKwUvBz2KjNerilMClQ3ho8fFK6Omxg+lr6u4eSzeN5xoWhnUoUnpaxjPp2IdnRzhdWIjZF8xpUw2vOBDAc=@vger.kernel.org
X-Gm-Message-State: AFuF++ll/wdAfFu4r4GCZgz9jTYA8Ijo03AQOFnl1BOSFMcrHj4gIHC8
	+NAmzf8Gcf/2ar7YEJ1C7ktSY6KdyQbnb54DFsqmb1EhbL8Ko5gxlK7S
X-Gm-Gg: AYBFou1FqgFS1fe/+MZmZLF9OEAUS+fqyFR13/yQ0DnnMhcSc2Z05BoGz+a/W15jQEf
	0+yFPbBTkty9y7Dg6XqwvKr556vug0oFhpv8r3rzsWfANh8/BUFkdjiH+qpEn/t/M+oRSuO2eS5
	U+oc4sv/WAlG+4FgifNIKQtvyDl3eUo3vdw5EipcSi3A/n0C9Tjp3YG8fhLeZr1gmDsl1TdkJo1
	773SrQPLXu9QlJy4LhWcogN0vh6yH9IxsAlERiPXV5JlCe+Amnm2H3zQDnuzP3EMxYyQKyursis
	IWOo70rQlIFLWubzKL2pGZ/Cl8i3YJFsqpIbmU3Bw923db4lIBi/k7RnA1Who32rtK3RolmVNvz
	I3cvuwwmimPMw7napaV0o/6PrMHSptSlVH3qiNEQG9HVXAPaFAt/CHcn/jsVlvT+/Uc5VqpwLn8
	f+UOmvrzLcAXzHfiiKMlPfuMimJfiZl23jYiNnbtGgzP4sNry0KZLhoGtipXBE8sV8
X-Received: by 2002:a05:690e:13cc:b0:670:f5bd:812f with SMTP id 956f58d0204a3-671632ceda8mr325747d50.82.1789531472721;
        Tue, 15 Sep 2026 21:04:32 -0700 (PDT)
Received: from gmail.com ([2600:1700:5431:250::3e])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6715f45f803sm831404d50.0.2026.09.15.21.04.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 21:04:31 -0700 (PDT)
Date: Tue, 15 Sep 2026 21:04:28 -0700
From: Chang Yu <marcus.yu.56@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Chang Yu <marcus.yu.56@gmail.com>, Andy Shevchenko <andy@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shi Hao <i.shihao.999@gmail.com>,
	"Jose A. Perez de Azpillaga" <azpijr@gmail.com>,
	Joshua Crofts <joshua.crofts1@gmail.com>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/2] iio: light: add AS7343 multi-spectral sensor
 driver
Message-ID: <aqoVTHzvDFkfVjcf@gmail.com>
References: <20260912013912.51887-1-marcus.yu.56@gmail.com>
 <20260912013912.51887-3-marcus.yu.56@gmail.com>
 <aqepkmQS_p6K1Bd6@ashevche-desk.local>
 <aqiyQOMGGIzu-91z@gmail.com>
 <aqj07iI_KFTDrjPR@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aqj07iI_KFTDrjPR@ashevche-desk.local>

On Tue, Sep 15, 2026 at 10:34:06AM +0300, Andy Shevchenko wrote:
> On Mon, Sep 14, 2026 at 07:49:36PM -0700, Chang Yu wrote:
> > On Mon, Sep 14, 2026 at 11:00:18AM +0300, Andy Shevchenko wrote:
> > > On Fri, Sep 11, 2026 at 06:39:12PM -0700, Chang Yu wrote:
> 
> ...
> 
> > > > +static int as7343_suspend(struct device *dev)
> > > > +{
> > > > +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> > > > +	struct as7343_data *data = iio_priv(indio_dev);
> > > > +	struct regmap *map = data->regmap;
> > > 
> > > > +	return regmap_clear_bits(map, AS7343_ENABLE, AS7343_ENABLE_SP_EN);
> > > 
> > > Can this mess up the raw read? If so, also needs a mutex to be held.
> > 
> > People familiar with runtime PM correct me if I'm wrong, but I believe
> > PM_RUNTIME_ACQUIRE waits for any ongoing suspend callback to finish
> > before returning? If so I think there is no risk of a race here. In
> > the case of system suspend, worst case scenario SP_EN gets cleared
> > before we read ASTATUS or the data register, which for my use case
> > at least is OK since the entire system is suspending anyway.
> 
> Yes, if the raw read is guarded. What about _setup()? Is it guaranteed
> to be free from races? If so, we are okay.
> 
Currently in setup_device() I'm enabling runtime PM before flipping SP_EN
which is a bit problematic. The fix is simply enable SP_EN first before
enaling runtime PM like Jonathan has suggested. Then I think we will be OK.
