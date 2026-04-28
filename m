Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6732D37BE7A
	for <linux-iio@vger.kernel.org>; Tue, 28 Apr 2026 17:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777396855; cv=pass; b=ASivSfW991lXG1ZuGJpyKPXte88efutIuB+yPmKxiWJCZ5WYZtJ//pezLCzOOYvHigYpel6hVIjUk1OW96aX0Rjtk82/69E7jvr9Ren8pdpe/A9sAQ8r5XD3pB2hVHs7/S34tlW/bg9Gueyp/if4wtEK+b5x7HDy6DQgiDD1AXY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777396855; c=relaxed/simple;
	bh=0LXJo9JawwRMbS7NHUQj7w858GMV737fCJ+M0fb5Y8U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T5nKLQjs9cpS9vRleHQJZvw6BGCx5b1NgxaRF5TFTV218lSU7sL0MjejrxpHF34M7aIBVw+wE8hD0H8xcUiFeiUFWk78cD/a3AwbGLX5Qqn18PcBXnstj1JB1PMGcx5qxXBwLC/abKjWBWIfR8+wkwNIwLbSOvI1paeKFT7cF9Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IWjDY6Ax; arc=pass smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IWjDY6Ax"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-7b37d84a6b3so122475167b3.2
        for <linux-iio@vger.kernel.org>; Tue, 28 Apr 2026 10:20:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777396853; cv=none;
        d=google.com; s=arc-20240605;
        b=DhaGUL2sGVaRyjBYzu5cS1YEchA/R+8JuJKleYhaMIR4ya6apVQwxJ4kjdgzDjo3XM
         LZ9RR7Xqi4kqaxs4GhEPKU7JXmadHy55IOL5Dj5rUNPTwHGE2VW2M7jhLe4w5vbvN2xB
         KsfR4NQs/AtlHt9a23oABPkCs61sYMkGXA+ZV8q0QItYSWjoRc9hn+Hrr8fsJziomqS+
         jofcxVok7ztPprca9WLcJXaO3wd/QXHHTvl1HN9FrbhF5hawMkXsPxhlKbsChZ1QuTpU
         dbZkdNOqkEtWIv6oJyv36ShA+34cXBB4TWmfD9ViNtibC5oGvteg+mAYFqlyDz/KVVaP
         8l0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=F7eSb+fdA67aZYznwEc2jSJ5+Ko3BagXejArh6fNIlw=;
        fh=ZiTVpMCCYBkKxuQb49H4gB2PPFkPpTeWCfx8M0KOF+g=;
        b=X4eCWBpn11n/FNdfYRbjG5yYpKxXovAm5J3c/G5qFYegwjjz+tL9b0T24dVAiqorvY
         l0XxH0Zp2cfzD+QybvUYKa+AtH1/EYsZwRlIk6AifZuicjJMQxkEcJago/e/2GiFrC32
         iaZoe3pXY7w6bSDaA7yJvMzUsgltuBmEkcY3gjMbnKw4KpreZzYWhlNU7QMQ96pL+PvN
         WA940tvhy9yiVup4Cm23Bd6oDNWzWoQrFH70cstq4YrTjXZSPl4K+NEaQ+SKMTmOcr+8
         dIdIMURLvk3G8GW50v+Mly9NUBGZs+zUG2d19n2TNjX/aRWhDC0TVDm9wsLtDy52ysaO
         eS2w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777396853; x=1778001653; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F7eSb+fdA67aZYznwEc2jSJ5+Ko3BagXejArh6fNIlw=;
        b=IWjDY6Ax0IW1zcbsj9j6KDRK4geXux2CfCjSBCbX6TepsHaSvPMOPDCARqyY3HmjFJ
         Ld8vUXdo3SOJgjw3vtGCOFisenzILK7V5mhYsMgw8Trx/Ycuxjf+1a8RSpRx/2GoES7L
         qedsisCwKpNKSbkZSl79mBpOKfcge86vqVmafsgt83M4hlVgxTetuJIrVKLWCqWATak5
         Ezguf7k7Wg6eKHih723SiOmhJtG/zHiq543tAfHYMkvX8GpfxyCn++DBmgl9wjHwxMSW
         RlZZWwl3+4OlWpCScdfxAz4jcm+8NeqlhO7k5BLre570U1MKs0zvR2xN+SLFYiT8Tfwe
         9ZWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777396853; x=1778001653;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=F7eSb+fdA67aZYznwEc2jSJ5+Ko3BagXejArh6fNIlw=;
        b=ZmwMI5VMTwaj/R1l1x1HuqWo6nOS5ePgsJaKAXgpHeijfmMqYTU0vPKv2pkMCDYxwO
         jc00K1LTMa7izCzjQtL40ZIkUXwhPFtLujP0GK6HzAQTjq7W3dh1q7LsWvu2LBSTbDuR
         VAcq/SU2NdKWGiTMDCaRFF6pZ9f9VMIT1ChuEiIRXxbxXgv2PLsEu6kDUInTKKQPIAdX
         ZZ7txXex0eg9M3HgH5YV+nOhicnZ1SzJl+lTX3ldVdImOap1QU8GCouEOxTPH8tJHzat
         b8D7Kqo0GJ/2qQ/YD0tc2NEvGadwD9aQf6HHJovYT5KYTa79zD6q2A06KAVRpJiKOjaK
         FOGQ==
