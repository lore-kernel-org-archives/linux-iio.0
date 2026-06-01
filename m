Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C66A33DA7EA
	for <linux-iio@vger.kernel.org>; Mon,  1 Jun 2026 15:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780328448; cv=pass; b=SxeAwQBJn0S0RHhS3FC+fna5ExBqKMoQRtoLEI3DCtOEroF7T7gll8STD/DPVyoMnarH+Pz+iY6wG3jbSJetKWlv2TR7EA7w26Kk1B6p6qKLxcoRxrXWofTTDUUptv7Lnz5WFuqvba4v+XbFtRfhV5Rpwqjb65nifzWN6Ys39L8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780328448; c=relaxed/simple;
	bh=a6jPokye9xhIexmS8Tn4JCF6YcGGmi3QWeug6TSTt+c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kmA5ur6jUo/UL1EUaGtVmwpbuzM9s/vb+uf8m+m9MvznmQGwwhksPQZdxcyJ8j3hXkz4INAXjFivCuqwW+P3hxNPDKyWE8OSvph/z6kaE9GhiE0KyZ6WfZMyvr4kgf3q/wuaf3WuTc/QYSx/wT0rrYgbowfvTpLtPbm/wwc1fFg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Os7JzOq6; arc=pass smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Os7JzOq6"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-68bd4aec7b0so552068a12.0
        for <linux-iio@vger.kernel.org>; Mon, 01 Jun 2026 08:40:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780328444; cv=none;
        d=google.com; s=arc-20240605;
        b=h/Lfyhl+SrwJTdJJoZCoy3Z70NUVxdnwUxe8+lmrmUZP1SZFTZ1MYN72EFU2mbll8B
         8JtxlNMFQf3SZIXRkjxR8qQs1aAY3bbwSWKH4DHvTJQ8ZBK8GzoGP5s733AUUEGxZlRq
         9mkWn6GJ7EZYQRtpdudPKZ1A4hat774kqRlz30iKzhdGjFxYSCqNkT9xLgQ+GGGEaqKV
         2/Jz/XLx3/o+cMhmBzxRl/dMQu+LR1DVNI0NHvqoUocPinY1ktyNzQ+xl9TDX/LY72U6
         TTYSHKuD1kojokgPHNWkOwDjCDjsGqCnR73+a+C60tUjviPaCFc76JquPL09J+DGFmSS
         MrTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lNsmtknaI8lnn5B+o4e9UU/fZlCkeKNAZZHydElBsGE=;
        fh=+RsWGf4pazlneK8V3zxTSnRw9EVPt9LG/Bhii58DbN4=;
        b=HbBtBhiPeISgZ4NAPwHuohMWJB2xQ46ZDNjiM3XgSxiyKObVTipEtJSTAD+EfKYgHW
         47g9Mjhi71swnFDImk3MoM3Znt/k7It04c812NZWAEcEv0d8rZlz1FUkkPs+TK3iwz1b
         FfDlSh/T1Eys4tMO3v+NX5yZyx7To/rgpJtpVe/S1V5WyMY4FukbKJL23/epuNey85qj
         r3YdS0WldJuIQ1XhAiBPerQphzpASl6GdupiZc9NT+N3CLtlmvt5R5wJDDr4lqfPSQha
         56xl5knFEh8UNTrWf5sgFtMcWU3NcGnmbrfkDu2JiDQs5DRr91LDeZedqQJ2U5Wo57EZ
         Sb9w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780328444; x=1780933244; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lNsmtknaI8lnn5B+o4e9UU/fZlCkeKNAZZHydElBsGE=;
        b=Os7JzOq6/FmolLKiUoE1paPsT0rKTXP70B/aprnQ/kDFagALZUZ7TfL/MqivTzW2zX
         o/Iv5ruBYMeBLnpRMcwOeCBqLr3gtLbDMJ0tOapfMKZIB6mjMvlOgYVlIDCeRXJMc4FP
         nONdZabWD1odKiVasHKEVmBaMqANI+0auM9BNn2etXZGj5+bzYipikdZUPR349v4fLes
         XwI8wjuztilmRBojRlXkOAVEhZMOu03mdsGnCpkTJalDh3mK7YBkN3ecgNOvaia6KICq
         G168PysekJQguuP8Y7Hzx+wigM+jGHfhC7NVSTyk1t5sOHayEoROwbiawaxwc6bhT5Sk
         3nqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780328444; x=1780933244;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lNsmtknaI8lnn5B+o4e9UU/fZlCkeKNAZZHydElBsGE=;
        b=dOdV7qpy99z19a9v7yevTHuxg3JS3ZPK3jVQa6iDDS+a6nVes53A6exnD3J9vWCnJE
         ca3odemRxClQYaYrNEHM2YiqB2GddLOKJYbmI/9+Bi1vxJOB7FUymd00h9Cy2C5WExxI
         AXIpQwh2UbTqobuMjHjj18+tzQsiaUp4OE1GGRmnq7jwfpYw2FyPkhTazecxO9YKyXd1
         wJka1vWjPFt9zL5MSC9ttoqBr+PbwzC9Oo4txm0RgrfkcCl5bS4LQZoGvfmj3V5xuUg7
         1ko23eR67ieeGr22RE/puMzrJKGfTDl49VlTEa/3vF6UN8FBKsX8HVU/2IY8xdi+X8rK
         WGEQ==
