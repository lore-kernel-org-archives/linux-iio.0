Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69F8835BDA7
	for <linux-iio@vger.kernel.org>; Mon, 23 Feb 2026 10:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771843344; cv=pass; b=S5451+6Lq+dFNvfnvb/LeHgk0sPoZX4eDF+OYBfvCuRgxeZw81MDlLlLxxogsl7DLaJ0V9pBtGiTDPP0KjAjUIHrf2xkr+rZuHRNvYUZbCWTz2DqTfp9SI2lgVgH4yl4YMHWhIjku5ZAhmsLwjP6S2hSbbZ+MeMBIQB9dbp9Ujc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771843344; c=relaxed/simple;
	bh=P41ECaBtVGR0u+MMMSObmf7Jb+y0JD0AdOXmIS3DHAU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bKDiiWSq7fg2S4SSRWVeht68Yo1LDbiKRt/g9pYnP5lHF8y3EN05mT6XJZnB5d+/qhf+ir3peE+Avx11HEG9XDRnVlxpPUfIv0UasOZ+SO46vnSZmXN6G3Ps3ulHa2HU5S8KZZSaIKQ9X6n8hPx86yYn4b3b7n8SWTMOkY4ZCAo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q1cjsye0; arc=pass smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q1cjsye0"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b88593aa4dcso580874666b.3
        for <linux-iio@vger.kernel.org>; Mon, 23 Feb 2026 02:42:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771843342; cv=none;
        d=google.com; s=arc-20240605;
        b=a087nlfHNheTQPoCPUKNGwvQxGYtdA5YbklBbNCsKIBRooyiKM2uaZWVqif1BAPDrp
         mKTyegMek8/Y1lDUBC90b56U5X/tIYZUHQj8n0hXMK3PZof11nc6vF6dPcjiHDW870Ul
         l8gEB9bPnM0UKcqNf7UXrSt613DxWNgCK6FcWmHEu1SEz7xJJjk9b6RskLY49vbZyj94
         JV0TsSU5EwIqCDBgxKJ70lS/AWzCUDuW0YJr8oeRLAlfw02LqzUNjrLqtVZdl2eYqf/u
         o+ZSQ8ts9DXd6UtFEPtQs/i1yhpp5SJAuWPM8N41Qj58+/eiV4QRUkT7Z3yaWPvqdfIt
         MJwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=P41ECaBtVGR0u+MMMSObmf7Jb+y0JD0AdOXmIS3DHAU=;
        fh=PoIl4GseUrD3opq2JBj4E2t3IyYgNT+fF9uMlF5xbjA=;
        b=hsxC5GKZSeSoISJuzSXY7KYb/85VDGV6OEkqJgkVXEM516zG7Aw4Cu0kMbz+haEPPF
         l3oprg5br3SerGyH3fYjyf7cNH7aRDBFzR/aGM1hDKvcKqtdFzRiFzU41p+cHwdNoG0V
         E5JSYfNG3NklSAkUA4z4uRyBPW8m0f10vgete/OkFeeb6BUKg3bYNPrsPKcRbHoer75k
         HIo8t8VDxntHt7t7dpnmk31wVgOEduhUMnOlwHmGNovQD80LA64yKjosHE9adpWfK116
         Yxm90JZKnFLjNh6jIfVpF+V7VQzVKqRKvVb+VC1VS/TZodBQlsdekv6MOJTI96sV+8zB
         FNtw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771843342; x=1772448142; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P41ECaBtVGR0u+MMMSObmf7Jb+y0JD0AdOXmIS3DHAU=;
        b=Q1cjsye0K3kzkv9EFEJ3OGVamMLTrJOqSkc1o9x7sRzUESbN/Kehs51F1ijM0J3kQ5
         TP0PfvBayxozaHAwRggwzWY7dD1o78gd/vsDIuBGPf6TrN80c6rZSOosjYtuXXbW0lHu
         wakRTH2ieQ2BCyM9fD0MhrOhqnmyJV48xJflt39UyFK7G+Mn+5bCxrl2l8zCjGiDrKMC
         LJ3PLVJKK2beVg8LwSq8PZwUSYJxhrRoSepk2ivbOu9epjidcoCFuXxcYqIHHSD9Hrd3
         e1hhMHpdFXInJl+sBxO4IDkB1yQVi1QSljZvm7okbg5OJ2i+AsxADmwXqnmgPo0CbqOy
         mP3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771843342; x=1772448142;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=P41ECaBtVGR0u+MMMSObmf7Jb+y0JD0AdOXmIS3DHAU=;
        b=EGUMvkxLtmeZnKwoBFGxAEC6JUdm/hGpsDoNfdarxQDOx8pFqeUFjQAE7E585uIJN6
         kJRoxVE4VIElKRU4PxPElIFTz+8tuHtSD2ucwwbP+s2qzRDeLJtYVu5ZjNDrJ5wCF29E
         TO2dpp4t71IVrnyhWn/PnFhwCO5EfjNMwcD7qXYPiDhoLypm4RGw312B1kEz6NR34NQg
         ONd4bf/V+PMmaSjFXMcmhV9opLqLiXQSJ+i3D0He4KzxFybC8Ki+1qThbv67k+TfMuqd
         3B5QWN1BnYRBSeGS9I2/UQAj8yEpZ4RqK8u62WzTjdXNil8IG35LyPtMuP8jPK72WgtD
         kNTw==
