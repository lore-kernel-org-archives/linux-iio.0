Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9035400DE9
	for <linux-iio@vger.kernel.org>; Mon, 12 Oct 2026 11:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791803769; cv=pass; b=qF6nLGGJ5QsnMsD/UDojYcZqQgDqlhWR1Rldg6QhJLP5YubLDK1+PlIQ3uAuc4rs8CIzNdnHrIBJS5p/JyEABiGDpVyp+hwr7RkrD2MvpXk2NcWnUWDgv/NDmuwV9XnR1Hg9a53gzaEoQqKkWW1n4VSq0HxJ0SPCt0beOUSIzPQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791803769; c=relaxed/simple;
	bh=BBYEwKeOE7OkkvDarXT0FjmEVf0UPxIbaghHxCPsYw0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DYOzAcsMzeQYA8GpLacOW82rMS+7fLBfwo4csCJyIlIhfceF1g87sQQWEtdpmLEvbhfGlFwWaP4RO/E5eiY285KPcIhKyKbhs4bCmW35DtWYvo+3LzopoFPlyBiob3KyJdDiF/hUAKXaRCLKJpIX8J6l5miCsCDWcIu/rtqM8jQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gk0WAK6V; arc=pass smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gk0WAK6V"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-c2a4e013a44so254268166b.2
        for <linux-iio@vger.kernel.org>; Mon, 12 Oct 2026 04:16:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791803766; cv=none;
        d=google.com; s=arc-20260327;
        b=K33Zy5oGyp+FNpHqm1l7i/XXr7VokxIvPmHy4E/uskUwM4ZY2jkX9MqBmn/AJSPFBa
         A84aul0hGeiEKNz5WPTrMoZoQouUl5224VwX6b/NGwNbFIlqs8a4O7wTnmKi4qmQAHwb
         NODjQPDuMLS05mlI9NastOAZWj+ZsKtOAblFWvD/vmw5L7gKuTIwEzVA3znzZ7VrSBAC
         hp2M6m+gB9su03Mz99wzHrOIH8OFqk62sCTsPTtD1VWQEnRiCChp4yc2hu0j4qcbEWIc
         xPN/ey/l6dtShrPucNuCYhDMmNcLq5JNL9sFESaHt0VbmRuUfQA+7ClqTnrYmbnxxnj8
         3DKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BBYEwKeOE7OkkvDarXT0FjmEVf0UPxIbaghHxCPsYw0=;
        fh=henQa9qlAr6mHEcRSjpfF2Rex6tNsRSYfx3SzumzHwc=;
        b=fZazVKkTN8PqyDo7NH4pykEi/PBPOaxNZnT1B7r8zKRyz3+9S7BwsMyJXdHG3nBYjV
         LY/caqZsl7mPo3qfAwjCTE6Vvnesr64HeFdrbYBPyOsvy1UTSpXWD27oLpRZ0xoOL4Nl
         t09Z+IQcbxuFhvtba8o4L8/wBZ7XQveXJ2yWI6TewKV/vBjAMs0EXXwpLI3keuSlSbyV
         3glEsblJPnZ7k9UiM03htMuUCgL7a/9w7h94m/mbaK5QP6aryM3tQugIXWEogDxGOnAk
         xYqHxh6T4ATnNc4ZjPrMEBY8JGmWR5f+8SjcejYCpXbfbIZwzvmB83KVotUWDnKX4Xks
         A+0A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791803766; x=1792408566; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=BBYEwKeOE7OkkvDarXT0FjmEVf0UPxIbaghHxCPsYw0=;
        b=Gk0WAK6Vgm6dDUsf+IsaYP2DUbXKD0CFA2nyx7qI5HBvdE/GcTni/ILHTETu+QER99
         ufpGr+otFH2p9jtrDoxelU9VYH/PGGyyAkW2q+/UjBAFgdQSoV4OgpuP/8iMZcyFvKmd
         dcdTn5aOmF0dlADFG1EZkZanMCXrTKRz0H3qcQlBQFYoMwM2Wu0P/OVebdMcZAim+TGn
         KqzvNSrR2uDeQk2nA1GRa0gx198ppL0EIXqcYMrZ3xbufAUWSI4LYAa//km4oWSQ/XWQ
         Qjr/VYl6zeHfZ8hyEM8oGWE7OpHu0xderlYpZ6j5klAw9J7JjyWgoPd4a2p4bmGbNmip
         nPWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791803766; x=1792408566;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BBYEwKeOE7OkkvDarXT0FjmEVf0UPxIbaghHxCPsYw0=;
        b=jQd7HOyYoSKG70L6u70gVj+i4lI47QIUeIH2uiqhz8oRK0CSnTrFBalPY2vmZ6d1JK
         HVFAdeyK/EkQYUuJv7kT/cNmJEt61hXjtLGOVpo5oLR4eFxXL5m8TeKKmKEdIVSVHZIh
         IKwZ2nNzdzesj65uf+L9kBh8ZThm2biyG+1buPY8y15IuyPEVL+7paDaj7GdFekj1lqo
         N4L7uivMaGzdPE5iCpmTYTm073nL6+yENJ2sBSP5fMdfm1mRTu62Z+ddSUaXFPucWf0s
         RnbS2cPNi2FVjLMAN0PCvWW2Qb7GvfuJ853bbHlbnj4u4FutSgucGURsypfDXNph7zJi
         aT/g==
