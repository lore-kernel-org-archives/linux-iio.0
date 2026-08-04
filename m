Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C149E45FFDE
	for <linux-iio@vger.kernel.org>; Tue,  4 Aug 2026 13:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785851644; cv=pass; b=oY58AAzbFXSyk2u+q8sUeVg0/imLPyJLBbmj0V79iLimHUxyy6EsvC3MvEIlVm1f5esSXybsxYJBnCm5aRhFJ+fL/rDH/aMONsPNlbdnjYT5y8/1Zlcv01A/5DB66ZSiA2gi/9dX0tE7DpVwKFYh/kpX+SXZ33y3gPVRG1sk6fQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785851644; c=relaxed/simple;
	bh=G7tap1XRGOvCEUHEXcCFtnTiVK07JRCwSl13kORQpeg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Bi0kitWhqL7mDar/JSMNvXmZ6PTXVFPv9IrVqYvimE67vLlTvySvLowHOmPNP9Vt8qqiB9+uhyX1zkC98AWHe5ipzMoe/cNEzrfuK330z3tbBfCyiS40LfnyfPD3J1qAs+GZMXH+fkYTGcUB6cY5fp1uz/K6KL5Szu2iJxsypwE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XhiNPZG7; arc=pass smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XhiNPZG7"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-c2020421077so239556966b.3
        for <linux-iio@vger.kernel.org>; Tue, 04 Aug 2026 06:54:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785851640; cv=none;
        d=google.com; s=arc-20260327;
        b=N0J+KSj8t+frrD/pVnIhKrC3zv7LVVXYMcgA+DCHtDujEKR/8WB00q3yRc0RbxK+1A
         kXLwigwm7BbLoMnx4YjX6NhScFqGnBal4MdIJ8owWeDRP7Ya2OwaLzG/7Kkw8Sfi/Orv
         aZBABBR3xQt+1OYB3IV/iGNAFR3OFWT8tV1XS+OgjrQR0SBboty4MAa/XpZ6ZUMVUwdt
         eVGJAXTtv6rKAkbhnaWDHgSAwIGJVtW+59lMdfUOMEwIUj9ERYb9TN6G6SnkqlyWM7qz
         jw6PcIlyEVe1/IysQB1oiKMVygt29viSdhRygSZB04JLu55FkGyJhXtPPz3DCqgPzErd
         as1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PPUmXWxsibLFFcGxzHWKhbRyg3VRNMzX4a8y84eYXjQ=;
        fh=/tbQFbCIejxhsA9N/lpdySrpOH5hLywHrPtUk8Zv0aU=;
        b=BKRaaogNExW4cShs7s4fYO68OGlKYjlGwfJrRF3YrwyCFR3fdEkeq1TfvQUOATu97Y
         wxfTN9ELuDRb7JN95lJH50cUZw1+Yvo/Moqf+pbRecsqFDgDtoVpIl9vMXG+1LtCglyS
         OSbw3q7DCgQXSJ/mESID+D2tSXQOr5saN5r05TC+ZoymEE0yXVQqht4fWcqqff2/ZRUb
         IF0Xv+YBTwEu0IFrOPgPNLUOpqWV2y9aLoTl3M6Ru3sOmk1SlaF3J3HOOC6TeSMCuBkn
         u4k0kGl0PsdyNxsVXh19DScV1zz/1/eW+uUjk8CPhINoMnkdgR0IZvvqKaLTT3pRB48y
         3WcA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785851640; x=1786456440; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=PPUmXWxsibLFFcGxzHWKhbRyg3VRNMzX4a8y84eYXjQ=;
        b=XhiNPZG7EgIST9ZDuMOOAC2mk74VETngpt+MdqMizPme9B+uHYi+9xp5EgHFJIyQ5K
         o4GTNKD9bj6Pfk5UAzIX/7qJPHzbozSsbDWdYZOt7WX8BCqG1nJNhNWXkcQfxpH7RJjv
         bjlQPli/Ba9ArUabmkF1IjLnH3yzQZRS944bOPP2bP/QDbCLe31qhB13SxeV0LNleU9P
         gzsLhjp1TwGUNpTAdJtL3D246X389e8vUKlyQjd6Y/26Q3mZjCRWQxJXfxlOHD1V2MK6
         QAVowppmPt3MPHx/KEgIvjxBSqIzocorfeArR8uLT9yURgGyuPfwJBgCC/IUTgS9C3Jc
         indg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785851640; x=1786456440;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PPUmXWxsibLFFcGxzHWKhbRyg3VRNMzX4a8y84eYXjQ=;
        b=G7O7yr2ptg4tScsskrQLCTev80m4reRAqj00PUUqvm7o/wTdjQlWeLzabJQA8WOiit
         jxJl1ikltUw9H9kJb1xyvU1L5CG6wsVjsGqfICwSEarI0QV6dUSPEElHTYHiu3mP0lG1
         RVu0hDOwpJbaaObQ1D5Qmv0GMc3+04SXcOkY9FINt89GMAb+VAPknEFrfQUd/gr+KfQr
         t30S8PqNs4tZ07RMGFkhYw+kg7WgZummvYcR+Pz6hSJT3KIU62btk+Cq952ETXUL+ysf
         J+O/vzg7/bMInnZvC7n/HdArjxKevWjQOkBni+hmLBbIAlW0w8tmQpyGe8tSi5YVz9Em
         jNiw==
