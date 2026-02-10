Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4330E389471
	for <linux-iio@vger.kernel.org>; Tue, 10 Feb 2026 16:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770740968; cv=pass; b=nFMYH12ClMZSEwHYWk5WYwXUxxmNxKsKE6/AIxgHQYxltgDMAyQie91BjB/sG2CaahufFS7NPO2x6AE7NwVKfhxy3KKQoEu0K+PzART6eV71TjhYFPXelD9xRhp8nseD7NWw4sEFLwwJl8UXLV9M6C6hEfNqzMRdJir67KAavD4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770740968; c=relaxed/simple;
	bh=J+VWldTcfADnTCCUyOQu7hy6eXpc6fT/7vFN7R/c++4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=raGgbcUwWN8Kun7wbrC8Eiu3FhOVtL5fV5G4U/1nPo8aBJkvTwbIQn+Z/rxCaoV7tFgflbAUf5fHd5QyNUWJlTkM8nu4i4uhEEwipGILxoyrSvl3uFXTJJ0IUdAaNMposFrpKWbgczXU5WkFEQGjiD4HF5i9ygjDqwJVqeK1Lzo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=huf9W+Rl; arc=pass smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="huf9W+Rl"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-8946421dd8fso10875786d6.0
        for <linux-iio@vger.kernel.org>; Tue, 10 Feb 2026 08:29:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770740966; cv=none;
        d=google.com; s=arc-20240605;
        b=Gel0HWmWpgMz1XoUnRqVanCqVFf/vee/JVZXSibQEcU0VoeiNvvE2Z/o7h8074Y4Zf
         ndwGiIjvwwSLXTpdIoyjc7Q+havLvwWYC5iJEYloBjS+fu5x3Vbn1/F0hKR4Z60mKCHV
         nGIon9mdoYZmuHcfkVCLgjnSr9jSO4pJCvo57vBhaLovnfSj6b4AC6JOub7xiKN2CGfV
         ZuoCHwUOCJ1BHl3uyO/Hp8+SV8mX/qiyjD8dihPHS5Z7Ymn8ojrD+/RfkEbgju1+sAk7
         QiPRlJ7dCH4PKI3zlGcj2dHavd09rFNrGdJvXSfuJn/41/WnS2feKpZar71NvN9hBSEM
         yKiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8NxRSBhGtuOsPJckNjVFGcti/Wl/9Q1xvm8JfNXImag=;
        fh=/iVVM+ioKFxSAmsweuYKF4sGWS8ojRWEA5I0CprrBWQ=;
        b=EDJT/lXdV+Ye7zYN7B5ZAmO95/YIq3BD4pLbYfhxgw3ci/67XAG1Q2ODF8nBxOvRPh
         0RWdRZVu/zGd9gLoCS8TxPS7FPY87gc0RrRfqa3meYNIS+GEZzOxCtO2ViKuUyldhoBt
         8FOnEcUMrd7WfR0mXSmHFJcfoayJsfEqPeA3sKFb214Ktc0RZ/WLl/T2mSeOIzR04QsT
         gJPaa2vbNogBQKml8Nuaetq3b9dhUFLXS/aIXn1oMiT+J4Ri6gxIOjqIoC6q3jhdKjnp
         Wb3EsgXZzI21jhV/6M4fj0hq2+xKnOjIEjVu94oeZRJQTZLFEyp9Ga0kkqG+LxcxCIYh
         xjTA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770740966; x=1771345766; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8NxRSBhGtuOsPJckNjVFGcti/Wl/9Q1xvm8JfNXImag=;
        b=huf9W+RlyF6a/8NrxDSmAkKC83Y3Ax8Hd1JQuVbI+ylAKeKjejwLE28xcOOO6JWLjd
         YldsRWDIqf8jYvl5DT2lr+JFpXUuBvRUv24LNWBqRcm9C7fGjCdlXr67wC5Cz8s19V/z
         0ol00eMr0YH0+qB+7Q0ZRyaZ9DCSz+pYvNgfb67SXClF39tEdtwlluroaWmYECWi3Eyi
         I/vS2PPQOHlBEGEQ5SRd2lIVb6EHOP9MbMohzPFE+krqtgx3LNSXUfCtQ1Rer+LKSw2x
         NukUY7ggDKrw3U/pOJyiUm+gc5fZO6nB0Ignywhd+2mzCkYiqBPK7+wGuVHScdtR6HfY
         Rbxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770740966; x=1771345766;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8NxRSBhGtuOsPJckNjVFGcti/Wl/9Q1xvm8JfNXImag=;
        b=S7FkfTiKQdH+GRtvbeLK3qSglh/nlLdZips5ZQFixrnZiVIKlHCw93ckPrKLjPI2LB
         PnyKaDmXn8gkI5b49FdzItbWrwtAF8iErZV5GoAA2epAflvGOgNBUzAYNcXl7lPgFgE8
         XxPan2U+0Css8ErNKJwUR7IYaQ2miYjAdviPa4MeWMTFFUHG+A7yW5qTjtge0z8+/7U5
         Xo1U6ABZhLmVS5v3N8U6T9x8K5aejiz0qFsCq3EhtPYAvr2NrAe5Ie3tvukSn90f98UJ
         NBRndWmrGA6govR8B2N8gSPBS1/11kEbcTYlN0/35TVYoCBh01rzkCrR+By3o+OjycjC
         R00Q==
