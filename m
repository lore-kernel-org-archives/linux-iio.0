Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27C1C383C74
	for <linux-iio@vger.kernel.org>; Mon, 25 May 2026 13:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779715418; cv=pass; b=pK1trwWkNYqBkMn032GSSeuq08OeRjvqEWV63TBu6Ddb+n1OakUXXTeCAm/IgMqXY+h49Xv1CqD4tWBzznNUXr7atMsZy0bwoLoSnnPeTujreV3VsDjUNe80LGj3Jy6GOZFMFuKA9VP0Ktsgq3fZCKj9zlmkueuOo53pb1g+GPM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779715418; c=relaxed/simple;
	bh=+BdezTZZ2xJDU1plnc5GlgQRS1RzxYkyrenMWctrdX4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=glzoouErwm+jkPvxZ9mYymO55BroNMqT0k1+OiuzLGaiAxsgd9FJldmMHdTQqqFV4F5Tb8E+EgS9mYKzvaIoCouss8txNrb6tn3RjgFxLy2TrIR2TzpB2uLNFtNtth2SVbfZAEpqAMVixoKJwDGaoIG3+j6A/EsWl+JbKFsFLWQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=o3qKi6tb; arc=pass smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o3qKi6tb"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-7bd9f61458eso70745727b3.0
        for <linux-iio@vger.kernel.org>; Mon, 25 May 2026 06:23:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779715415; cv=none;
        d=google.com; s=arc-20240605;
        b=R/cI6o/kXwqISD7PHHjn+aECbNUyQ3o4MgOwZOfKDk/araP0pGcdmw7NEH2pLPY/0Y
         RLAFFy8fg50Tu9N+Zq94VuuuhQtm3nYw5yYigJGzmsdhgKk/m63HIcD28zvTmvY6XW+z
         aMx5IrlCi/1BvlxTnD+BC9Y/mUFJBVNxGU9riYYXFTP/nxWKuKxFP3tvEKiEQF9MlYxe
         xUDrtVVWFNHDD6RnqKUaF2Og2ZFqj8qK6r0MIsXxG4ucbaN6+5Ji4l3NsMfUE+/HXiVj
         i8TLolcSiKqvA6ViikLtfD8aBoYObVb0emDMBVZs+BX2YTP2R/aM/oqWnK35tfhHDjpC
         lqag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bZlVCaPkKYN85O4NgITQHjQkGhUnieAIagC6kg3O9Os=;
        fh=Nvlj0sC+uhwQ6Ec+dry8vtuzClyEkUvfdhgY3gJ8ImI=;
        b=Pba9Mk170EFwNcjfPzuhmL5WW7Tan26HHi7hcqwunPdUoBdo9xCBNEAPeY0GX0u+8T
         UKk85sS7xzO3TykJ9hRVhytnoLuT9rg8fwPbeORniwi/Qxb246DH4StGWiTkLSv/DI9S
         SM3xeUaCpFBFDziQi3Mzh5TZpuJINbO0qdzbD3wHc57xedMMuQwiy3aMq9262sx+Xbq5
         gdd2+c2VrPFNn42PLe9P+JLoptYfhZOGTDeZIaHf6fZiaXe1dSD5ldmKUDBB68Uubqxd
         1R3kzvIrSPEfx9agVVtCWc8bARkospNcTrDQBdIlRHt4Fqnoi1LFn8DHVHrKIytwmY9R
         GCFg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779715415; x=1780320215; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bZlVCaPkKYN85O4NgITQHjQkGhUnieAIagC6kg3O9Os=;
        b=o3qKi6tbhy6mP8W3bDryxKx2J9ZHqmDDE0y3V/Tw7rjeAQx4NDIu2J52ehStSi9qTl
         xU2mUWDGmJhIL0nl74RmEcgE6+jobVvFiQla1ik4HNZNIYyYgVN0jEi+vcvu1LMmHdUA
         qXE6M+K7zGHz5IgE7FJquLzGuKl1/+Sjs1jNLEilzkC5bzVORNRIKvA77BLrg+Cy8eEv
         4y1d7qWI/SLtBg8ScIpQG5IBHN4if3Z9WiNjBqtMGku9J11199E59k/zXpb9HqF9Oy8F
         vYbVU5D6i2ahSMjf0Gj6Bymlgkaw1nMgEYalrcRe8w9JiSoSFAefgjgcrKdDbrp1WMcE
         AWBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779715415; x=1780320215;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bZlVCaPkKYN85O4NgITQHjQkGhUnieAIagC6kg3O9Os=;
        b=nOznlKkl1NSQ1kMOEK2zBtRK/MVgC5v3bRbsk4v1f/N2gsmP69SExRKGECKq/C3bY6
         3uTsekjAcHCl7bfNhta7/8RWy27qAoPGEQhTL9/zHg9lE7TzHPceU0GVyuuM1T/ZIJBf
         KMxPIoqDo8IQSpIQHGyZouyLEIUxOOoXtD97GrJoDSmw+w1/sHCCKMawa8CqUqSKHX+c
         5zcV+7/UgxaDL4FZ5+ugVvZ2BbR+f3nNUftqvjg3gj5dHWiLk6d+N1tCAo1240n31HFZ
         maOJQWYuk3YlHJqvvOSY0shap3pMlqxfBqN1BbjhVsEaT2qHhBivE/vDSQrPH3F+Odml
         jmwg==
