Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01E64155C97
	for <linux-iio@vger.kernel.org>; Thu, 12 Mar 2026 12:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773318010; cv=pass; b=EjDrbiubgi0h/fmNpwdECl5r5ToNff/GUjksa45+VG2tFZb4GW1tjk/y8u7S1Q9BZFpaxInI5XMARVk5zzg8SxGShpYCX2IuH8YDa+FU1i6EI+44A174yaCZMfbux+JAxxOR/3RK8b6Dk3t7OI51lIZ+kLlrkjG2+XheODzKOQk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773318010; c=relaxed/simple;
	bh=2NSpCyOYQE7+hyIONoQ7M5Tx9PeSJxSaG8ilsuMay4U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q1T8NCYPNuDVKT9gWkh/PRQvS/5wXj16eSdx1+A5WZOiN457bUR2dtBcsXiFDlHDJaGo4gBPwgTp4a+TYIbGdAvBM60/bh8GAhg9yeBbrVhHj0HDuNTOa3R2uN+GVm7mKGKki8mc6S1Yyb/yDssrL/pXckgFlJapgpch3RqcPgQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B9H0nF4c; arc=pass smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B9H0nF4c"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-7986cc3c35dso815277b3.3
        for <linux-iio@vger.kernel.org>; Thu, 12 Mar 2026 05:20:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773318008; cv=none;
        d=google.com; s=arc-20240605;
        b=Hh72WxCZY71MSIWtFOddjEphhee1qzqTcxDndJ+mL/bVlxKx4pPorXlAStuSGtzC2M
         6dobE/rJSwZjHPuN+RGJ3axlZJ3t8UNoKg/uzNf4eP07a5DtSL42RwYxql25BzGFVjxw
         vuG84AY1AJhFuoTV+5wkCRUvEYyTJlYdsvVNTUqbr6t7vzyetnF1h9K2041JuIMYmXf4
         zHviLxUJJoIUKAeCGLaOwfbvi0CwtnWB7xS4vgv0BWsM00LhVCYACbM+juyVOg8fomtd
         bMAGpEIW1PFvH7XWQIWu4D2h0uH6LtFRq5WUScGkHRyY5W9NQBhIzSrT52fzjKLKqNGC
         zTxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2NSpCyOYQE7+hyIONoQ7M5Tx9PeSJxSaG8ilsuMay4U=;
        fh=psNM0eRlTrHqG2AnqO5X140QITkgQWmuGnpw03VxFLU=;
        b=LO9HN1mXd4Il9kooBEvXBhIkiPgD49ba4RzVpwqLRo0Ga4f17ltxfgwEeUixypTjC9
         kNdx+A/unFQxdJWO/OEx96WA0IyFDAZB+6QVGPOpz1A7JrKRjJeuGEyesnXH+1EegX00
         WUHdWW6b0lsaOukdgVcWRkNlfHQpVOXjLY2UHlVMb5UIyFyBgTG7LkY35EBXdCNIRR3+
         +3Wd1FXLkZHnzQfQo6VcJW3vj4L2tokwHKoLuLgvAfyxs2bQUb9Cg173ov9tA18iGfuM
         AEmul2acDrbygFptA/xexog4s8ySQ7IsWNqqbFgJromEh1ta1bdIZS7VlmFxAVkzPxva
         MGgg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773318008; x=1773922808; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2NSpCyOYQE7+hyIONoQ7M5Tx9PeSJxSaG8ilsuMay4U=;
        b=B9H0nF4crxhv6zWZ0JvdzpCnt8Aa0utBs3tZZTYPzVy1j3OKcALZEdQgqDWUeI9bqa
         eC9H/Y4QasGbPIDGbUMTWZ3lqqhbNdtAIXd2CAzBxmO3Vmzx0RQWfjAxp7EhKINWIzbj
         /n4ahRWFB9qwUQnmhIVV2vE8hcdyvFbz3NGEqgnJJtQ/e4KhMF/vOKtJwdlPdOQYvtnc
         wjQGO4KSoGpkxgKy7Mm0BEqt6V87f9MZ0Ud5k8e8rD7tQiZFimhtfeLiGix2WWP7TYih
         gx9ZWkPiGXhDaK/6wSPczOXrMIfcGv8N4yRlFttCocR49J5uPQLoBdrP4D/YM9atEbZo
         K1/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773318008; x=1773922808;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2NSpCyOYQE7+hyIONoQ7M5Tx9PeSJxSaG8ilsuMay4U=;
        b=TJBBVKca1v9dmC+JiUahvHfg8rUKcNmUtltCjyb2XwVsPDCaR8FBRJpMzYSjsnBlJ5
         nsfDbuZvWfXuQd3RoPku/CvHSH7Nez1j9nY5EFil/+IvbTvEMHxBnxkNWrZzTLDSJM3a
         VZkwrnq7qgSqXB0HKIxR61CA6IIJlRRF/OH2F0mIS9MeTyJckqLuGYls7RhYbNADUbuz
         UaVf7zflWEBECy/KdOlCkhrPVFzhi/VAPWzhv2kohKoLNz++N2jliVsjVBZFqjZVu9yA
         qYazxj6fH1Wncdw1gcra1d5Ut3QQ5V0nQISzvgnEPj0hhkqrqSB2LT+Hp7MPFha8nPvm
         i2Nw==
