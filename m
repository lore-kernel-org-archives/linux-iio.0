Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4449145B27
	for <linux-iio@vger.kernel.org>; Sun, 12 Jul 2026 08:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783844250; cv=pass; b=JzMdVTyEEH2pAFW8nf4j5FOgHnOwBObL7AczyL1bG7BUqSa3p6zgXX1oKv5iVgLL/m/K9n2ytH+vEl+8hz3XMt8l/dLSqtw2MkSSKJbSEczuaFQWChzkC0aTvbDsmp1t4CtZl4EuF/xyZBA6J4jEIwwImHIVZfPGz1w9pLY89Jk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783844250; c=relaxed/simple;
	bh=QcgPczOmIZhpoU7K5cfpBikVx1RlXpjjVlgbZztf7X8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SIm/2x2YUFnCE2/GRn/iiZfRdHG5yK0WOyKVjYCjlNDMOe0WDFSIHildx6tpVSEt5dAgodyzObiXh9kqAlqGxy2WZsy3jYVk3GPZRIhnmZ7usiquS7x4vy4WVVNvZ9AoDB9u/4lHKN0RJnjau+/oQdZX54oj1aVVXC2qGvNIutY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ggFNlPF6; arc=pass smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ggFNlPF6"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-81e8e83ff89so12752887b3.0
        for <linux-iio@vger.kernel.org>; Sun, 12 Jul 2026 01:17:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783844248; cv=none;
        d=google.com; s=arc-20260327;
        b=pliA6k9DeTueg8/DfF937WAX5cIiZ7s60OsXe7vIMg+nIDypXXXwx/ufH8y028QcFR
         GviP/tp2RV80tY+4pfwUWJPW8rr8i4n7x9mZ2We7shM6OJJ2xa7UP/MexWkuIcBCyJU1
         LL+sHnlA5eF9opCGIXrvAnVmvvKY7eV3bbL75yhJeBCAbQqbsZsbWHmGxzBJ9r5K+/uP
         hzl+Ce/UCRkf1vezKHhiItem6KxcdO6Kp2xwq0qX9dgaHSJ6KPdeAfdWrzbY7LmwFiL7
         BiO+2oMwIjdFG2KguGcrP4H0ytA0f1K/54hepNjlfYxQ2/uIlU5XdWTRso/lTq29kDaQ
         Vngw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XBeJuKeSd8OONAL9IImiegKRcrM3/07ehHgrbhteJ08=;
        fh=Bhgti2KgTjtXJi0/NaMzZJx+QSUe397odzn7QbVGNv8=;
        b=W3pUrzFSuVc+FWKlRyc3LeoU9R4TqcT+9GPzDH7TnMUN1wAJDuWMHLtyV7L93MR1mW
         JSlYL8V+q2woOS+Tgkup9bl/VhS26OmVzAyV53U5Ja7dgqlnyxzR5AGx2WS0voV3kUct
         INizuC8avQ0Du97NVQFBehHA1tGzIfdcr2jX0lyISGng7xfxn8KUP2FcJ7+lxMDpyK/R
         0XVcdp7JoDr4ErzjyAIAEvVwIKWpOJgEuGQP4Y/+X8+b7WtsusujQv+lZF1w7Yya0Cru
         Wu/l2AFIMPu9j7wsptu8TIy5t9on6BN5Y6CGc705vIaVqe6Vf2nsV4ooYmUUsMBiW7p0
         TJTQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783844248; x=1784449048; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=XBeJuKeSd8OONAL9IImiegKRcrM3/07ehHgrbhteJ08=;
        b=ggFNlPF6cp6vEAr/kXtjlFWYziYIJDtwJ/8Z8boY56e/Zj2qOQdL5scWSZZPqr1W2W
         YD7tHnXOvlgn4JtGLsQHP2+czWdQmK8PROb8M07vdh0sXGEb/0SurcYHWB3PCl1lSWN+
         JqD1NqQVfGiabCGeq73eMzLb3a3G4hHXaxlGTjmoVgT/sHqHohRcfaYwkUUbMle0rJl6
         0nZm15XsGqGxH1sS2E5tV6YKzQaZ3UturivyPKGCKXuddLUTIcnUvc+Wunf5ylbxL0E4
         QXhd8qFERgXHpZ5pwyTvM2Nbwh3E6c4jZjdiEZ8dJGfHqAtiV4i/3BrEL2TFlr1QnCVM
         cnMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783844248; x=1784449048;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XBeJuKeSd8OONAL9IImiegKRcrM3/07ehHgrbhteJ08=;
        b=LV+IE4qfcfCKB1FZ0n1Ew2tB2/Phcc/zz4O/cgRH2VVbJOffFw3sxJamG9+W/vI+RR
         oXvyKxG4LCcCYnf/YuOGJI8nWWGtirgz7NgAaykvR3nHs3FmoqeRMS1p4XsjTfG7jM8d
         BKfb+oP8qq5zc/eEBqR3n0bt6f5JWZbehg3Rq2E/Wn9goGmdfGVr0duzAYz9j2n2OFOM
         7X/w2zn6OpyUeQsWu5YxAZ9rm62JMrJivNx04eOIaYDpmexN+8WkOm+Ywr4c9+qs1cVw
         QPOeywU6kQIjWQ4bzfXjfpJcSidm4+FDrSaXjLxT9yWdcCoq3LAL1nPCCAu/9WynAaOc
         bllw==
