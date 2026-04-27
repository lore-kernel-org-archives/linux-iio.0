Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC4DD3ACA6A
	for <linux-iio@vger.kernel.org>; Mon, 27 Apr 2026 22:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777330236; cv=pass; b=EabsZP1dKUXkRjwnCNmtLu0SHzC8gDRV2JJXwWZeNHctEsdD6Y41Rlh0ppe6WCHIc6PyIbv48nazuDUz4Q/bK0i6TirsFJWYkZ2lDxMrvx3dZwdNw9hvpfdfUZgTDsOPU3djOWvtfgWnyADeU5pdYr1OOj9k4KATXlSB4AO23HU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777330236; c=relaxed/simple;
	bh=RXTZV68O3DRCGKhAyGkFPFkd/p8Lig2G8UNsio5gTc4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Tyh72RZAbmu2PdENm/OjvXUf5vi4jeR7qV0/GMh7X1bYGGtIh2UGzQEzObmQcvOmVTQqm15UrmmVBprPhBpS62r+da8GT1TSLiHpKqcsiyCVDHR8UXWPUR6XN9DLde8NSVLle39BUbh6Mim3kqaOzfkc2z7XwvZpOjsgWSK/+sM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H+8lxpje; arc=pass smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H+8lxpje"
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5a3d1561e38so8825933e87.0
        for <linux-iio@vger.kernel.org>; Mon, 27 Apr 2026 15:50:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777330233; cv=none;
        d=google.com; s=arc-20240605;
        b=TTBr9i5UiFsH5ljl7Is4O3U4D3u+DitIDKP/nv+2KHzqkpoe/n/Lvi1olB/nYzpRgO
         d/pe+EHKsktv1Bmfh1pSFK8aJTRY5d/xgQf4tZURYD9uP+dVe6pXTzte7lvIPK917uKH
         HkbvyfH8LRUnNGuaEmdhR9ViTLAzH68cLVAknd63K3E7fLxYct6S+EeDA+nGZkyM8cLN
         jdwgOrde5xzAsOKSoAZ/2P3mKTFTJs5NmT7BzZGboKr5mMI2j/HyMJbQyLVFWcEhD9Ol
         bHH+LDQqkfpQXXDSP9ch5FvHD+Hf/7zK9WJsrfz+zwH3ikZoS2KkwzAxGTvmj+U8UuRD
         EqMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=t9i7kiC0TtYAjKQnNhk3lcaZ89x21BmcthCPfYmj70U=;
        fh=9MflcUqjShRoW4fsM5faAXcpMK5paXWuSxcxP+mmfuU=;
        b=DnDSrT+YpTDNRk9/AiDwcgCGdeyNDGuPMbbteEkHNd7r3ddfaaGtoFfljRcHj1PuQy
         01x9MmaRDWkVxxIpz5yxU8yxqcmlJsGC5JryZmv9c6GJZCgwJm36oarowZsDciOZKpKM
         M29HL7TOb2ycpFaGq59lUPie6n2rFDPEeymaHxd+ba79Or9TP9Lndz69EjDVBpj+b6M+
         1WuvZJNrFgMaNDX9PAS+g6S6WSigJb1/7erBF2/fbh9KNawOWXUc1L6s09bbPuaci1Dj
         MPy64BeBM8mZ3rJI5H+PldBuopePwT/dl2x3vEl1zabexa50Kz+dkR37cIhumLai88QD
         tdiA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777330233; x=1777935033; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t9i7kiC0TtYAjKQnNhk3lcaZ89x21BmcthCPfYmj70U=;
        b=H+8lxpjeUGy0Klt/tvVskRThpFVyQOIKpaHMEcBzC0OQVWbaMYtU0M9wMn7I5ZHhhY
         gYaNdQkkofWgm9dcJMKqRwvqGa9SiQrOmBy6JH7aAF92BOBHcplaObgdv8xb3OWPZLrl
         uwa9CxF8PSGEIip35E07tGmLf4GwFxBtGyc5x1pszSIXvKINyRU1pCe2o7uYKM5so+jd
         OJSWtbFWENph55+jzzn8dG4efEV/OUdSu0bsHd7HsY4WCFEehfC5uNLu+swbaYaqIT02
         pt/hMVcTc2kbOxMF1iaQ0hLONrFEj2u1xubIzqJVuYT+y2bhWjojHurHcWUtVsivWW22
         TQmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777330233; x=1777935033;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=t9i7kiC0TtYAjKQnNhk3lcaZ89x21BmcthCPfYmj70U=;
        b=i0lRWeXzk06Eor8Atx+mpfnUHj9sG2YKOLvz5RdseM+h6NbIdmbYnodVwU6HaBCyu9
         uOO7NYWR141suUD6Gg4JibeibaAHNr6Xi3gflasayo1aUZ/hMzMIrrSsNGySD1dzRMrW
         UPlOrjQfEouHzxobMBxgPyZZ599mjlBJ7ufP3OdMVOXSWSAHlbBvn/Ic5P7MVhUnK+TJ
         WfdoKdeNbtYw80LjhBym8XNewVPCqwDHnliCaIzWX4p8iz8RNywkBWHcQzexeAwA7TBg
         Fd/WcL/icLMvKZcLxgIK05xEE+uSpeW1vJNNMg6HZnWjoHKxH4ARQcGnBxHvxYuYIxcK
         /0Tg==