X-Forwarded-Encrypted: i=1; AFNElJ8QVzFBsbASTbersUf8Gsbu02yl1TtSFK5vDdpQ9UDomGZ1U6lv6wDK/Be9IAIteiiqNYwo0XbfS8k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfwhV3TvcLnt1AdRCl2APOeSnOWwpKQi5S/FoTWncNygCjw1tQ
	PWaZtJ/vxNSoSox2RoHS2c/84F+64/msZD4BizN7YNcZ5Zp8KUXuYQ8ZNkS68sYSTBXnMlxRSR6
	jIAb/SJO3Of9Z84Hz6UvlSo8bA46EcR8=
X-Gm-Gg: AeBDies1XBYg+6HqtgfzSWiiacHTvydBVfeWSNGXEwhfWQ+dffNNVt8Wqz1rRqTp655
	dXkKVLo9nwMJfpbKLi8ekUPdnODLvJeqWNVb74I67uKA/zNEkZAcOF9JvISgO89vnOs0ugx2Zhs
	Vb8DZt/9f37+39RRhJyeR6tVP5tai3StQOKZ8tsFShQV3KIqK84732iBO9dxAgeDM7DWqSDrAzk
	61mS80Qf+wFwEw5qInnrHemPZf4BUBre2IneSPb9kb4lAfCwDWkujHJJRp0kbDoFtLUs8j4Yw/d
	BoAfM6xEWoJnyvJpBVzgv9RnX13jaoc=
X-Received: by 2002:a05:690c:6605:b0:7bc:8ce9:b996 with SMTP id
 00721157ae682-7bcf5594daemr36674867b3.40.1777396853433; Tue, 28 Apr 2026
 10:20:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260428124644.49707-1-m32285159@gmail.com> <20260428124644.49707-5-m32285159@gmail.com>
 <20260428163247.4511aa5b@jic23-huawei>
In-Reply-To: <20260428163247.4511aa5b@jic23-huawei>
From: Maxwell Doose <m32285159@gmail.com>
Date: Tue, 28 Apr 2026 12:20:42 -0500
X-Gm-Features: AVHnY4KyI5gLwGg-6nlFdFyazhGF9KoHsbgyAx6oyOoY95opVRNLsIGOxZKr5H4
Message-ID: <CAKqfh0FRYBrYwE0F2zeAgfF2NiJdBN8frfMQno_=ObKsBbmUdQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] iio: magnetometer: rm3100: Use guard(mutex)() in rm3100_trigger_handler()
To: Jonathan Cameron <jic23@kernel.org>
Cc: songqiang1304521@gmail.com, dlechner@baylibre.com, nuno.sa@analog.com, 
	andy@kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 28, 2026 at 10:32=E2=80=AFAM Jonathan Cameron <jic23@kernel.org=
> wrote:
>
> Read the guidance in cleanup.h  It's pretty clear that nothing from
> that file should ever be used in functions that use gotos.
>
> Whilst there might not be a bug here, it ends up being fragile
> as people changing the code may not noticed that can't use an existing
> label and hence jump the hidden __free() in that guard() call.
>

Then I guess if we really want to do this then we should probably get
rid of the gotos? Because I can certainly do that. Either that or we
just keep the manual locks and unlocks.

> Be careful to ensure any expanded scope only contains calls where you can
> easily see they don't deadlock or do anything time consuming.

I'll also double-check that.

best regards,
maxwell
