Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA84D3346A6
	for <linux-iio@vger.kernel.org>; Tue, 10 Feb 2026 20:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770756876; cv=pass; b=JnVyePHTSqOX7Daz8/0VbW5Ew0Z6Zy2OWjEPfM2oD8mevL4UtscOzJ3GkSDsK5+lmi2/juhS77Y/GCUyuJDZTF/60HnrxN8SjayWawg0Xsu7eneBjK+AOOj7/SZxh6VvJafd6MuxbGqboKiLYuMCJx/F+dlR+YdvMliUdgIVX8Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770756876; c=relaxed/simple;
	bh=q3FqIQvO8cvkl4nCC6YTH6him8mnQtv/Z9tzeCFgRWg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aBYLtGmnWYoPis6HSnH9HPXOii75U4mzfm2b0IDGhlVl4Rf4meBQyXb2nhbFKfr87s4fKI+MHlj7WjW6Is01Bi4lVq9T6gx9Pz5f4i9sd7qO9uUGi4+nvtK1QVKhnnQlbVI8nLLk0WqvHkENOUdwJvgwr1Fa3Z7iDceah6z2XTc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f3+wPWSa; arc=pass smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f3+wPWSa"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b8e9c8ada38so1009926466b.0
        for <linux-iio@vger.kernel.org>; Tue, 10 Feb 2026 12:54:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770756873; cv=none;
        d=google.com; s=arc-20240605;
        b=U9xynLCvG1G+lCuaK9EQL2P2HSSDt9czUCcHxvPcQ1m1jaVbI0XXH/DlMDK822OnDx
         aQI+FdDaq7kHRMHx1YbXxgvixl3o5CYvG7GNkPE+gDiMw17CcXD7g99ekk6MGBlnQPh5
         WRAwr5lS3yGune7o6buNFnIpsiAh9jzC59+elxylkSNYwvG+8jmIph0eZYdCwZnkLfSX
         CuBD+qIDbUw45S/q1aOyIoMy+U+IGdsMNfKwEnAvAclSV0uc5TsolwKFF9QYuHAII1NQ
         s1KS0Y+6oraa3j66UyWeicImkvjl0PWRSQAHiIoqtpDOfirXTB2V/MtUNfgkJW1ub6fd
         LXIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=M0+zRUlOfUnZOOssxXAVkmpFMr6RYTxI9SHoGCQOmoo=;
        fh=BXhG76CNwBSSOesvudT/c1OwQmUbi/ITUxnJJk3c9yU=;
        b=Xw4TnkfZCwkayHq3msRN/sLr7dT69dZsXkAWaY6DcwJ912ikEM6i63eRlYmaaf+h2T
         Jg5+si7KCptC1pt5ku8zIytjGUFBTfHSvaYtUkXqzeTGvdFSmSAu/HdbJfQaIT2V2S7I
         j+7Ap/3/htBD37b2B437YJ0tC/vBD9msZjt4xc/vT7Y2Bd+ajYDsceh+lzCRcBZWrvXS
         fj+1M+fKU4+NJhsThr4ogJSl8SuVJTPl33drW/t2ZFZttk7iP3kkFLkL9BoDoWoo4EKQ
         rtgnjXgos3DrAG2UK9i+2jMfqBzEACB8+a43Jb5WLmBAdp49Bhvpbg1USyVqhjhbiO2u
         6n6g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770756873; x=1771361673; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M0+zRUlOfUnZOOssxXAVkmpFMr6RYTxI9SHoGCQOmoo=;
        b=f3+wPWSayTc2E60IhSxm49E0QL/luMF3k7mjZP5vHil72zAKJ2vHTduHOaf7/+5wM/
         RCJtBd6y9rx/R7yQaDiecPU/emfu0T+RRwEGLYre128N9olNEyVhm3otiGL6MuqCFcbh
         g9kJkPxaKZvDIWA+8WSw06SXUuFdvYZmGmRuvZe7JAc2EpW5gKUB6cyDrbNQ74NVc17l
         62aqyLEeG0+8X+gsWKgcSmuKelUafIqRHWFLI5T97CbS0SzUMvgKZFc3quhlW2lgMUAM
         RvHvkwO0Utimskn0tsIGHyOpr3RuE6/TzTyCsVp28482R0UtRVXPGsM40UafunSNCjnb
         DxYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770756873; x=1771361673;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=M0+zRUlOfUnZOOssxXAVkmpFMr6RYTxI9SHoGCQOmoo=;
        b=ZZvm+QzpMKaXf6RQNi/97AklZ8aUhH2BRsVUNV6I8+ZLQdb0mFjuf+NL3CW9zIHXAn
         YI+H8VQxXCipx4nbibLn61GOeTdorWVaMEDp6E0GhZD+yjvrNaBG3p3QbPTsnyYREjbT
         0o6YnOQNr2Ktv6aU4Xx5TXO1n9mIoOZ7VoIVoqntrY4eFoLfOo3EawXa6xKUhRSi4GkW
         GdFu8hzwyMmiUQA3xQFuElnVFFWhhjUGGLcwk+8htgc9cKATh5Hlgd6oGFPvC6ZlFsy+
         ShaGxptU8riGGtGFnOqJvfsBNY+7hcEgfzo+IzkICEwhQR/FCKAXwv9rfOrZosgRIdM+
         hpYQ==
