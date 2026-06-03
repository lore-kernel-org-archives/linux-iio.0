Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2431382F31
	for <linux-iio@vger.kernel.org>; Wed,  3 Jun 2026 14:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780495890; cv=pass; b=qsX+/sv+OVK2rTc9EiGs5SbeRDXnXg44gezRAOIHXvdLsujl2KShqdK0AP39pdltlyXoVm6x+N1fBvhMbTpo8dpVSzWWal6s2hrYd4e6E0do5xf47Xt8JA6YJ8C52tHz+HmqNKYzeoBlWdyPIG1yw2Hr84QC/TYjUjsRa0CNgPI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780495890; c=relaxed/simple;
	bh=J0T//PjZ8vmpTt0DYps/hq0hsme+tTywEjcY/Myy1Dk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SQpNQvBTNpo8j7j8bV7qbVPlVnoXLyCqTpSCUM0XM4xK+eEgcTgVfx6d1XOPHoSpe5PFEImCUBF/mQtuLHy7PHQ/d+8pZYCjRUzc8luDOHkDJHFadP6C98gyK75rW6S1VXrLd/uAleroWtFrf2gXjwRTAwmSoeajuvXinVggc50=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pqSseIrE; arc=pass smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pqSseIrE"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-490b4e1ade7so12938945e9.0
        for <linux-iio@vger.kernel.org>; Wed, 03 Jun 2026 07:11:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780495887; cv=none;
        d=google.com; s=arc-20240605;
        b=gYV8zZBnju1MO322noHZRU6kTGJMFHPAbun99tgCpVH/bMw+3UYeEvcstKQyCAk4ts
         wu3Med4S6V31R7ZIN8c0X/w+38WE1+E16NNW2VqxvImmrr+IVOWqoRhvyKMSnuml4/4P
         d3sm1vJPjE6yj0JT/U1sU4gMy1c1UUE/l6lswY5JG6VOI2ziTQYHrYj5zz0HSIsaTV6J
         iD9Yd21TG23b4OICqL7T4R6AoFGCqbmJ9gcAdOW8w4+7wsOjS0v/e5E8Hp+NyRES6sUn
         8GEzoOdZIGwhqMxzc00InWFOmZHr2sDffFcxfvHBoaEgaGXr1QfgL8/ZIY/x0/dpR0Ym
         WGtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6CACAA4uU+KaJ+JCYwxfhqMbDUI9bUD1OM/DS88kIZw=;
        fh=lD9eUY/Amz8IdJcF1xUR1B1jkos1AfAarz3CmO4CJZ8=;
        b=HKG8U1tHUMxAdnbVIlA2AfpqcBTFVFlnD2DJ3aAl0MdfXoiqiE2gnaC/NZUaoF2bzy
         roIpiKbzyIGl1dI9ykh+PV0YB1S+yaILLyrxS+fQIV/b2CdlcvnyY/VqGllgeG3mD33a
         /FkUffwhk1SIsNfpG3B6+OsoQBzBFWj5nAPXGlT0C0ffFaRzplFTxwt7za9Ft/uFVe2Z
         0EKr9a/h6YFXeQPQQFvdHif5Tb+JF0DjqnM1cUevJofdSiYpjsixhN7bqw/7mt6/1ML+
         6s33ysBnAdLsabStAqXR/HRvofVk0ad2IPkVTev3ZfFyVoGsQknDtqToOLvH+gNnX5Rg
         W8+g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780495887; x=1781100687; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6CACAA4uU+KaJ+JCYwxfhqMbDUI9bUD1OM/DS88kIZw=;
        b=pqSseIrEuxb2IsE6dzpL2LFznOYvNELOxng1t3HOUHbEq6w8rNlJOlDHmvN/903l8U
         Uou9vO75kkW9cNNmIiV88BNY2SffbWUVZw4Jo5+FWAa+3+ClTW3aLHHewRgj1zG7ChJv
         uEPKgC/9EN5S66EOR5YCD0mvI0IDpw+3DmWMhWcexXMD1uzD9etskihhh/48Ex0ii2ST
         ZQfloVKgMInLaw3T42K8t647AM0sLSD+BmX0C5kmr8+KIopnqkbWxXoQoFMPlbJbGKnL
         kNhel9PXbEmpggwQk4d+q+ZAURiaHGQZ0toZBy8yFUuS2bLWZuNwpTzM27cxn1EGnAH4
         6Knw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780495887; x=1781100687;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6CACAA4uU+KaJ+JCYwxfhqMbDUI9bUD1OM/DS88kIZw=;
        b=BkaX/Bgcq7YDvvZjaKFNwFN1AnVqGoIZ/Q9kxiaOj5xUOf/D0opeFPxBd7BnzsyNHZ
         cDGL9ooIa7T2tU6qWLpfNiSMn5eCMMpQn11MLUVIbKvDz73XXUwrmrS6Nr8B5+2Igpud
         0eay9MaLIl+MOY4rPA85YS3bZQfTbuqRCxSbVAE/YQFoGgbvOUyNCiGjwB3Htsb1yqvn
         1xEkYp1Bo371j9FjsN0k7Sl5wCQVO/fNKAkdhf4p5NmCd6FfC49aeLaXIEbwki5ME51L
         Te4uUEMdCsLvOQvwd4rhqviEcdn7md7aFqFbAtceSgkoD9KIK4qlKXvrO2BvnNeFo5Hl
         TFpA==
