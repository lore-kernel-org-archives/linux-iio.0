Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5D6B3A2576
	for <linux-iio@vger.kernel.org>; Mon,  3 Aug 2026 07:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785741895; cv=pass; b=MFEBN8rx+2US+9XAyX3ECGwfXrV8sYhKrIjo/5X90MWrONSa6I15YLYbWfP9IXdV8DFwfQej9hIluGxON318xhPpr0YCVRDHlEb8HpGoLaUDnqDuDsDX/cnI/yBvc3uMvxmp69U93nn07alD+nEgC/4SPZjD7/Nv6ObQ5MD+8jw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785741895; c=relaxed/simple;
	bh=UxMJ/F2lB9mJJrynu//npxeqx2aElpyU8JJeKc5ehWw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n6oUzAbqvY96QeG5wCBGZRWPKYEkWkdj9Zlltq7qWa0jxTddjuNFVUkFkR5/sdgbJYNRBVuyyGLdrEb75tAwguUUdzQJV4vVNtNvE0Zlyf+gGeqyrYSW5JZEwPRpOFSekdfEnrukwRTKox6lGhXgbkJCK9uD+P6JMZjE/PbYhPI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CCJ4nwFd; arc=pass smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CCJ4nwFd"
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-39ca0a30148so26848781fa.3
        for <linux-iio@vger.kernel.org>; Mon, 03 Aug 2026 00:24:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785741892; cv=none;
        d=google.com; s=arc-20260327;
        b=EYDsissofGKJKA7S/39zpaSGiI5/oywy2bYwDjH99AnlhvSnk9CUnEGqaFQCqgORG7
         TbtmNqVNkdVU7QAYoS0JH6sO+aGk0KSkTPb3jfCZKRLj9GUBb2p90kwxH4XUjr51Fy/q
         V8kwdvl1JvdpjDhRn9rojywRlDbxAAqVj4cedmbk5Q2Tb+lV+un9W9fNBvuPONBJMPUx
         Y6+3yZKPNfDq8INqjbis8nFpKrtMM+x0elwUtOfPHckRIo4rKb1eSMpAdkmSWlY5wvM4
         b3bxP+JWvtZmVYPBFcNv1Jc14o0N47dsIrLtv/UP7a6Pzxejz72EFf1kUdc+Nq5UXVKW
         ALFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=PdyUQ4xcGPHc5vl0Zwp0XFzGelE8gGBuGNsLR1SwvOE=;
        fh=vr1FOZ7rQgYyxMtllIL+HzLn17bS4iG2xkTXocYt67M=;
        b=hRG5hHjjAeZcnUrbL+CERE6zCkIYrCKWPJyjMfUfyApSdgp6qb5z2b7knx8qTOm5ZZ
         wLRTSm1TqCmfNKjnxf7j4xnUh1MV5DfFZNZTKa3EJ93iwx2ZFrHiKTpyKaam/mytADd5
         cqxXFp3wmMEBQmqgR+6T8HdGivybjs7SL9XqzgFU38NK2/tUB01t67BWjpNNBxrD7tR8
         c0SAoh+BciXzs/KO/yr9VRvIN+EdLyIXdTzWU2c80gOSgR3EScw3CfrfdzXjzeAHJ4Gu
         iZTfaKcQe+YbfIu2L1V+/UAelT1I0ictFi0SBXp2TJbvBkSLB8lvqZLZ87Z3+hMsiFx6
         uazA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785741892; x=1786346692; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PdyUQ4xcGPHc5vl0Zwp0XFzGelE8gGBuGNsLR1SwvOE=;
        b=CCJ4nwFdYlk18BkWHb+zlaGdRskoaV/sEQrTJoVPFwafPPDGW96o0ZKZSc1ZqHTeO6
         QfiinGuxsl+lt+sKXkP4MJJZJtYcZbez47Nov5RYdL1CUm5cj/ami71fO7wRTH58eQHI
         h5hmRXSFJBCtk2qZmUwIUJLYUykLLn+3GqXvPl/S9G0Oh7shJEBZZGx+26t5P7HlFaUi
         h8lQWIOYSUSje02t78GaotsVwO+cMDohVhpAiGn3LPC3MYjULe4whcAhtwETUOgiRy8i
         EeApPk5cZM0sz7LyAsmnLIBbl7IEcDRPxv6ccClQ+w3XCAb55dsL7MUGwsp55u3ODgmX
         Qu8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785741892; x=1786346692;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=PdyUQ4xcGPHc5vl0Zwp0XFzGelE8gGBuGNsLR1SwvOE=;
        b=EBlsKn4dJu9/pHNE01TvyUVnkf+BUrLntOSYdiHvrGa7zirVvBpdNqBxkg0cr+cZMS
         4ya8EqLZ3LnWLdyEO2p1dri1Sr9jgcMQAAZkoIcXWPUIms8Qr++iYiWli62e2EyBkZIW
         /MvF8e88DwYaYNMYVhfeLLQv+WzTqoTW06Eq1Jh9N2njKityQmQ4ZkNO4iuh+xVChiIH
         3vCraVQwE8AsmAUkBpMfro1C5D8rxLi8K3wkwoJ3IN+ts4dhE+PyBb1seufEBPYL4ofk
         Jj2oG9qcz0v2B5pDmM28541fasrVHmcM8K24fjKLJh/YvC4nOR8+3LUEYNB1viuKdqP+
         Ln6g==
