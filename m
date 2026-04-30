Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0493B377560
	for <linux-iio@vger.kernel.org>; Thu, 30 Apr 2026 06:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777531303; cv=pass; b=TuF0xJpCU4s2EjY27HUkYhlitrHEQogPXWayXw4tOVtgXwf9RUanTArt5eK+Pqj904SxjwIrgGKSiBFrNecPwXIHvwmZyvEdG58QaTvwLgvn4GlcMTlaGO6oWsPe6/zxFlWJ5x3R3YlNQDe/NJlQ5cTIODWGx26VnAXLYbZkkU4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777531303; c=relaxed/simple;
	bh=tgYoUPiudW+8N/1pKEVuRNZBE1mclTeN4g54QU4TDOY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=otexKUg9uxxgG4FRjXLEwn5hgAe/q9igLAtI+yjl262+a+amnu+Y8cpjPMkZbDMMdnV38nC0vStbmhiFiF5utf9xXPEiSPzvdoyMltXZao56YrRS9cHxUDFwacoMV1bLGwmMB9qL1Y/YO2R3ORN4UkX0Zdc35eXwO2I4xwxusSY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mb5DCVdF; arc=pass smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mb5DCVdF"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-79a2ee65171so5451767b3.2
        for <linux-iio@vger.kernel.org>; Wed, 29 Apr 2026 23:41:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777531300; cv=none;
        d=google.com; s=arc-20240605;
        b=ifxolt+fO4vbH3NyEaMjfHEgyhoo8ObaO6Wjmee/e1HadrLpVGDBTq5j5PXJkp/QD4
         4J0j7U5pjuJx2uDP5nxwStRuqohqU7r+ru6mrZfTWVzHr842lknaYQM4aF4WdgBm5zay
         Ltk4tIMn1krcZT0ifCmCGMzz6WdKkDENs9we8nYSsvVqV7DPySxw8niNl4mXwPULe8vk
         RLmI/l2zHW41QUkuXxeJk3uMeySHk6xrzZQKSLWCYOxr8R5qIPN418AJUI2BW3wRJ/Zs
         zzEng/bzHgzr0ujd/Sp+6xLZ/wNM1+6/hZC9l+xJhlTm3qZPk1pn27X1K2f83zhOuOqv
         o7Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/gIoVB6BkR1a83Q2A0L0AyH8GUSyuYWT8ieGS1Yw0xo=;
        fh=cPwHnsd3d7BbdAGYI1LhyuudwZQldpW1kG5cYljvBIQ=;
        b=A9+rbxbbVOq7yLNRDNUnAECgv+qSB0TxgM7KHFpzoUJ1YF3Wd2yjP8PnpJNz8htKN/
         LbUcVVtrVZ0tEeGF7bbdW0k6xzsF3UvJ0EyXQgWTdIdOkJEvANar0Qspp43scGndfk7p
         UmhOB2/WfXTe2wTmAzfM+DElgvmyqCMD3FioNrtPxEVU7xIP4iRT+MhS4uEhO991GQKA
         +V3cUR1rMrDWq2cUD4mAWeRHhL7kaq2HsGaFAqbWTU6JTuojjpn+e6qRLnoPfcb8JD8L
         5ihIcPNPHu7Wt143TxM4kqw9dDSTVnnPEeT/woFWtsGjhDdFyccNpX1oFIIrqIouPd2Q
         Fndw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777531300; x=1778136100; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/gIoVB6BkR1a83Q2A0L0AyH8GUSyuYWT8ieGS1Yw0xo=;
        b=Mb5DCVdFV+L/f/mLKa+xNBywZCj9qqR2IljiJ9+0IyFyJ48y16gvFHgK8ach//WaY+
         GjCYDtMa2dCdQDP1/sXDANxQFnQSwJ3BttRoDToIRPUJKBmAVr9yr/mqgY1WdKO2jlDj
         ae9ZWllv79uwlQ2CWEhVtSL8wCoX/n25Jo+ZgV7sphCk33500KLn5alccZiN2d8tzYVG
         zAytfy1yzdpPssPdZHzhdTyjw62fZaxtv+VWG5KpNca3GQUdP2W8pOfHcUdb6lsoe9RF
         4o1Sfrq1f4H9iWM1FV3bXOzdd5QCR3IiKLc4hIjEg4GjBbL6CqP9IyFCAEVsT+zct6Cg
         YR6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777531300; x=1778136100;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/gIoVB6BkR1a83Q2A0L0AyH8GUSyuYWT8ieGS1Yw0xo=;
        b=IWM5i9J5nDgs7DIQ2frhujVsASr9Ekvo2QLtKgZjBWaRNPvRytDN2RElKPFNc21X0s
         tUGQAYIOGx3PvJIQEoP5N7s7EyjTAoKZeKA7oHtiJAHjGEt8BR1pyDKcdh0OXm+3q2f1
         ou6Dppr/urjiZqYf1Id8btoeDZihymyJ88JZ7voiZWq7fVZ0qGPoBQJAZ/gPsy1Ubi39
         VVpRDIhdkY5Qg9FLTE6ZKi3Ogsqf6nPfNw3wqluMLMqkQNnzQ8VHyvbYN1vr+zExwsPH
         Fvc5Vcp0N0slpMmE8xi38yOFdV54yTI8sXqLzo/40va3m2L6MaCel/+x6/ehhx5+OjF8
         zvFQ==