X-Forwarded-Encrypted: i=1; AFNElJ8Uq4JPaas5D5ezvxBtRuImBwgxsFkLn7cUZA6CI/gjocp6t3Pos3V08+/hxGjLb12IpnJ1sz2RWoI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQci1nxtZd0LmY4I/gadEmrVrtXExL0UL39bd5ErqzHnFovqBZ
	Hf6oSavdXal5SATpWUwQGkD1pQnnvUsPxG8y28dP6bwGiNhjCjhHqS5uw78B2pUCA+bXidz1iqf
	Zu/nMNNvMB+IWq0gh5QfLPad7zzE0xRU=
X-Gm-Gg: Acq92OHDi6OBxfPSdOIAtpcu6UC2LlfSZ0BmHfeqccbon/he+LiQvuVWfxLQrL+OKAb
	L/fRXFeanME09ez+xzX/ZYLssk88vUEEPLNPqeEzhM/14xTA9I36oR4HKQBq4NSyVeKyL0xtGdC
	qfgichptqvrWnL5Yq/pFiyerDQ0/MoFXNmQbxbzg+8YE5nYwfkF/f7e7XPHJxUFkrLFDnat3S6W
	Od0Z2N4cCegFBB87KkFGAURl2TvIoJA1fgo08ZvqNzM/N61uS+CANTRHxHWtUSuljVo71rozTvM
	lvvLeC3MF31hWdjif0QKiGSuIZVlm0U4/l8fhYi6pUEt9KOxJ7/hhoWOJI7dBNIX5FXoW30DVaf
	zlKoGKSEDH6VUGRu+4kBnvOSB/y5JEf0C1IOpKd6NGKn2k1qnf3qREuGx20qborCgAJ+pDBnD8v
	QlhwswQJVy/pYXq4+X
X-Received: by 2002:a05:600c:8b65:b0:490:b9c3:6c58 with SMTP id
 5b1f17b1804b1-490ba04d535mr41203015e9.16.1780495886801; Wed, 03 Jun 2026
 07:11:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260531111605.2411980-1-jic23@kernel.org> <2417EDFF-1ADA-42CC-8D52-C93E90EC4953@gmail.com>
 <20260603145551.3f97ed31@jic23-huawei>
In-Reply-To: <20260603145551.3f97ed31@jic23-huawei>
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Wed, 3 Jun 2026 16:11:15 +0200
X-Gm-Features: AVHnY4LcuFKG3CQqaPg7WdE0Ti7h601NxXV2uQHxjBXNd6acxjYBVfCPM74bpEQ
Message-ID: <CALoEA-yQrjLyt3vwMKxMy+dj4f43Cj8PfZFtkGPBBP41oz3Myw@mail.gmail.com>
Subject: Re: [PATCH] iio: buffer: Ensure bounce buffer used for unaligned case
 is zeroed.
To: Jonathan Cameron <jic23@kernel.org>
Cc: Sanjay Chitroda <sanjayembeddedse@gmail.com>, linux-iio@vger.kernel.org, 
	Jinseob Kim <kimjinseob88@gmail.com>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, "Reported-by: Sashiko" <sashiko-bot@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 3 Jun 2026 at 16:04, Jonathan Cameron <jic23@kernel.org> wrote:
>
> On Sun, 31 May 2026 23:58:25 +0530
> Sanjay Chitroda <sanjayembeddedse@gmail.com> wrote:
>
> > On 31 May 2026 4:46:05=E2=80=AFpm IST, Jonathan Cameron <jic23@kernel.o=
rg> wrote:
> > >iio_push_to_buffers_with_ts_unaligned() leaks uninitialized heap memor=
y
> > >to userspace if the data passed in is not a multiple of 8 bytes and th=
e
> > >timestamp is enabled.  Use memset() to zero it after resizing.
> > >
> > >Fixes: 95ec3fdf2b79 ("iio: core: Introduce iio_push_to_buffers_with_ts=
_unaligned()")
> > >Reported-by: Reported-by: Sashiko <sashiko-bot@kernel.org>
> >
> > Hi Jonathan,
> >
> > Looks like "Reported-by:" is duplicated.
> I'll tweak that whilst applying.
>
> I would like a few more eyes on this though just to confirm I didn't mess=
 it up!

Sashiko had some remarks about the wrong member being memset, however
it seems relatively standard... human 1, Sashiko 0?

Does this memset operate on the wrong pointer?
When iio_push_to_buffers_with_ts_unaligned() is called for the first time,
iio_dev_opaque->bounce_buffer is NULL. devm_krealloc() allocates a new buff=
er
and returns it in bb, but this memset uses the old pointer, which would res=
ult
in a NULL pointer dereference.
Additionally, if scan_bytes increases on subsequent calls, devm_krealloc()
might free the old block. This would cause memset to write into freed memor=
y
using the new, larger size, resulting in a use-after-free and out-of-bounds
write.

--=20
Kind regards

CJD
