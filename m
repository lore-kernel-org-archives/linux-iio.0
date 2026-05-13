Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9A018462
	for <linux-iio@vger.kernel.org>; Wed, 13 May 2026 01:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778636383; cv=pass; b=MHmg9APcgQkr5Z32SXQYIHcuZj4kcd1P44DwdDCvMk6OGFX8gnGmVUNqo04KXOa2N7q1hQP0AglPEQbr/Xga8y2zVc1WmpnNnVg1VQiK9uHbfdX/gOzMCeCrs0W4RrG3TyfONjNHOD9EO4V9TOkeDCN1FN07vKcSD6G4tRyaD+0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778636383; c=relaxed/simple;
	bh=20meJusuCmF0Wi5J0H1zSTlEwhtkkmYPgcI11j4GGNA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fThBPbuXGmZUqpRLYOod2YE5hfeSKdZ9OYua2VYAhFNOBPD7LFO21tI3CRlTyHi0RogxkfEEhAZjFoOye0UjJ39uCfqpavrYyFqJlKgFNlOOojef6FScaomBaaivBLX9RHs4zByZ0KTU/4hZXz+2NgH/EXHItJEb7ECdApjT+9g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gqsGuo4d; arc=pass smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gqsGuo4d"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-7bdec52f48dso82835767b3.0
        for <linux-iio@vger.kernel.org>; Tue, 12 May 2026 18:39:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778636376; cv=none;
        d=google.com; s=arc-20240605;
        b=fnjq4ed8HwpnrrWW8BZwb/GydOf/idHmdoPc8fuwPQMTYUvkZpPqO2lbNHbELwjP5Y
         jzTEWLK6brECKXlpgnPcLxuDo+qdZNXYz0Wm2GGEqRBBoDdXdjJCnB98FLs3toWqxsPe
         7kHhCWIojHxNJRXSllqP6AIKnMs3pYKGrk2TzD7YXM6X/98GeTKHA/J8smW2EfBEDDLs
         r1T91+gwfRsGm2oPbP6U9Pm2DqI7G+rjF5K7gH9F/0TJUnsTB27KwAs6JjeDzph4zQUC
         aRyDSBLlGeDs066YfqPdngUhcN/wm2GtA/WLfoVW+F1pkjecE+ag4A/xtsPZTG4xAE+m
         qLpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8Y9kwP2oYnTnPFUuQgsW9ZtW3MhjgWg8s4KC5o4vDmQ=;
        fh=Vtc1yEaRVanwoMsLDJiWHRhNE1U4D2ICAUYwFGB0IMk=;
        b=I71AVEwja9wc1Ak2P6cBR3s1hYfxKxkjlvoZxS7D1V38M6xrEQuoqRAXT7l+jcdU+R
         rQqQbbHnuil9sBB72VJOfVcUc2pdyzKZ/g0w3k/U8l2anhkt4WWELk9FnHhz9X0C2w+J
         JoUJpcsqcnLVwcshK4f7/+VWp9BXHEvMERhGHRSkOEKNkToFAzTM6GEdVDgpAKsSNcZq
         TMeuAd4vQU3qj0fbdOl52YGLht0TJm5SNy2uKnk8Afgona+e4jxlRYOnw1NmXkV01dYu
         BnDgqs3MnT4aCTIn5M/xZUhTvncPUnaUTlW0D/JrFQfgL5wn1FnziSlCWGurDQB7F6jD
         WQKQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778636376; x=1779241176; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8Y9kwP2oYnTnPFUuQgsW9ZtW3MhjgWg8s4KC5o4vDmQ=;
        b=gqsGuo4ddD+qvh5PoOoF9mY96kMJ7FLolXW898aS0KY3PQGB4voaCoHoj6yuOy3PpU
         OfX3N9ZnasnHU6n8cJh/VANuHUjxNA5AdRE57juwj3oJU3chA4zwKLhDB+JrghaEjO/6
         tZhE3KdHKW3+NJdVjrm571tvB2rjxKNOqB6YO8o5r+2wipW70MKlNgA3c894SW7mi1N2
         XDdQRkfZG2oZEwwSJy5btxZJETD4EMawUK+HlGBdz8n39c/xxhk0khEq6Z7nUf8T4zcK
         FdQ15WcSyDpf99dTwnT7usz5CVCKhRbdD/MCkAX09yfvT/V5sGpSlBfbQlvBK5VhFlSP
         oe0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778636376; x=1779241176;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8Y9kwP2oYnTnPFUuQgsW9ZtW3MhjgWg8s4KC5o4vDmQ=;
        b=Gp7IaOU5fhVXlKkDeJ8ywdp/S9G95zulTBHh6+asuk30+AoKvRR+n4OMbkzX9n4AGS
         iFA2jEXpW73ZEiiNnarl0ND+6YvJZoSiyGiK9XporKXHMDWzWRqjq2MIp/28eZbQhMtt
         qSVgQPsLFtt2tgsc1Jh7tiJQyXA6mI69PAyeAuAQ7a9T2RCahBHBy1GYI6tfvQJcNU8d
         0BGVFpqUjlMKNB3ViyS/iqjnlVP+JHx9NbLCfciKwExtsyrPMYG3Ay/tAuiZVruwYpsc
         cFXoJh3cXXXuOf+vox6XgCAEMPij0JwrG4c0D4z4UVf1Tm2WqwsBID6myVwu3ZRpM2SX
         csWw==
