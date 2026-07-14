Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCCD9360EF2
	for <linux-iio@vger.kernel.org>; Tue, 14 Jul 2026 16:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784046063; cv=pass; b=peXXynNjqa+/d/YirFL8ZeQMnENBQawabkjMa5oKaOXYWJKrTccmfMz/4mCvKL0rrZ/xNXgi3V3TL7lbMRq9io/txK/5yIgCStcitH/oWnbuT+H4P1MdufrEIHl3DndgqATY7jZiqzxgIqQDE9CjBq9+XKTO+CiQp+kjMKNXhlY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784046063; c=relaxed/simple;
	bh=w/hWVgWMBEAi4baxYBKguUNUSjowVNXqcyrAzFXEtd8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mGyOg/FtNF6JHOzzHo5uCkIO8WGF853YsoMCfFtnaTsulMVfDbuk3CV7BEiXoFiwI4aSzIiV3ivKo0gjlZzFjCWagpbDk8xRq07RNHZHddc23iAzPAKb6lJO+Pjf32NoNpxnCwut2OERTwv6f5/px5dpPlu6SrnKUxXIL05namU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=o88uYxWm; arc=pass smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o88uYxWm"
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-39c7fd21b63so32073701fa.0
        for <linux-iio@vger.kernel.org>; Tue, 14 Jul 2026 09:21:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784046060; cv=none;
        d=google.com; s=arc-20260327;
        b=Tt+S3n2nFIFzuQvtvX8SziuLanPslMKycNWdSzSK0uRamngGTnVA7wQr2OoSI5xjZf
         8JsNzqgmvejzLd46G/XMp/tawkWURoU92yTbI2Evw7T451kldee5KSBUW2BUmIEr7Wct
         w7qrLj9qGZ4QqfsdV38aP9YQCFeUf7yncqFMTJDufz5CdZ6JLaOPY0BL2IMjHbWvDTvH
         3fUn55/QgI98/orbh8CMdmU4WLAB6GJrW625xz6ySSOth6YERuh7wU9CJ8aQj5o0ZIci
         QisyGy7cWQpGS+roTrUJPENZXypYk5c7Xx4x9ywlSuD+xpNzDB3jSn1y/PID8qWcPGzA
         rd6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=w/hWVgWMBEAi4baxYBKguUNUSjowVNXqcyrAzFXEtd8=;
        fh=aid8IK5nDjVZfQ0XgSZkr+unEPs2zJvLPD+0WIqFvlw=;
        b=JgeI8GjQpkBwDJJ8RDb+thkhsB6sKGXMzyJFj1jsbtIDmP4amjWXpzIipmAWTfZZoO
         EaCqD+Lu6ZAPIW/cztCw30hTV2dsMcALSUzXvuJySmYPiEytmmQIx+CMisa1GQHyeeRm
         n+OrMt79giUkwMgb0I7rz0VgzyimHFxLfaBr1SZ9pb+K+Q4/g/3Ib0lfa/Whsagp5Rr7
         ++0UiIrVwUbJGisUoy6odOYWVMguVUHY7PUl37wnYTT/r0P1jZXSLxtIN5LyDtnp8LNs
         syucWk5pYpenTuO66cnsq/tD/XCu1mczl/NxXj5Yx3uYeokqa0zimuZ9J7SAXLijd4NR
         t+lg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784046060; x=1784650860; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=w/hWVgWMBEAi4baxYBKguUNUSjowVNXqcyrAzFXEtd8=;
        b=o88uYxWmrfOlrLoUAui5B1keRvLo2aRYCLAqClorVJDOjWJ0+60sz9JdyhgwoGiaBv
         4AVJC9ZR7CjU9S4SaqLYhX0+ramX/orn5b3PPwvxe38m2GOQOnNlTCxDnAoNZMX7wJRc
         DcsX6POpWAH3n6NxS2xS2T+3fjv4j4OOfbnqxS/JgDxoOQfQbix3ritMvzghfrTR2M3k
         jR94NGB1prk8cZ4fYECOq6zaxMGAprVlqXeYw/AeoGhEW8tn8nY3N+PKCwD7MpnPIFfP
         h0CBoH0hE0YuXAUtZxnoFHNXoL9uUYbFrSds/QLHIptnvhHxf025hO/MV+JymmXVLYYM
         X7dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784046060; x=1784650860;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=w/hWVgWMBEAi4baxYBKguUNUSjowVNXqcyrAzFXEtd8=;
        b=o+QZaiAaH8nFUks1yo6BZj3gvb3ceQYjTq9PpCSURtbWKtucc7OJpNWJxL768mzeOP
         y+CM/bHXF4+gpU/lYOI9hQ+MlLbxi0i8uGSvdaQ4uHNG/TbVPZ9iRNtbORVj4XjuRMLK
         vFDc8SGGVGnBXGfPDiOEp9oeOs+vRriXCJEcTL0UyL+S+v4R7TzZGnnk6l+oaOKZG2f3
         KtIFiWmNicgfM57LNei74BAjxA1IpHMp+wONIAGdhppY2A29wKvs6j5LYBzNCWZjq69L
         FtrDgQXNAJIdpb7pOYSUvuRzUIp5UFfgEW9SG7DFrwldLgHSChnim7kzqzmES0d4+/hz
         lBJg==
