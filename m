Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCBFB40DFA4
	for <linux-iio@vger.kernel.org>; Tue, 28 Apr 2026 06:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777358418; cv=pass; b=NAZOAo5v53+xmx6bex7Nwwx4jHDcQuslMICKBWCb+M5IcO2RhdXbZxmZFRW9JlvfoKuFGFKD3G6OZF04Z5Lj2wVJmXwnzaQ0PuDnYgPahdgwwuuYU8m0FbxSHNwg0Mu6FlPanu19sDcgoRuLZZEUb8F6Ljj2HmpZAUwQmZoO6xQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777358418; c=relaxed/simple;
	bh=gUBFQUuLT4y62lDpZYid+HnWFExZpyMrTEA6w3nkPbE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BHtVE1aemQRtTDogOGPuuJqfS4OBWJXxti+0o95PjJ2MtXpKLHFY9ID6VQabiDrsoBQeDR2VIsqYT+SVgHbL2WwWpqzmW1u5LpdeL5B/XmaNJJIlYwTL28wTH7Vef9wG9PtHnCVzVVwTY9FVxxcdUABke3Tz61444R6AqZVWta4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=r2Y96hMF; arc=pass smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r2Y96hMF"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4852b81c73aso91539405e9.3
        for <linux-iio@vger.kernel.org>; Mon, 27 Apr 2026 23:40:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777358415; cv=none;
        d=google.com; s=arc-20240605;
        b=CePtppzsV6763me/wGVM8NzIqV9Y1xRviIQ6I267qKMjVuM/MMvwuAn4ZYLnUwHbpX
         AWHVKehKBkG7vZyLVeX5CaqTDeI+oJqv19uoJXDVIpMwcLjRhGZLJWxFT6tSF1pgdiKo
         ZXgjmeivWteh3qyFJbgGZD9igXATOsn1DU8kBHUoIGeBOQeBOXRHqFk1QM13un7AkKCA
         iB0+93/ZsQt1wLG5ISUoRyGk3ATeE6QCcYHYncxr458ZnFOSJdfcOPY2XWs6vnFHYyMK
         pXUOhsf0sZAXk1oroyA9T/0oTMnGugUAv428gdLuLIFG4MJU3OAJ3cLMZjAL4DgFk9oW
         5o2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=sQDM9G+P27zm1fzEyXP86Vz/k6eZe258soPmp3d5UvY=;
        fh=Xgpc1Hle0eC4r8bhKEl0oxgHwPN3Aw6ytcPf/k9ID0g=;
        b=M0Ug3Br7ir/4gA3goSqL2j9e9AuMezb3NA+dE7DkuXeyiGIPpzWQUuRYir5onCbWPZ
         8ZkJYTc7VZNFLgnXbLvBSJpxYb1TXj0kNTByQzGdhDhZqejin4hfQifavqY0VetGgtWC
         wpkSkAoePcbxQQbRZ1za3NIhendAJGl0vRHeLt+bY+83SZGs1C8o2MB/y781qMzGFsPs
         I5dHdeP9CB7ZtzE3Kibrzjpk17Q3bG4+E7WiYORVF+T+9F9Vr3nQMkGxgvWkrV2SFZZo
         qvAdHD3/rklO2vTXeat7pkEaPgs6GzDt88x9NHbiSUEwhb+6KhdPJp/Jf+AvT8IY8i5t
         mZiA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777358415; x=1777963215; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sQDM9G+P27zm1fzEyXP86Vz/k6eZe258soPmp3d5UvY=;
        b=r2Y96hMFJLU+xKOOnk7Dtt2b4q9fv8HsTD8D9FPTiHvKih0NLwz/fKaFgtkOV8I40h
         j41hmtOPNcYFA3Uy/lGL8VKz/uVBT0EySexdPGxPucizVHRXrcxSZggv4KUT6+VrtjEr
         Lg0icwvfVYeP2bYElK7B2NZQypl8Snha8HfyjdwnIMzUJGtP+RhoetBi0SPOxrLoanQ1
         AVA0fV9U4h/aQhd/ArkUNPm7zMY68eyjFXSEVStiNkmdlqeXD3m9U2qFVvG/sQ2RBsCf
         q9OSLbojnRNy6uVPvuuolXFXTR+lV+gDmz7SEGqBXGUyo0NUswbZdlc2Q1X7GskKSvUB
         n9XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777358415; x=1777963215;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sQDM9G+P27zm1fzEyXP86Vz/k6eZe258soPmp3d5UvY=;
        b=XOI2GZ3eyMpmtVfoVeVkNQ9Msb+SyiAIjwQBXM+FBdIPreAGmEwruPD9fydgMTGSd8
         HGVp7HfAcYbg0zOyjGEW+yF54pJv+pV8biG1bBKgY3/4xfVycwcVyeBD3d6b/fNcEPh+
         lOC4bCZCAeoBiA2AaB85KMMbM7MMI4MpkD83AFkqf+ExUocgtZ4vq1Ld+1eV0I5BS5I9
         jsV/POqwZebKyNHPSMWVVpgYHetlMx/vI5YT4DMnnk4lU9EaGq2a09faeA8IOhsKG3b5
         DQN1udTcvv7qmtEkdAxuw8MsSJGPcC2LbNZdumbKVmAiP8LEBv6fJdfWJoaT00ql/FNX
         tPOg==
