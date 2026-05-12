Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4188D29D27A
	for <linux-iio@vger.kernel.org>; Tue, 12 May 2026 06:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778568514; cv=pass; b=Z2H89uvcV+Wl9s5Bj9w6Ec4zJ/jyHcIo/qLamTbhQpWJoVa6PV0aBl974p/dQrweXdR3UyA/pFD2Syyi7PhLUMp32ErxPRSveAwUms8ECEh2mjbcdmVMzl0llVIp5kWWwXRvddPLJ7R4E6rkbTAuHaGru70ynn7HWC6Pr6dXr5w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778568514; c=relaxed/simple;
	bh=LfcVaG8MSoLybwq7I+cGS/0geSQDT90LoxEK6iJoQms=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Yyl/UnHMVULVjgmVfVAyRBbUd5wMkc/MQ63LpUmiBzOLYDXXcii9lEB/Ibz5xpxvqk6ZjHi9QZLv0tRMdbaK8NiiwTbuSdbPPOKqrOMApYq0D/MBVlXbu/X4KbeAIjsm+KT8lvyEid+UT/Fvxawk7kdwktoz4sTkwlRXIvLtqSM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iLjXtwIT; arc=pass smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iLjXtwIT"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-bd24f466598so109673566b.3
        for <linux-iio@vger.kernel.org>; Mon, 11 May 2026 23:48:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778568502; cv=none;
        d=google.com; s=arc-20240605;
        b=QGqnMUEI7EMksqL4gaeg/rZIJjxU3b7asmSmizYvmcj8dDirZv2yior9ySQtdA2JWA
         vaSgElxrc36UnmuufYpXQJ25CTrP5BNoFIMCSefRNBaOEZ4rkcUsRCooxi/sF0QpuMaP
         RIY4c8zxSOsdHo/kQTS8FTnrsFnOeLchhsYzRmthSuKA8qp6OLqGGpeBzQsRG/3iA/vb
         JdI4D5cAvsf78C+/WRMoK+x6OfdjWYGu0quy/f705sOdnOUQ76Wuj6mJKpySuwU2e+AR
         Ezu3E6lZmK2Y3qbDQ7TyqplDpRIez4PG8w98Jrn0r1fUzyIwcfaXUxYVZEkc1foEbrIH
         VAJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=wFTa1Qu4vivHMZ7h/kjmMuCcTIeg1RKlZ789oyl3YpU=;
        fh=WRgh7DouO0dNE7joTR2ggT4QUrTwQEuqahyQYwMFV+0=;
        b=GLOmpEAJQsteUrsC5v1KYUjzEUGm8ZxaPr/pbwMBeeXyTSFB00497XjMBM7c3kg1yS
         VAct8jJhe/lf0/LJTR4iWIzaLRenh7QMfKviDIasl1KQGWg/GD3ZpVozLdpU8rd8f9es
         STR8ydod5XDmzdXxzxZeMapmNYOk8GB/7yPnICKhDtPC2N/q6y2wzPtkKc8NI6vYUlhD
         XUgECioyEJoB4na9Y47jIip6prkw5qMSqF61/sNDP1UWAoZ2zbW80fFYosymC0AESvPQ
         E0564Ec+4GsUeVB3hDPNhx93DFr4Y3wa3+7x89g2O8ArWnIdZR1CUkdHf+yeQmAD8OJF
         yLRQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778568502; x=1779173302; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wFTa1Qu4vivHMZ7h/kjmMuCcTIeg1RKlZ789oyl3YpU=;
        b=iLjXtwIT6b7SSIH0nK2u0LKJaeuHqdrTkDrh+Eg1uqTroYRxJIqBDEY8nA3nHFnVfb
         sjYcvc84dcUaMKVebF/nekYCZL4+yo+4wJD3I/ahGzaterqThvytQ3a1dbMuV8BwlFLz
         NUMnfaZcJZuuqhNaWKaDgcmEd6aqgUlQYXIHOuYoZlHTi+B1HBE/5P4rUy3crQvRdidh
         PFi6N0U7G5f/BxgGVajjSnU07dbmKFPIHInHEc/iJipbWV5iEp9F8g4cFqjRb11nkHoH
         0id/m6rTcJTUXie2WkuDUd6Z0J0e8DP1ibNxfBS+RdT8YKiOGUrEGW9WGuLEqeMcwZ8F
         Yt+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778568502; x=1779173302;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wFTa1Qu4vivHMZ7h/kjmMuCcTIeg1RKlZ789oyl3YpU=;
        b=JXYewck7SHDPaeWoTJ6EvQmCSClByn9e3d2ws2geqRH4IkZsqY4vH/FmU+nFCPtec7
         ibN7SZtzfOLUoGmomEvrr/dY6i498PmAjvnUXBe67bT5xP8OeU+Br0S8ypSC9Cilz8iH
         PNo25ovtjzs9g69lySHV5ZRD1e7I7P6NgpCsq5ZfJatcd4DtfCz9eQtW/hyFUyjI8r7R
         mwMIIAyXmS0jHrFIZ+CYALo++VWhBEOajSTdKQ6h+VN7eaAjnYKCwYsMULRKkyEUe3vB
         CUAaoPTSJf9FR5Hr3zI5GiYACqXQlaRONqSSi1i2Pk1Tf+XbfxBK5J1C7pHEHcMAz6/o
         6olg==
