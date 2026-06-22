Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FCAF390C85
	for <linux-iio@vger.kernel.org>; Mon, 22 Jun 2026 15:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782143661; cv=pass; b=o8p6tUcEO/1MX3oTB+tXgUfNmhnPNTEw6wxjbKo+x7xLDcdl3My2tKqHAxO1QNBre88vJKEFPvOHFe766SsrvC0nus/TcofytBzEjGPm7sOMc4FJh2KnWqvEQ+CX4msP6tfAZgIbcjl0SppSVQGG7gH2XC19etYC+WKSBxc6JUE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782143661; c=relaxed/simple;
	bh=fFT6rh8/MPrWk3ezl0FulU+V8/4A5ig321fIpbZxvuI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EjIFu9EJuBGIG0AVT6eTyAW8uOM+NUJA5goadxB0cgqCpZg8VPMxh7bbXEL3ap02b63n4iI/yvsgEar4dnTSW9i9KWde2lE/L87agYm4t1TrDyXNIbxeplTVElsqz6d7SX7nEDBiOODO3M5zgVH28OusTJIwXh6W1rLyfN5oHZY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kD4op9Hd; arc=pass smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kD4op9Hd"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-7dfceeaf168so55215407b3.0
        for <linux-iio@vger.kernel.org>; Mon, 22 Jun 2026 08:54:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782143659; cv=none;
        d=google.com; s=arc-20240605;
        b=gy9hhovcwcwToVyHjxhon8o3qUhzUVeDqh8Gng1bPKmRTd0XbZBF/f6TO8VwCnuLrs
         EMyBXdtAs6nFVnEO+bg1xSZKSQtoY7CgDSZPmvBgtIsk5ayXsZJHTF7jW6Trpsf4IQGd
         vUYWKh9jISKI8NIlptgS/hDzlxjGwv3kMd+qkJi+WPsZrF0r3+ZT2wHY2xB65UthV2Ym
         q5BNHspaHZwG1js5hPVN2gkL4t2m7jVjgimAHhmdPJhjOp3m5jUNmIMtf7ZFaP9U2zzw
         7vRd1WxR77rrOjV8Hj0K4JznhrShrDIbXdcZA6n6rzSh76lGWe52a/mmMKp77t6/09bP
         IcsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fFT6rh8/MPrWk3ezl0FulU+V8/4A5ig321fIpbZxvuI=;
        fh=lX0znLu5cWrEC1DxsUyFLz7HTtmvMfkKq/YQ9XYvG4Q=;
        b=FK5BUFXfT9BMrFRD3wib/xkCznAvVt9PEx8v97OAqvRHFLx6xWrJqM7AByM83iSvWE
         GfD+gEkEvlQNjm/ArOhS69CehOQR8NmHnbg1zTmRJyTagJWWWL5wze128qwFq3Uf/o/t
         yQimp4sB61RBWRVpRsLdLyO5IACVgE4gFRsEJVcRc9TlHqetvOHS9+EFFF/OyuhokjbE
         R6LC2jPxqo7dLXnZXLYX87GSXPlfETZjRMqjp2WhvqFS5NfdJQzUKLt+gTflZ9GSAXBC
         Lwj21t4wlYNDE9kW8kIpU7D6m1nBet2uVScf7IWoUuY5DFaD3JAZKfqyKtgmMm3Tykpc
         OOOg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782143659; x=1782748459; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fFT6rh8/MPrWk3ezl0FulU+V8/4A5ig321fIpbZxvuI=;
        b=kD4op9HdfVanW+T/g7dYDeug5TKLefwVW15o7pQbkN87Ufk/5ZSK46707aN1LBkL4q
         nLjHAgcq2hH3yFFIBvPh8zktCRz/IzvT/WaEpF9ljGEEd7gFyNlnwFSUKMbBXFcGwM3s
         3tghnf2lIuncxqrz3aLwfmG87UQO0c/vTkvfKkkZgISMqg5fFx8NVO6ldaJWPznVMhtD
         QbVWq9O0F66FOt+QcIAOeg5PrHCFq26OcukRtuFbrvPCgXuX7ic/wyHRG3x91f18O/Gj
         enFWtA3PK/ewQbo1n/RUZn5pnt/fQRIKBDhukn335GC4+ozA73iFl2GDwx9a3NPYUUZ8
         ZxQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782143659; x=1782748459;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fFT6rh8/MPrWk3ezl0FulU+V8/4A5ig321fIpbZxvuI=;
        b=CI/JRLMGv3Zwq3eYfsXnahtt6kxcqAjI76Cu2UulYOFWCz1Qbs3M6lKQMAAwDiCIES
         kJ+S66w5i7oFKoL6fTulJy5oHf1GctlMjImYbh87T/fPiHbP/denF43Ptm+aOXLpQzYA
         suVYclCjPMruvzselx6ezm+tQQ6WXahwj6C195/3YzGK59YBjm6uMH2NcX15awuhNDBc
         sLcjHVV5QVrxoos6CpxDdW+bTA+63tRH2lWQuDKXwYX6P8AtJkoTn0xr+809SluR0xWA
         PhiBmr2iiuNQQufiXIYzF1JdUVxVJlFZS8vNs4wXRxXZ0h73GLoxTuqNFuHhSlsNP+xS
         Q+Zg==
