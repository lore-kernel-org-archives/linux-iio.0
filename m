Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 878CA145B27
	for <linux-iio@vger.kernel.org>; Sun, 10 May 2026 08:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778400281; cv=pass; b=os7HyQ9S4KHj0KsvhLaCvLCZnWqxj6CmkayrAoIVPoo0/J75Ou+cxYg+cnfTFy0Rrq+GZvRXJ9TohDx60FAIezVesNjOIvkaJM3Aal8Rq21CSxOpjjn0uDwUXmQ4QCHYg20lNVXdfb8Sn/UuAEL0xRNhyjJpayIMxRhjPo+KN4M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778400281; c=relaxed/simple;
	bh=mPk4WEgoALeYIImoTOb1eW7uqiVyblc60biwns3T//k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ht2QuCq41Rdlxf+Aqws9iW8OfrI6bFlMoylJ+ZdWc+3dxRF7xUFsq2Jt0ooeM6joIbdTfcdIv4x4bWW8gr8FmC5XTX5TcokzTioCyFdq++c9f1F8duXGnyIO0tg6Tk3xkRLu/MHj4XPrOuDO1jFzzpibJOQjgpOMiUp8KVwxlc0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LTE3MlT9; arc=pass smtp.client-ip=74.125.224.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LTE3MlT9"
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-6530287803cso3262162d50.1
        for <linux-iio@vger.kernel.org>; Sun, 10 May 2026 01:04:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778400279; cv=none;
        d=google.com; s=arc-20240605;
        b=iKmVIDAI/aIq5vFIqXQucTt4KsJkYbDusDUBZm/D065Ue8ciohJSWZY4srZwAwi2LW
         dJdeFp5XuAopuakmLj6jlhQrDMjJNsB+hOUF3ec5c8ltTsqeVRkYs4+7u63M/ArEQnUI
         fTQKomx3qD0mSHxOLvNVaq2xqmqAgime6Nwgp7vwelQkdEs/SnrrmBS3lmxwXC9iSasv
         XEuVaPQdqM6Osg5DS8TqNLHplTZD46NCZlqd0rJq3Hy9JTe0OTQXNrCE/Ehonz1CtFW3
         Jte0FXZKo94Y2fZmT/mBqZXAwmw0ZmTCxyOFAsoUPoTqzH7ixOSQFJfXQFVpEpIsbpDn
         07iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=mPk4WEgoALeYIImoTOb1eW7uqiVyblc60biwns3T//k=;
        fh=xmoJxuoZTTXpxTmAuSXiHPTd3G4vJnZ9SrPxpVV61Rk=;
        b=Vo1KUvYzB+fr6UQ0hrtjuTkTySNcy7Q2i6xgEAupfD5uKn7UPGEwMPXZH0BvvI6h7z
         y0PG0/0ZYCCVF/6LjgNdGrXvpZ0BPctBjy7bdYjG6gtvXJVUa3rM10VvmN9KOrUb5kB1
         WuaSSA8tTYBNn7pHzwhpNAd9tEIyXfs34toHtvtAZMp26Gy8hmj60lDY8JXJ43wOPta3
         rlAqZ9O+sZmI9RPvn4E3uJwICT1kub1NmVZc9CRGWus13cw06HtVgTqTSMStF37fKke8
         Lo7EJaR9LISEwSWddLq03At7Ozk7H992Yzbs0otCzNwbA3ECguBStRaY9akXJX9JCUe5
         WXlQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778400279; x=1779005079; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mPk4WEgoALeYIImoTOb1eW7uqiVyblc60biwns3T//k=;
        b=LTE3MlT9buCsjf6VMw+tUoauXrm/lZCJvva6e3QH/3cV/ShPS9BVl9ZW6SWXEG1nF7
         DF0+Xyz1zih/HRV4LuucFabDdjqc6l6SnxggR6PkKx5ynWBZ0cwnm/IMNNH9f/Q/Cyz3
         ec/sA7BSxkJVnfneAFkWX1sgWPCcavyS1jNvajsjnVG7qjH8Y4I8VtST7Y1R27RaZZZA
         AUgoQkpTCSWJ48KYkjNPiUfYfJEDZmN7xeiQAk9rcxwyISwMfJVuPO9cKVno0zP1SB20
         40TEmdsi0QysfR70D6wyHzchD6osENK43ffGSezciqTgdIR2vPqLN80XY11pCMPE6h42
         M7DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778400279; x=1779005079;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mPk4WEgoALeYIImoTOb1eW7uqiVyblc60biwns3T//k=;
        b=FfCdGN8EmfXYjR/SgyHXH712eNwKWJyXhoCBbc5GtFpkTefc8dSBHrLxmHaoy1rsWc
         MDp0zBOV2GmNNOHQfFy0eMeeOnRFK+n7tQdgERt4Qvz/bv8VtjY2bLpOe1cUkoZzffG9
         OnutVvVzakVk5wVpvz8ms8Wt1layiw+MkddiPlYyt9cQPqvPzYFMMu++TqMWIbsbfbTr
         b3iBxwDIfJgBvfjoqozPoTbt6tF6N7Ey7litQU5ZLzuOKO4+vjKqCy2ph08sZduklSx6
         +gDiNfD2xgBaHHom/HAN5RzFpA1mXVgHu6i6HV6guqtrlkgN8jW6EPjvGo08/Fqrtllg
         LnzQ==
