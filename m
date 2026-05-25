Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1605B3845BD
	for <linux-iio@vger.kernel.org>; Mon, 25 May 2026 13:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779715156; cv=pass; b=I1E6eMK1SZn7Blzgn8p/92KzNWmOYUI3CK2FX8eKrYYSVG1ytmjY0znnP6I3qUDNfbtzmSFoSSSI+mofFyuCVY6NMHGiqplYD0YFbvkVS8mp+N2AMFUFYHSa7w1JG36gF1uQGICsd9PxH0xKn+hg62ECBK7LrnOBJcRzbndQvKw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779715156; c=relaxed/simple;
	bh=8bD4hhV9R1rrByl8nODL0zdz+MEjBPj+Kc6NRhnT61E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dX8G6tA5T4RxXF8WtAaNpF1h9SLYkv6GBPRwgtPoaGFc/OBxbaIO6oaknTBfasJe4tEjTfkPRrrCepIj1yLNTdiSYdl0X7o8St9P0k5MtYRuvG2s+/m++sHiVdlNFg1c53sxmIfPgf49UQUdSqRYPYlqRQsXot7lKcQIfXdvdII=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iM42wkuo; arc=pass smtp.client-ip=74.125.224.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iM42wkuo"
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-65c3ea2ebf7so10446987d50.0
        for <linux-iio@vger.kernel.org>; Mon, 25 May 2026 06:19:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779715153; cv=none;
        d=google.com; s=arc-20240605;
        b=aHBrS4vPH0cVCQfFooeViQnYRdVOWnjakFHvpWk9ncEgr3OVlhE/s99Qv7hM3eof3A
         PD2cAlLqen9sc78VGxbAwhT6y67VzLFyThSsEbb8CkhnmbYkIuzb7RiZxyxwMBG0d7OP
         RcVJwYsFlM+3cXudlqd4zRsbKzRYbCg5I5W3OdWrNgXXtzxveociGlpm3wyQbIdbkiPG
         msO+WeqXT4vHuOipeDJEGlqa/Mc4oYCsBemCOg1a2XFg0ghg5Eem/OQyEkAYRl2HPS6P
         MFKmDFxlNus+YzP7OqNzv2PDY7mwx3z31ALzE+HSOg2ouwmt0sp2uCZ8bDCi0OZpRMLn
         ff8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=LZ1l9EjcFdXcWL8orZnpT/5BIMT8jYn9V+RiteMHsoc=;
        fh=6y3S1B0KzcDCfZxs9VhAomdVl/VsWozKHyfLVSD4CKU=;
        b=QKrpMAAaZJpgzjL/EhHn68ocA7phBK477diwP5zV1CstlZdn1KU7s6p6FAIP3885dr
         AgFF1b2mfR6gAls/1328waE0CxeY7647cJWYCFtQ1/CjfJohrKM5d2GVgWwDkIH1eT7x
         90z72u1YGmUA+7QGXj68zjxl34ml8TNwilL/oLvT9mOBKDCOXONuk8JmxSdLwYYmm1Rl
         KCWYVLR4Zv90HYDWcvZzN3uF+rv0Zj4oDZZVirH44cR/GKXl7ioi7mJh59RFv5ruXZna
         A3O7isa+Kzik10WmLyisDJB2Y1Z5AKn5WFX24uJDb0GR1ppCql4z9XJvRPq8gOMcL8dk
         lj0Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779715153; x=1780319953; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LZ1l9EjcFdXcWL8orZnpT/5BIMT8jYn9V+RiteMHsoc=;
        b=iM42wkuoQSkFC7jTSCDZGJKrIjqi4OMcSLsn3EFAuiZkxl2iwLJdXh1oH3LwKR/V/3
         bwZ7LjWooVoaX02SKgc70WlQHC4DkOHiYoPv9IQrWYFveMjYjXcxCx3HUp5LB3PvSYUh
         rOBGIjIbo5GIVu7BNa9AI+Nws634FTSgk/BDELqO4QnH7mLDPEn++ceCXA+w/hA9Xqv3
         WRPu2KM4Aeim2mXw1AqhFR9cos5L3sOR+dRw/XIiy3+/Cq66jtZAAUciVUoYWRIGQmGc
         +tRjOb3UWYXbblVAdPhQ33D179TjFjxRHtTIYmwjmCsopzqtxoMv4P5h1KHYoGjdsFm3
         PObg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779715153; x=1780319953;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LZ1l9EjcFdXcWL8orZnpT/5BIMT8jYn9V+RiteMHsoc=;
        b=m5pbKigEwwq1o9zuCVGs3CwYywS38we4oQwJqQJjYEcdhxIvuSJ2HkOrJ/58wVAgy1
         HWW4phnmNQabInmRviVgfF0E841j0O4YsdvTz6+is9FyzvvBzlUesffwyXqMcTMDkyfy
         +95O1ho3G/lsStEGIhz1256w8hppysfHzHP2dRQ8XoD4WauNvIwWmIJb9q77CmQcnxZc
         oUR5ChYJzEjchiAoiNsVOEUKLJSkF9R5BeYe8W0/eWzObPFTJlPOGDY5jmvj77fR4GqC
         JExykfAObxH7JGBXkmRRGfwphvPIp6ETplNz45Fmi445Bhfb7cXK3D4C0xFoeiYQbEu0
         HXDg==
