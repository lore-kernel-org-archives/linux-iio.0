Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4DCF3E3176
	for <linux-iio@vger.kernel.org>; Wed, 11 Mar 2026 17:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773248922; cv=none; b=nzDygo45z+4HY/DsmXhMiYvT7eH51fnh2GBASpgrr79m/1nub+XeBf0e1lQrS/XpjUZ8pFfn27q8IeMKTEYOQpBm7B4OAcF77xLbVdJDoHpeFHJoslLOjHKjXrMX7uNSKWVeKt5TNeYdgaJwq8YL7E90FQA+fYOMsnsKNoPW7MU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773248922; c=relaxed/simple;
	bh=6mhnSaAg3iLefoQGg+TR62AbdmaFTj9WXmqTeVzCn+s=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hmitK7O2c5tOE2DjOQAxY4egzJRuntLfxtJGHsLwEqa1Zblt8SqxGCF9xj73F/tro7mXiT5GFlDe3cGzHuC07hxg/Wm2oQLFmqC0l25BZvPt3qLv3diEkAYgXQSmpkLi4iGRJI/wZvZxc3CqRtEN6a7TRGQPlQJugxTHXZMOB4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nc8AlKWt; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nc8AlKWt"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-5090c27d3f6so1025971cf.0
        for <linux-iio@vger.kernel.org>; Wed, 11 Mar 2026 10:08:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773248919; x=1773853719; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=cuyOusyX8t2/9N8XkvP3Pzm/04mnrL2/yq15S8/jD6o=;
        b=nc8AlKWtKqYsEyQ94EoiTPpSlHFUfJhklVvy9oZxCUkrpMiESY9TjHo7gAyOfrDvLI
         cB1NNQ+yH2AI9BbR24vsBN7mGcM9tgNSfzTXjDsrcRQsaehrBP4AmMVY44MBwe2JhRjZ
         ViGSFrrGcS68sRKHSGhTb2d7jVPSvvBR83CkFyz8L5TfN/CPCTtXPadWOmvNM7m9ISws
         GDLwqSeg/7zsQH3LSAnvWr6sGMCt9aQ9/xRAa3QozzXmJhD5e43A/NE9a0eph7OG5Tuc
         E0xjCKJPmlLouvxKtmS6ufZ3kPl9k45Pb5S4QBuISJgbVkcUEUguj7YDAU411dN5vh1J
         zU2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773248919; x=1773853719;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cuyOusyX8t2/9N8XkvP3Pzm/04mnrL2/yq15S8/jD6o=;
        b=kSBFgJ8+cYCXmzRN6NXX1/SakCpkRQddBkCVZh42SPPjEkASrfY73kOnf4SFneh4cb
         dqpdOJJVUZlYJAPzaWlSTyB84HYm5lHlz8d5xzhpBL96Sw2Bplg7fmGs+SQbvzT91KT2
         TUDKtFXLs3VXijHVeg/7dWniPhlS/5XBmSsxKVGCAN06bcdU7Oa2ue9XeFSlWDIEO6Mu
         fTWYU6FBxYFHRGRrQqNmERKhu+DoKxEqflbbWAg8OSl8qb4ACwIgtTybkdhZvVI6bvyg
         R7qLRB+RX1Ltx8TlG5qS0Yx1hbo212L6rHaSu8AyZ6MTwZYUQ1fKBo4ktJvg7zfu2lfY
         1vgw==
X-Forwarded-Encrypted: i=1; AJvYcCXDNxWe7J4lQpiunAWNhQaE105XJtt28/bHABCkvXttAYDiJ2i52d1fQ2ahtnwmJ2fa5wRj8GlUXZ8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2hipmkgQKrMyemQFZEHuUdMFIXC9z5quE9Qqt2bxwHpMivKjL
	oMcc6VY4Ou2uD+SeFmh5a93noDMSJBpKyJTGmgLTvWmeUiAYsq36d3Vs
X-Gm-Gg: ATEYQzxHJQz9a2Jh+fT67DB83Usrxg1RsGPQH6oXpJoeFmg2Ow+UGaOQfJqhOrHMDzU
	lmBNiafP38vHfKzU4ce8jJqHf8sBe1mLonhflxn4+9Eu6fWRqVFiaNcdXA8dpe679rts0a9OUTE
	+eanHT1prxvoKGyezxoBmnlfxYbYycBg47mxiuKTurStDIijhNrLId874EelWPCyz5mEGRUuOCn
	9ey2+XOwiEJEgwrmp68l0HGPMhCcq0CvUOagzywibS9ThEch6CYJezt7Hlh+CNq+XJBksqMEEK4
	OlasXxaSdDu9QAzeMl2L892xT1YTbKgzqMCJxpUmDo1omi2HirIAmp9tdu7WMh9lVqtOtaG0weN
	l9lJ/xiuhsAUmRTRVCrUxKzN3MpelhW8ky/Lzh+mzkUHF/T15ByxHxydiZ6JavhtzhiOEZR0mJT
	gvLKcU3YACI8GN8TdomzSpWbQOeO9L15QIE1snLnfvnFx38ZLZGmmv7ysLzeUNZfp46EBzbkVUt
	Amg8AXV1864Q94B9HGlX6Cgen3o1mJ1QIWyJEhO0sIU8XBnlio=