X-Forwarded-Encrypted: i=1; AFNElJ94QwTzZLkDsxaGmyp1zWT8sI+ZvCvprePdWgqZwvJKZar1baZYAnoDrRgwTnidGGHFL0Gc+uXgp50=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywu18s476tj74Q95yOwxdU81yNGZcZlm3VNUyUKAaHekgM4LUGs
	H2ICQ+ywkVkJL1+2Qe+eHlvKTCdJ403KepW3RoZc9E82t7YzwrZphxSk4idKdCZhhRAIM3MguJb
	1d4TQTnEFpJlMn8a1nP+ftb4mmpyLdYA=
X-Gm-Gg: AeBDieu8wDzGFFJTAHyKx860YDcrorh84RG5aiVH8nnv2ifmQbEq9rXmVKjiOC1WYyq
	VpwQ/9DSABdiVdnuqztqHSh2S6uoFmeDMErTS170IM4Q24ZELaIlHX3xQJc2grS/Y5LAfYmq8+a
	gKiE8zYy2Ecr2BhihBUYt4gDMbjbCI4qtq0jY679rjfYW6vORxDcTSfVK91Swt4BFxztwcFyxJl
	Av0ERRXQaQ4dBqyusel4XH5CE9SlzJ/6ENytTZB7TnBI1+zQU9wm31p8lvNJujZUCgFx3Bl9QpQ
	7WLKCw3rs3OhJjFyyLg+Aei15o9sPFruafDQpozJbiYS6ErYk4DUTaOwoyw+u9pZOM19lhTHUUY
	f17LJlkNaPd024nK3F/2Emtzj2YQNW7aLRU5VMEYeIAEjMYGNsoaIFtcjMpW4udCH734JlY87pR
	gf0HFSLRZgxvQf2T5870JgPD2n30U=
X-Received: by 2002:a05:600c:138f:b0:488:bfc3:efc with SMTP id
 5b1f17b1804b1-48a779a8d25mr26523955e9.0.1777358415126; Mon, 27 Apr 2026
 23:40:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260419183623.86587-1-joshua.crofts1@gmail.com>
In-Reply-To: <20260419183623.86587-1-joshua.crofts1@gmail.com>
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Tue, 28 Apr 2026 08:40:03 +0200
X-Gm-Features: AVHnY4L2NiVXIOgdtYJpO5cYLUPDu5sKaIeGgysnFzBPdESdr-oC-_btwBQ33ao
Message-ID: <CALoEA-wOZTTC3byrcOjhFORQbmJQFWiROtsnxScpfuA8PYMVig@mail.gmail.com>
Subject: Re: [PATCH v7] iio: frequency: ad9832: simplify bitwise math
To: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org, 
	gregkh@linuxfoundation.org
Cc: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org, 
	linux-iio@vger.kernel.org, linux-staging@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Andy Shevchenko <andriy.shevchenko@intel.com>
Content-Type: text/plain; charset="UTF-8"

On Sun, 19 Apr 2026 at 20:36, Joshua Crofts <joshua.crofts1@gmail.com> wrote:
>
> Refactor the ad9832_calc_freqreg by removing the redundant u64 casts
> and 1L bitwise left shift and replacing the multiplication by a bit
> shift, as multiplying integers by a power of two is identical to a
> bitwise left shift.

FYI.

-- 
Kind regards

CJD