X-Forwarded-Encrypted: i=1; AFNElJ+GP3HHfCBkhOnCW5jYTHvIcYFIRjSvayqfD88MeD8mK7gGtnwRn48EEL23DiSy7nl3osTPO/wGCnA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyE1gM+HiaXj3OD3GL0dhmYXfYOCZoFMjiMAo1IPeTNBUA6w5Y1
	8NL2if+DB2XzlB4plZCSPICBouuu1GazRHzDRwmzp60d7AdSRsReImEKdKgZMgZ7oOdIcbdSOrY
	PjRGyHTQxbFTGaSjFPbN/VlHEarZbEPc=
X-Gm-Gg: Acq92OGgzWGQePo+ZCusjfzLh7Eo4JU4n0zMWi5jyG8mkeBuB6an7uGymjzkg2ET1IP
	g3x6Gwzx8WtvBpLBQRHhBMm8KtUiPAxXFLpKZOvvmguLkLh/k8izt3e251Ke03xrb1dXEyqE2kQ
	scNAbLYDaHo02jaPxMfoCQ9ZEntcQuEa+7fQ2ZK9egJuE5EsBDOCKU1LbAkWkFqS3oYwQ8fZwgo
	mbE6OSxrHItHShGRBKs9eJ2Mf/zMVAkj86kfWJshXbZ0u9FXsAeS05pIEtjiWyniHts6OPB4iHN
	0bSpeI5TxUYENs4UcA==
X-Received: by 2002:aa7:c61a:0:b0:66e:4395:e920 with SMTP id
 4fb4d7f45d1cf-68c8cd241d0mr1749690a12.7.1780328443771; Mon, 01 Jun 2026
 08:40:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260530173514.56640-1-tahanarimani3443@gmail.com> <ah1u6r2NemqKd2k7@stanley.mountain>
In-Reply-To: <ah1u6r2NemqKd2k7@stanley.mountain>
From: Taha Narimani <tahanarimani3443@gmail.com>
Date: Mon, 1 Jun 2026 19:10:31 +0330
X-Gm-Features: AVHnY4KolE2yhOx0-Ro3MWDZW28K-XYZipNKjcVxcCIa0M-ullZRHUCewl_IrV8
Message-ID: <CAEsNvj8KrXjNez8s-2hBarMJOen-veS0S3w8of3iPOrT5hoUkw@mail.gmail.com>
Subject: Re: [PATCH] staging: iio: adc: ad7816: drop busy pin requirement for ad7816
To: Dan Carpenter <error27@gmail.com>
Cc: Nishad Kamdar <nishadkamdar@gmail.com>, Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"open list:STAGING - INDUSTRIAL IO" <linux-iio@vger.kernel.org>, 
	"open list:STAGING SUBSYSTEM" <linux-staging@lists.linux.dev>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Dan,

Thank you very much for the review and the excellent suggestion.

Using devm_gpiod_get_optional() and checking for NULL is indeed a much
cleaner and more elegant approach than hardcoding the chip IDs. I
completely agree and will implement this logic in v2.

I also apologize for the corrupted patch format. I will ensure my git
send-email configuration is properly fixed for the next submission.

I will wait a few days to allow time for any further comments from
Nishad or others before sending out the updated v2 patch.

Thank you again for your time and guidance!

Best regards,
Taha Narimani

On Mon, Jun 1, 2026 at 3:07=E2=80=AFPM Dan Carpenter <error27@gmail.com> wr=
ote:
>
> On Sat, May 30, 2026 at 05:35:12PM +0000, Taha Narimani wrote:
> > According to the AD7816/7/8 datasheet, the AD7816 is an 8-pin device
> > and does not possess a BUSY pin. The BUSY pin is exclusive to the
> > 16-pin AD7817.
> >
> > The driver previously requested a 'busy' GPIO unconditionally for both
> > the AD7816 and AD7817. If a device tree correctly modeled the hardware
> > by omitting the busy-gpios property for the AD7816, devm_gpiod_get()
> > would return -ENOENT and cause the probe to fail.
> >
> > Fix this by restricting the busy GPIO request strictly to the AD7817.
> >
> > Signed-off-by: Taha Narimani <tahanarimani3443@gmail.com>
>
> The patch is corrupted.
>
> Otherwise this seems reasonable enough.  (I haven't read the datasheet
> but I trust that you have).  Let's add Nishad to the CC list since he
> is the one who first limitted it to not check ID_AD7818.
>
> The other way to solve this would be to use devm_gpiod_get_optional()
> in the probe() function and test for NULL in ad7816_spi_read().  I
> think this would be a cleaner solution because then it works based
> on the device trees instead of having to hardcode which devices
> have it in the driver itself.
>
> regards,
> dan carpenter
>