X-Forwarded-Encrypted: i=1; AHgh+Rpf+TVo8qZ0Di/558T9IYBamDpz4eDVIQ/SZNHXIKNBAKmy/Ie4AnXO1vPxltH5MTsaOTKDd+Bov8A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZa3N4wVOo+KEFx9Vfv1j0mF5YAmjEax8ijD/Ojlw2AFz4LVqo
	a1WVZ9j1rQWGm9QX8IsDwUVpJXEJQPVlQcGKHjLqYmtstn5YT5qiUqbLL6AsQZQ69IOQL3kKPau
	UcMvC0y/nMoTpRNj+2b6L2cL/h/eRWo2AOhLW
X-Gm-Gg: AR+sD10aaHe34F0VMDhe1eBFKYUBQjxJPG8mVvAObPq382MMoh1kkh+r1sUkcizfsgg
	qlgO8i1JZNbwOecnus6sFWxwjpirf+mHYml1oEx9QUx/7lUdSTGNHDWsuQLdp/xEF/jkSk5XBQZ
	T0DNeRha63GCGHnYX5PAsCYONIcFe+1KCM0pWyCG3JmUV8nXPlUNntMMsF19LN1MFfOx61e6gOe
	SEkV5wsDiKBY+/E9LtnKRmAFXWtrZUsrUD9v8B5nwpnsExKAaavqNBdTJW4OSsv0Zv4SbOnHc5+
	TFicTB5WS9qufKMg6a0+ggfQJBuQkr99WghUlAlUeBQNPiM=
X-Received: by 2002:a05:651c:43dc:20b0:39c:6e2c:23c3 with SMTP id
 38308e7fff4ca-39f8613cd0dmr11794621fa.5.1785741891607; Mon, 03 Aug 2026
 00:24:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260707151542.91997-1-muchamadcoirulanwar@gmail.com>
 <20260707151542.91997-3-muchamadcoirulanwar@gmail.com> <DJVQDP9J54K1.AANCLIJC23YF@kernel.org>
 <CAO26r3QDbT07dTsMfMB8Y6H+qBzh-PQxgcTTVKqJ7C9yv-emsQ@mail.gmail.com> <20260803014308.35ce74a5@jic23-huawei>
In-Reply-To: <20260803014308.35ce74a5@jic23-huawei>
From: Muchamad Coirul Anwar <muchamadcoirulanwar@gmail.com>
Date: Mon, 3 Aug 2026 14:24:39 +0700
X-Gm-Features: AUfX_mzhU4wYhxOP2FAXZgZGaEkFuYq6L3OyTBG7NvndPDUEM5Vzh4T4eYBOrtY
Message-ID: <CAO26r3QYVUP5VgtrgwhGeqbJsWZbL=qFVVHvuRNXPLaYB7txCg@mail.gmail.com>
Subject: Re: [RFC PATCH v4 2/3] rust: add minimal IIO subsystem abstractions
To: Jonathan Cameron <jic23@kernel.org>
Cc: Danilo Krummrich <dakr@kernel.org>, lars@metafoo.de, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, 
	andi.shyti@kernel.org, wsa+renesas@sang-engineering.com, ojeda@kernel.org, 
	igor.korotin@linux.dev, branstj@gmail.com
Content-Type: text/plain; charset="UTF-8"

On Mon, 3 Aug 2026 at 07:43, Jonathan Cameron <jic23@kernel.org> wrote:

> > From what I traced, yes. iio_device_unregister goes through
> > cdev_device_del, device_del, sysfs_remove_dir, and ends up in
> > kernfs_drain which waits for active sysfs readers to finish.
> > Please correct me if I'm missing something here.
> >
>
> That covers sysfs, but IIO has a bunch of chrdevs (though you aren't
> using them here).  I'd go for 'almost certainly' for whether synchronizes
> in all cases but we have found one or two races over the years.
>
> The way it is supposed to work is that the unregister takes the
> info_exist_lock and sets the iio_dev->info pointer to NULL.
> It also wakes up any one polling etc, and returns errors on all
> in flight actions.  Every ioctl takes that same lock and checks
> if info is null before carrying on.  The lock is held across
> the ioctl to stop any racing with the unregister path.
>
> I can't recall any recent paths being discovered where the
> lock + check was missed but we did have them in the past, though
> normally not about IOCTLs but about in kernel consumer drivers.
>
> There is an outstanding fix related to those, and read_avail
> + lifetimes if people allocate storage in that callback but
> I doubt this goes anywhere near that area of IIO yet.

Thanks, Jonathan.

The lock+check mechanism makes sense. AS5600 only implements read_raw
and doesn't use chrdevs or allocate storage in callbacks, so it should
be safe from the race you mentioned.

I will fix the SAFETY comment in iio.rs. The current wording is too
broad, so I'll narrow it down to describe the two separate sync paths
(kernfs_drain vs info_exist_lock).

Coirul