X-Forwarded-Encrypted: i=1; AJvYcCVu5Ugvz6Rzo1rLT6GuMM3dxH66fpbOPrYTfY9FcP6rZZ0VUFm55xTpncwi6/4gO6s8LjwSQ98/85g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTcB+8fCi8v4J/66cnCFEYy56LdBYzqxwNJrVU49BrEAVMo6ay
	/m9VQq5xOmMLghI8VMUwdH2wEvFhICeNmG89Y/WTKkusiCZUdJVG1tkfVBvcaOwWYVXwa5Q5GE7
	fLelXWfXADxLySAhoOn1sWnaiLsd5Tus=
X-Gm-Gg: AZuq6aIbxCfgqeTP4ws5NBY/phx7H190MPfV2brf5+P4NXbz1jQOnUIrVnc+oozdxwr
	4OZx3R1NnXwp8XygCh3/GjlQVR3WWUAN6sQDfVoUItpQdP7JexVZ6gwRGMmaKyJ8bQLcofngxCQ
	NLNeI+J3PnNGDPkpuKtjhbj0aupkPvd5jiB7kHu+/zuzWoC9uRlo6kMr1ipS2xxCjwK/pyMT/tG
	yHHz0fL3yqncae2GGqqQQdqYk4wms+FpHYNKrIY+UjVZD78IYPxWCaMVkuWp3nhOos3LgxBFvrc
	iaIu7JgMxWo87loa80Lh8ky2toVZrXwy7Yxc/XnO9/C9JWU9heKBzvPmGbGzpUfmgRl8PAWQ
X-Received: by 2002:a05:6214:808e:b0:896:f317:17dd with SMTP id
 6a1803df08f44-8970fbd8d08mr22667816d6.0.1770740966165; Tue, 10 Feb 2026
 08:29:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260209-upstream-20260219-v1-0-2b4d74e309d1@gmail.com>
 <20260209-upstream-20260219-v1-2-2b4d74e309d1@gmail.com> <aYme6jXNyPM_AHo-@smile.fi.intel.com>
In-Reply-To: <aYme6jXNyPM_AHo-@smile.fi.intel.com>
From: Yasin Lee <yasin.lee.x@gmail.com>
Date: Wed, 11 Feb 2026 00:29:15 +0800
X-Gm-Features: AZwV_QhOyNJgQd7vK0x9FealX_MphwskI8gr5HBDi_wedHBJB44eLUiKvIXsZck
Message-ID: <CA+NOmz+KKhSAX8cEUhcS=GPCTtagyFZS4Pszj895bf-07ii7bw@mail.gmail.com>
Subject: Re: [PATCH 2/5] iio: proximity: hx9023s: Protect against division by
 zero in set_samp_freq
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, yasin.lee.x@outlook.com, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 9, 2026 at 4:46=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
>
> On Mon, Feb 09, 2026 at 11:37:03AM +0800, Yasin Lee wrote:
> > Avoid division by zero when sampling frequency is unspecified by
> > falling back to a default 100ms sampling period.
>
> Fixes tag?
>
 This is a proactive fix for an original implementation issue I found
as maintainer.

> ...
>
> > +     if (!val && !val2)
>
> What's wrong with the positive conditional?
>
Agreed. Positive conditional will be present in v2.

>         if (val || val2)
>                 ...
>         else
>                 ...
>
> > +             /* Fallback to a safe default sampling period */
> > +             period_ms =3D 100;
> > +     else
> > +             period_ms =3D div_u64(NANO, (val * MEGA + val2));
>
> --
> With Best Regards,
> Andy Shevchenko
>
>
