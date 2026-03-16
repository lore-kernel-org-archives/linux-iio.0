Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6BAA389109
	for <linux-iio@vger.kernel.org>; Mon, 16 Mar 2026 18:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773684697; cv=pass; b=FtWQWvYJ/sSJGbT7iu3tkdB+QLT03cDKTVZx/bg6OJ39IfkasbPbHqL9fDdZ0CXSE2JoJLGvBKTLpYQiy5aAcgPRvfNkNYEzryZUcF1s6404R/suyihRFJOeChXXG/vJEI9jDOdoBFFQzLcJmhaF8XtnulaDl8WRL/V8e4qNbb0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773684697; c=relaxed/simple;
	bh=hphik5M+PJmUSYg+rm0OoKc4euDMNlGeZuZLytTvLfk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xj41jePLmyYadDIT4vkfmANzxSwb08QGJHhBrL/XNgbHMtXmG9b4c3ypb0cv1Jfy/jh4tni5ZRO90pIAjxXiBcv68aBHUJXeSMCgNXyUrGvremV0TJTS9/PDmTDvJENFlGPoItrZWxBoirC3E9xFf10GZWvPUQrYOO8GIMzX00M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R26O9FF3; arc=pass smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R26O9FF3"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-666f646f5cfso835009a12.1
        for <linux-iio@vger.kernel.org>; Mon, 16 Mar 2026 11:11:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773684694; cv=none;
        d=google.com; s=arc-20240605;
        b=XKaQ/VEvpkPOEC8EfWiTvkpxcspHRVVKxXlm/OClaJYdBxgaVQuUsixoJS/DQz26Mx
         lbLjEjUMqbPx8T9WCZcqRfz3QIwRguG7qG0z6CN4ml/dsOOarqs73fgH6SoVVbPA1Y1Z
         S3HuDz/yoTTFAqIvHBWPQp0IDWf5jYGTE7L6udXUIz31K+8GpjBpSy7BBj4FGyApqTE7
         /KfkhxIBAAWNdKRZFRq0E2Q7eGUfGYY8VLoP+er9D9DkZ8fNcRVSgXkoK20z8OMR2nvJ
         8Cp6uqPbCq1SAdj3cop/nyiP/paKwSXqLQTs1jThuTDDzY8EKj/eT2nLfQ9zgbPsvkMV
         2cUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2mQDjvv1kYE0oq3kLc+8QgwfQbMotk4A0gZvEtKOkqw=;
        fh=hg04e15nWpNa7dUDmTSfwmb79SwSYY7c78kPX5wPHVk=;
        b=Qks9u0TsucphwOPL2OOAE8/wqLfaHW8wxL4hTwhnEVH2eMAoZ/VuMTTrRU4UTcxl1Q
         J6kl5s5C9g1RsnRfSmmdaCOPDkGqvsmsYiFzNtAls7pB54izr1MYchwV7lmO0vx1kuwe
         COWitvDtKMlq8aYLj81kTB5AkzK6O9MnYlsFL60QhDfQtGqq7YCnj7E67rguPyM6FzAs
         4bHKSQpJNmnkgF83Pbi1nEsFz6ff4ZgeIvfP40wqDMCMXVAA0DNejZ3zfE7SIut1GNep
         yac/A7VG1URTWTXRZQxC2ZGk0VklKXOBRKzUE7V7qsHyw7Lsm3xI8z27MQ632Lk78bBz
         7+XA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773684694; x=1774289494; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2mQDjvv1kYE0oq3kLc+8QgwfQbMotk4A0gZvEtKOkqw=;
        b=R26O9FF3HqwSqLdYFe8chVSeIZSrmZ58zKixwJKTEOP73eITI7ZWWdhw4gCGU0XjSZ
         nlHTGi551RoiA5PN+1KgmER/QNZXm1diyrH+LLWW03NPPKY6it4A2EbIobALB4BOpHC6
         qARmPGsVG6G9SCgLLh5Bq70kxUVE7SumPITdtrL8lqwdKYPjeRVBjJ2B3wMJiu5N8Pnq
         rYK//CXUjx2SNiDWa9rQarw0BUu4c4qQ6CYILl4K+F26Q1VvcF8Knf2or6dOTfjSBCdk
         IlBIu17QPYLBxURdm8ArGxXkremk9kuT2YXO28La7fhkJNclWBULMbSzfBvA9vvoIHFk
         ankg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773684694; x=1774289494;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2mQDjvv1kYE0oq3kLc+8QgwfQbMotk4A0gZvEtKOkqw=;
        b=cN3itlBNzpYJuLqw/M0jiNoMYVSaQ08SsSTR24FPHFMNWa5LRi4CzwLH0XJA75Mrv6
         Kr+TUbol8mqHW3KR30bSQ+DY2AqXvMFjwcauNnCB+Av95yvj3MW/+wQbmPxQzXa4MXVq
         lLRabmRdv0Xv7SKRaT71xKp1/m/GlJvmF7lc7Z0GlkR60yj+Uu8E4M+qsMfjlC/pR8Mc
         +vgQkD7EMBuZfF8ygqUzkayXMNXehCTnkoqGcNTgdxOjrzKoifPbfKyTEaeXbThf9Jgs
         hpYqrE9AbxsYisvQ1uUiA/t4wRhmpmyCRkcomIp0FMH419lM0qkQ9X4S/yFFxkDLzB6a
         4Z/A==
