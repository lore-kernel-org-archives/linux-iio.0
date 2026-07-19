Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DACA43A5E96
	for <linux-iio@vger.kernel.org>; Sun, 19 Jul 2026 15:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784475638; cv=pass; b=aORwVLzhGP9KVU600fLlRyrQM/AHbjeJWaEKfmUf9xHgVLRvhw1N1fewDonErgIc5JDmnRxeIweQMPXkno7n4kSqFTduJc1tUcZ19XeIfAhwePwEQ2NsAf4x84Uzwo8Spy01l6kW/TqOFXIymWA6HIA2tEZe0fHOo+V42+Flj5s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784475638; c=relaxed/simple;
	bh=XSVB6QgVpwhv+8CMMPqTc3N/fcdzOVInqR+4/LGh9jE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jY25POOss62NAQNkiSUwv+IbTwvOBjpGS3b0CWRCsAvwDdXaiU/KgCuUFvfIB5c7GyCBX9QERLJ20YAeL9deTwqj+RDb884YvXdy83r4DRcpdHQyDAdaNu723nbjAtsErM6KPwY9/ieDmvibxVykGAm3M71k18MeK1/PtZTWc2g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LsT9XESN; arc=pass smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LsT9XESN"
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-39c8e65e3f5so81536401fa.0
        for <linux-iio@vger.kernel.org>; Sun, 19 Jul 2026 08:40:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784475635; cv=none;
        d=google.com; s=arc-20260327;
        b=s3iOm7ozmUbcf28M0pQ7vQ5Dyu/w8jdkFYe1kZKWpS7khTrAMlK51qxllVmWMqhWal
         48dx4JRMQ3MuiTZ7XDWvZbc1+w0odMokJh3SFN0mOGRlBeXeYhHTcRv9uFCeecK2B83R
         i70zAXRUfkLfjjfIbt9sCT6f9at+vxzZRe945l218u7nWqr5vN2B4H06cFHB34HlDyRD
         tk952YeSklmab+IFID70V+LHmPjhwWESeuUSTWexNTQVlniFKj/CWSESvTg7NuorBMtW
         0Zixan6unNfnOlMiKDJxTHf4k+t0qu8tYJRPvOs0x4m1EWqiXXStT6HF6fjIvoFb4J8x
         BVig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=XSVB6QgVpwhv+8CMMPqTc3N/fcdzOVInqR+4/LGh9jE=;
        fh=fhwD7+S1ehMZTpFTY18g2Ag7wc1hlBm0uOXhQtiC8yg=;
        b=TMsLzIakrkSVQYzsq7KTYqZtDYyUxHX/0+UvSioAW1nKlJCIINK8T+1WPlpyOQ2JqL
         0MgP38vzkfyKQddEWd3EKyZKU6yVCnDQsW1epRUbe/g6ibuH9JrvV09V5YEQv/JJfdn7
         KwpSOp8sBuj7c8maus1hrJ/oLDYwgosx8W3GbfnUd5qtgbIjzxj4NzZidJReRQrEYp9R
         o6e3gxzGuslJDeShN1pF8VwSHrFlMoffM3neyp/VExqf5XukYDNOAkhcDXkSgHuw00aW
         eNLRDJ3flaF15j4qX0OGD0loPsmdY2L3i+tlbCWSc6V8AMmbtO8p/s+qVEJeqBypXMVc
         MXYA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784475635; x=1785080435; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XSVB6QgVpwhv+8CMMPqTc3N/fcdzOVInqR+4/LGh9jE=;
        b=LsT9XESNq0BkgYUzoLK+k/WOKnu320oHbaZf/g6rfQsW3VRCXqT0Fz+KnEQ/mNeE7v
         AXOm2MhlRbEeU7rnYO9c5G48TybmglySa+QR8dwQP/L/NG1woQMnmOiXeAfyCIVe6+8h
         V4CB6qUcT/ACPvlvQouxWwZl68EIy0bR201+rxFP8ieO9VWozXuqYm/nbhL93TgF7YKz
         SgsYHjW0PBvvjw1IinK1y+kVVxtT/769BJhYf6YbXNHGNT30HYEO753OxQ1zqhTda8ZA
         c16BzyHrZrGnbOZCoNz9EaFA/mzP+FM9DDXh6KFswGQPifv7yyG24OsvxA0IU2c7ft+H
         WXYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784475635; x=1785080435;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=XSVB6QgVpwhv+8CMMPqTc3N/fcdzOVInqR+4/LGh9jE=;
        b=aNuUCngYsGgI0zdsWmWA4/FTY6ESUOFuZhJwjYYEF9M+V9bj/NENLyIkUpk/A1kW4/
         JfFUaFP47+r4kFqdiGeBiMkHpENFJPEHcnRTYydqQ8K2ogDRVFwP53wzIPZZEhPOHOEx
         IhoytkU969K7FL/LgzLpWx4kI+7ZBVg1CFuf0GuaKUIpP87PhLUDlpPVu8rtYcVb+2tV
         crrCNKEjCdgCAEUC7aO8w+ZUEAN/v4E+zkdXXmXC218jd1bSWRgjH8KJDoz5A3QtXy10
         0w3tkNOUOxDkfQItI466ZwgFudcUPRUc5pWgYe1bL1xfB2ZpQA8OvHQSEuP+QJE8wfHk
         B4DQ==
