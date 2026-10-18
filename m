Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 534C6435504
	for <linux-iio@vger.kernel.org>; Sun, 18 Oct 2026 06:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792304568; cv=pass; b=iOVHjM1Qi6DuBc4feekizyp++644VDbCd9Z3ftWhEUQZakH80jGM6ZXCXOBYPtNtC6PDwkGarN5urj5cShoMRq0Tfa9DiQLGKzSYJIYj/ipRTNByPHsLihynV5YCM/hv6JR5PsrSxMWrILNCK7dZ4UUoDiSCIp7VOTKV1VP9d44=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792304568; c=relaxed/simple;
	bh=HlmuKfI3kJB59+iXbrxqBJk3gEIqwcG51Ecw2r8EOIE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IQXI6xtrTktNzNYTvBfStaAX6fPHBGAJ/aQeDiUlVBCwg8EPRw/GE25mQgDTb/z72jbIdYJiiRsm52+LMTWWucvtDPbz+AnbDYgdFga2juC0GZZQJrBuQGCZaLzkSmz3KiOGa85RzE7u9u8G6DM9Jg8L8cznrOlbQE6hHV7eKnM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PhDh+qrO; arc=pass smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PhDh+qrO"
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-6df7f544919so709910eaf.1
        for <linux-iio@vger.kernel.org>; Sat, 17 Oct 2026 23:22:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792304566; cv=none;
        d=google.com; s=arc-20260327;
        b=TaCYL4VB6u/MVpRbndNI6mpkXskw8ucNl1G5ZmfO32+K1e5trFQ24p6ef3FFVyWSu5
         2eRqOtCZUVE8CQxwQONLvHCehPIMxuHf8Cqdgfi+f3MxJIbDMi3BhTrZr7T7ivpPlnQd
         vNwmzKl6E/e7MTkHnD9KJQntg3QHt/4QYfCQYqR67+7SuAAXyUOXlLF68Hzp/e5WRziv
         2sLg8qxLxSjxFWyplBIMn6RIRklrCWIZE9K0TUXzgTdVBvYhzEB4bZME6Hn+LseEqviT
         Kd/PcEaZV9+CUytD+FA/AuuDWvXkrccGjFlp/83MpB50uyb1ELyZr7HtziVYfYRw2Z92
         9chw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=HlmuKfI3kJB59+iXbrxqBJk3gEIqwcG51Ecw2r8EOIE=;
        fh=PNDZAf80YyCIV8HGLRM6KRo/AiWxw6dQYLkGyb6rQfw=;
        b=CIsovahK6USp+01STx20hQ29W7Ma9zUI99RxYN4XZmW7hiEGmscnr2AKqYvwAFwYHM
         +rwrxn7C6WFcOVmCDC5VbqF59xUF6FPWWKdXW52jj5XH5x1+naWYkJ5p0t4+USvMGvy6
         U85WlSVPPnDelZYI1nlSopZypISa1u4EGVn/HoUuJ7Ab6nsHx+rmKoRoyKS9FxGSFfO2
         jV4DYbj4VoYYns4kGGtj69WKp+sJd2Che4KZAOs1osnittLLbi02KYOXJmiYSo3C6yI4
         r+VS0BGQtpVmST4VVRn66ewrF19FgSeehdSmNoqa88HD4/PWCmvylDJ69u5m7u+S4J5I
         tx0Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792304566; x=1792909366; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HlmuKfI3kJB59+iXbrxqBJk3gEIqwcG51Ecw2r8EOIE=;
        b=PhDh+qrOhxN77Im0x/CueAthayuaBjMkGBIkEp+yKQ2fsOeRAU8FUWk0P6oy+dhH44
         Qv2ArKugNW7pjoiALVApj0wCwrEMqm3ukBFPS07qWoo/Ak6DHA7Ubg7ex4kaB0RaAsnD
         E6Z7lXKG3WLfuVQH78+Sdp4ARVS+f0q0LripIU00IGzN2iiXYBSQd86EThnGbaieRGqu
         rAbyntrQiEZxRIO49tTDbs8hQ8VFDlvTbzLUBI9M2OTR50Trvu5lt3QfVZPxmQw4B9ux
         21DSgLfdnaX0fxpdySGIsxsW6yeD62HH0t0g5ZhScXUt7pP0pkEOTcV8b/uui2XYXaG2
         I3KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792304566; x=1792909366;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=HlmuKfI3kJB59+iXbrxqBJk3gEIqwcG51Ecw2r8EOIE=;
        b=ffscWK6ir41sHxGovM0hPgXR64NmCZ0sJFnOUkUtgB6go/HFo4BCDTvvH71P34T7qO
         p9iI9kx2yBRMOYdGlxOGlT6ocEo8R/LKA21mvNbkFlsSesP4NWzqkxI5TPn+C3Pury64
         ccMxhvXaM96H8D0HovwNtS2wRuvlR75v804/77+51x+ijD+TTFU0VsU9C6sREOo2jkPF
         KQ7pUa3SrMUVGcfSdvYFMFvUPCrxgxLSubsZjFIIwUhHHpOtsaLKgO07rBsSvczgkH1z
         J1FhJ1EOhEJbEU6y7adDtm43xF+NNe2y7FN37PZTO9Tj11kDYem0YgLDDVvIqT7emNun
         yRGw==