X-Forwarded-Encrypted: i=1; AFNElJ+jACwhSbRg08cIEPsPEgnZ+UTQmyfvzZY+JN8hs43W9wUk5o6JctjvClG5IlgXwDVG6b7gMP6bbvU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwqfaxwO58wje3zieVwGc3yX4u7uG1KqnHsW0V68jM4KVMOydu
	fI6XVHaKZCPufFKoNYO6bCh3AtRQyZx/1n1KUdB5IxL4bZgnLRlE46W+eYOMwkn/fVHQRnxhvVs
	6ZXfyc6P3qPF39CNcmPlwtFZPeeiG6vg=
X-Gm-Gg: AeBDieuqYp+aL72UM+8s3pdke1rbMZDto8tu0rxDMER49M7yft+Vv1QeBnEkMOFXUNy
	qf+UNg0mGnBeKeZqDEDxxc+6/WG47BdsRVgbxfKF4I8QINr0dSn8Dfu9aCkIJF0Jl9zPJyN5r9e
	KNpVyNPC3D9AlPPO5tjIcarLOZzwbVUlr6Ue0UAaApzfSbOjq73N6GzMh+Erzzkj0PnSI2Iqw/1
	0Jljtx3xxwn6d3TKl75tkE0Edeab7IWzuFuskNrQdfeAyBGb7oqVSuwFg7k01hhpb8McSlEpGNo
	OSksPYzrdeqJmVE=
X-Received: by 2002:a05:690c:8:b0:7bd:498d:7c91 with SMTP id
 00721157ae682-7bd52a81262mr15121557b3.40.1777531299852; Wed, 29 Apr 2026
 23:41:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260430021439.67591-1-m32285159@gmail.com> <afL3K_xeOrjIIQ_X@ashevche-desk.local>
In-Reply-To: <afL3K_xeOrjIIQ_X@ashevche-desk.local>
From: Maxwell Doose <m32285159@gmail.com>
Date: Thu, 30 Apr 2026 01:41:29 -0500
X-Gm-Features: AVHnY4K56mlz0FJt3zbULXcNWyVHFRtZJJFklTedOO4PmriCzlpQ64VXMxOtZX8
Message-ID: <CAKqfh0H1tq1eC5h54G1Vft26Qkaa4nYEdhwQAk=1R6CNXgnveQ@mail.gmail.com>
Subject: Re: [PATCH v4] iio: magnetometer: rm3100: Modernize locking and
 refactor control flow
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: songqiang1304521@gmail.com, jic23@kernel.org, 
	David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, 
	"open list:PNI RM3100 IIO DRIVER" <linux-iio@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 30, 2026 at 1:31=E2=80=AFAM Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
>
> Almost there, a couple of minor issues and feel free to add
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
>

Alright sounds good, I'll make sure to add the recommended changes
below, but right now it's incredibly late over here, so I'll get back
with that patch later.

> (Side note:
>  compare this change to ACPI PMIC one, you see what I have told about
>  in that thread.)

I probably should stop wasting my time over there, I'm tripping over
my own commit details there and that driver seems to be at the point
of diminishing returns.

>
> ...
>
> > +/**
> > + * rm3100_guarded_regmap_bulk_read() - Wrapper around regmap_bulk_read=
() with a mutex
>
> Always validate kernel-doc
>
>         scripts/kernel-doc -v -none -Wall -- $FILE

Thanks for informing me about that, I didn't realize there was a
script for that.

>
>
> You forgot to update function name here.

Whoops, nice catch.

Anyways, I think I need to sincerely thank you for your help on this,
it's been great.

Best Regards,
Maxwell Doose




>
> > + * @data: Data structure containing regmap and mutex
> > + * @reg: First register to be read from, passed to regmap_bulk_read()
> > + * @val: Pointer to store read value, in native register size for devi=
ce,
> > + * passed to regmap_bulk_read()
> > + * @val_count: Number of registers to read, passed to regmap_bulk_read=
()
> > + *
> > + * Intended for use only in rm3100_trigger_handler().
> > + *
> > + * Return:
> > + * A value of zero on success, a negative errno in error cases.
> > + */
>
> ...
>
> >               for_each_set_bit(bit, &scan_mask, mask_len) {
> > -                     ret =3D regmap_bulk_read(regmap, RM3100_REG_MX2 +=
 3 * bit,
> > -                                            data->buffer, 3);
> > -                     if (ret < 0) {
> > -                             mutex_unlock(&data->lock);
> > +                     ret =3D rm3100_regmap_bulk_read_locked(data, RM31=
00_REG_MX2 + 3 * bit,
> > +                                                          data->buffer=
, 3);
>
>                         ret =3D rm3100_regmap_bulk_read_locked(data,
>                                                              RM3100_REG_M=
X2 + 3 * bit,
>                                                              data->buffer=
, 3);
>
> > +                     if (ret < 0)
> >                               goto done;
> > -                     }
> >               }
>
> --
> With Best Regards,
> Andy Shevchenko
>
>
