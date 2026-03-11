Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD3962FE071
	for <linux-iio@vger.kernel.org>; Wed, 11 Mar 2026 13:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773234702; cv=none; b=ZMG+V60tQj+bwpRfnoYOldkog0EwzQopjryYNT09aoVs/RXhMknhWVMdIUWHtkKjXocL33mxpmWQqZQqFBRU3v4P4KCMMaqkDCOMPrLNsPVaCeOOZsS5CIFZDGtIRyAUoUzXZVSra8wmAn/T0i7RlRgWQ+S5dzXre0N6p4/BLek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773234702; c=relaxed/simple;
	bh=K9qy72R7O75ja+5FY0n9soMVsULH8HxP54HOwOuSKew=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EquTsOJFXv0Sk+QYaPCq/Mp9UotOh3OkZdGFPlGAfxzuUSGLf25hXueCNgi0bgluX0F0fiL0CMUu08Lv18lF0l/3udNg+AukhU9lKdCGKsGUm50W33S/5gRx6Bvxp//dnyk+YU57kplUEEAI7pH4wsmKcTX6F5nYkNcOcpR3kwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PR25Bubt; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PR25Bubt"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-899f5d337f7so12488146d6.0
        for <linux-iio@vger.kernel.org>; Wed, 11 Mar 2026 06:11:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773234700; x=1773839500; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3+xjwlHf+QPiwLCHoffflVQHwDNAbTHRgVpez7H6bQ0=;
        b=PR25BubtCDsoYZ4CSZ7OIOfwD3Ba2MBAZE8vXaKa1Rx1yI5LtK7FCOPNSWUV4rdtpG
         acuPqBOFb76AfYFO/2ob/dcPY6Dl4fx3dGi8AFuzvksqcxKEP0prZqNKUlGBzh46+Ua+
         IzpZUMdhTmvU1Z6LUOQ7APCFGgXFDgd4Fza9VRALGHfG4cKvr6ULYcBc3DtyOaLVmvto
         WjcNNW7z1aOTLBGptO9Cfb8eo4VCIVPF8wXZeMVTr3n5CSrsfgsWSQP7+oxC7Ruc2esu
         XU16JBz/56qn0c0658OLzUbp9FQZnU/Komtj96VqGkG89dYlGya94Y1o6DYBEJnOqzBl
         q1fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773234700; x=1773839500;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3+xjwlHf+QPiwLCHoffflVQHwDNAbTHRgVpez7H6bQ0=;
        b=U8FjKQTxBIAd6EqMfZiGfibFjjnVCNikqGX1hN1KpagbNHi4T9iyPg1Zbn/KDR/2Dj
         pNRuGQaPqj4MnBtgY/zoOh5+bwtmYRyvsrcnZhgK3O6DINQFbIICJIh99M2S7tdGp2jw
         ZDPg9yfzY1Bq8pcdYjVJO2t7bET2kpYw3qGcV3luXFH0eHWJHcfWWMOh7YUEMefqRaIR
         V46+Ubauooe9+xn88d/CW3Ex2uTNp9I/3F7nhT6rNrLnUIQXoUg4TtISEMkjtdp3nKTx
         jKYJSyBa9X0ziVRHxZSUl3F4RvrANQMgHq6fYE3umgLm2sgx31OQuSmPt+pYuhsInz+S
         662g==
X-Forwarded-Encrypted: i=1; AJvYcCWXXL6zHwrBgQg65D/NAFWeM7FXnId6qDETvhr/YnZHjU0uaOXjZKF1wLdLrVopfw7nP6uxfX4bxiY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyC6LHtVx06SN025NK7wcVj8tAf7eLL2sWQqD0YbVXkrxyFJThG
	gaKbgRi9UXpfSEr3gwHoeFG7i9qFzVik9uJMkPnlto7V6cnQ9/P8RrSL
X-Gm-Gg: ATEYQzzUu89dIC0KozBqwKEM31ToEMOSMW8JstknoLjV+IHdbTRMycj6q5rM6oR3HmZ
	UnGss8jBtlF5FBGAK2GX0VZGadxUXdU/JhRRHm7cCb41jMRY8PZwZd89n+xZGs6ijbgsWAx/G09
	iNjifnsiIlz+vf2ocosDONVANH1NA81NRRSP3lVHdhPlhO7NIeFXg6OSgcXJvbeSKIeBrO9au6p
	HyYkt2XctW9s4jHmCXPNTO8hB00Uu4dODT8JYkIj7C5Iv86mlUo1jQgNdcPatMQlIIpQXdUSjs+
	htyjMvZ9vQ2CsYojZFJwR0Af1nodbB4hEpWHSliwV/QiJR7nKTxlKdHnd0CSvsp5Nmq0rrCBPER
	oZkSlXW6U1rXJeLXVMaeA5pVsJnK83Zda+pGm5vreK4QO/1By9NfVfoUhRtj4AJYZ4yf7F1D4e0
	Pb1q5hCvC+VgdCDEh9VNGyxmT28lzTfeIQ78sXBBKcr4sV9sylJMYRl1iNfJWpEAGxw5BZbOWi0
	Q4qGlbnFZx8vXdmJKbAan6bwas70X1A69dGMZggTUYarZWcfxI=