X-Forwarded-Encrypted: i=1; AFNElJ9vOnNj8yqsD1YgBjpJYa1HIhaQuOlFfmrSmTLTBcynpbSbh8v+4ddrCX9bxeiA4zeEIKQwndcbGjM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOpupu36mMEpPXE6T8OW61yuSAY9gqsB68qYgC78bptGKhNpVh
	VYz0baZPrwyCt7VcvCGdPi+6N5rVSa3kRFfUUlw9JbSt3vL21ZwV6zy/UXzfcGGrqFCypBpjB56
	029OMSFa+oilXvcNbN4pF/oIrY16JWIM=
X-Gm-Gg: Acq92OGXFBLSdGN1mtMORiJ1wRdj5tFN2shA0aFvuk/v2nz8N01NgKG21+UzzITm8BV
	5g5eLSfbTr4Ae/cOqFRdA8F6Acu11IPS52hN2LvsFQKNWVLjBrNv/oBUiCT3xOvr272AQVOEhFW
	EyNb92jUJDEWzUo5emmj2iu+bQqtGaNvIFa6wTM3E5a20urr9GMMYTMqjC6Mcz2b32Kz8vY7+N6
	TV88wuOaLOl8rug4l8Syone2I2LU6V5v09sNZnA8UJ2+3xuTXSNHM3LjdldWbdLi3OxKMS16f9o
	xdtM
X-Received: by 2002:a05:690c:d88:b0:7c2:db9a:7bdc with SMTP id
 00721157ae682-7c5100a939emr62003197b3.22.1778636376510; Tue, 12 May 2026
 18:39:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260513013638.147606-1-m32285159@gmail.com>
In-Reply-To: <20260513013638.147606-1-m32285159@gmail.com>
From: Maxwell Doose <m32285159@gmail.com>
Date: Tue, 12 May 2026 20:39:24 -0500
X-Gm-Features: AVHnY4JU2kPlFHLy9SKB1Vb-_Kb8NDXHzyIWuQaJVyz33y5b6yKjx_tQO3e_daI
Message-ID: <CAKqfh0GHVtAS6Uw3Bjo+B0PCpcfT8FogqEPCmt2x59zhmmh1Kg@mail.gmail.com>
Subject: Re: [PATCH v2] iio: imu: kmx61: Fix potential time-of-check to
 time-of-use race
To: jic23@kernel.org
Cc: sashiko <sashiko-bot@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Daniel Baluta <daniel.baluta@intel.com>, 
	"open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 12, 2026 at 8:36=E2=80=AFPM Maxwell Doose <m32285159@gmail.com>=
 wrote:
>
> A time-of-check to time-of-use race condition exists in
> kmx61_write_event_config(). If two threads enter the function at the
> same time, both threads may pass the check and get to the lock. Thus,
> when the first thread releases the lock allowing the second thread to
> start execution after the first thread modifies data->ev_enable_state to
> force returning from the function, the second thread continues execution
> regardless. Fix this by moving the data->ev_enable_state check inside of
> the critical section.
>
> Fixes: fd3ae7a9f21c ("iio: imu: kmx61: Add support for any motion trigger=
")
> Reported-by: sashiko <sashiko-bot@kernel.org>
> Closes: https://sashiko.dev/#/patchset/20260507223337.48437-1-m32285159%4=
0gmail.com
> Signed-off-by: Maxwell Doose <m32285159@gmail.com>
> ---
>  drivers/iio/imu/kmx61.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/iio/imu/kmx61.c b/drivers/iio/imu/kmx61.c
> index 3cd91d8a89ee..3afa369de3cf 100644
> --- a/drivers/iio/imu/kmx61.c
> +++ b/drivers/iio/imu/kmx61.c
> @@ -942,11 +942,11 @@ static int kmx61_write_event_config(struct iio_dev =
*indio_dev,
>         struct kmx61_data *data =3D kmx61_get_data(indio_dev);
>         int ret =3D 0;
>
> -       if (state && data->ev_enable_state)
> -               return 0;
> -
>         mutex_lock(&data->lock);
>
> +       if (state && data->ev_enable_state)
> +               goto err_unlock;
> +
>         if (!state && data->motion_trig_on) {
>                 data->ev_enable_state =3D false;
>                 goto err_unlock;
> --
> 2.54.0
>

Silly me, forgot the changelog.

v2:
- Started from scratch due to messy git tree
- Updated commit message per Andy and Jonathan

best regards,
max
