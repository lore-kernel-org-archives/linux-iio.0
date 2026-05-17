Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B941F3B9604
	for <linux-iio@vger.kernel.org>; Sun, 17 May 2026 14:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779027989; cv=pass; b=gc1Dwgc4qTToU/iODr8YcOp+oNafGEDCAWMdjmLwPtF4Fy8WjKg50AqAgLGoHGsqtLAQWByeo9OVQk9eF0IFVXQ+PNXYEfXmcMq2iSJbr4fiCmpMs1V3BLFJjo7ZCd/+y/OKA37RgY2J15B+Pnx0aVVITK82ZuWHYC38ScHejWo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779027989; c=relaxed/simple;
	bh=Gkvz8FuV+k7erKPiRfZE7MtCx2V48IISIIAtH3VnUDI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EU6ibkYlkP6R4Dd4b5o+i6HCz2Dhldc2tXkiC/JfiFoBiELXaKSRXaSwtSAHlY+RanEFfF5PgN0F8UXJ7QEHyKOZkzgPdykiTRlGsnULw+1MYe+Az3f60wY69+ML6l5QwAjhivfKhu/bORG9qQg8I4josnQC9qPsaBvYKldvzuM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W3QiGTjx; arc=pass smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W3QiGTjx"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-488a8ca4aadso12773625e9.3
        for <linux-iio@vger.kernel.org>; Sun, 17 May 2026 07:26:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779027976; cv=none;
        d=google.com; s=arc-20240605;
        b=KkYlHx+u6kzoiw1EXPOIMKlMGzYl+5CGXqlhYzinCK0jDHc+i54eXAfdjdGFxXd9bQ
         gT49chlPv5lq1+z7Dg0g/T1ZBwiAlBcpq7VHeFA2Tn6g55U8qY3ulKAkYwDTMgwSa698
         CwU86rniE3J3VFDlVogbc29l+vCdPiWgiMVo4b95Zrx2mIM49A4i3V2D259zQpUNdqoG
         93H6IQB2tFT8ES2rSIrQ0mi8uQLamfdu3nlaSimR8yT/Tw/6/kv3WoRY014RUdJVNg3B
         9CF6X6tdJcQhQ57NLyw27bNHs83qtu2f+WRR6ctkH1FnYbwcVIe3uGdVM0AOwMrLqO35
         J5HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=kIbD7lOBiblVhxTn7ntPA7uMa1vlKZnETYPcj80Vvo8=;
        fh=jqxKdlmwEJZvUkZNmUivqrdoCjINnfqd94cLDJANw8k=;
        b=ZkvWCqXyVzmM8VrfaG7piykpln+wqiAvGlDzyoMUlwaPeD9cXU3l8hgF+JhSvTdCUj
         YN2le22SzHo6ZSsfo8UnfP+ja/1Fc5tnqPc+8StUX8xcxf3mErh9AkS87xAB4guJTLE4
         1uqaHoTLx3kdJ4VCw6CSaewvYSnpWR4VglbnMc/r3hg9OgWYEW0Ql9++MixayhX4STiH
         ZObglpa7HdR1VkIGAVAJl85l3oBi1WRMoFENPyNE2S8B0rTNIlHS86sm7E7rYQq2vCIU
         SlS+s/b1r9NDhilmFKsvdRj+7t7ewZQSYUYKx2nLJllzKwn6rT3YJowrGEzth6pXRg9D
         pKTg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779027976; x=1779632776; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kIbD7lOBiblVhxTn7ntPA7uMa1vlKZnETYPcj80Vvo8=;
        b=W3QiGTjxJSLX4FELgVBQ3CttmWlCVUpHgqPhVsRGmbuGjEaixkYRMDIw3UveuCTkRb
         bvOL1yh8KLRd1IDpz89ApYVywhbVwthsH9PYtm2/0Uc9JzXbOW2ZU1VLcp7ZAdYC+iKW
         TlzkQx1nQhZvXNl2pEsECUO6uuqqp+nIYb3E/342avK12QBqXfHfNs/r7VGZcQ9tgiUQ
         /ou7tjYH3pzxnR3mIwTeN0zN+wHlwMdcD1BOMZVeU67p/2up15QQHyrvsf6eFhfhQYqW
         dMbNf+h2WANqcZ6WXwT/jeW2Zqf9IOw0QIT/bzWlq0vWTgmCz7BL/hPs/Lqi0gxOthKF
         IScw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779027976; x=1779632776;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kIbD7lOBiblVhxTn7ntPA7uMa1vlKZnETYPcj80Vvo8=;
        b=TkbAq8W+5LZnG02eGyqehFte3RYyYPfy6+h9Pgg14SqtOUjJCUOZu6roAaYvXwtvqR
         M3NNoP6X49FFUluXaBLBHaXpqsxmjISAczqOMv86AcckC0k5LHz24+nqQgGZtDLOLyEf
         hUBYJJ6mcgV3D0JTL4uV5d0wJulnHuFKBpZ5nqbvFhuQNNvN5/YMCWw+m5lMVbtLGkw0
         NnZwyMkowUes6Qc8IGrZuo4LQE1DQo+gosLX0rWltkI6SiA42XpeiBVWwbKsGjPYe3rG
         SwKlqSjpuUjm595qN+EnJYmciZYT/tnmMztLZnnRM5BZ3Ce0hGTa4L7+BZw5kDFPa0uG
         iziA==
