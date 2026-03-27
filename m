Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 943AD223DD6
	for <linux-iio@vger.kernel.org>; Fri, 27 Mar 2026 05:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774590924; cv=none; b=lq5nMpfvOYRhHpJzg1vBSYsHB5vVLpAN9BAd49jQGTAtIy/rAIiKsi+dMcFfs68VJWRFeOMSpqhusbDXHuSg/sXEnCeNUB8FIpQIKNctGOBlPBZNE8T90sfps7M3M++oHmPdIa3H7+qBOZmebtCCKbO6W7ZUAgK1MMzbR0k2HLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774590924; c=relaxed/simple;
	bh=z06M0oYKGFXAJv6OJOJc9oOo7Oc92RStX68+8voyE+Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XYiozHvWS1na7izw0ldLrbKEJJaHLFXge6dz82dFdqD/OFgFwPWzqmgDvPF6dNywsSZWWqRoDb133XDD7LG+yDNHa7KUpVll4rW1L4L5vhRDaUDxd2qDq/oAh0GZTbCvJ3/xSEkqSY0tfaf7EbHMBMpbsPej+sJ6zeWbJZFsicY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sk02M8C5; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sk02M8C5"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-82985f42664so1061761b3a.0
        for <linux-iio@vger.kernel.org>; Thu, 26 Mar 2026 22:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774590923; x=1775195723; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ldF8NbzwArQflUW9AH/3x6alOg8hN4ABWwbFXUDr7ZM=;
        b=sk02M8C52NAZSFqQNqLOZNN2FuQeB4rl3EYJP2HI7a7+46T2kPZxBVDifLicdmcpOz
         zBWgvNLM84p/XD9e2cuGoEwcRUJQHIHO1et4uHHJ0F9+KHkTmhNYJkrrYhJCFWRAOwrZ
         MQ0HA5L03BMDC3pdRGT7gu2p6EHcobJzEyW/poyTTOT1TYgWeTcfaGspBGmPH1ZbICcu
         GWOTAYZi+f9tkSLRPQpdEuoy9cjXskfjmKy+d9XbpchDnkWxyXb17fZb6i0XslMlsuxU
         5RktRp8II1ykXaMWoGEgV+HmxY3j0goZocSI9B3PmJQRPGfMbkTaHcfDkPYUP8sgGagQ
         5f6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774590923; x=1775195723;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ldF8NbzwArQflUW9AH/3x6alOg8hN4ABWwbFXUDr7ZM=;
        b=Sv9Iawjo1SG1M6J9Y3OpmGkAzZ///GziI1Qqq7Ua6eBN1WKwwlsXzdkZADgSP1rH2Z
         4oIcmPiYpebfU0unCBLXjVTSQ3ntmDSqe1HtRvGtTYB1zF3eh1DHBLcVeLK2ub4A+A/j
         OfXKGCYda1h0dFSI3Dj428bClIvXssF4lJCSAYsMIqOEtXKoLa4KpNvVp2QjKC/C8t08
         XcqlEqV9YOa+ri3+vVON5ONxAVSz006F5Tz8cu2BAfjTgsZGTtaACu822xoL1ysL5SMt
         jUD7VvL4Gc03h6HUDAfODw+2HdymPzGIdrhoyW7ZZaaMZv2uHCoVZhefOFTF29CgJxUI
         +11w==
X-Forwarded-Encrypted: i=1; AJvYcCUFmLZQ9EfkfoyewPCA8hHGHF5TdP71piRevZ4WlaaXCkcRY9XlRevjQEXKGh0xr+JipOA8a7kS+Vs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEdwLe27LZ+ZyeLjaCx0vtFkqiLvW/PpzxveiL2KWMm6RbQ5Cj
	5Yals82aZCqTuAy4hiuMiOLqocyEsUYQ4+y9E0C+aIX5CsiA63bthFU=