X-Forwarded-Encrypted: i=1; AJvYcCX74rHRW3nd2daQFrllbIS2Dx0i9haDRqGaeDGuZRARzXMAbfYjE0nj00Ho4SU3Y00c2jpawO/kI5E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0r3Vugq59nZfD0l1dttstZVG5Ht1a8ZxhXje/gONGPFx85hJP
	Yx6jEpyii5ktsg2kBYWfsWggF4ULkXgM6SFEhrvq+LTbA+fbYM6yXJZQtbuSQNFbPe/z/5YsvNm
	qWK+LSeOcnmQjyZfnETC98cH7IDzW3SlAqsgTI+k=
X-Gm-Gg: AZuq6aI9qxPpeAbxM/sj3md6e2YKMDP3P8enQv9D7V9mP2e3+5gRxczqyyttFBZ9+hz
	DukpcctyQLZxQ+Pt+GlfAU0G+iOQoWWrc5riTXP5PfAtGWNDRx85C7nuheWu1YSsrkGj5/Bpurb
	idfOzT+daePGSLMfuheVububHfQ7x3PpwDGVs+2vgj1luMOLt1zVi+5sIDtfpmt+T/vnU1lcfyZ
	kgDIrRVZV3Gy5dPyTlFhjnGhFaxNa264PBBfBLzxEWl4ufJl37oYYSRpMz/plHtD/qxYs33d/tF
	2iEoH+O/ZYcQKeLSC3c6SucyFj20CmXa2dyxHlwPItEkAgF00sRAbFiB40Qyt6MABmjABnAtxCi
	czdE3PR0=
X-Received: by 2002:a17:906:478b:b0:b73:5e4d:fac4 with SMTP id
 a640c23a62f3a-b8edf17c3d0mr872130166b.7.1770756872908; Tue, 10 Feb 2026
 12:54:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260210-cm36686-v1-0-aef68dd46ad4@gmail.com> <20260210-cm36686-v1-2-aef68dd46ad4@gmail.com>
In-Reply-To: <20260210-cm36686-v1-2-aef68dd46ad4@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 10 Feb 2026 22:53:56 +0200
X-Gm-Features: AZwV_QiJ4Iw7UcJSk9ruANiayx_rurPPFTMjvoK7bffS_WbsRrm1pZ3P06rt0sE
Message-ID: <CAHp75Veczn--S=G0iEyUOnVYZ5rT+F_Sw1=6YOo=ynPiKPHF6w@mail.gmail.com>
Subject: Re: [PATCH 2/2] iio: light: vcnl4000: add support for Capella CM36686
 and CM36672P
To: Erikas Bitovtas <xerikasxx@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht, 
	phone-devel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 10, 2026 at 10:46=E2=80=AFPM Erikas Bitovtas <xerikasxx@gmail.c=
om> wrote:
>
> Add support for Capella's CM36686 and CM36672P sensors. Capella
> CM36686 is an ambient light and proximity sensor that is fully
> compatible with VCNL4040 and can be used as is. For CM36672P, which is
> a proximity-only sensor, also remove the IIO_LIGHT channel.

A couple of nit-picks, otherwise LGTM (much better than the first
version!), thanks.

...

>         { "vcnl4020", VCNL4010 },
>         { "vcnl4040", VCNL4040 },
>         { "vcnl4200", VCNL4200 },
> +       { "cm36672p", CM36672P },
> +       { "cm36686", VCNL4040 },

Keep it ordered by device name (string literal).

...

> +static const struct iio_chan_spec cm36672p_channels[] =3D {
> +       {
> +               .type =3D IIO_PROXIMITY,
> +               .info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW) |
> +                       BIT(IIO_CHAN_INFO_INT_TIME) |
> +                       BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO) |
> +                       BIT(IIO_CHAN_INFO_CALIBBIAS),
> +               .info_mask_separate_available =3D BIT(IIO_CHAN_INFO_INT_T=
IME) |
> +                       BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO) |
> +                       BIT(IIO_CHAN_INFO_CALIBBIAS),
> +               .ext_info =3D vcnl4000_ext_info,
> +               .event_spec =3D vcnl4040_event_spec,
> +               .num_event_specs =3D ARRAY_SIZE(vcnl4040_event_spec),

> +       }

Keep trailing comma when it's not a terminator entry.

> +};

--=20
With Best Regards,
Andy Shevchenko
