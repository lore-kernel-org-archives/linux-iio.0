Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA1F531E828
	for <linux-iio@vger.kernel.org>; Wed, 20 May 2026 03:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779247165; cv=pass; b=cCo3yId0om7/3p5skizWDM9KAsLs2s8cdxlZ4rIiYg4hPX0Tge8NTPv6WS5WeDD5P7bPc1i4df78b2j8lIw3ZgYS6EEK8x+0h75Z2eAFKboG255hhkc5WPo3jazKS6r53hNURdsAkstlvqXayb7gzvqbEnWcM+sPOwaQKbSc5jI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779247165; c=relaxed/simple;
	bh=sNG+6bFeLw1iBghaaykGtH9JRexVRArkpWpqbiV/EEY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eRQ53pQhwPhfssTgJ0rKB28Y57EVsCdffZiGwE4Ukd3MGHAi8MTqvP2LP2hwQ/aGhEQvcnaAzYQMWO18eJEq1c0OvHZEDrw3jfK/7xwKoeHRnkuRRhAjAIqMVBr8ZWbqR4fjJSelKvYz+G10lKCFczNaPz/7SY/be29yHCuz+Gs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q2uVP65B; arc=pass smtp.client-ip=74.125.224.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q2uVP65B"
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-65c305f381eso4564856d50.3
        for <linux-iio@vger.kernel.org>; Tue, 19 May 2026 20:19:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779247163; cv=none;
        d=google.com; s=arc-20240605;
        b=P9uZsLErBLfbJmD/js2qE3/vVZ/NuBf5v52gfNatJumPpetsRW5qkuZ+7TAvGikk8Z
         YoCAy3QRPB6VszJwFuLKOuTt4qFA9k6gT7kZZFaH93eFdrj8SbJqoUxSpO6V23zT3vhW
         DwsYjbAOrivSGC4+OCiQABUDlzGQbDFN8oVrwgX80CNe0dU7OOZK0L5OkPJmsNyUiIvp
         1S9sYKw0YtXiUrFYYTK9TeV4RIrvEXifUd6DJRpJXB9SG0K3r0HQtrTIA3s0QGdii9n8
         xAERgR8zRkyyLCKzgEL98nnx+q/dVBwK9/sSJ1kt6W/1yXIb1qfrnDUkb6POEQd/EFi5
         nCHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=sNG+6bFeLw1iBghaaykGtH9JRexVRArkpWpqbiV/EEY=;
        fh=gQ266fx6Qte9TBnJ6l/VAMm0pm8pXXgft36kLLZmScw=;
        b=HQ9H9O5z0ELpF2U2gqWB1/qCtqFoiyeXv8Qt15xCPhjelDaU2xV1xyNjKuQi7KwjeU
         imsJJK4a8UbbKTILDvXBQ/SC+A5rPaaVke9I6zn3xFrNUu2LRsV3ShSZlzwTu3rPWska
         CoY3ueiJCmmR6ZqyF4PULUd+5Fz7Ni42DzSAvlvnXWBiyZklBfMNUIYX9VY+BQM4TP5M
         D7QGvQZint1spsJ0jQQotnb8mhAzS1vTCI7Ch4OAYMNQcU7N/HGzZn9/rqPfOJPi4bXr
         0YIlhKfnEQHKvNvU4WUEsBuCOV37srFxRkjllkWuyj0+cwZCIT9XDJA1Rnmg0dT1QriF
         vHgg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779247163; x=1779851963; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sNG+6bFeLw1iBghaaykGtH9JRexVRArkpWpqbiV/EEY=;
        b=Q2uVP65B9wMU0pExsDHv/BKqXUgUi8A4I4aQgJsGjVM5Uf9t/kMRqGocpY6E6+IMWL
         jWDdKRmHWzlgbgPY0bx2LUkWf9kbUmsqB1BxLaOXU1MBT0ZpYkrHKl4EoN0OiTpzqbiX
         ZmCnpyiXhD92yKhZQL1cLifFyk3IDi8QU0WhO95DzpeBwZKHwwoedDYy+V29cCR9TozT
         Z2lVCRGnKtDe+olS1ubO+gziE6xwjE35R+AiZhky6QwBOdYTaWIm4b6C3R7HroFERBGG
         hF/HPYqW2KQsF8WgKO+ktqHs+EJfnIf/6iN5TO6kIk0Y1cBll5wdstPF1xj2ACjZwoRV
         RYSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779247163; x=1779851963;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sNG+6bFeLw1iBghaaykGtH9JRexVRArkpWpqbiV/EEY=;
        b=s6ElTdCcLRbCEtCX7beRpQDKd39C0kxeQaZ68/q21sZ15fyxuuDzC0SVT5OAXmTnne
         RWk736Og37jzIJISen0OjYJgUyJa1y+CFGGkg41VAUvjZlhVl2CQil7FhQ8OfILyHYnr
         WxZu6tm1kF7dYqvbEkW6pl3Ish4cleVUVKhhLN5THEF4A0oNmE4hJxvhZh0gAfhPzcHV
         LH9trNUd5MuFnFEP5TXT9FQnN4vgWenoWQqUrSeIE6gB04xp6Sczcp+BSG09Rt4wblYi
         vNYKah715fyqOQhxPtPStcGS+6DQl4XIcUjBq+7618W7Otr0BBrrnp14EGK0x+PMIaO0
         iwXQ==