X-Forwarded-Encrypted: i=1; AHgh+RrgGkKXhD9J8tsN/ww9iIqIFrYhA2GBe7GQGCKUOPpwYGOAM5mpQFzLF2RcUsEfHyfVrHc4QGqgDU0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhJ1C2qaihmEE6b2naqrVtcgQ89fVLjTGsVi3be28qZAhISWWx
	3LTr3Ikb8roDTV4NgTfGlpWHcfmdJdAnp7f7JEq4C6s1S9wL9LOYDfnOjlpgGxEhCQtwoihyl2a
	m8Y9OUN/BePnW5DdtognmXqGG117u4/Y=
X-Gm-Gg: AfdE7cnjW8z7VW8gSKFjXX24rohpyBNLBK+FHyZk05A73xe6sVz7oIKmVIDJkuUm7R8
	UXk0ljcWyB73JZG8/v75Gx/lUX9a+KbIPSKEZOLgp1GSxpu2mTJcszbmfR/57PG/a8RCOEKfWik
	8+xA0yYx8UgKXLK2NtKcGUttjiRMoCXl/WdVBUSB9Al0psxfZsVDsT8iZEyL1RfAQUdHUKVV2Of
	lKzPEsm1AG7x23aNH1PeHbUcyD3b94CrNhJCZMNCMt+2+4M0arwBzcUk9l1TQXNFUWmZNBEo+SX
	qWG7R6O1zG7TW7L2CknbFOaWpNrrm6P+r1PG0A9wZg==
X-Received: by 2002:a05:651c:150f:b0:39c:92b8:dd9d with SMTP id
 38308e7fff4ca-39daa839b20mr9821661fa.26.1784046059486; Tue, 14 Jul 2026
 09:20:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260707151542.91997-1-muchamadcoirulanwar@gmail.com>
 <20260707151542.91997-3-muchamadcoirulanwar@gmail.com> <DJVQDP9J54K1.AANCLIJC23YF@kernel.org>
In-Reply-To: <DJVQDP9J54K1.AANCLIJC23YF@kernel.org>
From: Muchamad Coirul Anwar <muchamadcoirulanwar@gmail.com>
Date: Tue, 14 Jul 2026 23:20:48 +0700
X-Gm-Features: AUfX_mxf_FzQxVLfuQI_7jeEOA2orrtEW894cnhKCVOqUxe_TyKMO-fvHYnHX4s
Message-ID: <CAO26r3QDbT07dTsMfMB8Y6H+qBzh-PQxgcTTVKqJ7C9yv-emsQ@mail.gmail.com>
Subject: Re: [RFC PATCH v4 2/3] rust: add minimal IIO subsystem abstractions
To: Danilo Krummrich <dakr@kernel.org>
Cc: jic23@kernel.org, lars@metafoo.de, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, 
	andi.shyti@kernel.org, wsa+renesas@sang-engineering.com, ojeda@kernel.org, 
	igor.korotin@linux.dev, branstj@gmail.com
Content-Type: text/plain; charset="UTF-8"

On Sat, 11 Jul 2026 at 19:12, Danilo Krummrich <dakr@kernel.org> wrote:
>
> On Tue Jul 7, 2026 at 5:15 PM CEST, Muchamad Coirul Anwar wrote:
> > Add safe Rust wrappers for the Linux IIO (Industrial I/O) subsystem:
>
> Does IIO's iio_device_unregister() synchronize against in-flight IOCTLs?

From what I traced, yes. iio_device_unregister goes through
cdev_device_del, device_del, sysfs_remove_dir, and ends up in
kernfs_drain which waits for active sysfs readers to finish.
Please correct me if I'm missing something here.

Thanks
Coirul