X-Gm-Message-State: AOJu0Yytt+taeuE+2vAgP2/FQv95QOIDa7wfrxDQTujFPFQRWvotAXvL
	EnE1w+ccHfutuGG1ekYYtkuwa72eKZIrCMR9a3rXZwqBNv/Bf9jKX+X9VCeQoq7qCZ/9/8S6Pcz
	caEyaEeqZ7gyoi9dvSrRDI027lMKmTj8=
X-Gm-Gg: ATEYQzwfWcDy0luReyKj4dCfjRX6FqTxzAwT3+tsQkCDOF4n9+2YkHsRzkRWNv1AW1y
	FmhFwd3GR1iqZ1EqVoBk60drdhegdI966zbLiTybWyGyXA/sqOL4B1ahn52kNHlycwC8dvz5Q+i
	nIjTGBWQl5jvGmpVQDMulT5a/957pisSPqbg1yortXYDQFfw2UFse6gOoA9+c3iiE8EuxJ9eINO
	dCrmbhagX/B8u9bYLvadXeiSqpHrQ9OvROkllKTqN8+hY4MlxLHuOLTHBh1d3qELQCIcIo+3H4B
	oq3pWSPLudVbhdUQczFY9gbE0ntpwHeDxz4RZ8s0ET4PQuzQpes5nMPCYqkF9A3f1wxg2P21Omd
	I5DGUC86okeMGAaVb
X-Received: by 2002:a17:906:4fcd:b0:b97:c068:555e with SMTP id
 a640c23a62f3a-b97d6c11d30mr41007366b.1.1773684693877; Mon, 16 Mar 2026
 11:11:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260315224509.48111-1-rosenp@gmail.com> <abgQr6Ij_1Bpqb_R@ashevche-desk.local>
In-Reply-To: <abgQr6Ij_1Bpqb_R@ashevche-desk.local>
From: Rosen Penev <rosenp@gmail.com>
Date: Mon, 16 Mar 2026 11:11:22 -0700
X-Gm-Features: AaiRm53wZoNtoFaaBrbyHVp7EcazHCKcde8u6npD5HDg1vqyGRcfEod-hykPGRo
Message-ID: <CAKxU2N-FopyQ51FVTWKzs7-u-MuEJVawxHX_t_iYBkpYMV4ezA@mail.gmail.com>
Subject: Re: [PATCH] iio: iio-mux: use flexible array member
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: linux-iio@vger.kernel.org, Peter Rosin <peda@axentia.se>, 
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 16, 2026 at 7:16=E2=80=AFAM Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
>
> On Sun, Mar 15, 2026 at 03:45:09PM -0700, Rosen Penev wrote:
> > Allows using struct_size to simplify allocation slightly.
> >
> > Removes a pointer from the struct.
>
> ...
>
> > -     sizeof_priv =3D sizeof(*mux);
> > -     sizeof_priv +=3D sizeof(*mux->child) * children;
> > +     sizeof_priv =3D struct_size(mux, child, children);
> >       sizeof_priv +=3D sizeof(*mux->chan) * children;
>
> There are two arrays that are allocated at the end of the same object.
> Why is mux better than the chan?
It's how it's already laid out. mux first and then the other data.
>
>
> I rather would see two times array_size() than the above.
OK
>
> >       sizeof_priv +=3D sizeof_ext_info;
>
> --
> With Best Regards,
> Andy Shevchenko
>
>
