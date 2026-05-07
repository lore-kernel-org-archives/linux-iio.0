Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF8083D8901
	for <linux-iio@vger.kernel.org>; Thu,  7 May 2026 10:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778148888; cv=pass; b=g6/T5JhknfnkjAsu9PMAljXzmgvlmguYSHKR2yFTSZ2Wgm5jIeNmEuV5Zv1wPSHR25+Po852NNZn/LzrT/QnAa/6VdeByjHC/PjOLKHXVtSgQEXZspvcTv4yADFS0K+e9dNa3WegbrxJs+pAm+4SmJMhTKWXCavNTycX1yXe2yY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778148888; c=relaxed/simple;
	bh=RfMXIYrU54DsFz7mTkL95eZWn2cpdHi22i3Y24nuDhI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fvjRyr+pzwk/sSExxDysLqVaQ5qv+JxCHyvHwT1uGuZ15yBjfhIOa1OeCpUfZDcnlQg+xwOzdPoeHlRZOJx8l2nA+/EjwcUwfmqzbTSR5VIR/JoTFAqVAc9XQQPoAwiGsOEKBJDqShSv6uDVlkWg7lsiM1jUn9m3aQ2f0sAG38A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EgfIOyqF; arc=pass smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EgfIOyqF"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-44a044cb827so537647f8f.0
        for <linux-iio@vger.kernel.org>; Thu, 07 May 2026 03:14:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778148882; cv=none;
        d=google.com; s=arc-20240605;
        b=UXuUJ3EHvMi1IBav5yr9p2t6moe+6FnuseyjnPOKVJKyRbasGd2104tTz6fKTJ/Men
         zNmwF+vNXmV5TTMhKfIC00gfkMJ5XEcSNrTN+J7gywP7/h4ysW7FKel+0mBB98uf1+DS
         Et9vFdq/gQQhEZYcz06yoxOHzWjfud/+qEWbeqRjJBsZpd+lxFz2eRN/hbbAiuTUbDdK
         CeYL2OIqq7bx/zaGVsGibg2nDR/4dzq+u9Kt2If8uoE1nbXy2YBodArJY5aiG2bQ+U4I
         w9c7l4BLS9cQ+Y78Wd43gPC92OkLzhd5niU0A9PPD5Lq5OXVpANbEJHKmCuU+7iEFB5m
         QxKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=gbKf8cX1YHmhO2c2DfVdrD6RA3iZbuTl/8vlGGgihME=;
        fh=1TBflLN5mzx7ug83JDLmxJloRwrSkGKFtL5MOH/Kl+8=;
        b=ZDlP8efiCUoocbdj1HwYprnVKoZcm53jVThHBALU1iR9+mw7owBDE1wgiyJFYUdQ27
         IqQoS+UOp16Lyr9bnvh9auYEXyPjfZR3ch1xZSrisKqoeYPYisNOxiOkOOlvylO9ox+n
         2jdQRtYvztVWTdcrDlufOErIalnAb6jJWtNVLj8SFWvmO1EHjBQPFm7t7D/uRnKS+YjL
         lAL9fJ/QCM6a2UZkABl14k41hE6TiLyDLF5X0xPIBBiRlNHkcAwgfTZYO3LVrmsVlu6T
         CAeaBPeiFSvoNgj13blGE2QHxgAivW9osBeCyMV4ALEBR6fWWfZh5uq6k1t8cLB/Iuqq
         sugQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778148882; x=1778753682; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gbKf8cX1YHmhO2c2DfVdrD6RA3iZbuTl/8vlGGgihME=;
        b=EgfIOyqFNBTkKdn/GU4prHmIx+usO4X3/oV9WCbArW/sT7zKB+IJ9T5jXkM14dO3/k
         tUUkFlF5I3ntF2TFhmc755EMKFRp0GlnxfwuHT2BL0ys5aWKeW7sO/mwOrhqldEwJERO
         tRztBlH8ns0SoHRNVfK3TIEHWlIXqEnS063nRhera3i1QHnWYqBfI+7X5CcFQA1/9iXt
         lG+b3+2G1FXBnthiI0gOuZoD9VpWagv3Dm2bVJo7pPvAAM+BKv3ykX7I3zPX9K22AkG+
         +g5iSks7EEK9QRTPJB/bl4snMFpN5HKV8jCNO4uRV0FamwrX6ePogl+yc8+Wthm9Yr6x
         MK5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778148882; x=1778753682;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gbKf8cX1YHmhO2c2DfVdrD6RA3iZbuTl/8vlGGgihME=;
        b=Mh7Hs9celUBOCslQFnUyx1Bc+KMC5DBmPgvQJrdQqqaMWHSUsofJEKpnEvc93gWGRo
         uYIApCo6gZlreUIjgIeO/9fNgLcntxBFqhBw4XtuxjtRDdwDctV6Bm8rtf3gq+lpMoAo
         JF8J9UNC+yTUJ/5WJEiSlx64PkbKWo76lGvIF6DAfez7CSU9wLUMvn7VvvBXF6K6KQg6
         d3OS2z1pg2cxKBPSxLhbdA/4oFDLH9sNUiK7noSOr5fnFSIUUs4GIA4Xp+9aTpGtDiB0
         A8LHDUUR1GOsqowSz50E8ON6KrPoSN/649WTe0qGTcCm8g29Rjidnm8/vKHiIFchMe1X
         /N4A==