X-Forwarded-Encrypted: i=1; AHgh+RpTZXjWAMjvM+dMZj7fO54XzlKQMJ1KWqdrPnkT8/IfaudfzcgEdlHwlLI6Q4hnm+qO8+OSvPpLCnI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyE2QCeI71x8o86iMQX/vvkcpnTFdrTZeZquhBChOUUqqDvxQBv
	sU1Au1LjvgbIZrVlQFpPCeVysuvTiFe6lJHiYvkM4AeYqZPcLtLt/0tFQFMCG9VTQPv3SBxj1Sp
	//U4TnkiaKpj6jvbHy4ZxaxioXhJWN5M=
X-Gm-Gg: AfdE7cmDLfZTVb5gyU6I7C2nvr2p8aT7y76jRORgOXOqt2/eVJJiy3B962GSpHJNko3
	hXSnsuBhHB08Ij3ohHyMuHUKZs3aH/7VqiYInZvdnBWJcvrdBOdEZnfqpVEH1tchzhtrIrBEVGf
	/2Ubbuf2v87aCqHploCiZWKNHB5PBNNO1jHvNbBpnIAJpin7gOT/ZpcFOmuYPvYzY4Pw17wrQNl
	Meo/q+ea29+dH5TGrHtAVb290UB9syXT7k/J4La9CwrDt+6XD22aCjh1k/iE59ll/wU1fc/sH0f
	IItoEg23ob4SaRB2OduMBeeCesJnXsI=
X-Received: by 2002:a05:651c:23c8:10b0:39b:bc9:90ac with SMTP id
 38308e7fff4ca-39eb28bca4fmr14571191fa.30.1784475634687; Sun, 19 Jul 2026
 08:40:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAO26r3Ttyfqhs3_jWDFym7FpswqFW4-UA8p1pQBcuWzDGGzstg@mail.gmail.com>
 <20260718024838.1623-1-brucer42@gmail.com>
In-Reply-To: <20260718024838.1623-1-brucer42@gmail.com>
From: Muchamad Coirul Anwar <muchamadcoirulanwar@gmail.com>
Date: Sun, 19 Jul 2026 22:40:21 +0700
X-Gm-Features: AUfX_my2BHAuHKNdQwXk2gMXJotqDpUVBbqWmJkHc40EsH9QN8iS6jWKjJzD0qo
Message-ID: <CAO26r3T1YV_9if9XbooMv0VDzLba0CEgpSf6Nx+_rd2D7_oJ5Q@mail.gmail.com>
Subject: Re: [RFC PATCH v4 1/3] i2c: rust: implement SMBus read abstraction
 via kernel::io::Io for I2cClient
To: Bruce Robertson <brucer42@gmail.com>
Cc: Igor Korotin <igor.korotin@linux.dev>, Danilo Krummrich <dakr@kernel.org>, jic23@kernel.org, 
	lars@metafoo.de, linux-iio@vger.kernel.org, linux-i2c@vger.kernel.org, 
	linux-kernel@vger.kernel.org, andi.shyti@kernel.org, 
	wsa+renesas@sang-engineering.com, ojeda@kernel.org, branstj@gmail.com
Content-Type: text/plain; charset="UTF-8"

On Sat, 18 Jul 2026 at 09:56, Bruce Robertson <brucer42@gmail.com> wrote:
> For the write side of that rework: I recently posted an RFC with a
> Rust port of the SMB347 charger driver [1], which Igor pointed at this
> series (thanks). I'm dropping my standalone SMBus helpers in favor of
> your Io-based approach.
>
> The SMB347 driver may be a useful early consumer for v5: unlike the
> AS5600 it writes -- a config-unlock write plus read-modify-write
> updates of charge-control register fields -- so it would exercise the
> io_try_write/try_update paths that Igor noted are otherwise easy to
> leave silently infallible. NACK and arbitration loss on a charger
> config write are exactly the failures you don't want reported as
> Ok(()).
>
> Happy to rebase it onto v5 when it's out and report back.

Thanks Bruce. Good to know the SMB347 port can benefit from this too.
The extra write-side coverage would really help, since the AS5600 only
reads. I will CC you on v5.

Coirul
