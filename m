Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0007449EA6
	for <linux-iio@vger.kernel.org>; Fri,  7 Aug 2026 15:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786114970; cv=pass; b=tzAIiZG5X7AApbNt06F53KiaFtxeSPd5WAlaHIh0rocXvJoFvNj24P87deqz4wx/yhWCgtW9O36uLUz51jINZPC+Yn/ZnWQaNkwAFWF4zsIb9BQFKjN9d9amCsIqD0z7Xc3q/OtluFMZmedbPfDlHn6N5XxZnCa+66+CYk8XJjQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786114970; c=relaxed/simple;
	bh=DCFU6ZI0LwywVJNIe9szuRW7NRPjME7TGQ0rZbGWRSI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bBl1dMT+jhQBLUtisF1jVFnkz3t7DFjbH1dmx0mEVlcSFp2mJhGApn2m8VnB5dE2lg78on47Gg5j3a2se6LRfraKKE4QHlkXGIdAm25tDS5Vqt4FLTnuQhtJuzbdqTFoisBGYsoMmGdWa6cLrZCsDfA6FiouDDkJzg97CgruETo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qVOXbUUO; arc=pass smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qVOXbUUO"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-49556f97a9dso22810135e9.1
        for <linux-iio@vger.kernel.org>; Fri, 07 Aug 2026 08:02:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786114967; cv=none;
        d=google.com; s=arc-20260327;
        b=U2IGy8XYXWQrdmP1UOxkf6V+r3OYEeu/dDUvm3wusMHD+ERJnlKOY5RI6uhC1ur4us
         P3kx/ZVLVt0iGz1/VnaYGj6S5+7qs5yPYNJxqpTZObijda/fde/qWNQIHYVs9c5Z9/rZ
         VP6MWXKKj9rdCBPeNp5d5vCpsOV/sFjeA0S+YZ/VE1jeH/3QCqNMsOOyIggKKt2+79id
         kTkdJzjeMDhW5n8cQblnEKk4gyCdiQJZa490gOrq6ODqAGIvbI3DucX63lH/cZxiwqyw
         eGyQvgSEAj6aPl1KOyiB4/f65hjdw244JqVOp5ESL9o3FzVReFLAOPSWT0NSHWG6fExg
         wBwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=DCFU6ZI0LwywVJNIe9szuRW7NRPjME7TGQ0rZbGWRSI=;
        fh=n/TcpjQC6MXW3S3+72T0VdE9iRc6YMnh8wP0/vIdEYE=;
        b=UQ/MZLAjEIa/02yelqH7eTqFVsBWEenFcrhwdy4dJ/Glhs5Oqv75gL7c9Q7RcY37F9
         aS535va0WzEFGnbPmzpNV/G7mEcfm/jzkmVa9UwXS9snG/ywv+A1Q3ucuXhMg1mvTGMi
         ZTvunyBZsvYIjYB5+K/Bw9VR0jNtV/01f6prktufItCGYqPqklLGBAYr+CVLFk9QvTkI
         vxwTEOtXKu4Kv+bdpphdcfmdvww27as3O6C6KWVGPW5qoIr4vzJAS51RFGCjzPpybCoK
         bCp0D2MFuLPUewsr+KIE0sjuVvDdogdK9yEHUKQstF66sRpKI7HM2lCF/DZ5Jq82Plgo
         ISHw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786114967; x=1786719767; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DCFU6ZI0LwywVJNIe9szuRW7NRPjME7TGQ0rZbGWRSI=;
        b=qVOXbUUOnmJlyeWxxh1DGYZ59dhawvWMeWB5nLExC4xUZYuSPSevX0HmrfskQK6qPV
         ZdkBGq186k1VFesbnCkfmaE71jHlCzRU8xBYofj7FUdChQmf9Yc6cYUGZfpIRXuDfqe+
         fbwctwOt93IivxdMv6qoL2oHChtIetUtFPVRCOuiUJsSQBTUjV1wvZH5/qYQnSzy0NFn
         ykIa6Q81AcT9zi0LaN+8y+HSlaabvqXcJP3mHz23YGNWJhhpBPY/HIIXu2U6lQJGgjbm
         ORrWn3QNwLahZpFru95S97osbFyuKQG8tWSmLMo3hMNsS+n+l9vQF/mEBkQvdWy417PD
         gVHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786114967; x=1786719767;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=DCFU6ZI0LwywVJNIe9szuRW7NRPjME7TGQ0rZbGWRSI=;
        b=pUvWwDuOG4nEVa2h8y0lLyjzzaJrzgFlI1mejWePLJ0k0RKDjfPDCGAk8SjWQNCvCH
         BrMNY8bBwZlK1KgCsmgzo4lH81VaGQ8Ack2gZWRbmlljxf9lf2upF09uOiGqeGREx+ZU
         Na8Qjs2a7/CTnN8rKTn0KhQlPen0VZk3XIASb56XjxPKahyA3umvAfhnlMLPvfRKlIQP
         QAneEKKgpupE4V3Mx2Yp3ufRL14IYEV/eXRHtH2ZFBhIw/kGGE9U6CXDwDRnD86vkN/U
         a+FLKBy2IUtH1086RJspToNeo38NU9i8AaFrqL3A95hPmD3oyVmmpzBBjr0+E1AYj8XJ
         5YZw==