X-Forwarded-Encrypted: i=1; AFNElJ8znCPGSO5K/Fo40DnceMvwNYdNTRJdCFjLViVx21Rzkxt7qEqPn+QExbHADVbdyfc0A6vPoqy71Ok=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzIioZDKQIrFUBxuXJIINr7xa586zZQ57MRn4v81TFuZ8u4dHr
	F5Ctv2d6bv2onxPCTuT7N5xTsLh0GGc7i5iLC+vNRcZcP+6Jr2AL+CW0JvAxTDYdg930c8pfVH4
	STjDsMEW5XvMnR18v271/W6dI3gSCri8=
X-Gm-Gg: Acq92OFRpKrkeyU+8zOdncEKfYNFK177ZChPKGeVpKLTACL1CMEpoSiQVz46aQSYOCH
	TYgf3Wv6Ps3Em17//XQWz2t9hlnR7ZuAOz5+tLfUkSpzuwziEDNEGqpLhKmO5vxhGGIq1jjqTHN
	G9j3c63RyhrXCjpLgVWQNdtrC5UDvBXZegCXtL11BJKEs9syhYCwJbmrJzB18NBPI0lsr4Xf3Fp
	uMRUz4Datty9mDZ0mT7fQk34ngT1yV4cbIotJqGXKW5mfYe5kkSsbrtC5nGLAwBU9H3G+D3/nTA
	zha/PJxR68iX0YRNkDqXXM4E6A3WnXRp+pxJaJ6C4xmQ0oJR3UDIxfW5q0Q/CfjPxBo9s4OK5co
	ruIWJpNU=
X-Received: by 2002:a17:907:809:b0:bca:48de:5cce with SMTP id
 a640c23a62f3a-bcc1499a53cmr609442966b.36.1778568501606; Mon, 11 May 2026
 23:48:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260512-mt6323-v2-0-3efcba579e88@protonmail.com> <20260512-mt6323-v2-6-3efcba579e88@protonmail.com>
In-Reply-To: <20260512-mt6323-v2-6-3efcba579e88@protonmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 12 May 2026 09:47:44 +0300
X-Gm-Features: AVHnY4LmZe6op_7Q9Zb_x2R3mJ89A3uDVU-76OXP9otXVwwfDX_cH9Q0T5k4R6I
Message-ID: <CAHp75VcR2pzdT-JbNXE_nOM-XC--4y8D81tk+7rvjA71ugTkzA@mail.gmail.com>
Subject: Re: [PATCH v2 06/16] nvmem: add mt6323 PMIC EFUSE driver
To: rva333@protonmail.com
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Sen Chu <sen.chu@mediatek.com>, 
	Sean Wang <sean.wang@mediatek.com>, Macpaul Lin <macpaul.lin@mediatek.com>, 
	Lee Jones <lee@kernel.org>, Srinivas Kandagatla <srini@kernel.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@kernel.org>, 
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
	linux-pm@vger.kernel.org, Ben Grisdale <bengris32@protonmail.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 12, 2026 at 8:21=E2=80=AFAM Roman Vivchar via B4 Relay
<devnull+rva333.protonmail.com@kernel.org> wrote:
>
> Add support for the EFUSE controller found in the Mediatek MT6323 PMIC.
> The MT6323 EFUSE stores 24 bytes of hardware-related data, such as
> thermal sensor calibration values.

...

> +#include <linux/err.h>

> +#include <linux/errno.h>

Doesn't seem to be used as err.h implies asm/errno.h that provides
basic error codes.

> +#include <linux/mod_devicetable.h>
> +#include <linux/module.h>
> +#include <linux/nvmem-provider.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +#include <linux/types.h>

...

> +static int mt6323_efuse_read(void *context, unsigned int offset, void *v=
al,
> +                            size_t bytes)
> +{
> +       struct regmap *map =3D context;
> +       u32 tmp;
> +       u16 *buf =3D val;
> +       int ret;
> +
> +       /*
> +        * Manual regmap_read with loop is needed, because PWRAP is not
> +        * a continuous MMIO space, but rather FSM which doesn't implemen=
t
> +        * necessary read callback for the regmap_read_raw and regmap_rea=
d_bulk
> +        * functions.
> +        */
> +       for (size_t i =3D 0; i < bytes; i +=3D sizeof(*buf)) {
> +               ret =3D regmap_read(map, MT6323_EFUSE_DOUT_BASE + offset =
+ i, &tmp);
> +               if (ret)
> +                       return ret;

> +               *buf++ =3D (u16)tmp;

Why explicit casting?

> +       }
> +
> +       return 0;
> +}

--=20
With Best Regards,
Andy Shevchenko
