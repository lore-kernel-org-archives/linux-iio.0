Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E03452EDD58
	for <linux-iio@vger.kernel.org>; Tue, 10 Feb 2026 15:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770736770; cv=pass; b=gDPkImS/ee3Mn+2aFe0eg4mtoQcciQR7uNM/MFyfPd6N0JGUbcArfoomyx18Mb5Ba3nXERuBrqnO6zR+o2qRQOFg+cg2w11NX6qkJjchezRGzExU6aFEep12Su89ZnNbYtxym8B8xuDC+kKKrp5UeAiNYAYe4iuU1xpxD7kRRvQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770736770; c=relaxed/simple;
	bh=KFwy+XHZ/qPXtJJVIJ01/iLROV8v9nLijRRiE15GBaM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PgmQbjH/ndLNyta9/TjQYwER78a4T5sOk+PgiYBxZmqv0+CIW/6tIj64F3jYy4mFhMQdaxqePw1yW78N5llG8U8g+LzxY9UbyZPpaVJYTFbas6QQBGC6J+y4vO5mfqZKJIe3MlG2g0KUKM60Wpw7mDzNbOYK8CwyTILjzPDhX+0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H4vpFBgk; arc=pass smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H4vpFBgk"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-8cb0bce7770so25480985a.1
        for <linux-iio@vger.kernel.org>; Tue, 10 Feb 2026 07:19:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770736767; cv=none;
        d=google.com; s=arc-20240605;
        b=W5aPktz/Y04SAwr2uc3Rf/CmxgFUAmCzO+I86RFEUBbziGZLeAK3/bUwdEBZ0tX5ri
         i1d7+iQ8LyO3Qr6HahIq3IYCaYTsPNlhdhSBb+XTHGUiKyO1nAwPg+oxwnIu2z+uypd8
         hmmDsmSA1rQSTJTQJ5RYoPr1vONkCaT/uP3Nr9uInuxnlZEPlEvkDPfqIT6A3oSLAdV/
         7bjuQ50Aw7ZET9o01gzxXPf0FyfAVmgghdtvTy/Is/jhyro0DqcsV94MzmTaYj5oaQtn
         pwGyz0yiIhRszez7z8pXsE+jGHco308oX22s+ly4jmXVZDmnfPKHBDZ9yr5TgU1cwcny
         96eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hU5GmP8IVcM4rMy0RzpLrIA+b1h4F9ciBJu+AummglU=;
        fh=vnbVeGKf3s5ZyyXztoLi/ojyNp5cyXs0paixWV0WOjc=;
        b=hb8C0eKxec15qkNTkjmej8ZvLwQXIIbk1jx/rAhPiSBtxwOu5lTrkrinCqECLXrwQE
         AitRv4Nd3OpVVumVm3XyIfP0NYztK/YIlTvS0jaScVxASIpSYzDWimy0IBzDLw4TSHlm
         szjm4zWBTp3kEVvMlEZwa8fX4tPiC5eGGoS+4+ey2Cyqmh+uWW72VRYHPVSE+/qyMHpP
         vJPidf4JA6SAW0Uz+U22kRXVWHrADJVqx9n0cw8EBskRR9mWn94bt4BkJLYq/J8EhYIC
         beTv3M65qETG8xICkNS07sNu9W2cze2jB7+XYDezm5SzUftalX28/NCTqkMWxjY22+1b
         2KcQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770736767; x=1771341567; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hU5GmP8IVcM4rMy0RzpLrIA+b1h4F9ciBJu+AummglU=;
        b=H4vpFBgkCgjshVx9qxuV4K0ClNoL8nBRvsB93+r4Ob9wOJ1NLDNgnBAXJDrG5+biU6
         O36hiNp4fJuXRwbwqMViZG+mJY/9FU0Vy1MVGS6r88v/cryuXjB0MZxxRGP1fO53GNZF
         iB+Wx4eBo3zCH/xvUbvniNXyBYV8fEWzBCB6K/LPQRbuYS3gFzwd+foThf20gdE82YAs
         a1D8iJrwXnnCKWDDNsXg3a+ar1WvHITDPBrqeLlF+i0NOTwW6MKDueWfHqvGS816TpS9
         p/x5u9kkbBV/84z4pp7MOp+VZ7L90aeTcr8ZokBWckaHW33BCROBpLIIMJz3cVe/lMk2
         meIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770736767; x=1771341567;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hU5GmP8IVcM4rMy0RzpLrIA+b1h4F9ciBJu+AummglU=;
        b=hakTEzAv50PiggC7wce8aCeb0PnZfqm3ssui0uS8cxVNRqbu/oykIaOibASBPm0ghd
         E5h8njHQhbFncRLBMndt3UYjNGSkfk8SLsRCpKQM2qKjFzzjQp3ZBSOn6A8No6gLfoB6
         k8/KvbpomgaaBeEnmMFUKExUmfOphnrHk19r+70R9OSXEaw1us+M4N3MAHnnZ6qrDA5d
         z8U3A+0zQh0jF2tZzNRrWQFYCsUrp0vZwAVs/0Pq0PyN9qNkRu3GPgJIVXJTkBsL1tbJ
         8kUclL7ZZQa1jBU7GC6teYZvdwe2RAIywZOLpyqmyRS5YZRS9vmYXddoV6JRc0hBCQfT
         p7xg==