X-Forwarded-Encrypted: i=1; AHgh+RpFQDGUlMtbtw7h3iQ6Rhco8qdBoQwZuL9N/WMLfKbu3bnQBCSHVaJBfLNziOzsrAw0MdE/EZCfRYM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVBeYZnbLASJNKLSQRRh8spR8oXBjGy7F11lYi2tD/v/wt7I1f
	LtYChNst0mimuYUBam94jcqnVKrnVxmdtUViLYshLcpqso6WlB1quPKz1xACdohwMEYEsFc0K8u
	Rv3CMMrf+ezaMUvt22cTl2zrq3MiVYfs=
X-Gm-Gg: AR+sD135+Wn/ioKh6VZySL/wZtOTk9osYgJNrDHV8m6Nk8wrsBHbsGtQa7WfI9YnWRF
	xG+cilTiVSHTambaa2bvKMNa74DwH5U+rOrJDAIzv9o+GtbVn9nC2CvkRVtmO+Y+lTUvTS2lV5t
	ygfd/7x1y0mN5FuWszAXJdUxkcD0lnIFWJkUsOnQ++rO7Hsd69mFrg2Oa9Q7bJTUQZ+neM0oBHw
	+S8XL5jGZI/Qrc+25F6OAsD+5mE81wqp6LnkWwGwrYe9lmge5bKCYSlUnZPCbGAwHg2uOTZYvsl
	hinX1W14IaRoirtKzPqPOL76TM5x6YQueg6IOmr62IjN23ldNb1Q3EInIP/bDSLBWoLAKIKbumD
	1EDKWTlGOVEf1EH8ItwEMJs19EbTHchWkbf9eUpH7XgBV0WFqh/+EmzOMIiJ4s02bujS9liwJyo
	qd54qK9aBR2/8PekulmD7z2NEBHm5tDCGk+/XsdyKJV9mUoCobAnofiIUqaHQWmcM=
X-Received: by 2002:a17:906:630b:b0:c1f:bbe9:963d with SMTP id
 a640c23a62f3a-c1fe822928cmr1417002966b.30.1785851640233; Tue, 04 Aug 2026
 06:54:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260804-mcp47feb02_refactor-v3-0-97f8b81f3628@microchip.com> <20260804-mcp47feb02_refactor-v3-3-97f8b81f3628@microchip.com>
In-Reply-To: <20260804-mcp47feb02_refactor-v3-3-97f8b81f3628@microchip.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 4 Aug 2026 16:53:23 +0300
X-Gm-Features: AUfX_myAnyW643u-12_ny2quh8TtnzwfkUEIgn_rryy2DoW96KR_ckNocIMJ2Io
Message-ID: <CAHp75VciUg_iwLQ3bp+mY6n2e=sf-697zAOe3PC7gPnpJ5PanA@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] iio: dac: add support for Microchip MCP48FEB02
To: Ariana Lazar <ariana.lazar@microchip.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 4, 2026 at 4:30=E2=80=AFPM Ariana Lazar <ariana.lazar@microchip=
.com> wrote:
>
> This is the iio driver for Microchip MCP48FxBy1/2/4/8 series of buffered

IIO

> voltage output Digital-to-Analog Converters with nonvolatile or volatile
> memory and an SPI Interface.
>
> The families support up to 8 output channels.
>
> The devices can be 8-bit, 10-bit and 12-bit.

...

> +++ b/drivers/iio/dac/mcp47feb02-spi.c


> +#include <linux/dev_printk.h>
> +#include <linux/err.h>

> +#include <linux/export.h>

Not used

> +#include <linux/module.h>
> +#include <linux/pm.h>
> +#include <linux/regmap.h>
> +#include <linux/spi/spi.h>
> +
> +#include "mcp47feb02.h"
> +
> +/* Parts with EEPROM memory */
> +MCP47FEB02_CHIP_INFO(mcp48feb01, 1, 8,  false, true);
> +MCP47FEB02_CHIP_INFO(mcp48feb02, 2, 8,  false, true);

Need a header for 'true' and 'false'.

> +MCP47FEB02_CHIP_INFO(mcp48feb04, 4, 8,  true,  true);
> +MCP47FEB02_CHIP_INFO(mcp48feb08, 8, 8,  true,  true);
> +MCP47FEB02_CHIP_INFO(mcp48feb11, 1, 10, false, true);
> +MCP47FEB02_CHIP_INFO(mcp48feb12, 2, 10, false, true);
> +MCP47FEB02_CHIP_INFO(mcp48feb14, 4, 10, true,  true);
> +MCP47FEB02_CHIP_INFO(mcp48feb18, 8, 10, true,  true);
> +MCP47FEB02_CHIP_INFO(mcp48feb21, 1, 12, false, true);
> +MCP47FEB02_CHIP_INFO(mcp48feb22, 2, 12, false, true);
> +MCP47FEB02_CHIP_INFO(mcp48feb24, 4, 12, true,  true);
> +MCP47FEB02_CHIP_INFO(mcp48feb28, 8, 12, true,  true);

--=20
With Best Regards,
Andy Shevchenko