X-Forwarded-Encrypted: i=1; AJvYcCWEE0bnIdW9wfRSwThXBGGIWfI7yDERKDYlsiFU+VhMtgDRWdvAf4cNnNnwQs9XVFKi7w5GLYm9Y2g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/ilEA0d2eTK3iPI8GwGSc1TC7KQUwXtG0PWyVAGYzI9yeCoWe
	MyVWia7L3lsTnsJF0JnpHjNOBXv+ysDLLVOkbE1GlpEIMEAeJS7roIuDLaYLkKntGiEnozyA8IW
	ZzsDiUEUPtIUMiVSYV6doO8maxR73SNs=
X-Gm-Gg: ATEYQzxDh6n1ZL/XZ9Iz6H5xiTafMkQoTdKbFyyJEzOxBRI1r6WodzYVJS5I1AL6pvU
	d/A4nJYhXRok9pOxUZFcBSX8K/+NT9agGeIVRQmNercGsw/mtLRlQfyCgJfNtN1y9yTg6f7UJ3t
	NMAT+jFvwkzzRiifBa9Z5zZSsFiNbCKaRrwfdfh5TjgYGWXnHfoY9we0cu+KvTfuprylzdUE0u4
	RMDW3i/8swlvOZDCQXzEPQDt/E+hshHV8VpCkgtbIrLgY7i3bKmKR49gWlYNpkAzcuncF4bZSgb
	X7Hr3FHGX4J0z6XtS9Wlp0GvTVuVS9orjanJQeSINyXesOuCtQE/jtIZLieDQdw7PBlIYxulYV0
	OAY98wRSKMI8lE12YJxPrMLx20DKU4M2+
X-Received: by 2002:a05:690e:11c6:b0:64a:e3b8:cc4d with SMTP id
 956f58d0204a3-64e5976110bmr1378367d50.3.1773318007834; Thu, 12 Mar 2026
 05:20:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260312080752.48091-4-giorgitchankvetadze1997@gmail.com> <abKJCRvTkz045yKw@ashevche-desk.local>
In-Reply-To: <abKJCRvTkz045yKw@ashevche-desk.local>
From: Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com>
Date: Thu, 12 Mar 2026 16:19:57 +0400
X-Gm-Features: AaiRm52u1hwYDVfrvrcCMhxaBD8T82ovq-SBnr7vA4P4RxTjghKjbFTU5XmIYaA
Message-ID: <CAE7dp2p7ikOqGNi6Vw1k+OLiah3M+BGN5FKbbBqAAfjDkeJnEg@mail.gmail.com>
Subject: Re: [PATCH 2/3] iio: adc: max1363: Format block comments
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: antoniu.miclaus@analog.com, lars@metafoo.de, Michael.Hennerich@analog.com, 
	jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org, 
	linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 12, 2026 at 1:36=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
>

> Please, go and fix checkpatch, this is NOT how we
> do comments, so besides the two issues mentioned
> above, this misses the leading asterisk.
>

Ok Andy. Thanks for the feedback.

I=E2=80=99ll correct the comment formatting and resend the patches properly
threaded.

Sorry for the noise.