X-Forwarded-Encrypted: i=1; AFNElJ8xo/Frxc5oHOxWF2lIIQE2NIvEihWXLcd2VBWXvs5vHSks0SWZSz1Daov9lyvUDcQME7UOT9OrhJ4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxxj1rHWmBvNnhvzEltJj9i8ZadKTYIxiyxgTJP7DMU2RzwzqKi
	tozaemCp/A0DAEX/Qq9nW6mX3DZgSVNQERI9slkZUf58ENPdb3NyVxHgMce+jlTcXEklA3sGhv5
	BwJuuBEhqTxgqo6C3OFNgOnBkFHtRUKQ=
X-Gm-Gg: Acq92OFgOmuptGvUu1h4wfPLbhznl/cK1jvd3LZ9+QVgHEoE3TTPdd58M70QqjJI7IB
	zHa7vDyFAD72ZeUVyr4VajKUh+7M2eOH3U4/g3qqrUcp2OWc59XlZz7dyK0HAHN5sRR7oSYtvNH
	vtEWUKwlnbAo2YGYgn0QWHaC/AbzvAjKgNyj6Qdo1YW0xlcyz7+EjSdIjfUIII7icjmtGPI66QV
	ZWOzgGleTgPm9kWP3NpWPsvrHvJrKJZTuaOejIcf/gqjb5jLVak1ZfO6dB/J7+fbkDvaxPnvsec
	iVzMoQE=
X-Received: by 2002:a05:690c:88:b0:7bd:5c77:1aa9 with SMTP id
 00721157ae682-7d330de95ebmr168149997b3.0.1779715415111; Mon, 25 May 2026
 06:23:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ahP3IjYJ87bNc1De@stanley.mountain>
In-Reply-To: <ahP3IjYJ87bNc1De@stanley.mountain>
From: Maxwell Doose <m32285159@gmail.com>
Date: Mon, 25 May 2026 08:21:51 -0500
X-Gm-Features: AVHnY4Ix5-r5MLMK4Wc8I9sdlBI7sguJNq-iT4KeCM14tJZaMcIUgMB0PpPnph4
Message-ID: <CAKqfh0ErCJV9yV0kbgmvpRYzD5sFEaUxTrXxDKVVeEA8m3WhRQ@mail.gmail.com>
Subject: Re: [PATCH] iio: dac: ad3552r-hs: fix uninitialized data ni ad3552r_hs_write_data_source()
To: Dan Carpenter <error27@gmail.com>
Cc: Angelo Dureghello <adureghello@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, linux@analog.com, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Dan,

On Mon, May 25, 2026 at 2:16=E2=80=AFAM Dan Carpenter <error27@gmail.com> w=
rote:
>
> If the *ppos value is non-zero then the simple_write_to_buffer() function
> won't initialized the start of the buf[] buffer.  Non-zero values for
> *ppos won't work here generally, so just test for them and return -EINVAL
> at the start of the function.
>

Please see my other email, you're also returning -ENOSPC instead of
-EINVAL here...

>
> Fixes: b1c5d68ea66e ("iio: dac: ad3552r-hs: add support for internal ramp=
")
> Signed-off-by: Dan Carpenter <error27@gmail.com>
> ---
>  drivers/iio/dac/ad3552r-hs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/iio/dac/ad3552r-hs.c b/drivers/iio/dac/ad3552r-hs.c
> index a9578afa7015..6bc64f53bce9 100644
> --- a/drivers/iio/dac/ad3552r-hs.c
> +++ b/drivers/iio/dac/ad3552r-hs.c
> @@ -549,7 +549,7 @@ static ssize_t ad3552r_hs_write_data_source(struct fi=
le *f,
>
>         guard(mutex)(&st->lock);
>
> -       if (count >=3D sizeof(buf))
> +       if (*ppos !=3D 0 || count >=3D sizeof(buf))
>                 return -ENOSPC;
>

See above comment.

best regards,
max



>         ret =3D simple_write_to_buffer(buf, sizeof(buf) - 1, ppos, userbu=
f,
> --
> 2.53.0
>
>