X-Forwarded-Encrypted: i=1; AHgh+Rq2DJPD88e+oL9pLZcC55+MIq0sQBFdeHHEEkdN00IfIpyvCkL/RbSDpCXR6CPv09iK5/+8J3toVCw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwasJPRHrwNsWsIKngBCz83twMdct93jiWGF1J8qB+ASW/PSVz9
	ZS9k7iwYmWddJ/L5/MDe36XKsR70Voa7Q+/RKbyXs1U1OuzpHo59kSSMmZCU2aGHd4sQTC9Fj94
	i3oE/QNQJxfR7EFkCwH4DZsnV2/9QQdUu4Vhc
X-Gm-Gg: AfdE7cn042tzkC7mCA+Rx1Np/htTtJkFRqd1+9mHgjIeYJWLTdMainT3j0GfvX9vmPS
	K5vbOa8T2X1h9nyeFDEyGgdrgPeyoFbKBydj6EunbC4LCBwZtAYcvpzepISag+ImbtmPu0JvzmJ
	mYenWGh+CedDWu6CAHLm2GaHT0ZPKYY93PYfs0TbEmIEEF+UHF+T2bxdK3huUCPi9RxBRK5Zc+6
	4wFXTdTFkqVimHQwwDqcGOf/kcKC7sJSjlDf2bbXyB3MNuHuIRvMljQYsKuLdiHtLsf9t5I+kmO
	LopI2SDtuEiV8TXkaLk0XrP+DqRpgxA=
X-Received: by 2002:a05:690c:6607:b0:7dc:c477:9e98 with SMTP id
 00721157ae682-80177c8176emr143906017b3.31.1782143658469; Mon, 22 Jun 2026
 08:54:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260621004626.66629-1-m32285159@gmail.com> <614988b7-c77f-4f0e-b220-c0acf44bef27@baylibre.com>
In-Reply-To: <614988b7-c77f-4f0e-b220-c0acf44bef27@baylibre.com>
From: Maxwell Doose <m32285159@gmail.com>
Date: Mon, 22 Jun 2026 10:51:57 -0500
X-Gm-Features: AVVi8CfkKiWSV6QC-225bN-2BFDSsBVkoROfjamGp7D_YuwsxMLOAnZGUuFi8Lg
Message-ID: <CAKqfh0F82T0-Gz8dODocBCEAbCZeXjXWsnE1fRX-KnCO9=T3mA@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] iio: temperature: Add support for the STS30
 temperature sensor
To: David Lechner <dlechner@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	"open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>, 
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 22, 2026 at 10:45=E2=80=AFAM David Lechner <dlechner@baylibre.c=
om> wrote:
>
> On 6/20/26 7:46 PM, Maxwell Doose wrote:
> > Hi all,
> >
> > This patch series adds support for the Sensirion STS30 temperature
> > sensor family. This driver currently supports non clock stretched singl=
e
> > shot measurements.
> >
> > Given there were very little issues found with the v1 submission, I've
> > decided to make this a regular patch series rather than an RFC patch.
>
> You should wait at least one week for feedback on a new driver before
> submitting the next revision.
>
> Given that you said in v1 that don't actually have the hardware, I am not
> going to review this. We are getting more patches than I can keep up with
> already.
>

Fair enough, I'll be away until 4 July anyways.