X-Gm-Gg: ATEYQzxEFuF/slDtgMuLydBttd59rVwV6kHHOP9+ueqRveGAuTYYONwrlJB51E0ouD5
	s/Ia03wgIaAlL+k14RNkl6BefkZTrtkuKQ2wmZcky29LsEiSvUZItR4fXc/oWPJw5lZ9NuUEdhC
	cryv9WDj9rejaGuSJNYhXBHa8ecWqqDVcdwAaSEodWff1BWD7XYLom/q2Njyr6YaUf8nLmdULk6
	qtkZFlGx+X+gz5S+9KNdY0gY4l+gAheQQPaxK4KgSJWwVWh+hK6h+QfUPzBR/PiIHCaqHKpS4Js
	NUuO7QsztRUmqS3XvxzhUeyvN07MuELM6BTCk5Q0zQaLKxZmXFcZODeuk3m6SEnVf4kYPayO2wU
	XI7ppudtokaj6BW3qPVWijORIBu/Vgp+4PRsSwqx9mU9xjdApACObhWn6ibTL5agm5EXnbvChRb
	SrxUJCrWYQZ2SdRJMU39jGvSIZ6PoaC8x0YMQ7AbMjrNCybH5FhbKSM3Zqih1FhI4cICfyx8zHe
	d/JmjU6KJLfGuE54+FbI+ocyOFg5tZfO5Gox3fZ
X-Received: by 2002:a05:6a00:1a90:b0:821:8ebc:2899 with SMTP id d2e1a72fcca58-82c95b01eccmr1171550b3a.7.1774590922804;
        Thu, 26 Mar 2026 22:55:22 -0700 (PDT)
Received: from localhost (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82c7d3f95basm4724829b3a.59.2026.03.26.22.55.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 22:55:22 -0700 (PDT)
Date: Fri, 27 Mar 2026 11:25:33 +0530
From: Nikhil Gautam <nikhilgtr@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: anshulusr@gmail.com, dlechner@baylibre.com, linux-iio@vger.kernel.org
Subject: Re: [PATCH v2] iio: dac: mcp4821: add configurable gain support
Message-ID: <acYb1XOmw1yoyu_4@nik>
References: <20260321180707.73a7ad60@jic23-huawei>
 <20260326071242.9218-1-nikhilgtr@gmail.com>
 <20260326203824.59e8e950@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260326203824.59e8e950@jic23-huawei>

On Thu, Mar 26, 2026 at 08:38:24PM +0000, Jonathan Cameron wrote:
> On Thu, 26 Mar 2026 12:42:42 +0530
> Nikhil Gautam <nikhilgtr@gmail.com> wrote:
> 
> > Add support for configuring the DAC gain using the GA bit.
> > Expose gain control via IIO_CHAN_INFO_CALIBSCALE.
> > 
> > Scale is updated dynamically based on selected gain:
> > - 1x gain → 2.048V full-scale
> > - 2x gain → 4.096V full-scale
> > 
> > Signed-off-by: Nikhil Gautam <nikhilgtr@gmail.com>
> Just one small thing from me.
> 
> >  static int mcp4821_probe(struct spi_device *spi)
> > @@ -177,12 +235,15 @@ static int mcp4821_probe(struct spi_device *spi)
> >  	const struct mcp4821_chip_info *info;
> >  
> >  	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*state));
> > -	if (indio_dev == NULL)
> > +	if (!indio_dev)
> 
> Not related to rest of the patch. So doesn't belong in here.
> Also generally not worth the noise of changing these.

Sure will remove this change in v3,
will avoid these kind of changes in my future patches
> 
> >  		return -ENOMEM;
> >  
> >  	state = iio_priv(indio_dev);
> >  	state->spi = spi;
> >  
> > +	/* default gain is 2x as GA bit is active low*/
> > +	state->gain_1x = false;
> > +
> >  	info = spi_get_device_match_data(spi);
> >  	indio_dev->name = info->name;
> >  	indio_dev->info = &mcp4821_info;
> 

Thanks,
Nikhil