X-Forwarded-Encrypted: i=1; AJvYcCU+pwk6nJqTxIRqmFCHGy2eCpY9IrscBG4dd066ZiGf5nIHj9QaIUDLxxECIMqoYb5PR1TJyCVASEA=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywi+DedsAOZR9mBRr2bN60Mk2mL1ALm1ROyMYV4A5u50Ssan799
	/PHYt8osprBjoU9N9mimhp56qUY6xFwUQC4Ns2g+sFtMXKw/eTcLQgt99QTRKrh9Dfg8MhY7XnK
	OCK3BKs46Lv2CNwpdag09lYlBvxYtHjs=
X-Gm-Gg: AZuq6aJmaDf7QuAq+jYgGNA9KYYU28DqxHbwB1LjuN6mVJ/ZTjZbaJoIMJezOykeKMB
	dwN84dLPjDZ/cDZLK3QQGV3YpP5huV6SZfK+2d21rhoGola2atEWHl6dxmKcfVl5qlmtJ8eyf+0
	MHGBc1N2hGljXWMnIspKtGVgAwmndDDsu3gwoKdnBk3xNRe0FOzvSZdqF42F8QCtoV26MzkApuK
	sSl/V2Frcw6fF30x67x2lE24Lspxj+YDbi76SIhY9lLRm1HGuO0vkRuyR/UexWoBlxpxc3N8hyY
	oM3+77bHDxfPU8/0Nh5S49rKGOKYyDIangLNQ5KhJHEXRYr3hTSu0nR3Jq3QUJmuwnBjvCAmty6
	5jMt/fYc=
X-Received: by 2002:a17:906:ee8e:b0:b90:3593:654c with SMTP id
 a640c23a62f3a-b9081a2aa1fmr456630866b.21.1771843341409; Mon, 23 Feb 2026
 02:42:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260216-adf41513-iio-driver-v7-0-b0ed387ab559@analog.com>
 <20260216-adf41513-iio-driver-v7-2-b0ed387ab559@analog.com>
 <20260222172912.60a103c0@jic23-huawei> <aZwYshRxNgSh3CWk@smile.fi.intel.com> <zb752y7tnjzsc35na572o4sip6efwv3i4lha4ls6fhdrr52h5v@bfgy65cmae4p>
In-Reply-To: <zb752y7tnjzsc35na572o4sip6efwv3i4lha4ls6fhdrr52h5v@bfgy65cmae4p>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 23 Feb 2026 12:41:45 +0200
X-Gm-Features: AaiRm52vOvWGhar45YMmK2bKJVNTzdmE6K0RIepFykMpsJ41Aa0DMBAQ9J054Sw
Message-ID: <CAHp75VdSV2QDMR0DueCuP=Ds-5A1NsNjqPWtmRbG4NvoJ=LjXQ@mail.gmail.com>
Subject: Re: [PATCH v7 2/8] iio: core: add fixed point parsing with 64-bit parts
To: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, Jonathan Cameron <jic23@kernel.org>, 
	Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>, rodrigo.alencar@analog.com, 
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-doc@vger.kernel.org, 
	David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, 
	Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Dmitry Antipov <dmantipov@yandex.ru>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 23, 2026 at 12:37=E2=80=AFPM Rodrigo Alencar
<455.rodrigo.alencar@gmail.com> wrote:
> On 26/02/23 11:06AM, Andy Shevchenko wrote:
> > On Sun, Feb 22, 2026 at 05:29:12PM +0000, Jonathan Cameron wrote:
> > > On Mon, 16 Feb 2026 15:02:17 +0000
> > > Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kern=
el.org> wrote:
> > >
> > > > Add iio_str_to_fixpoint64() function that leverages simple_strtoull=
()
> > > > to parse numbers from a string.
> > > > A helper function __iio_str_to_fixpoint64() replaces
> > > > __iio_str_to_fixpoint() implementation, extending its usage for
> > > > 64-bit fixed-point parsing.
> > > >
> > > > Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
> > > Hi Rodrigo.
> > >
> > > This looks fine to me, but given earlier discussions I'd ideally like
> > > to wait for a final review from Andy.
> >
> > It all depends on the series from Dmitry Antipov.
> > Can somebody help reviewing the patch 1 there?
> > https://lore.kernel.org/linux-hardening/20260212125628.739276-1-dmantip=
ov@yandex.ru/
>
> can we push for the exposure of that function to kernel modules?
> We have discussed that in v6, and I understand that:
>
> EXPORT_SYMBOL_FOR_MODULES(_parse_integer_limit, "industrialio");
> in lib/kstrtox.c;
>
> #include "../../lib/kstrtox.h"
> in drivers/iio/industrialio-core.c
>
> is not a good call...

Yep, because it's a temporary band-aid. The proper solution is to have
shared code provided by the lib/. So, the wrapper to parse 64-bit out
from the constant string literal should be part of the lib/ in the
result.

> > When it's in, we can continue on this one. TL;DR: for me this is on hol=
d.
> > But if you see the need to have the driver being in IIO, please add a b=
ig
> > fat FIXME to make sure we will get this all being sorted out in the
> > (nearest?) future.
>
> I could add the FIXME into iio_safe_strntou64() doc header. It explains
> the context:
>
> > + * The implementation of this function is similar to _parse_integer_li=
mit()
> > + * available in lib/kstrtox.h, but that header/function is not availab=
le to be
> > + * used in kernel modules. Hence, this implementation may need to chan=
ge or
> > + * removed to reuse a new suitable helper that is properly exposed.

Up to Jonathan, I hope we can move the above mentioned series forward.
Without that, as I pointed out, this one sounds to me suboptimal and
unneeded double effort.


--=20
With Best Regards,
Andy Shevchenko