X-Forwarded-Encrypted: i=1; AKwUvBzK+m+3WVXC3s/lOUg1HggMujimCiGR9AY4L+X7+V3F9UCfpSpBOhbU/OwQZyFvdJWbzuXxOFW/6Rg=@vger.kernel.org
X-Gm-Message-State: AFq9FYLIPhrln9+ZKus5QtPagigxTJyBQAinYfR4gscY7nT8S68YY2L8
	//wNd77mZm5hv3W+Abj6tg9RiN0WfjDC79odF0ZyfOAPFk2QaSpndM4cOEDiY1A76Vd8Xu2qwP8
	I+8SshhyrJICA9kAKUhz3hTD4eYahEn8=
X-Gm-Gg: AYBFou31O3R3b7NPMj/p9M5Z64COEevSFYu5T0jjASkaSWuyJaPbaLBxTqj1RrWy1Xu
	Urg9QDCb/QB1o16Me4l7sVRfSz2Du4t13oAUHbo3+P3NVvPuLs2NWT7UACluBNgN07Nk16snINM
	z9CHmfVVwkM7clepjVrQKoJQUhFSvOqeLFw6z9pLyNkPZvqkAgDkcukIVknFya/D4P1yZN5qvAF
	rS2JE/p4o8NL8oBTXdR0H9f/8m5sLk2YtttTvkUs07olXr2CYaLRgkiJ1RIENe/rj1xtis2kWaK
	I7QUwY/bG3KHREidCcf/M9L1FYdiwyVaiaUOacelWrq9JqHEiJnIVDO6
X-Received: by 2002:a05:6820:4b8d:b0:701:795:4eea with SMTP id
 006d021491bc7-70357495e00mr3531298eaf.62.1792304566146; Sat, 17 Oct 2026
 23:22:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261014091111.20059-1-abdelnasserhussein11@gmail.com> <20261017231747.4906975c@jic23-hlaptop>
In-Reply-To: <20261017231747.4906975c@jic23-hlaptop>
From: Abdelnasser Hussein <abdelnasserhussein11@gmail.com>
Date: Sun, 18 Oct 2026 09:22:35 +0300
X-Gm-Features: AclHuK_Ca_Uy-OZ7tfLlUzH9RqHtWG8Rwb9-cwyEYDkMviqvqgdGx4a3apmhzxQ
Message-ID: <CANpqX3YDqtqGeeqscxF0YqMWMmSB9fpkMbxapq8WbbZWSQH=EA@mail.gmail.com>
Subject: Re: [PATCH v3] staging: iio: adt7316: use kstrtobool() for sysfs
 boolean parsing
To: Jonathan Cameron <jic23@kernel.org>
Cc: gregkh@linuxfoundation.org, dlechner@baylibre.com, nuno.sa@analog.com, 
	andy@kernel.org, u.kleine-koenig@baylibre.com, joshua.crofts1@gmail.com, 
	linux-iio@vger.kernel.org, linux-staging@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Jonathan,

Thank you for your feedback.

I apologize for the confusion regarding Joshua's tag. When Joshua
reviewed v1, he pointed out the necessary fixes and concluded with
"Otherwise LGTM." Therefore, I mistakenly assumed that I was required
to add a "Reviewed-by" tag for him in the next version to acknowledge
his review.

Thank you for clarifying this for me, and I hope it didn't cause too
much extra noise.

I also really appreciate your encouraging words about these small cleanups.

Best regards, Abdelnasser
