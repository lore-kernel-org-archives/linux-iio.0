Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2984E3112BA
	for <linux-iio@vger.kernel.org>; Wed, 25 Mar 2026 19:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774466478; cv=pass; b=DVLWUmOh47/w/mN6lAqeFnGHvJmfig9Mr6oeBAz60vDWudRf/ydkQumIHN+bIXKrdh43AlXw49zFzf2B5shUkV2dNTK/9v4IvlzWnP+rYWrViqvMHZGYjIshBSC8nPsVoTGRJX/S3TnbH+LqXwZgLHrjTkc4ER8JhxxhMH1l810=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774466478; c=relaxed/simple;
	bh=J/WZlyr995gt0vR+yT+xP0hI4Y+4jBJ7PHLcIa+cJOs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j8Q/jwDMk71Nv9ygaBJpg7WIlebkMsW22/Uk7uuuICEy8zaDXinKIV/KIZi/8pk3LUPCQDlSq2nayFvMH5dCUKb8Ra2N5mvqIV5PSpK9GrZRRACedcRzUDfquPpbTSMguIElASzQmzIht89TwYVX8zhXLhCLfJfbZe/gnMzYd6o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BxxuoqHI; arc=pass smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BxxuoqHI"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-794719afcd4so2338837b3.1
        for <linux-iio@vger.kernel.org>; Wed, 25 Mar 2026 12:21:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774466476; cv=none;
        d=google.com; s=arc-20240605;
        b=eMXNB7IqCxek7WQiUz7Wi+/m1svg8+gTS3nluedpV2Oo3F1z2MTb+jlBRB+OC8qko8
         Dzzp6ct8cpU74Z28qkLllIee4fCsttB15nWQwT2RDc1eQ6He8JbTmOASPeUxqEQMnIJi
         8z2ghcp7dt4Q6nw/BkCaf1OtCgR0hAHFYqJM+ElOYxz8THFoyvdTzIVo8DseK/qkzJ2n
         xEYStjKraOtpbER3VdZAvswznfj2XkNi++RiVDa1hqLwSDCigU6PMKVe549l9uQlZRe6
         wfoIRekmzz0wtRl6mT1Y8OyMTslPUWWbt9/MOuIvZxradTHA4CqZVKsN9Bdes/PrB8pp
         imVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1EbhhAfyAssyGemdaqOUAW2OG6jq32M2IZ58bPruCrs=;
        fh=ZmzNv8k9MscnGh5Rhm7grh6HT6iLUSSh5jpIcJge/64=;
        b=Mc6vLcZLQt8xrxVhmH/WDaiYkZy15L8eeyd0EnsGETD4kDAIT4vkUEE2YQ1GuZVTL2
         YLvn/SvTjbb85NfHxhtmVxVwu56RxRwxo4fmFWGL8jfDBItCi54XrnPvDgVeeTzCeX6N
         nCZXHsr118FN1JlOS4EkWiM+5dXKs1PHLg01dvaUXMYJ5daPeAqy2JgSTa93HDHvIYaY
         1S1OpwjJAzdl/7fKV0/+7Tdg0yKt918rSyTeHrKY5vjY83JPrzH+CeluYNl7inMzPC+1
         vuUjOvRP9uxNdUVaO7uowxON+PPiKV3FhnKEoIkBJxbRTuh159740dK85nNGx++6MWPJ
         y2eA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774466476; x=1775071276; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1EbhhAfyAssyGemdaqOUAW2OG6jq32M2IZ58bPruCrs=;
        b=BxxuoqHIhz++VIcr1e/2miux5xrY8EKUPEXMN6mqeLwgx3boDKyFTnpIE94Fk1YEbe
         WNL1+7QUhEEiw33z2ApfFesMBIJM0lYlQtgQ+lZCpRKF38Px2X60LWlm1YGUXXOzAS7y
         bvKFw0hFLa+lRCxA3K071123vgxNnZ0MWiKU1/zdf+KUUdknro22Z+aFszrNf1yeMv9W
         7wGosEz688oSwMqngy4kVmqkm4w7tKyLquNi0h4LhNbF26q20YgHgUtPeLWTw2T5d5G6
         oW8LkPYRd7q1KBNsQ1VuclgiTIKUxIUur9qc9V65/rkeZvyCQ0oqsTBsrRUIXAfaf9Hh
         EVaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774466476; x=1775071276;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1EbhhAfyAssyGemdaqOUAW2OG6jq32M2IZ58bPruCrs=;
        b=qHbpAzJ1nu56FwppTJ8Le5u+oo/65mHQFpJnSaP7PKB8MRxqdZfnDtlEKqBifxjkvh
         b86IBMuGQgDJTxyV2Pk7ITkHkZ2X29/SrhHRkcuiIV4X2HSkx/5JNLk5NOHeyJ3yLPDN
         fLb/Rps6TkVVbqbBSEVKWtMb6/lzD6Qfi49/7ZgVxGxgIouVdN6FsjRhi9OvOCGXXSAC
         Dg8sN/Co/ur7vO8W1P2m0088H45Phk+uTSnsQr5jXSSfDxuhZYyoq/Kl/RmYmr/9i86C
         hhpvGT571Jk5mzpATmjPTbdz1TKmGiAHMRpPhWWVL5rzhiOGqG3N2+IXQFTTdoXt2OqE
         hQCQ==
