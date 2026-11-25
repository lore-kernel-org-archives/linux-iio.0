Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.171
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795573504;
	b=pnxLxYUuvVVG03I93P0P4z4Dm9cShxoFISAChF9vNlEUoS0CK1WeeolEzvAmncYooTXG
	 B71rNL5z27goGgTUtFwgs42eUEM1Jzh4DuP8vMlmG9kz/32scfDo4GRmkKDLi7anV3Me+
	 zS9fmfesdTC0uv9AzV2ASI+yu10bFAOnRQlQVGcvjeAS2evFYdOvsv1SDaFhAqeV39reS
	 LUVKwlnAE9NmqGh5/fmrJ666t8L4DZOYHakDHsYOdRiDbWLqF0cg7kCQyednuM1QJ/Ge9
	 6lEtcycVD4PsWfXfexnIOAg6fW7GjqhP6QoehoQm8p8Yo2q99gq7e09b6Kw75b+qh9g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795573504;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=RoVdVJuanm6IY9SbdoTW0HDKXtpUnzxojZdIdcKrd9Y=;
	b=IhClXjsCyy8s2OZOgv6RRLEZqe46czUkVzTGLeiYCth/wfEl4ei/5J6rSt2o3y42ARxf
	 n9IV5xu/0D+alZbxKo1nVKzey/nmyVT4zCfzGzjwO3YOqdEo2HW3ebukeSrbUU91BD1DS
	 jzdfOIi+NAB6U+ytpojwZi3WFfw02b9OjPg5nCOBh1W69aecyh66HLTbQUJWLoRdtFnPK
	 WtSHDQOE+3BNsdUN3w/LBg8gp9BPvqkJ86066Tf116dkSn3FFFTcA1fdoAZ21aYlRbmKh
	 vyQvyckuV3pscgm6BNfEMQ5R6h/Pu3sRB3uRz9/RJy3dBZZuTFr81m0kNdYOgUReLRg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RDPnUdSz;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.171
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FC0A606A31E
	for <linux-iio@vger.kernel.org>; Wed, 25 Nov 2026 02:25:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3FC0A606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RDPnUdSz
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-3ada7d53082so57747381fa.0
        for <linux-iio@vger.kernel.org>; Tue, 24 Nov 2026 18:25:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795573502; cv=none;
        d=google.com; s=arc-20260327;
        b=bno675t8RmGPHpOoK86NTBZBb2MV5WGSrFf+cjvzvrVW4EhAE1miSJuLIwYBlCVLfc
         W1dQD6ZUzMqNzcuAefJszyRZ+cYnn6FKTwBHS5dfN8AXK5SNf4ivivMwgl5CVe4FyTwB
         738/Yx3mwGlA6Brtv+0j6OgmwdeZyukNllmNwQATCucA78Y1be1eTinZueGxB3jrkkOB
         KwYwJIhfL0HAZsQRI9Dur/32hUKqvFWjj5FCnWzrt7ZcJvGxajhdk5L5W213dMj9m7+l
         mEyvusImETvo1LV63M8x0DnuATrGciV1spOH2AjDfpCU1B5ppXmyQ8fjSvgKGU/Zvkda
         F94g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=RoVdVJuanm6IY9SbdoTW0HDKXtpUnzxojZdIdcKrd9Y=;
        fh=e6tqJyl1gMnYSuIlOTL232XHQCh01hdFFQ0/+HMBkQw=;
        b=ZEI6PscsGnuA6swIbvPiZqoomMM+YWkkqfNgB8IqRSir6332swMQzPqCS4N7UyBsIy
         3GOvfZAB9mt032WQsHWCT9/pBko2eC/gTQUaQfbrD0frt3K7T2SS7eWPlxeMMoSXSHj3
         lZqJIPiH3+QVibZM+h3iOvOCo7FVeK/95Tjv2PLbXeEmCsp36tK7ZB/9p2ZsmwjPELh6
         7qo9bmnoAj32KiH6o5oUVfX+6Vm4O6cH0ofvWca5MCfj9TnfdF5T3IQnj7jkjxk+lfyo
         2DEqW+tkFLd/mGLLJ6nZVxTZvq1C6e1SjYx2b+3TPpuUInRj/3rvffNsgfK37TcF2S35
         M4vg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795573502; x=1796178302; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RoVdVJuanm6IY9SbdoTW0HDKXtpUnzxojZdIdcKrd9Y=;
        b=RDPnUdSzB/AhnrN//N+BqPMk9ZTTXTKqFwy8gyHKdHefO1PpfVCMR6aUyienTzJI8P
         JQGcRjKX+MmaAJZP+B6NKdLw4K1FiiVv/6KY1f/KYSLS45C4rvQa4hna4gHfroEycXg9
         5lJVhz6BETGdhwdNnDbEdLmmRORAdtJpV5iWI7e9M8rr6iI8DHjdVvwL2S2z1QPfiOUa
         Pojb1nWft/8I7O5ZqDj5nnkxRhCwPDxrbDwItFQbwdO2Zaqcq0UY7r1w+tqo2Kg6hLcq
         nCJypzIw9gh4ToZYIVblfw33S8GICrIljQcEyhLP8cllbNWTJ1sIVcj6ZIeQ6W73XNxJ
         fwSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795573502; x=1796178302;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=RoVdVJuanm6IY9SbdoTW0HDKXtpUnzxojZdIdcKrd9Y=;
        b=I6Dp/B4EwovaTjV/nJrfRnU/hkF5ByVE931QvZ9YCHz55ii1kmR7Q1+s5LSzsXfC/V
         Sp4jkQ2Sry0hvhy9SlM+sZkS4bsJ91o1eoMmNOlhS4sHh+olShJ949lGGjpN0mp8bxRi
         q6iTAVgb+rN1S/DKQ+dBFHHscd8FFtjo4jqKkNu52J3Utt2EfgiFGY9rKB3fdaIKhWQ6
         mhjBtv/hi7X5Nm1q/k/aaYPm2jy0XIS0Y9ABuRm0Mxrq/qY3g6/zW2etH0cE48FMOxQg
         1QG23dMNDZyPXPBC2mWFrZfU22nXlFsBc6SUDlhFIFo3HjOUZFSTxUpo4/BrdnQItAOi
         QETA==