X-Forwarded-Encrypted: i=1; AHgh+RqdR48eQe+Pc+jUkdUTZnGZpBwE/wvzZB6m8YJtNwKuOrocWRPqoOtt+Nt/fFtqfBlMSOZJdJzHCYw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaDy/jYa85102Tj1nwjK2nb3tqtPirjY2IWNBEH4jBDtDH5TS1
	gzqGrzdYxSQto5jpxEtK4pDPzs2ttyk3XpnSRoBWUYRh70UDOFiBX8BzLrvtdJLHlfnkgJFB6I8
	i/+CoplHq/91lKpgiSKoOO2IXFVFGBTc=
X-Gm-Gg: AR+sD10JOQpFbENNl0mhGj6bMOlzd7HTSNXwVZcT5P5zGPVT2t+eEKaSh9B2WMMW8cU
	84o/jlcjrs2mycnlTBMJmvoSZKr3fC1QV6qFa25hxm64MHyeopCZYfMkR2f1e63RRuSejHk6mCs
	JiH3Zmz87I1rnEWKYuIPE4h1kIqdc/Egh1fnOUAhqDWQ34CKOuOyfhF9fV+4/mlPcLf9y+bqoL3
	wykn9Ju23MzOOP+0MlLQhD0aZPN6NcRKM/VXynfVqnsv6focMs1G4vkzUWr95QZb+PAvI/iwIv0
	oEB8N/1pUTu2qAdiWU3FpDtqMuOJNXTCCP/lf9gllqCelB9dvYD4dQULf4zXsb1RTJ+apkwwJSv
	UDAGHTOW7uvCIjiHiXyAMc9nDharOKs0GYYqpF4II8bKt/XrMc/J9X3A+BWzwUBok3WCfALRF5t
	ywfNQOhepy0UaV750Sa4tG13jl1pOwnnizyutcZ34wXgCq5IeBzh2cRJwLsXw2hvodsiNYtlEt7
	fDMgZ+gRf0fqyThVGPZWH2+AQeV3kCfbloKcV13
X-Received: by 2002:a05:600c:840f:b0:496:bffb:fb7b with SMTP id
 5b1f17b1804b1-4994e7c0446mr292266615e9.10.1786114964433; Fri, 07 Aug 2026
 08:02:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260807141938.2491195-1-lgs201920130244@gmail.com>
In-Reply-To: <20260807141938.2491195-1-lgs201920130244@gmail.com>
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Fri, 7 Aug 2026 17:02:32 +0200
X-Gm-Features: AUfX_mwPjWUC-eFDTxy7sTbry7TIjOL0nXNnuA5P1mzfuoDNmoaTCqn2wPL110g
Message-ID: <CALoEA-xEgXWaGxQwfh6HsrOMkjjCeOf5RtO1GuF7=rvN6ff5JA@mail.gmail.com>
Subject: Re: [PATCH] iio: proximity: srf04: fix runtime PM autosuspend cleanup
To: Guangshuo Li <lgs201920130244@gmail.com>
Cc: Andreas Klinger <ak@it-klinger.de>, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 7 Aug 2026 at 16:46, Guangshuo Li <lgs201920130244@gmail.com> wrote:
>
> srf04_probe() calls pm_runtime_use_autosuspend() when the optional
> power GPIO is present, but srf04_remove() does not call the matching
> pm_runtime_dont_use_autosuspend() before disabling runtime PM.
>
> The runtime PM documentation requires pm_runtime_use_autosuspend() to
> be balanced with pm_runtime_dont_use_autosuspend() when the driver is
> removed. Failing to do so can leave the autosuspend usage state
> unbalanced and may result in a usage_count leak when the autosuspend
> delay is negative.
>
> Add the missing pm_runtime_dont_use_autosuspend() call in the remove
> path before disabling runtime PM.
>
> This issue was found by manual code inspection.
>
> Fixes: 2251157b335b4 ("iio: srf04: add power management feature")
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> ---

Since this has a Fixes: tag it should also be marked for stable.

Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>

Also, please check out Sashiko's review on this driver, several
interesting issues need fixing:
https://sashiko.dev/#/patchset/20260807141938.2491195-1-lgs201920130244%40gmail.com

Kind regards,
Joshua Crofts
