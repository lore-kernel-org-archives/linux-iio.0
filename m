Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9860834CFD0
	for <linux-iio@vger.kernel.org>; Tue, 28 Apr 2026 06:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777358257; cv=pass; b=cJsHeEayCTAtFxCNugooLVTMX6jOUMDhD3ekfiNW8hmLyqR73P+sznv+O52K6/8vUao+BRTau1X3UrzKUbrHY3rjxp0aOfY5jDEOdkonchxloubEnbkYKqIDFmDQYx3dsMPP1rFX0KXs/b/h9lm+G/1yFbQZJLAahVVF5V6bgFA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777358257; c=relaxed/simple;
	bh=osWR1yArc4zGV2zLjpeEpAJ8pec8VvGAjLkx0B3n0ZY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bWGSu3Jr1e+PEh+/eUb59YK1y2vyZ6lboF2cS/5ieOht4oKbI53C8viaIV9LJLVUZCGyKIXRJjrvPCBOwUiqWIZT9RImwJNgZxiihJnVbEXDiyMYxxSHqs6jdAYLQfUVMMkjl33lb2qVO7+b+3PiV7E2IDOBhFMY8MDWBnuNIy8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ggmw/k1C; arc=pass smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ggmw/k1C"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-48374014a77so142487505e9.3
        for <linux-iio@vger.kernel.org>; Mon, 27 Apr 2026 23:37:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777358254; cv=none;
        d=google.com; s=arc-20240605;
        b=FqkrUq34xoYGwHWQ8cb49M0epwJBx74IkMGiFUA0LZqMs+mHt8QbC+HpbRcelWw93u
         ZaVk4Or9QGHmsB8YxSbNT3PvQHZkzTGROeBAVZkuORhr9yQnOCM2UVEbPS7RAR2yFjOo
         S3j2uJL7lnELOEjCIrQSM4d9vL7apTc/xCaZYbKQ4cb/xNEwVNRvK5Zk2/WzMZXnITHr
         pDqceiKji76bo+kq76jlnJcz/TaBYN1bp8b4+bHvgYvzzQitX5gNGMFwuhxQat1fa86N
         pKKeD6ue/T2J4Aqq1onW+3xyqov725iDDIeCgT2cowkeuGfjXSa2XgrWem4521NJ5bxL
         r49w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Memd8e5IDgRhLPyZ8bT1Ft6csbDkVIoEM+L+Ot4uiio=;
        fh=Dg5zoWqUx76h3UPcxsppTHY72IFDoZZoazTlpye19aI=;
        b=aS3RLL/guAr8ODJMPVAHFWF6S/Vos4BJlM3x2JJe7QPklHMqFFWhQn7Ilqb3c/98Dj
         hon1+pGCNCQacOdWCXfHodVHbhyUbkSKsXgwgqsMB8zH5m8q5tkBS18PAq0wFZMgeG9X
         COrLA3Lmz6Xuv4KiV8x9F+RmFLwiJkKqdxhAfUHaKvwaBOaYIXy04G1QFg+fDsYCuu/C
         aeIot89tev1mNnxbu7oBg6SXkWbP37fcV9xSjT8c+KzfKo3lvWBmz/PxiP/dtfiXdPay
         AwZbLJGvLEGDgyPkkJAdoA1dLbeJy2tZELpHkm2LbHnkNFU1B8iu4RaQZunNys2QLE08
         i3Rw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777358254; x=1777963054; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Memd8e5IDgRhLPyZ8bT1Ft6csbDkVIoEM+L+Ot4uiio=;
        b=Ggmw/k1CQlVnSwGV3chDyzRmRPfnwygctvNAFDO9r3uNt4u7FauwcYFHAYpLSvW53X
         Yyqqrd5ZEC4aT47uUAPepFksAWzAdhYm7SsknzHSv/ZVdCNsXbcJBgvuIcaFEV+iBJRu
         pglI6uWjZq6FPoyBP+VliQx79o4OnMs6TfbshPn/zperqAYUe5jpd0sqUAmeDVp4Azbk
         9+YaqcUFkfrux4Jnu1doW3kNhsgeq1zXc8Z7cQxZ3a7B6nPsolTbOpAuISLMC65fceaL
         OPUYVmuD5iT03hqeJ4LrwlZYnK3sXCodi2ZML6N+3HPIh1ySmEWCn9KIR2cX5UKL4DA4
         buOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777358254; x=1777963054;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Memd8e5IDgRhLPyZ8bT1Ft6csbDkVIoEM+L+Ot4uiio=;
        b=gffk4O+XH//+HapiO5y89uZZE8dmjf6JJrzQIZFC3Ox/ru1BAS9givf1fa4LwRo4CZ
         +8D/yxKHLyS0SOedt2/gj2ncMRTkDVF2aDA13vwfC/cjeEbbS41xWkElKsRlgKTmWIfC
         2xectKiCK8X8BJ3Ot1F3lOKLCaa7GXzu+P7pl5Xv5l3mN/IMbyjlPFkmd6TD+wwTar8Q
         Hk0rPUQE74ybkDNUAP2B2cq14fyN47QCG1gDCrYF/WSKMVPXrRIxVpyCEt3PZaRIXQX3
         8uoi91KgYZppcxQiDP+kMtoYES3qaaG3KZ9rwrGAIc3shd4TqzgtmkVjdEF0YyZRzJOI
         045w==
