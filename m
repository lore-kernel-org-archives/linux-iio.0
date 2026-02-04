Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F28F29ACF0
	for <linux-iio@vger.kernel.org>; Wed,  4 Feb 2026 10:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770201163; cv=none; b=dG3JtCQyPsEhwLwzqZ9OyNZ4gl6EEKKZhp3/2aBTTbAguLEYmWblbzbzr8/SGRbI4E2LT0lzPc39KxVDcZr7Fsj6rsLYJIHJ4PlHfOeV+K+B5J3wCcBMcZ9n/5RZuWCWM1w2/ztZIaGUN59ZXV2ckJaXgfZrSmqvJsasQ9HD3jM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770201163; c=relaxed/simple;
	bh=b2cRwyuXxJOInW7Wf1Nmi/IKrpY1TVgZuFPHiHNaWoI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c95r3e3m0e+QpDDShIrnLha7hYyZ08Jq8UMPw4Dx9f0eVXaCbcYBGEakiUN/OaDfka79QAvjbpRwpubebjAf7ObQRn/zbXDp3pQ8E39Qj2SgN9rQLV9uZRa0pTFweRHHH+oh6FLcPFEWn/lX8cGe6UWVT6Dpbi+gb7cImMB1H54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GmO3xC2K; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GmO3xC2K"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4806f3fc50bso66353405e9.0
        for <linux-iio@vger.kernel.org>; Wed, 04 Feb 2026 02:32:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770201161; x=1770805961; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MRBjj22CT+sIy28hxhJS7D7A0Tb1EUHDE7RRcCvtOJ0=;
        b=GmO3xC2K2G5ofoKpjfWrKZfjbg65nqk813K5kj4QYQsFc9/hfDdA6Hh6f8FPX42N6b
         E341wSMb+8qW4TRlQkLASMa6+FLFyEIuEXITlRk7WE+kUrXrKlEmpNeCbCsRDnkfbmDP
         57ctyAuEAnZQELC6gV36SnbG56hAPv8azC7FcLx73jrp0x0uWlojmz7Duus1WAHVOLUB
         tzzrk8aJeoAj3z+1kSWa26NOy/3vFos/nFw91c27lKLk8jQrlAcmtc5nwgDAnmCotILF
         zYMSjbnXHHqynQvCV8Mc50AADAcUX2RYyz+IVXXcUmuVqHwhGhWzcaCrnNGX3i+fq89P
         P6qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770201161; x=1770805961;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MRBjj22CT+sIy28hxhJS7D7A0Tb1EUHDE7RRcCvtOJ0=;
        b=nAfHxRucMniS5PprjwRf48IlI5i3HPTlo9y0ya+/Mm04+AbiXqAefK5VSEsQ3codNt
         /q4703PCk67RmL0f0Ir/gzvE+XbgXbj00tO0PLNb4p1xIIxVFztA6C9gOIpSk88/yak8
         LRD62RYCKtMICwojNG80MFmXRhdRuwsmnc9zO2ZqJB5QrbRxYmg+DsuxQGCDErKgTG3h
         CV8e3QA8rnXylKVXbcx1G+orkp2H5UsOOcAXEowk1xasvqHUUlzMPYjz973/24gL5FoF
         t57CTzt6fQke8nNx/O1IS+qIg/SIjTAOv6n/o7UrCayl/llO4G9qqBvFWyXQiCx3p9YH
         Id3w==
X-Forwarded-Encrypted: i=1; AJvYcCUWAM86UiQvEPqDN3k8K0H3/rKWKgjIb+ZOMav8vEWfTgwV0ol1L2ya1SOusbZTFnEA6u0uDkDwSPQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0xKZzpoZVHvpUxuMb4U0qQwWy3MmYe2dgh1tG8lwsavtxrmBl
	fEM2l7CtYbK1pYBbeGt9CPp1l5ybhPJDAQ7srZ0TFf/10j8CDeg0ws+0
X-Gm-Gg: AZuq6aIege5h6+yGFu2VJ5fSmskDPdEge0cv4J3tGLg7pcfqpEDkQF6G5FTFnbZUX4I
	Ue1qZtAwwcKyL5290X69NZ5nyGHn/0iIHixGL5F23Qv73Bi+J84Wm9NW9u1vMt5bSqxs3Jb22Xl
	+tSUmdc4WGmsUzOY0HCUCidYK3vruD1gIf4Hlq1kzXIThfMVM6ZtBE4jvplv4Bg4pWlUbG+u+1G
	gE5vdZUSU5kqcjeLvzZhaKtDwTlsiFKLu4N32kJbTgPSZVde8sPp9MbjDsdXJfPeZyLoTVf6qKE
	qnTU8i3vCxSJTloKo0xo43snffgfuxVqIcFcCpJc7fiAY2YIBOB99lJ3amVcq6ZGXhUj5DWA+N9
	roEL1eiXOWhyf0auax9GsrjVfSJcUqQ0g9J9SHmbapHsPwSQQEzA/96bVpCtlZeDkqUufRWfM0K
	UDMGf7PNHVtklUcgfI7G9A0KaSZr+YwVL9LAZP6YIe9FMUZltPMM3B
X-Received: by 2002:a05:600c:4e05:b0:477:af07:dd21 with SMTP id 5b1f17b1804b1-4830e977f95mr35524735e9.25.1770201161433;
        Wed, 04 Feb 2026 02:32:41 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4831091a0e9sm61722105e9.10.2026.02.04.02.32.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Feb 2026 02:32:41 -0800 (PST)
Date: Wed, 4 Feb 2026 10:32:39 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Michael Harris <michaelharriscode@gmail.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] staging: iio: adt7316: convert magic numbers to
 BIT() and GENMASK()
Message-ID: <20260204103239.332b66af@pumpkin>
In-Reply-To: <20260131162140.5abb833b@jic23-huawei>
References: <20260130-adt7316-correct-macros-v1-0-8a71df1e42f1@gmail.com>
	<20260130-adt7316-correct-macros-v1-2-8a71df1e42f1@gmail.com>
	<20260131162140.5abb833b@jic23-huawei>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 31 Jan 2026 16:21:40 +0000
Jonathan Cameron <jic23@kernel.org> wrote:

> On Fri, 30 Jan 2026 23:38:28 -0800
> Michael Harris <michaelharriscode@gmail.com> wrote:
.. 
> > -	return sysfs_emit(buf, "0x%x\n",
> > +	return sysfs_emit(buf, "0x%lx\n",
> >  		chip->dac_config & ADT7316_DA_2VREF_CH_MASK);  
> Is the compiler complaining about these? It really should be able to tell that the masks
> are small enough that the original can always print the right thing.

That will be because BIT() and GENMASK() generate 'unsigned long' values.
Sort of silly when they are used for hardware registers that are fixed width.
You can use BIT_U32() and GENMASK_U32() instead - they will be
'unsigned int'.

	David