X-Forwarded-Encrypted: i=1; AKwUvByanlN0cF6/wYSGbvw/w2rB4MW8uheqzW64ewH8r+Hnaj3OeLPP35DOThjaWTCB8F+EmPzF5z6O65I=@vger.kernel.org
X-Gm-Message-State: AFq9FYIjhYHdBIOyTwHlgINax6atrzMX/7faRUbpJfauWgbelqQzHyEO
	yM3mE14ovoGB/o/jb06geeC22PBdvcYm0VWapiY411TPNDsm6Z4lwB2qtjmQkFgXLjHHgKCBhz5
	2kF+gI2sr/7N+eqfsjUkXCCkv7JA9t2RJFpl6
X-Gm-Gg: AYBFou09KrPitZ2EKeV4v+u69mjZhh9awKyWKCkdyPTrelbG+gYU+d0DiE4pGvorsMN
	b1CzrXl9Ckfp68NlpQn2xkR8fAaFN9stHn5ho4Oy2enG92fkWAdEFEvc2Zpa0OWJG1dV1iWWO97
	ZsdhCGVBhqAa2GMnkqbIscVvTqZkXQiIJeErIIRt4wJDwKLprQu9QRnIZOJXMBGGlDtta9UEC8u
	hQ/4t0AiKjGIM3xqkRrcUHmeZjuQFiByZJipdBUpkp3BNdc6GYybJdYMZTnGMA95Zwt7n/sBdH6
	s/96ecCOjaaly6Nym7s87rMK3a/7eTYXVMX4jxBeRQR3vggyZXip9upjWdT3gQT64JcRPiFdCet
	g8DG1ZR2XZafnIwCcihoYCDiOGxjobjIRAAxOrOonWu5XhIzi+25PyJ9JZ7mMdQcT3ovOR4PfWg
	aRvt12nbFnXItdpIMBp9uMXayZu1NYZvwjeKKOlR+ftz78a6J7C+g=
X-Received: by 2002:a17:907:3d09:b0:c29:5b0c:1b44 with SMTP id
 a640c23a62f3a-c31a9fe3d17mr877054666b.37.1791803766024; Mon, 12 Oct 2026
 04:16:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261001-adis16607-v1-0-9c89cee35d56@analog.com>
 <20261001-adis16607-v1-2-9c89cee35d56@analog.com> <aszAHLVf7MEqvht7@monoceros>
In-Reply-To: <aszAHLVf7MEqvht7@monoceros>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 12 Oct 2026 14:15:28 +0300
X-Gm-Features: AclHuK8PxCMj8iFJZZKRqYPj-GoQuTI01kOIZSMNlNkGPy4YGUhURoNUhpmsmts
Message-ID: <CAHp75Vee96s0-h0kSTs4O9rtKjYZEPB_8AnEqj3j=+SuzLkiOA@mail.gmail.com>
Subject: Re: [PATCH 2/2] iio: imu: Add driver for the ADI ADIS16607
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: radu.sabau@analog.com, Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 12, 2026 at 2:12=E2=80=AFPM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@baylibre.com> wrote:
> On Thu, Oct 01, 2026 at 12:11:50PM +0300, Radu Sabau via B4 Relay wrote:
> > +#include <linux/mod_devicetable.h>
> > [...]
> > +#include <linux/spi/spi.h>
>
> Please don't use <linux/mod_devicetable.h>. <linux/spi/spi.h> is good
> enough to provide spi_device_id and of_device_id already.

On the same grounds as for OF, it has to provide the data type for ACPI as =
well.
All the same to i2c, platform_device and so on...

--=20
With Best Regards,
Andy Shevchenko