X-Forwarded-Encrypted: i=1; AJvYcCXUkDWoeGw+J0Twv1ZcUO3vhpfvkxMT0ekU6lw4bt5Ukvy35Z0JgonsmbMygwNJf4IQN6QWiPm8lAo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqrKdcHRGqRn6362v3+sIiA6YzeKNydHUC4qQtn7OE7565P6a0
	RV66+owzgZD6bKXbiWFbNMeNeV723w+iobOwlqHHtWhU4plHhS5xUJiDLQpAsufvccKDamX7Y/9
	jmNnZALzcfFAGbZ+LRTlgwHpEq3UayVU=
X-Gm-Gg: ATEYQzxOoiy4EAah+rFirrv4ojCmH8LLEQTpwHKJ/GUCCxUcK3HbF6mEVCXNzVunQeL
	PbogK9PbgOfRSaQgI2G69LqpjGlIWvc415JaJDfkq8E/CzrA0ISKHI1jVauvaoJbLtbiiHr4ujS
	DV2mp7WF4bpofR8jeWJUMqdxEc2ltOwc2yY+LAUsZX/Qli9Xt0l/CHDDx73+QEW4XI+ockDojV+
	lkKeLUOmDd1Tbk1W96Iw+9xbr5gGOunFCcp+1YdZVuSd7uoirsCuejFjNMsARvr59OSgjpt5Ufa
	Jd/Z/A==
X-Received: by 2002:a05:690c:c4f9:b0:79a:c960:5d7c with SMTP id
 00721157ae682-79acf3a4b67mr48757137b3.26.1774466475966; Wed, 25 Mar 2026
 12:21:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260319184615.10970-1-matheusgiarola@usp.br> <20260321155530.27751a72@jic23-huawei>
In-Reply-To: <20260321155530.27751a72@jic23-huawei>
From: Matheus Giarola <matheustpgiarola@gmail.com>
Date: Wed, 25 Mar 2026 16:21:04 -0300
X-Gm-Features: AaiRm530zMFBC5hD9qbYJhz6p5o2Aeqk4Fy1RPGmqFJR0Aro5bfFtSuyrEUU2o4
Message-ID: <CABGH8=az2T+GMy55_zX-C-9=rMauaWvqGBF=+VCoRBSCDTmnHQ@mail.gmail.com>
Subject: Re: [PATCH] iio: adc: ad7280a: replace mutex_lock() with guard(mutex)
To: Jonathan Cameron <jic23@kernel.org>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, dlechner@baylibre.com, 
	nuno.sa@analog.com, andy@kernel.org, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, matheusgiarola@usp.br, arthurpilone@usp.br, 
	davidbtadokoro@ime.usp.br
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 21, 2026 at 12:55=E2=80=AFPM Jonathan Cameron <jic23@kernel.org=
> wrote:
>
> On Thu, 19 Mar 2026 15:46:15 -0300
> Matheus Giarola <matheustpgiarola@gmail.com> wrote:
>
> > Use guard(mutex) instead of mutex_lock()/mutex_unlock(),
> > ensuring the mutex is released automatically when leaving
> > the function scope. The change improves error handling and
> > avoids issues such as missing unlocks. It also simplifies the
> > code by removing 'err_unlock' label and several mutex_unlock()
> > calls.
> >
> > Signed-off-by: Matheus Giarola <matheusgiarola@usp.br>
> Hi Matheus.
>
>
> > @@ -885,13 +875,12 @@ static int ad7280_read_raw(struct iio_dev *indio_=
dev,
> >
> >       switch (m) {
> >       case IIO_CHAN_INFO_RAW:
> > -             mutex_lock(&st->lock);
> > +             guard(mutex)(&st->lock);
>
> Scope missing...
>
> Thanks,
>
> Jonathan

Hi Jonathan,

Thank you for the review and pointing out the missing scope, I'll fix
it by using
scoped_guard() to ensure the lock is released at the right time.

I'm a bit busy with university work this week, so at most by next week I'll=
 send
a v2 of this patch.

Best regards,

Matheus
>
> >               if (chan->address =3D=3D AD7280A_ALL_CELLS)
> >                       ret =3D ad7280_read_all_channels(st, st->scan_cnt=
, NULL);
> >               else
> >                       ret =3D ad7280_read_channel(st, chan->address >> =
8,
> >                                                 chan->address & 0xFF);
> > -             mutex_unlock(&st->lock);
> >
> >               if (ret < 0)
> >                       return ret;
>