X-Forwarded-Encrypted: i=1; AL+hErF6N+uoKR2DnUETwlmyApedRD1xvKHDtmRBmIvuf4sMu5YZhlE+2+za7Zo9uFZ4toR9k9vIeVBkpD4=@vger.kernel.org
X-Gm-Message-State: APuU4Z9LnpDnk2kE5oifBbStZrW+DGJY5Htu633+NWDYpuWuf8vapc0O
	fA4tGApSjGMD0795k6eCvh0AmqxX4GM+QRvqOdlnQZHGyW8cycdrSuRVhfC5xNI865wqxhZw6xo
	TcX0Vsz7kIl4xQkZIdnImFPnAKF35pJY=
X-Gm-Gg: AZFdTZdEOVlXhLXiGbympCyp5diSyWHYy84b5TZjh5FOaFmM+0bOhAb4FkWC/kaO2Yd
	GK/3fuxL1s19rC5IcCBNwMxtkTQmqTsQ64pC3yetPBTJJLntAy4pL9LLDAZ+q/Q8HDz3b2nNfAM
	+co9EpGal+DnKz5E96SNIt69QHqwjbz5h2fvVgJJ4fj3WyHWep8/3Wyelsnhh2l60sTNg9ed8O4
	mgv6Ht0oaleN387KzP4ObbwOpJhK2kFgchay1dGD7r+yMM8LOIgS6hyvC8EtlnnIHfbVLswIAk/
	3sIfJY5dWPyZ/Ifa8cMMRF3+M4ld12cV7nEF0mF1Yl/sVoMY6B1SSqoCnySOtceWgweVF/Hgqnw
	lVPieBowtOpSpT+h76OeAxV3l+TV2/peIuF72
X-Received: by 2002:a05:651c:160c:b0:3ad:ff5d:19b1 with SMTP id
 38308e7fff4ca-3ae7b7fbe41mr38238951fa.20.1795573502123; Tue, 24 Nov 2026
 18:25:02 -0800 (PST)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261109155743.83740-1-muchamadcoirulanwar@gmail.com>
 <20261109155743.83740-4-muchamadcoirulanwar@gmail.com> <179538281024.9825.4132712997497273037@linux.dev>
In-Reply-To: <179538281024.9825.4132712997497273037@linux.dev>
From: Muchamad Coirul Anwar <muchamadcoirulanwar@gmail.com>
Date: Wed, 25 Nov 2026 09:24:50 +0700
X-Gm-Features: Aa3M54rxCZafdUbvRb9-vw6Ll7Se68ZBnBVHsI0xIW9ramLI50wU4YKTZItQkks
Message-ID: <CAO26r3Tn95hm8SCEcP13wXE7p+iQpJ0O2n_tyhQvYUTkG813cA@mail.gmail.com>
Subject: Re: [RFC PATCH v7 3/4] rust: add minimal IIO subsystem abstractions
To: Igor Korotin <igor.korotin@linux.dev>
Cc: Jonathan Cameron <jic23@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	Alice Ryhl <aliceryhl@google.com>, Daniel Almeida <daniel.almeida@collabora.com>, 
	Mark Brown <broonie@kernel.org>, Andi Shyti <andi.shyti@kernel.org>, Shuai Liu <847807867@qq.com>, 
	linux-iio@vger.kernel.org, linux-i2c@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, driver-core@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 23 Nov 2026 at 04:26, Igor Korotin <igor.korotin@linux.dev> wrote:
>
> Clippy shows two issues in iio.rs:
>
> 1. Line 332 -- ..unsafe { zeroed() } in VTABLE. The SAFETY reasoning is
>    already written above the const, but clippy's undocumented_unsafe_blocks
>    wants its own comment immediately above that specific line.
>
> 2. Line 408 -- unsafe { (&*priv_ptr).channels() }, drop the &:
>    unsafe { (*priv_ptr).channels() }. needless_borrow, no semantic change.

Hi Igor,

Thanks for the review.

I plan to use `pin_init::zeroed()` instead, since `iio_info` implements
`Zeroable`. That removes the need for the unsafe block.
I also removed the explicit borrow, as you suggested.

Cheers,
Coirul

> Cheers
> Igor
