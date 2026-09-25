Received: from mail-yx2-f42.google.com (mail-yx2-f42.google.com [74.125.224.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 961872F3C37
	for <linux-iio@vger.kernel.org>; Fri, 25 Sep 2026 00:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790297527; cv=none; b=hb2yx+tKFgoO7xSs/nTepAGuyDJbfX8TAVCrc7Nf9LpfET786OgflPjZOy6xfy+fAixddXDyyBbjBJKebjF1DpojmL5QwYrelvKgsvzKx2fGH8Ax4eLulEleq3cq2Bfgwsf8FbrxQAURd2Zb5Dz0OGY3oOEUfrdR5QLvyQNSbMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790297527; c=relaxed/simple;
	bh=SU8S+k0GaQXhN8wKEarVxueYV4JjSov8C14rwhv0NAs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iMydfX6AtUtk2JeGWRHmeaGQOhKrt/8/OixpTmuKxdQiLmsuKpQuEtwcWHCIucXsEVAu5BH1Fkb6/uW/ysFGL0H8UNIsLAXako0CpgJIPfTh76iuz4AMaJyo4KkkKGc2wQKuj2li7GbZxAfk0u5H85hNzbXL+lDkRy+63uegYX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ELRfux6N; arc=none smtp.client-ip=74.125.224.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ELRfux6N"
Received: by mail-yx2-f42.google.com with SMTP id 956f58d0204a3-672f90fc533so526392d50.0
        for <linux-iio@vger.kernel.org>; Thu, 24 Sep 2026 17:52:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790297524; x=1790902324; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=waVePeybHmNVRSEGWIUXZUy64+O4FCvxTaJgwpuKHSA=;
        b=ELRfux6N9Oki6EP1OMjq1ecT3yEyMMRgn4eBI12axrzs7vk+HeRocDMvN/fCSZSC2o
         FLoyUZ62Je4GNBWnFRJvn3Oo7wsjDuq+YuGtyptYZZEICKJJ2eDdmq7pIDgWC7x9Q+GH
         D2rXseRIIFeq85JEXTUi0vqeDTPg2i+uTg5T/FPfu2kV3g2YIhewsghRszgHAYOyYz3D
         W/rKgbEPzU9q/XC9i241qZz7K6hC0vBqqCPe5yv8VnPIFF9YJ8z9zQRN21lPE4h9Epzj
         +lhC4oqhRwaAUIRukG/dLOBafw9TXF8Y3lgksUx0lGdnVMzi7/zRV6tB7TXYR4cZKxM+
         UgHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790297524; x=1790902324;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=waVePeybHmNVRSEGWIUXZUy64+O4FCvxTaJgwpuKHSA=;
        b=FPMPZHeAu0lg9+BFRfP6Pi9AU7KWDHHhvYr3ySfoCzs5lZ4Nhe0BX2JMRexguw2GIM
         wD/0iboHRlesuUhTwKqkufDQaFY6hVialivZvarjfViiqgLaedXbOTTKptN15aV9vYME
         ngsS9YWZvWNmgGuTQlYSNLMJNqg7rTxy0F2DBggxc5RLvHH8srQWlHphEFMHFvDqiiW2
         FJ0dDl4j4STScQb41NSugJURi9uvepSJXCm+7pfEA6tKR+xbz4lRTMS39ea/Tba8xOXl
         Zr/uiO33Ca/buxvk/KvaLIH/B+S8zaV7aYcMcR/gDULGvJi5FNf/j2bmUXRWJpdRsJHt
         0m/w==
X-Forwarded-Encrypted: i=1; AKwUvBzvJEpQFKnyAmMEIeqA2KOdQPaJQ6o4vLCLI1eIfkHhylTmILEIQQAcHgj5vaYj0cVlg/5GdL/HRa0=@vger.kernel.org
X-Gm-Message-State: AFuF++mMnjfmppZa/LkM8Uvj+b7ZXRSp26DspmZH8JVc7XnJdKT3dUTw
	jCYTG2JIKeSEcJGAdKidByt8XGCca7XUCO0P+Mqo+YYIGk6gQijbPWvZ
X-Gm-Gg: AYBFou1T5dGizVi/W4tzqym00C3wECv7ZAm11Uy2wK9H0c8si8SPLIQ3QLy8IIyhYT0
	BbF3qS/Mkk9qbgGGMNYawmmngpQPwUicRyjaOgT7r2hrPqpOnXUFvRYUgjMxr4iLpdYW0Ub841e
	edy+ralnYktcGbD86CMQ4xA971PMJxWpaJ7WQti/HXWBDZb+QP2DC0bMZzcX8zeq4b0OufydOWm
	qN87c6dDCohTXMpsExEDT/zv0xrm/au2RmmZxv/zaQvDZexTcnFcnW7EmvuUflLlwUBh6bSaIVk
	IO1ifCMlbpCdZjmrAeEYNhjtBjxjWTp9y+tUjXrfv02czasl0e5/OM3IszcLacErEUYFEy6jbg6
	FiZK2sRHbgZFRj+WtyJlamXluu/xlEGHRSNkqZccN/DBKkjXA6LhnL87NqsedlnXzEZK9PmK/ZP
	VdbzK/0prCTsbPeYa80Bn6ZHW7SYMvOjBcRsVQQPen1SV+pzBOTP5gqQ==
X-Received: by 2002:a05:690e:d44:b0:66f:c1be:318d with SMTP id 956f58d0204a3-672ed4db1a4mr1606622d50.100.1790297524534;
        Thu, 24 Sep 2026 17:52:04 -0700 (PDT)
Received: from gmail.com ([2600:1700:5431:250::3e])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6740ef2932dsm293078d50.12.2026.09.24.17.52.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 17:52:04 -0700 (PDT)
Date: Thu, 24 Sep 2026 17:52:00 -0700
From: Chang Yu <marcus.yu.56@gmail.com>
To: "Jose A. Perez de Azpillaga" <azpijr@gmail.com>
Cc: Chang Yu <marcus.yu.56@gmail.com>, Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shi Hao <i.shihao.999@gmail.com>,
	Joshua Crofts <joshua.crofts1@gmail.com>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/2] iio: light: add AS7343 multi-spectral sensor
 driver
Message-ID: <arXFsPr9gmjLXMYR@gmail.com>
References: <20260919235145.48273-1-marcus.yu.56@gmail.com>
 <20260919235145.48273-3-marcus.yu.56@gmail.com>
 <arWccqy8YlLJxeWA@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <arWccqy8YlLJxeWA@gmail.com>

On Fri, Sep 25, 2026 at 12:02:34AM +0200, Jose A. Perez de Azpillaga wrote:
> On Sat, Sep 19, 2026 at 04:51:45PM -0700, Chang Yu wrote:
> > +static int as7343_read_raw(struct iio_dev *indio_dev,
> > +			   struct iio_chan_spec const *chan,
> > +			   int *val, int *val2, long mask)
> > +{
> > +	struct as7343_data *data = iio_priv(indio_dev);
> > +	struct regmap *map = data->regmap;
> > +	struct device *dev = regmap_get_device(map);
> > +	unsigned int unused;
> > +	__le16 result;
> > +	int ret;
> > +
> > +	PM_RUNTIME_ACQUIRE_AUTOSUSPEND(dev, pm);
> > +	ret = PM_RUNTIME_ACQUIRE_ERR(&pm);
> > +	if (ret)
> > +		return ret;
> > +
> > +	switch (mask) {
> > +	case IIO_CHAN_INFO_RAW: {
> > +		/* Wait until integration time passes for all 3 cycles. */
> > +		msleep(160);
> 
> three integration periods hardcoded next to a hardcoded integration
> time, so nothing keeps them in sync. make ATIME/ASTEP writable and the
> fixed wait no longer covers a readout. as73211, which this is based on,
> computes the timeout and polls NDATA. STATUS2 (0x90) bit 6 is AVALID is
> defined and never read, does it cover all three cycles? the datasheet
> does not say.
> 
Configurable ATIME/ASTEP will be added in future patches since I want to
keep the initial driver lean. I'll switch to dynamically computing wait
time in those patches. For now I'm inclined to leave the value hardcoded
just to keep things simple.

The documentation on AVALID is indeed pretty poorly worded and unclear.
I'll test on hardware when I have time and see if it covers all three.
I think it's fine even if AVALID turns out to be unreliable? Worst case
scenario the userspace reads a stale value, which is OK for my use case
at least.