X-Forwarded-Encrypted: i=1; AFNElJ/LceHu4OMM2pcAL61zxtUpL4suYPr/ka53xezm+nVSFJOhkIDPxIIrHtWkR2DVGMT/5lDpC7p6G9Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxg7cgGbWHgb1tzx0MS4+V5GK/xoz3gAlSJNfRK8D+KKKyJ3jb0
	KvMFtZFyF9XiLOC3SmHAmeushnUMAWB/hXMeg3HzNL/w9/nCDxyI1ORZA4kk8P6k5EW815VHgea
	wpTObkKWxpiVze+9+RJrM9xywQ5zTEWY=
X-Gm-Gg: Acq92OHVN7o/QvfYw0ons3Lq0cfCPMjtoixVLQe6PTw9KrMX0bzZLGvDgu3JytfnXKL
	FfCZcBB7kRM27M27aPo6GG9F6nxeFPCpbCYxky4y02sbll8JF6SprAF9QLB1Qw3Iy+mYSPtZuJv
	9Wg5uG4p5OLRO8i0DC37EbY9SRn34tbs8c4ji1FUxoqb4oi7/UiVPZBE4nr1nMHUf10XUOCPj6Z
	P9Ks/FWHVS/R19Vj+26jVUMVp3jmxnjfzlqYGdUZ/JwwHFW1yn4nq63x7HiIX+KCXcFoGkPg3Vu
	wtBP6HA=
X-Received: by 2002:a05:690e:1516:b0:65c:5e34:7343 with SMTP id
 956f58d0204a3-65ec99a13c4mr14300051d50.44.1779715153028; Mon, 25 May 2026
 06:19:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ahP3S9nOYN3pG-Fp@stanley.mountain>
In-Reply-To: <ahP3S9nOYN3pG-Fp@stanley.mountain>
From: Maxwell Doose <m32285159@gmail.com>
Date: Mon, 25 May 2026 08:17:28 -0500
X-Gm-Features: AVHnY4KK9hzC8IuiiFBdKBDnjJOGGMh1HJ9ZcdNrpkpYcGQcS0iFGTJqnGUlKx4
Message-ID: <CAKqfh0H0Z0xr4bAjctr9h95QTuEUTF1eCgBsRZVHn_KrkZZX3g@mail.gmail.com>
Subject: Re: [PATCH] iio: core: fix uninitialized data in debugfs
To: Dan Carpenter <error27@gmail.com>
Cc: =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Dan,

On Mon, May 25, 2026 at 2:19=E2=80=AFAM Dan Carpenter <error27@gmail.com> w=
rote:
>
> If *ppos is non-zero then simple_write_to_buffer() will not initialize
> the start of buf[].  Non zero values for *ppos aren't going to work
> anyway.  Test for them at the start of the function and return -EINVAL.
>
> Fixes: 6d5dd486c715 ("iio: core: make use of simple_write_to_buffer()")
> Signed-off-by: Dan Carpenter <error27@gmail.com>
> ---
> The original copy_from_user() code was better:
> https://staticthinking.wordpress.com/2026/05/23/simple_write_to_buffer-is=
-complicated/
> ---
>  drivers/iio/industrialio-core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>

Codewise looks good but often times people will prefer

if (*ppos || count >=3D sizeof(buf))

over

if (*ppos !=3D 0 || count >=3D sizeof(buf))

Regardless,

Reviewed-by: Maxwell Doose <m32285159@gmail.com>

best regards,
max