X-Forwarded-Encrypted: i=1; AFNElJ9HBhGZY+LJY1c9eEYoBykP/OTLSyTv8JlZpyH1Wx6Z8Jz9ZPU0dsZWT0041lWCldyK4jS78+JdAfA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYVXooA77rpat6I+ZTj1Mz49kW+mQmYyyJriRwFucdxMchRiDg
	Q/uYHn9tpZsijvOXHmBEVo89uxJBb9K4wTIbnFjS4txZ94uJwR+/iqwEKEVPGAcVWY8bwdyqekZ
	jwlmdnY0WgGbkZ3lMa9gg7yQ/eUqXh0WkPZhk1ZU=
X-Gm-Gg: Acq92OGng6WXWNjwNKi+GJEDRcKHNcPUnlT+/W96NMfwti/oAwZzQu7ramJxD9nX54a
	l4ZcHYJQu0o2/5pOupPoLkMiBdcxMgcChM+bjCWuGWzTmExOTaScB3AuHQPo8QJMv/yw+4CL4od
	GhwUZSw9maXGwyvkybTgE4CG165kf0yDy8+jxLeaZcBLbtusymvPWOFGPQEk2Hed/ZwMkMxOcNY
	aNQP+3auv9B36qhuL0r5rb39TRvGUXVLxD7+twAMSow92ZxdvWWyiZp8pCxTM70t6ssPZ8LH6vh
	bHDx
X-Received: by 2002:a53:d04a:0:20b0:65c:409b:1cc with SMTP id
 956f58d0204a3-65e227f76c7mr18434081d50.34.1779247162882; Tue, 19 May 2026
 20:19:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260520024153.1647951-1-xinyuili@126.com>
In-Reply-To: <20260520024153.1647951-1-xinyuili@126.com>
From: Maxwell Doose <m32285159@gmail.com>
Date: Tue, 19 May 2026 22:19:12 -0500
X-Gm-Features: AVHnY4K9ybD5EuFHYUdUilJnfUZs0eOI1mGWy_JDtoGhlYPGCYUVHFjVsnL9-oo
Message-ID: <CAKqfh0GLQ=OZYnhNHNc1Cm5X-ZRzs3vGeM0ojCRnOxuLM2hn2A@mail.gmail.com>
Subject: Re: [PATCH] iio: gyro: mpu3050: use devm_iio_trigger_register
To: lixinyu <xinyuili@126.com>
Cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Linus Walleij <linusw@kernel.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 19, 2026 at 9:43=E2=80=AFPM lixinyu <xinyuili@126.com> wrote:
>
> mpu3050_trigger_probe() allocates the DRDY trigger with
> devm_iio_trigger_alloc() but registers it with plain
> iio_trigger_register(). The remove callback calls free_irq()
> on the trigger but never calls iio_trigger_unregister(), so on
> module unload the trigger remains in the global trigger list
> while its memory is freed by devm, leaving a dangling entry.
>
> Switch to devm_iio_trigger_register() so the registration is
> undone automatically in the same devm scope as the allocation.
>
> Fixes: 3904b28efb2c ("iio: gyro: Add driver for the MPU-3050 gyroscope")
> Cc: stable@vger.kernel.org
> Signed-off-by: lixinyu <xinyuili@126.com>

Hm...this signed-off-by doesn't look right (unless, of course,
"lixinyu" is your real name and not "Li Xinyu" or something like
that). Please correct if you send v2.

best regards,
max