X-Forwarded-Encrypted: i=1; AJvYcCWNDOvlaCfVZAY/Umu7j8lGwC2ZgLHN0RbXnnae4NgzSDAGlHTr+hL9RpCJGErkOYGFsWgHJXVsUBU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3CV6oseyHIUsE4PZUPWcS0KUTa1edacW6ecu3EkPRVXTyrCrT
	UR2EYiaKSWf+JGH0beDEAmFQdm5innvwklYAyuN+io8iV2iouUNTjn4lqvBcIVxQRNBnsd2EmoQ
	tmw1Iqoa/ohMm/ZFXmLc7UBpS46rzzZ0=
X-Gm-Gg: AZuq6aJknbHgEmZHcWgTPx2rWGMN3Mk7dHMDi4OfQlUzRAg1JC04L655jdmFdeXR752
	0/hp6ggmzSkyDnW9lgdGFl76GaR69yOysTxzv1rS1/rm/W9oK2CVGPCiktGZR/PTIuPfhsf4o9+
	4xDoOkfuHiqCreG40axUKwpm+TaQmcMC1UBXCIxQL4ozEI8LE45JiTaWfAX2OTPZdrQ8OUaF3gf
	u0qV5thVMNyeFpoCaAWC0HDk/G/FrSEEWwFxMYtKgXFE6cboY8WM5CemEi07X0c32j6Wcziv+Ee
	yPisggHD+YQrqIz7d5CFUZIjoHTNH46Difnf+9D/R6v2K5X+0bD2+BqmwZrcPzqycBjukjWs
X-Received: by 2002:a05:620a:2584:b0:7e6:9e2b:6140 with SMTP id
 af79cd13be357-8cb1ff6fb59mr213066885a.8.1770736766777; Tue, 10 Feb 2026
 07:19:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260209-upstream-20260219-v1-0-2b4d74e309d1@gmail.com>
 <20260209-upstream-20260219-v1-3-2b4d74e309d1@gmail.com> <20260209-masterful-fluffy-pegasus-bcc0de@quoll>
In-Reply-To: <20260209-masterful-fluffy-pegasus-bcc0de@quoll>
From: Yasin Lee <yasin.lee.x@gmail.com>
Date: Tue, 10 Feb 2026 23:19:15 +0800
X-Gm-Features: AZwV_QiEqpPddOaPW--sP2JoPVxG7qV0-Jt2wC_EEXrk88javWqQ4GwU6BS7Wns
Message-ID: <CA+NOmzJou6bvoBnY6WvwpZw+aob2qokzXwmOT23t15CGo4xEeQ@mail.gmail.com>
Subject: Re: [PATCH 3/5] iio: proximity: hx9023s: support firmware-name property
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, yasin.lee.x@outlook.com, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 9, 2026 at 4:02=E2=80=AFPM Krzysztof Kozlowski <krzk@kernel.org=
> wrote:
>
> On Mon, Feb 09, 2026 at 11:37:04AM +0800, Yasin Lee wrote:
> > Add an optional firmware-name property to specify the firmware file.
> > If not provided, the driver falls back to the default firmware name.
> >
> > Signed-off-by: Yasin Lee <yasin.lee.x@gmail.com>
> > ---
> >  drivers/iio/proximity/hx9023s.c | 7 ++++++-
> >  1 file changed, 6 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/iio/proximity/hx9023s.c b/drivers/iio/proximity/hx=
9023s.c
> > index eb4902d18d74..b680b89956bd 100644
> > --- a/drivers/iio/proximity/hx9023s.c
> > +++ b/drivers/iio/proximity/hx9023s.c
> > @@ -1089,6 +1089,7 @@ static int hx9023s_probe(struct i2c_client *clien=
t)
> >       struct device *dev =3D &client->dev;
> >       struct iio_dev *indio_dev;
> >       struct hx9023s_data *data;
> > +     const char *fw_name =3D "hx9023s.bin";
> >       int ret;
> >
> >       indio_dev =3D devm_iio_device_alloc(dev, sizeof(*data));
> > @@ -1111,6 +1112,10 @@ static int hx9023s_probe(struct i2c_client *clie=
nt)
> >       if (ret)
> >               return dev_err_probe(dev, ret, "regulator get failed\n");
> >
> > +     ret =3D device_property_read_string(dev, "firmware-name", &fw_nam=
e);
>
> Incorrect order of patches, see submitting patches in DT dir about the
> order - documentation always comes first. This is here an undocumented AB=
I.
>
> Best regards,
> Krzysztof
>
Hi Krzysztof,
You're absolutely right, my apologies. I'll resend the series with the
correct order.

Best regards,
Yasin