X-Received: by 2002:a05:6214:76b:b0:899:f22a:7d79 with SMTP id 6a1803df08f44-89a57c42ca4mr82636016d6.16.1773234699762;
        Wed, 11 Mar 2026 06:11:39 -0700 (PDT)
Received: from RDEALENC-L01.ad.analog.com (24.206.116.131.netskope-rdns.com. [24.206.116.131])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89a65bed6ffsm13621686d6.16.2026.03.11.06.11.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 06:11:38 -0700 (PDT)
From: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
X-Google-Original-From: Rodrigo Alencar <rdealenc@rdealenc-l01.ad.analog.com>
Date: Wed, 11 Mar 2026 13:11:31 +0000
To: David Lechner <dlechner@baylibre.com>, 
	Rodrigo Alencar <455.rodrigo.alencar@gmail.com>, Jonathan Cameron <jic23@kernel.org>, 
	Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Cc: rodrigo.alencar@analog.com, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>
Subject: Re: [PATCH RFC 6/8] iio: frequency: ad9910: add RAM mode support
Message-ID: <frn4iotwpzef7ca5yosmwllxrottjlu2rpgpbdogrydsujebf3@lwamhpkzxn65>
References: <20260220-ad9910-iio-driver-v1-0-3b264aa48a10@analog.com>
 <20260220-ad9910-iio-driver-v1-6-3b264aa48a10@analog.com>
 <20260301133153.7f2f8501@jic23-huawei>
 <20260307140735.5ec2e608@jic23-huawei>
 <bxcybwaz3am7nrrfcjuvkbbe7yp4vwcxwwh4dafaj5dsy622s7@m4vdam6tyaht>
 <b1187027-3ddd-43bc-a773-8b5d794e04fc@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b1187027-3ddd-43bc-a773-8b5d794e04fc@baylibre.com>

On 26/03/10 07:11PM, David Lechner wrote:
> On 3/10/26 12:40 PM, Rodrigo Alencar wrote:
> > On 26/03/07 02:07PM, Jonathan Cameron wrote:
> >> On Sun, 1 Mar 2026 13:31:53 +0000
> >> Jonathan Cameron <jic23@kernel.org> wrote:
> >>
> >>> On Fri, 20 Feb 2026 16:46:10 +0000
> >>> Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org> wrote:
> >>>
> >>>> From: Rodrigo Alencar <rodrigo.alencar@analog.com>
> >>>>
> >>>> Add RAM channel with support for profile-based control. This includes:
> >>>> - RAM data loading via binary sysfs attribute (ram_data);  
> >>>
> >>> I'm not sure that's a long term viable path.  We either need
> >>> to figure out how to do it as firmware file load, or via an output buffer.
> >>>
> >>> Firmware load would probably be too static and I'm not sure quite
> >>> how we map these to IIO output buffers.
> >>
> >> We would have to carry it for ever which is very much not ideal.
> >> The firmware approach has the same issue, but can be thought of
> >> as defaults at boot time forever.  If no defaults then we use whatever
> >> we come up with as the long term solution.
> > 
> > I was thinking about the firmware approach:
> > - Normally a driver would request the firmware during probe and the
> >   filename would be pre-defined.
> > - Less statically, It could have an attribute that once written, it would
> >   request the RAM contents (e.g. under /lib/firmware/ad9910_ram.bin).
> >   It could be the enable attribute itself (but that would not be effective
> >   when the binary would not change), or a separate one (e.g. destination),
> >   or a new one (e.g. load_en)
> 
> Have you looked at firmware_upload_register()? It looks like it provides
> something along these lines.

Thanks! this is in fact perfect!
It might be ugly, but for the sake of debugging I managed to get libiio to
interface with this by exposing it in the debugfs.

	debugfs_create_symlink("ram_loading",
			       iio_get_debugfs_dentry(indio_dev),
			       "/sys/class/firmware/ad9910-ram/loading");
	debugfs_create_symlink("ram_data",
			       iio_get_debugfs_dentry(indio_dev),
			       "/sys/class/firmware/ad9910-ram/data");

-- 
Kind regards,

Rodrigo Alencar
