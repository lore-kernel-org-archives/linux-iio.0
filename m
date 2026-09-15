Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CA7F3C3F4B
	for <linux-iio@vger.kernel.org>; Tue, 15 Sep 2026 11:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789472823; cv=none; b=f1rANVAI416hxQR2qxSqx1Y89W4err5kKPFW2iVriBkjEULzPchj5yhM4n9dEKqbZiI1bTIta9srKNdm353JjAUphnPnFXGR85xIVk6iMMBjn+0rKhLVUojTUfZwYlU2KyYXxvepfX0bQdQQHMPQ5y2KVxNk1GaCZhVHKRAfk4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789472823; c=relaxed/simple;
	bh=ac6tZgLnUNvpCiT3oBM1Q0XjYFyZen8Qw7kHMHY2Vkk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=avyxMgLddE8RyKEHNjN0rQxy+SbKphghJxuILlTiMvSObACChXckOQco6qTK9JzxhZGdHYSLlPYnETEeAsF/KZ71fjTKej5BKcYTDIjh0cLr8YeiBdyUC79qSn2Kk/RFPOeu4YdJHsHfA8R7mFGHUewVWal0Eqz77+PVaauKdMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mw4lOVLI; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mw4lOVLI"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49cd4ba9f68so2206975e9.1
        for <linux-iio@vger.kernel.org>; Tue, 15 Sep 2026 04:47:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789472819; x=1790077619; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=XWLYzPKn9Z277Ee1TDtRp8i78DpmLDVKS5xGRIF3oZM=;
        b=mw4lOVLIDzBcm7GIBDJriKcukv4n7/qahjXwFqNOId4CgaXeh+OKmuKbQ0haTUdwlQ
         LVnKVJrpMUhvp9UvfZSa23q4Xf0pgVO3gV4UN9Nud5iLDQoR9+yG9aFDl9s2dsyBLnyf
         9ISameNdMEKPtHDE2ZbjNquPYfh/0dzf/RrpTRotMnHl+alkLpk1VuL/kRoC+VPpl7A9
         oQG6RuRQEPO7SyaJ1NN8FB352skPMm++iTl7KfNq2wDtFzd3Q6toeZaab5GKbvQpH/Im
         1PBltYUrHxGXjJ00Syd6LEuRo1aIjWaGlvMAXL84+J7PIKteqL2Ok5Y8npbeaumCwd8m
         CH3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789472819; x=1790077619;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XWLYzPKn9Z277Ee1TDtRp8i78DpmLDVKS5xGRIF3oZM=;
        b=yrin2/c7Ww7/JFEDFxVgB/MI1sEIAQkP0w04PDp6OJ/M5J/uOkKRKcz9e3HOMvITMo
         FyWxy158qTmQpvpOlQtNBd0bhs2X72NoeKCMSlphsDE3lGsfGwEWL14HBblxVQrQTyjh
         4+syZPQUrOi3v01IkF89oVtLwFf7AkMr7pQdMgBzQ0Y4OHbHtqDyJRytNBcMIPTVw/ji
         lnrMX655TutdHn9WswI3wp8HWKiPOcaMebKalBGHPdopeDF01xlK/bDABi2DxioPsuM+
         KH/AGB0tZ9LqFOS3G40QqpP9j5C3qw9GQHm7kNTHlrYtfNeJJIj2qKmdOcNYE7VTlWCn
         kvnw==
X-Forwarded-Encrypted: i=1; AKwUvBxn3wmd1aHjOUX8NgAnOh2V01qIZhLi5NozkfAwXNiojYlfeWMSjP8Mggzpi/E9X4TX7IYjZ060WuM=@vger.kernel.org
X-Gm-Message-State: AFuF++methIolyZ90T9OqT7nIge08t2LnuePc7SRjG6aksahLueoVwFc
	fRtD9M8Szr4/NtyZ6VmVIYmLJ3JIJyJ/B4tTgZbIDhkgYR+vA9ldOS8D