X-Forwarded-Encrypted: i=1; AFNElJ8dmeTlOohp6IkBTLQmh8jiyCjUM4p0oOiWrURsIrYLd5VM8vrkJisLgdjG2rn9S37sCs5VL2Z7a+4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw95jTBJYTmO0xcN4O38Dqwif3R+FeWZBkdMFkgxQ+KLU/n7Kjw
	TAvTKyl4mY1WRI+CBJPgfzr0hy9OVV2I3iTAC8HE2EspDOpVfoej91myk6v5wQlptqVQ3Aw2h2w
	ZVQEXhllsT0sGqJ/Z/q3YOqUrzldglFo=
X-Gm-Gg: Acq92OGRAR3qZEqUM5E4NYzY74jp/f0G2xMGRGwEul+9OZcmynFZ8EAy4wYCLEqNQph
	OLZEtwXSNbKvJ0RSoZD/EUksXHV3kGWWvh5mz+QcDBUvzfu7jq9Ctq52NVLLRueHxA/CJLm0LWz
	PKcrxhT/Mf9goDYyK/y5L8E+iK4CTemt9rtFZBXcWLpT7RBxmsSVNYuj404mbO0Ux2rCGxEeDEL
	yKvvs0Ayd5Q1aeBnhodXP9MF8C0y3GW3FrNqX7LxDMypzKMQX9D9tSKLCYGu/Lhja8NdLMElnsg
	ael4
X-Received: by 2002:a05:690e:1181:b0:650:1c44:cce1 with SMTP id
 956f58d0204a3-65da8403cc8mr4798496d50.25.1778400279478; Sun, 10 May 2026
 01:04:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260510003136.35026-1-sozdayvek@gmail.com> <20260510004244.37342-1-sozdayvek@gmail.com>
In-Reply-To: <20260510004244.37342-1-sozdayvek@gmail.com>
From: Maxwell Doose <m32285159@gmail.com>
Date: Sun, 10 May 2026 03:04:28 -0500
X-Gm-Features: AVHnY4Jd4bKlkZcsI2Y1pMqkZEDAOeu_h8OeQugEZ_DJs-y14X6K0Q6i6Wzr0wQ
Message-ID: <CAKqfh0GWMu5WGfSigJOAredavrezZgmPVN9+qmMZ2aMoVX_jYw@mail.gmail.com>
Subject: Re: [PATCH 3/3] iio: chemical: scd30: make command lookup table const
To: Stepan Ionichev <sozdayvek@gmail.com>
Cc: andy@kernel.org, giorgitchankvetadze1997@gmail.com, jic23@kernel.org, 
	dlechner@baylibre.com, nuno.sa@analog.com, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, May 10, 2026 at 2:59=E2=80=AFAM Stepan Ionichev <sozdayvek@gmail.co=
m> wrote:
>
> On Sun, 10 May 2026, Maxwell Doose wrote:
> > I'm curious, are you having AI do your reviews?
>
> English is not my native language, so I use AI to help with phrasing
> and to learn kernel review style. The technical analysis I do myself
> -- for this patch I checked via grep that scd30_i2c_cmd_lookup_tbl[]
> is only read (one read site in scd30_i2c_command() via
> put_unaligned_be16, no writes), which is what supports the const
> change being correct.
>

Thanks for confirming, just wanted to check since some of the phrasing
in your review did seem very AI-like.

>
> Happy to follow whatever disclosure norm the iio community prefers.
>

Typically reviews end up being one-liners (e.g., Reviewed-by: name
<email>) and that ends up being the whole message, sometimes reviewers
and maintainers will have inline comments. Obviously you don't have to
follow those norms but that's just what usually ends up happening.

best regards,
max

> Stepan
