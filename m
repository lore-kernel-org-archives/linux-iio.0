Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1D692DC321
	for <linux-iio@vger.kernel.org>; Fri, 19 Jun 2026 07:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781853656; cv=none; b=DxGlxZI32mcIeeHFfboNta3ZwnuyBLQHU3DmecaCm7+vyrOyeJConvYqqGhL2A142ADfDAnHJhVs9oUbigXjbxWZRNIcjQ7F/iAyn6ltiBtFQJun1mcKMJGGUumvyrP86TSSJWJZCaptOfp2GEKpMbeRNmSBfb2Tsxvjc8cLWGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781853656; c=relaxed/simple;
	bh=bUa88mQN4NWcZMiK4de2lIEq0406H0oitLk8zwau3XE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Nrk3tLCl5nvXV9m0an86Yf6//iyyO09tCnKvorBmPNDevbndp7WbZI5VsVp+fUitqv+90UY3wMEQac37qxbDmU8z3Oz7wfI8iGoRMyzOG5uYpvPUEed65z5xTgi8vM6yOYiwTnUl9KiTK3bf3pZBw5YjN910JIvTD0+NyOyQJl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HnhnsdjX; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HnhnsdjX"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-490cf3000f0so18642515e9.1
        for <linux-iio@vger.kernel.org>; Fri, 19 Jun 2026 00:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781853653; x=1782458453; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sByovQZxDoYQv+dwt46RHg2UDqGoRyWhJLe38rqHMwU=;
        b=HnhnsdjXCJZqlT+7Z1rUcbl5BBT0/OHsLYx0HBnxzgMEXCXaZhUqFCdoLfinPZCVut
         drymE60A8BC8FYxfOB8N2sVSAOt9J6midqtczpDNiQcjeFz6M0aULdJKwc5InSGdKzM4
         XDynaTLzHoPCmciCxrKpwSBFD08Brj4XT7F3g4I3gm/3UPfbHKaO6/4Sd64Lbh2Kq3Ez
         TZ/rTwI8Hy4Eq2K+FILanx6LaWQVcH3mqnNh+HmpnOl49uYC0p2aitYbs/bmiw8gR9pz
         LMVHb/1h+UfHvQZ04XF0QfwuC/oj9/kpdCeav2f3JTs7NQNCY5m85T4gH1otrSdCWDjP
         4o6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781853653; x=1782458453;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sByovQZxDoYQv+dwt46RHg2UDqGoRyWhJLe38rqHMwU=;
        b=fIjG+kylQpSfIk97uFRDMwevcIYx4WSoUTf8GGIihwbHuGgjULbgkRsaWI80kuDOl7
         +MWCwFlN+W1gd3MN0+VjUPMj7AzhxuKL4scGgzOfQ3RMf500izDL/Bj+3aiygG+eIVX/
         M7sDDs/tNrUHKSeQOBgArE8ahXcXGOhApX5jHrskJ+1ExKssNxkh5E7fK/4x4+YUwfGK
         ST5vDj6K/LB1m6WyLg/Ss8zlVCqSHNG+umV0/gAuQBKQjYMilKkOxN7cEBN0CZay+Orb
         QrhkqP4BUeumm54ELV9BiMmIZ10o0gaVJABNQ57awMHbXj82JVsH8ZH6gD4HGO1wVZ9Q
         aHlg==
X-Forwarded-Encrypted: i=1; AFNElJ+sOro5JVLXL4hn0E6d9ZdDOx/YEEZKbZqGyMsKc08cs9Nf164HavNJUZ5P653CbIhH24XGjUpsQnU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzv0QpZWReRozj6H7IiGyOCpkiERvVMkFMq45CgC1PkbOHP4Hog
	ybzXbtgq9I3Nnn8Jfx/uZP5TTzWXf7TvO5paWazc12lNw9nNzB8bhKOi
X-Gm-Gg: AfdE7cnMpGZGwuvpDoNEb6l5nbBhH5r6jwmcvKUgtjZBSNi4zREkjkAUVa4ALgjGs+/
	Puy8iOIekLGLvYU5F+bVQLJ97zGP52neMt1pndi57LC1+EhV9dWJAGsKb9ck9zMNbvikSfX7yDk
	r9WTwgZGmItwyOpgarctMYgYbkAfHwBn0v1kzcR/QjS2J3g6DY1/1Zqefy9cWK45p/C1rLLI0e8
	zMo9A4UDcJXAj5SjLTfGqPoB2mWFTl/xRYakCFlJl0gJCRSrSOHJ2ao5bnz0RMGprjIdSW+bdkx
	1JGZT7chtQGwkQBNNRwuxyoPKV9x4eH3hRdmVTmU9HV4CzqvLWm4rHE5JptGQukNfYbzk/bpWZH
	eCyXZ/2qG1h8eeQQEGBFJXyI2xcohx59xZ5bPr2txKt4+zmZWI75sYallRUrOOr7xzv8Ot+W3GZ
	PzkiGKfUJzKfXxrBRo5xvuFF7MjOhdlW6591+om9/TxvvXqsl/p33TO/5oeCg9r2HK4WvDDP6nz
	KxZ+FApUbaqDgZoGAHFUN8L8UXmb1ha4Iy6+vP69WUBDqiXFmD53MZ50vfbJKHlua2XYyfwyNvD
	D3N9iznjQo81JOlFpXWpxMLz+8/Abn/jKMRqBw9/qgZPscq6WkFPtVE=
X-Received: by 2002:a05:600c:3f12:b0:492:40f2:4d78 with SMTP id 5b1f17b1804b1-49242326cfemr16873635e9.2.1781853652947;
        Fri, 19 Jun 2026 00:20:52 -0700 (PDT)
Received: from localhost (90-182-112-124.rcp.o2.cz. [90.182.112.124])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-465090c51c2sm4967880f8f.13.2026.06.19.00.20.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2026 00:20:52 -0700 (PDT)
Date: Fri, 19 Jun 2026 09:20:52 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Mert Seftali <mertsftl@gmail.com>
Cc: Maxwell Doose <m32285159@gmail.com>, jic23@kernel.org, jelle@vdwaa.nl,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: iio: accel: dmard09: in_accel_scale always returns -EINVAL
Message-ID: <20260619092052.00002344@gmail.com>
In-Reply-To: <CAA3Nooq9J67DvK1FQr7jmnvTk8LvYRj4m=6+ax1d+xbu1eTq2A@mail.gmail.com>
References: <CAA3NoopBN5qXGvcBY3M-oxXzez+up3-mXZF2kqtzDmnZ50T3Vw@mail.gmail.com>
	<CAKqfh0E2479wCvQCRq24vB7r6HP7tgy6YKEVF1U0wHF=uchVog@mail.gmail.com>
	<CAA3Nooq9J67DvK1FQr7jmnvTk8LvYRj4m=6+ax1d+xbu1eTq2A@mail.gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 18 Jun 2026 18:08:58 +0200
Mert Seftali <mertsftl@gmail.com> wrote:

> Will wait for the maintainers call and If they agree on
> implementation, I'll try to reach Domintech for the datasheet first so
> the scale is a real number.

Did some research with Gemini and found out that Domintech went bust...
The cover letter for the original submission mentions that the driver
was essentially ported from the Android driver for the DMARD09 (the
Github link for it is dead).

FWIW I found a datasheet for the DMARD06, so maybe it could help
https://www.scribd.com/document/358640331/Accelerometer-DMARD06-Datasheet-V1-0-pdf

-- 
Kind regards

CJD