X-Received: by 2002:a05:622a:1111:b0:509:31d1:eb0 with SMTP id d75a77b69052e-5093a1d9fb5mr39796621cf.65.1773248918614;
        Wed, 11 Mar 2026 10:08:38 -0700 (PDT)
Received: from RDEALENC-L01.ad.analog.com (24.206.116.131.netskope-rdns.com. [24.206.116.131])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5093a14791dsm16436701cf.31.2026.03.11.10.08.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 10:08:37 -0700 (PDT)
From: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
X-Google-Original-From: Rodrigo Alencar <rdealenc@rdealenc-l01.ad.analog.com>
Date: Wed, 11 Mar 2026 17:08:33 +0000
To: Nuno =?utf-8?B?U8Oh?= <noname.nuno@gmail.com>, 
	Rodrigo Alencar <455.rodrigo.alencar@gmail.com>, David Lechner <dlechner@baylibre.com>, 
	Jonathan Cameron <jic23@kernel.org>, 
	Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Cc: rodrigo.alencar@analog.com, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>
Subject: Re: [PATCH RFC 6/8] iio: frequency: ad9910: add RAM mode support
Message-ID: <bfiacew2zft2ayg72g7g2dxdnzsqxr4m63kkz326o7ybb5rbgy@hg4hs4plwj5f>
References: <20260220-ad9910-iio-driver-v1-0-3b264aa48a10@analog.com>
 <20260220-ad9910-iio-driver-v1-6-3b264aa48a10@analog.com>
 <20260301133153.7f2f8501@jic23-huawei>
 <20260307140735.5ec2e608@jic23-huawei>
 <bxcybwaz3am7nrrfcjuvkbbe7yp4vwcxwwh4dafaj5dsy622s7@m4vdam6tyaht>
 <b1187027-3ddd-43bc-a773-8b5d794e04fc@baylibre.com>
 <frn4iotwpzef7ca5yosmwllxrottjlu2rpgpbdogrydsujebf3@lwamhpkzxn65>
 <3a967f38a43933f12c98a9dfe4f1e85fa592b41b.camel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3a967f38a43933f12c98a9dfe4f1e85fa592b41b.camel@gmail.com>

On 26/03/11 04:54PM, Nuno Sá wrote:
> On Wed, 2026-03-11 at 13:11 +0000, Rodrigo Alencar wrote:
> > On 26/03/10 07:11PM, David Lechner wrote:
> > > On 3/10/26 12:40 PM, Rodrigo Alencar wrote:
> > > > On 26/03/07 02:07PM, Jonathan Cameron wrote:
> > > > > On Sun, 1 Mar 2026 13:31:53 +0000
> > > > > Jonathan Cameron <jic23@kernel.org> wrote:
> > > > > 
> > > > > > On Fri, 20 Feb 2026 16:46:10 +0000
> > > > > > Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org> wrote:
> > > > > > 
> > > > > > > From: Rodrigo Alencar <rodrigo.alencar@analog.com>
> > > > > > > 
> > > > > > > Add RAM channel with support for profile-based control. This includes:
> > > > > > > - RAM data loading via binary sysfs attribute (ram_data);  
> > > > > > 
> > > > > > I'm not sure that's a long term viable path.  We either need
> > > > > > to figure out how to do it as firmware file load, or via an output buffer.
> > > > > > 
> > > > > > Firmware load would probably be too static and I'm not sure quite
> > > > > > how we map these to IIO output buffers.
> > > > > 
> > > > > We would have to carry it for ever which is very much not ideal.
> > > > > The firmware approach has the same issue, but can be thought of
> > > > > as defaults at boot time forever.  If no defaults then we use whatever
> > > > > we come up with as the long term solution.
> > > > 
> > > > I was thinking about the firmware approach:
> > > > - Normally a driver would request the firmware during probe and the
> > > >   filename would be pre-defined.
> > > > - Less statically, It could have an attribute that once written, it would
> > > >   request the RAM contents (e.g. under /lib/firmware/ad9910_ram.bin).
> > > >   It could be the enable attribute itself (but that would not be effective
> > > >   when the binary would not change), or a separate one (e.g. destination),
> > > >   or a new one (e.g. load_en)
> > > 
> > > Have you looked at firmware_upload_register()? It looks like it provides
> > > something along these lines.
> > 
> > Thanks! this is in fact perfect!
> > It might be ugly, but for the sake of debugging I managed to get libiio to
> > interface with this by exposing it in the debugfs.
> > 
> > 	debugfs_create_symlink("ram_loading",
> > 			       iio_get_debugfs_dentry(indio_dev),
> > 			       "/sys/class/firmware/ad9910-ram/loading");
> > 	debugfs_create_symlink("ram_data",
> > 			       iio_get_debugfs_dentry(indio_dev),
> > 			       "/sys/class/firmware/ad9910-ram/data");
> 
> Or for the sake of future proving, maybe let's make the sysfs a bit more generic. At least the path,
> 
> /sys/class/firmware/dev_name(iio_dev)/*
> 
> I guess userspace tools could work with the above to match the fw blob with the right device. Also,
> hardcoding the name as it seems you have done will be a problem if we have multiple devices, no?

You are right. I am using /sys/class/firmware/iio:deviceX:ram/* at this point.
I suppose some complex transceivers you may know about may need different fw_upload
instances for different CPUs or profiles.
I like the idea for userspace tools to expose those. For now, using symlink into
debufs is working just fine.
 
-- 
Kind regards,

Rodrigo Alencar