X-Forwarded-Encrypted: i=1; AFNElJ9uWqfHiz8qLkJlkGLV8557z8ZXqlvUhOfgYxZ0AOkSXmWAw+6eWXDIhYGLLrvS3iHUFUjV2JvldDU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1uOaFm1o9toGCFvJoWortu0oeBkR1VhEWD6NuqDh0f3LaWEVc
	M0kY+aue08R4lyBc3f3CKSuI0vZ6Uof/yPRlkJszPqr93euXJq8YNY6jQnI28WijottGrRaYM8y
	OLxICYl8vYO7KHO44P8gNd0CBKJH3tfKzot+7
X-Gm-Gg: AeBDiettqt9tdsdL5Zwg3QqfXm/qZ0pyPYtROqC0NRScuYXnoBTcnzgvhjO/4fQ+Ly4
	u9gnaSDq8c7h+/hApfVB7dPgNgqGxfoqy8k8PZSczsNuFeO4pd5ZksUG834Mdf7lOUGOMR0AR86
	fI0F11p1Ytdcw8MpUhbL0vHGgxtjwrM88hilA3wmz9RyX25IlFFI7zY/oxrv/0k4Gfi2a9PYyAR
	2AkHDPgIhMZQ3Xp3CphduBcuM3PwYQbwDydUUyT+IlcQjoUhBVuSiGvqn71sdAzJQKiorUmJDhm
	WRiFTGIa9164ZfkKYME+siehO3myKa+XQ2n76T3BL55eBwDDxO/nHXP7jxRHYIJ1YQkjQCQTGcQ
	ZbEMKHN0NHTcUkUrsps+Uqx8uhKWM97t0MranGDx3xnMuxenycLXgYW67jlsezJkesKDcyS9jN/
	05daxTvnYR2hIthVxn
X-Received: by 2002:a05:6000:144a:b0:439:beb9:5a96 with SMTP id
 ffacd0b85a97d-4515d3dc683mr13374269f8f.31.1778148881573; Thu, 07 May 2026
 03:14:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260505-magnetometer-fixes-v5-0-831b9b5550fc@gmail.com>
 <20260505-magnetometer-fixes-v5-14-831b9b5550fc@gmail.com>
 <20260506180925.3fb80edf@jic23-huawei> <CALoEA-x0baxV+9-rsN9omJ9GnLw3zp2qmU08RjzWniPOU+uxKw@mail.gmail.com>
 <afxk7mDvc_-IHVDy@ashevche-desk.local>
In-Reply-To: <afxk7mDvc_-IHVDy@ashevche-desk.local>
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Thu, 7 May 2026 12:14:30 +0200
X-Gm-Features: AVHnY4I8llWvDOCuy7ra-SdaHRPLpbj-GXlDgamAyITEUzOp79uGBjcnGrmPqUw
Message-ID: <CALoEA-za64VHBpw1Zh5LzvhJtgViwq30xpPb3NGMkuh=0_=HXw@mail.gmail.com>
Subject: Re: [PATCH v5 14/18] iio: magnetometer: ak8975: switch to using
 managed resources
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>, 
	Joshua Crofts via B4 Relay <devnull+joshua.crofts1.gmail.com@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 7 May 2026 at 12:09, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Thu, May 07, 2026 at 11:19:32AM +0200, Joshua Crofts wrote:
> > On Wed, 6 May 2026 at 19:09, Jonathan Cameron <jic23@kernel.org> wrote:
> > > On Tue, 05 May 2026 13:46:10 +0200
> > > Joshua Crofts via B4 Relay <devnull+joshua.crofts1.gmail.com@kernel.org> wrote:
>
> ...
>
> > I'd just add pm_runtime_mark_last_busy() and pm_request_autosuspend() here
> > to make the device suspend.
>
> pm_runtime_put_autosuspend() is exactly doing that in one call. That's what
> documentation says about, and that's correct, however it might be not so clear.

Maybe I didn't look enough, but I couldn't find a definition of
pm_runtime_put_autosuspend()
that actually calls mark_last_busy().

Either way, it wouldn't hurt to add it manually, just to be sure?

-- 
Kind regards

CJD