X-Gm-Message-State: AOJu0YyzjFXGoWAccqiDYdwmSRO0lRpAYmxdFadeylaFhRJLyCgorRyq
	0T6LKzV1+TtuuYtCdFuwsgTiw5loQflzK+yiuusMKzZDeH7mBhfc+NOQungE+uxB4NsgzOjb3mn
	xJLU7QN5LNkopYyTQDb0SAfN1xku9BIg=
X-Gm-Gg: AeBDiesqcmKBblgHGgGP4J5ihxCeC++e7ZT6nXdqeSGddzytxT/ruEfEwKf7P2Nk21r
	g6XMv883YUi2XFc5yuO3heyIK4S10b9hCxrHBv+MFPwofW6aZxFidmEswjZi1GnMDiQx5r2vCWx
	O8yFNGbuccr1MLkvrTH5D6v1OUnVR00zTqW56uLxpcS7iECghFk5ylr4HlGfBw9JT9Hj0OAbFrk
	cLjp0gl3ChksA5cpx9kn2nEFTZ5Rvwtpt++P9uuFBp1CAldIjDU14VuPHoyYVgLsXZPtIX/D7bF
	YO7oHyxEt2Z2T7L9Y094pmWbynwF61pIiA4NsbqfBVRp7Nvhij0qi1624Q8hG7xoLAR58LfDt3i
	FOBUS6SR3KaThH9f8wJ7QKIiOxkvSqA3z1tka3v9mWqriqWCnYGUh2yln4GYZGJ5hjvYbDImzKr
	y/vwh85YRrdfE4BqiU
X-Received: by 2002:a05:600c:3b0f:b0:489:1c32:210d with SMTP id
 5b1f17b1804b1-48a77b0a507mr24484075e9.15.1777358253676; Mon, 27 Apr 2026
 23:37:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260427201412.3067235-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20260427201412.3067235-1-andriy.shevchenko@linux.intel.com>
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Tue, 28 Apr 2026 08:37:22 +0200
X-Gm-Features: AVHnY4IIG4iiOSMtQBZiITnJg_LcQr494FCjGxumTdOLJhBeMEpFttJOEhxirmM
Message-ID: <CALoEA-wCTEUA44ST5eg1EyHQTEop=wHn12NGddyqzPMa+EUZ1g@mail.gmail.com>
Subject: Re: [PATCH v0 00/14] iio: magnetometer: ak8975: Additional changes to
 the driver
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 27 Apr 2026 at 22:14, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> This series is an attempt to make the driver less a rabbit hole.
> It's a continuation of what Joshua Crofts started doing. Hence
> it is based on his work and first three "patches" here are supposed
> to be folded to his series accordingly.
>
> I have compile-tested them, but I haven't done full double check of
> the correctness from functional point of view. Joshua, please do that
> before incorporating into your series. Yes, my patches are assumed to
> become the part of Joshua's whatever next version of the series, that's
> why mine is marked as v0.
>
> Should not be taken directly by the maintainers, but any comments, review
> are highly appreciated.

When you said a few changes, I didn't expect an 11-part series :). I'll go over
them and am them to my branch. I might check out the guard()() and chip_info
changes.

-- 
Kind regards

CJD