X-Forwarded-Encrypted: i=1; AFNElJ+GWH7HwJqDt2xBR1VWkJFrsLPhL4iA489+hKOn2Ps9AqgJgg1GPHU883k5F25Y8KEZ4JaRFbM6fV8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTdXybxvpyfgn08AslZ1QusSddORDl/d5vLK6sf3SRli1PxBMi
	lj6zAxaIlvSIn5WWSpy7/3BE1099pB1A/P+S3w0U7euEP/ECxnnnbSeUdwqEpqDHOIg8iJaJtLV
	bbZznbuue0b5513LrRhoNk6f/DcmrlDc=
X-Gm-Gg: Acq92OHl+8XOKvHYZ/28ppOowvTl+RuZFSqzoc6hKkKO7ocpDeUv6drm+WwF0YubEPe
	W9tE1MYi1Cyn0vGgqrR1Okt4Kzk/lFlN7yrFNmCyedVp80Nl5Wgk0zbsBnwKsQkDKmnv+mmVt7X
	DaD0r9rMoe7LsftxjrjeWBL+E+YDOOE4aM7NL4wAjELaSMg0DOPl0LUGX1zN4rbrv+eFMyxVwJF
	e8kTGO4iiSoAJ5NPgvv3ARvfWNhChtxtA09Dck36DtbjhnLo+1+zL9Y/dtZX9/gFk2W48OYX5Pq
	Kocw+SWk2otP0j20ADgp87BQortIg8ORm9ztY0QVBm7jX2pSH6pdD3XFibaPyNGo/FnNT1K2Iqz
	YZz73yGLcNs9MvbsVXrUyWjD93WNWsKSlwOxwdQAOEDkYA/7HWzxj5bUMApxT6l8JKrGuQOJGEV
	RXm14LHjvf7LGbvEzVtw==
X-Received: by 2002:a05:600c:8906:b0:48a:5501:7995 with SMTP id
 5b1f17b1804b1-48fe63270f0mr141583565e9.18.1779027976256; Sun, 17 May 2026
 07:26:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260516-veml3328-v1-0-1d4b663e2fe3@gmail.com>
 <20260516-veml3328-v1-1-1d4b663e2fe3@gmail.com> <20260517141054.3981672c@jic23-huawei>
In-Reply-To: <20260517141054.3981672c@jic23-huawei>
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Sun, 17 May 2026 16:26:03 +0200
X-Gm-Features: AVHnY4I1LCjLfqsWnqx5ys9B91bu-zrmM4tALO3Qti3wW-Wp3ykaBA-fCTv3Kp8
Message-ID: <CALoEA-yk9dJFx=pjjm-=UmTi6Wzx1crLswFfGC2QtPMCP2834Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] iio: light: veml3328: add devicetree binding for new sensor
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 17 May 2026 at 15:11, Jonathan Cameron <jic23@kernel.org> wrote:
>
> On Sat, 16 May 2026 23:50:53 +0200
> Joshua Crofts <joshua.crofts1@gmail.com> wrote:
>
> > Add devicetree binding for the Vishay VEML3328 RGB/IR light sensor
> > connected via I2C (SMBus compatible).
> >
> > Additionally, add an entry in MAINTAINERS.
> >
> > Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
>
> This is very standard looking. Have you considered if any similar
> bindings can be easily extended to cover this device?
>
> Note that there is no direct relationship between bindings and
> drivers, there are single bindings with multiple associated drivers
> and multiple bindings covered by a single driver.
> Also dt-bindings get used in multiple projects and some of those
> will do different splits in what code covers what parts.

Hmm, now that I think about it, the VEML6030 binding could be easily
extended to support this device - oh well, should've checked earlier
and it would've saved me a headache.

-- 
Kind regards

CJD