X-Gm-Gg: AYBFou0j561Uy6wCrLEhNNccmxGYsIKBbY2qzp09TUr4lQV2PkR5r2G1kItVul8DpXt
	huA3GdHxzwTBsV0fXX/QHyqoGXkdHkQhdR/E1J90DSsI4K/pzgLZFnWzVJwlihtDJcQjZJrHgiM
	my5AnAJJshlK1vsdbIPqnNDmsLz3qz2MesYH5KS7c3MeuYa7hOqOzvH+sc+ikqGTvyVsUVgntHq
	/HGeah8rD6PFK/Nv4QJXwmZddNXJLVE41oIU0hZfOHjiRAfjtT++TPpBRU+tUU7ASNSFILaF59g
	NwYMRmHCMqwEWmzSbPF6LeAlBUjh0H9Lkk5yOvRCJGH80rMf3lXB6dL+RN1oVido7oHWk3AOXev
	ipia7GqR63aAqm1GrE/aZNhGdRzNtf3bGr17ZzDo58WfzYTiJgGcA6uw6v2+WM6aRfukJkvi9GH
	mRWFnWRQ0bo+qVcxwRNEx2w2803rT+08WpQapyB2w8EUCwIpOSQiiFhjRkmTeCVmbWNFWCorcBs
	UOKbnTe2YYBVDjTsVamcpC646R4aVdSBfuysxuaU9UI7UQJP4Lpl2JySQsFmKxuRTtvHHkp1aPN
	AKcs7CEZcmHkq94DzMmm1u4ff3RlVXohAvDoX19gC+gMvq9Ct+Mc7sqhzu0VP3STn1EkLSAU0H4
	ueVbc+hgxAp027GK++t0DkjgvV/ZX17gBj3dLQGZhclVcgWvCCsxwPh8pnRpVu4CC7KRHCb4sxw
	2NmN2saCEWiSSeM2M=
X-Received: by 2002:a05:600c:1d0e:b0:49d:1a02:4797 with SMTP id 5b1f17b1804b1-49e8227fda2mr11731415e9.17.1789472819082;
        Tue, 15 Sep 2026 04:46:59 -0700 (PDT)
Received: from localhost (90-182-112-124.rcp.o2.cz. [90.182.112.124])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49e7ef8a7b1sm53841325e9.12.2026.09.15.04.46.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 04:46:58 -0700 (PDT)
Date: Tue, 15 Sep 2026 13:46:57 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: "Maxwell Doose" <maxwell@maxwelld.cc>
Cc: "Abdelnasser Hussein" <abdelnasserhussein11@gmail.com>,
 <jic23@kernel.org>, <gregkh@linuxfoundation.org>, <nuno.sa@analog.com>,
 <Michael.Hennerich@analog.com>, <dlechner@baylibre.com>, <andy@kernel.org>,
 <linux@analog.com>, <linux-iio@vger.kernel.org>,
 <linux-staging@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v7 2/3] staging: iio: adc: ad7816: Serialize SPI
 operations
Message-ID: <20260915134657.000016e8@gmail.com>
In-Reply-To: <DLFV0K85626F.2MUXL6JKFNF5H@maxwelld.cc>
References: <20260915075939.18180-1-abdelnasserhussein11@gmail.com>
	<20260915075939.18180-3-abdelnasserhussein11@gmail.com>
	<DLFV0K85626F.2MUXL6JKFNF5H@maxwelld.cc>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 15 Sep 2026 06:39:34 -0500
"Maxwell Doose" <maxwell@maxwelld.cc> wrote:

> On Tue Sep 15, 2026 at 2:59 AM CDT
> Abdelnasser Hussein <abdelnasserhussein11@gmail.com> wrote:
> 
> > The ad7816_spi_read() and ad7816_spi_write() functions perform a
> > sequence of GPIO state changes followed by an SPI transfer. If multiple
> > operations occur simultaneously, the GPIO state could be changed by one
> > thread while another is in the middle of a transfer, leading to a race
> > condition.
> >
> > Introduce a mutex to serialize the operations, ensuring that the GPIO
> > toggling and the SPI transfer are treated as a single atomic operation.
> > The mutex is placed right after the pointers in the device state
> > structure to avoid padding holes.
> >
> > Signed-off-by: Abdelnasser Hussein <abdelnasserhussein11@gmail.com>
> > ---
> >  drivers/staging/iio/adc/ad7816.c | 11 +++++++++++
> >  1 file changed, 11 insertions(+)  
> ...
> > @@ -47,6 +49,7 @@ struct ad7816_chip_info {
> >  	struct gpio_desc *rdwr_pin;
> >  	struct gpio_desc *convert_pin;
> >  	struct gpio_desc *busy_pin;
> > +	struct mutex lock; /* protect device state during SPI transfers */  
> 
> I'm a little on the fence about the comment but if it satisfies
> checkpatch then thats one less patch later.

It's perfectly fine to comment like this, especially since this seems to
be the style the driver uses.

-- 
Kind regards,
Joshua Crofts