X-Forwarded-Encrypted: i=1; AHgh+Rp/JnndH9MZ0rrh2pj00cmrZK9nnXAXr++jwIB6jsDJt2e+aE7B9GTUmJjiG8f3EPYeSCKwHLM37YA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4BB32ek/28krBqiNzHDyozrFUo3008AHJzG+15p0jHQH8bVcO
	dLq6TJzd3roVal1GuEVSnuEkxdlY9CtPxc7DBUYv757DRnuofmYe4P0Vi+WTfgZy57cUW6mAA/0
	UzIRBDtlHQsuaas8ZJB4QqyK8F2q9Dpw=
X-Gm-Gg: AfdE7clZjfq+bMQt7Eq1kVVodVwBE1NEvmM2YSHLg0/sZdKLbxpQn4y0yND29cuLeoy
	3Nnuyu2kaGquR8v4n9QS0c1Ymj5VT4LmyZWiI4KtjtuvOuQeM4F3lHtFT0ikuQEiZqXLM6L6yZq
	CmvlQKydO2s7bgsq9yCuYIFpWOvelH9thXNV/tDJ5eu7mjferKqEHIbRUkVI6IH3NIKaLl+GRZU
	vkXyCmw7+kI+gvSNA3/KLx5ycEADlBuFlF0/bnS5NtdJL+DrLLt1PpSf9AZ9vOD8lyrG4CK0g==
X-Received: by 2002:a05:690c:e08:b0:80c:80f1:71d2 with SMTP id
 00721157ae682-81e9013e52fmr35436147b3.42.1783844247670; Sun, 12 Jul 2026
 01:17:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260706074650.96042-3-birenpandya@gmail.com> <20260706074650.96042-4-birenpandya@gmail.com>
 <20260712000823.327e506a@jic23-huawei>
In-Reply-To: <20260712000823.327e506a@jic23-huawei>
From: biren pandya <birenpandya@gmail.com>
Date: Sun, 12 Jul 2026 13:47:16 +0530
X-Gm-Features: AUfX_mxoGr7c89SnkvfiNiCzOUMFjKaQsHNrF3XaSifRn7BQl2XlO6U0FGG90nA
Message-ID: <CAAeMi9+2QBXKx6Rp5da9LN5NypeH9vUEn524917Ax6Drvuw_Tg@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] iio: accel: kxsd9: fix runtime PM leaks and
 unchecked returns
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Linus Walleij <linusw@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 12, 2026 at 4:38=E2=80=AFAM Jonathan Cameron <jic23@kernel.org>=
 wrote:
>
> On Mon,  6 Jul 2026 13:16:52 +0530
> Biren Pandya <birenpandya@gmail.com> wrote:
>
> > The kxsd9 driver previously used manual pm_runtime_get_sync() and
> > pm_runtime_put_autosuspend() calls in various return paths, which is
> > prone to memory leaks if a return path is missed. Specifically, in
> > kxsd9_write_raw(), if the user provides a non-zero integer component
> > for scale, the function previously returned -EINVAL directly, leaking
> > the runtime PM usage counter.
>
> This has become too complex. For the fix, can we just close that one
> problem case.  Then follow up with the refactors and hardening after?
>
> The minimal fix is probably the code move you have to check that
> the request is valid before doing anything with runtime pm.

Thanks Jonathan, Andy =E2=80=94 agreed on all of it.

I've just sent out v4 as a fresh thread. It contains just the minimal
leak fix: moving the mask/val validation ahead of
pm_runtime_get_sync() in write_raw()
so the -EINVAL paths stop leaking the usage counter. Nothing else is
in that patch.

> I don't have time now to do a full driver review (too many patches
> waiting) but in general this looks like it could do with some
> 'modernization'.   I feel justified in being particularly rude
> about this one as a much younger me wrote it :)

The macro conversion, the per-case PM scoping in read_raw(), and the
write_scale() cleanup (ARRAY_SIZE, drop foundit, return 0,
reverse-xmas-tree) I will send as a separate follow-up series once the
fix is in, so it doesn't hold up the bug.

> Andy's point is valid about the reorder.  I don't think it is
> a bug, but I'm fairly sure it is unnecessary as nothing else is
> going to mess with the reference count in this window.
>
> I'm also not sure I care about an underflow if we are in the
> weird corners of runtime pm failing on remove.
> Note that it doesn't actually fail if you drop it too far (despite
> what sashiko thinks).  Runtime pm counters are always >=3D 0.

I've dropped the remove() rework entirely from v4 =E2=80=94 you're both rig=
ht
that put_noidle() floors at 0 natively,
so the reorder is unnecessary and the underflow concern wasn't real.
Still learning exactly where the line sits between "fix" and "cleanup"
for stable.
Thanks for the patience and the detailed checklist for the upcoming
modernization series!