X-Forwarded-Encrypted: i=1; AFNElJ8XEXKI4B4eyOk+xC/b34wPRh01lgzeLcsgD09fsUa0nTu5ZSOrXS9R2dtu2gMU1S9buFOn5WpiuK4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyZNcP41H0ymAaAhIn+GH9j0xn4kcNkvWwQUvK7IeXMGK3SCWS
	nXYml679ubiPpT92LCTDKo0k+AT68IAHPXeOKMxVbJnFcK41o0ZcrG8pw7oHf9RwbvaeoVCK2Tl
	pjZWanJPLdwGht8nyeO/sTNU4Kq4B9tI=
X-Gm-Gg: AeBDievzk6j9De/XLZgJ9fZF38zJj38ytYZDKeTLg1tOpJW+WCb2TSh9Dw5MQwD2O4C
	plrRmmSf1gudGQRjzWZ+QlnI8DW/tcczc4/g/RoaOCgJULEsmfKjMEdvVaq+H6KF3xH05+2QODq
	ehf9hO+fCRl1MRfflbRrYsWxd+LgocOoUt7eokrZKsYiyB8awyXxPb67WlIQSSo+npZmdu9rme9
	D5Oeul1p7RAXzNYhbBNkuyJJyvJXADSxsFhYNTd0TxJb57aXFc/9Mr5ar2Pz2LNwh0qa1Gcyklj
	ZwV0c4foGYFClbAgbDN3rOvNAQPsl4LnA/fRtjfJwirG8o5zPHO3Q/Fg0Q2h46RandDU8C2ZGJw
	Bs16DPNB5lKViwg==
X-Received: by 2002:a05:6512:3f15:b0:5a2:afbe:4aaf with SMTP id
 2adb3069b0e04-5a746618205mr203474e87.21.1777330232575; Mon, 27 Apr 2026
 15:50:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260427100950.33936-1-piyushpatle228@gmail.com>
 <20260427100950.33936-6-piyushpatle228@gmail.com> <ae9usdn2rhyehzX6@ashevche-desk.local>
In-Reply-To: <ae9usdn2rhyehzX6@ashevche-desk.local>
From: Piyush Patle <piyushpatle228@gmail.com>
Date: Tue, 28 Apr 2026 04:19:55 +0530
X-Gm-Features: AVHnY4IcQUbpuyx0RBKiWGnyz-7MVXUid1BHQkGvh2X5EkzoPMZ9zsqYVT7Yamg
Message-ID: <CAMB+xkY40wKVRsDwsLD21bK-hc1YnmghBDej=twJ7t2vCeiEyg@mail.gmail.com>
Subject: Re: [PATCH v4 5/7] iio: adc: hx711: pass trailing pulse count into hx711_read()
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: ak@it-klinger.de, jic23@kernel.org, dlechner@baylibre.com, 
	nuno.sa@analog.com, andy@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 27, 2026 at 7:42=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
>
> On Mon, Apr 27, 2026 at 03:39:36PM +0530, Piyush Patle wrote:
> > Move the trailing-pulse computation out of hx711_read() and into the
> > callers. hx711_read() now takes an explicit 'trailing_pulses' parameter
> > so the HX710B support patch can pass the per-channel count stored in
> > chan->address without adding a separate code path in hx711_read().
> >
> > Use scoped loop variables (for (int i =3D ...) / for (unsigned int i =
=3D ...))
> > to tighten the scope of the loop counters.
> >
> > No functional change.
>
> ...
>
> > -static int hx711_read(struct hx711_data *hx711_data)
> > +static int hx711_read(struct hx711_data *hx711_data, unsigned int trai=
ling_pulses)
> >  {
> > -     int i, ret;
> > +     int ret;
> >       int value =3D 0;
> >       int val =3D gpiod_get_value(hx711_data->gpiod_dout);
>
> Try to follow the reversed xmas tree order.
Will reorder hx711_read() locals
>
> > -     for (i =3D 0; i < 24; i++) {
> > +     for (int i =3D 0; i < 24; i++) {
>
> Why is 'i' signed?
Will change to `unsigned int i` in the scoped-iterator patch.
>
> > -     for (i =3D 0; i < hx711_get_gain_to_pulse(hx711_data->gain_set); =
i++)
> > +     for (unsigned int i =3D 0; i < trailing_pulses; i++)
> >               hx711_cycle(hx711_data);
>
> With the above the both seems like a candidate to a separate change (afte=
r this
> trailing_pulses patch).
>
> >       return value;
>
> ...
>
> So, split this to two:
> - trailing_pulses (without touching 'i')
> - localising loop iterators
>
Will split in v5.
> --
> With Best Regards,
> Andy Shevchenko
>
>
