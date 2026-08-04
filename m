Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12025468C3E
	for <linux-iio@vger.kernel.org>; Tue,  4 Aug 2026 13:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785851428; cv=pass; b=JygvoMbm554wqAFGuPJ1l2ijoHL6xsTKQhQIr7QPj/bWMJjwk7gGT7WESnGLdzE0IDqgbVJT/VDnRIZiEkijJ5f8Q1bpqTAIw5lb7jMaRvljN/WXzZh0j0vVpuzstti74U1Mtwyq/fSWUHsk/P3zxV5hAUbtO6evj6MePT0+7EE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785851428; c=relaxed/simple;
	bh=ntiiMJw0n1K5Z7TxjYixtiA9S/kmRkDI1jzXd/0u+98=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ixxo0SZjbTF6qwDoYA5ntGUFkq1/dgNbVkfWj5jVFC6yM7nexeJlPrDGu2gEmbOJLjNUOtH3ImOuBJMph+bgbCV2njpi0MnCU6ihkvn6+OLkgNSLfhJJ6wFIvvr9T6cC9Hi3ALqcPTJ96fUbOIDWhBHGTNnjwlq36o2IhZvodjY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D07u+bpM; arc=pass smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D07u+bpM"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-c1670dad7a8so645591766b.3
        for <linux-iio@vger.kernel.org>; Tue, 04 Aug 2026 06:50:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785851425; cv=none;
        d=google.com; s=arc-20260327;
        b=HKjNlg0C7EMYZ5VfDTCo1gi3h9oUTej2R4UTOxIyXJfPughiccb85AHvLFxoNW3a9S
         5uqDlSkgXp55os6IUeBswl5ZsQHvuaQtONzwpWG99UAIbalChN0lHxyOx0FAupp8uaYS
         2R9mOgSaD3Fg6IAO0QJzYD9itlBj+Y3qKIyhWEAeyQ4OobFcFvjmxIuVcGwnaUYtJRt0
         ov0ZKTQKIKhilk8T0mb2RBXdslCcn77mtiLWbizUfQ2sbgORLFp3n/XIil/Wv46qlkTu
         lu2Tr0puMdpxq4f+nmtm2YMrF5DleZt3pmkxv7xZd2k1Ff+v4/q5bxNzkrmWnYuVu1JL
         0kQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zPUq4gSDjzsN5XydY66vNAKwQ+iuieDx500MN2oAnCQ=;
        fh=IiKag1fDeSkUePz25OMZMZLpbRxxrncZXlVr7rM7YyQ=;
        b=ekWeBc2IFs94/Xuysu9vBnHOr4aZiXbbkO4YoZBfdDzZZOmQEyl20jM7gDFZEZyF2J
         ssFaZZHVw9xTaQ027qiC1iJMOx+U0UYRD2+daZRgeRnpCiOZ1YGWcPqETsG7upjD8lwz
         S9CM7PpsTThATrpMu/CxGqcr6iyTrGZcYHy0yY7p4mzm4t2r+48uEaQYyJVEafmuW9Ji
         r0OO2MXXDmsJj5sYMhF7CV6vupIFNG1pFPLeCJXwdCoQI8V63VYfCZQgYGm1fSXJsBF5
         Jl+verOoa/qcN2x8WaFYeTn456aQs2TOkm6kXuVN3EshyWlDnXNaQaDNNxVzu/R/XGnc
         CwLQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785851425; x=1786456225; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zPUq4gSDjzsN5XydY66vNAKwQ+iuieDx500MN2oAnCQ=;
        b=D07u+bpMSx46z38z4vp8dB/Fky8rDXkONVwjlbi4YeD6FtHrUmTn1nI5ldJEesSVA/
         PXb+alcBt6rONyOUh9/7Jqnfy6G/5KWEgk2m2YvG6g01dnSq5D1VQ2TLrieLVbJwgnFx
         bzSR6Q6Eh6wU7um+3XiyE+VXO7RV2I+QdNVeDsIizJFOY8nZzzADSszyvMVTCvUcLUGp
         M5yUWNijtcZc/Q7PLoEwm3QxFCd2/AARYvBFksAOtc9sGdinUSWqZ0xGCi6GcCKKhCgm
         Y1MARARMUJZ3jZCwCmVafi3VnGQs7qP6xD9NpAP3pXgH2CZm5bWPnqq129SjLaGiTguj
         t7HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785851425; x=1786456225;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zPUq4gSDjzsN5XydY66vNAKwQ+iuieDx500MN2oAnCQ=;
        b=hEno3JOXqmgxSvywiQHbu+lpN/+16k1JNAPn6bbvwRwgQXPr/U+/2vCFhRzXavREf0
         v4Es0BUfYexKKo57BflOFXoHRJiY4xN9unLGdDEVHfNPu6TqjtghcCQ4YQotN6ZpWEI6
         Qy5H8AnpsgZLFZwz201t8YF1N1k0kuVaj1KQWOcOHqaBwm9KX3OHcl7G9rraT5p/2cc2
         O2RA995vjarHWjGcLxOXI9d1bE5GSTx5S9AsbsLJDC0qgIb5RA1nPRLTcALgufoU7nVN
         /Yt59eupLFEYD9KpVjriFlRO0xrptAd2n8AsWW0MfMsFUWoAh4qZwU8P+llu68ytWTcF
         sYww==
X-Forwarded-Encrypted: i=1; AHgh+RpxKFqoBTciqa8HaY5SsZSKuMYE2PcV3HIJUMCgfZeWCGV7qpX0x/IePPiAMb7eqnzRL3GEKa836WE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnD2IX9sYga09Vk2qFJS3/9akTBSCKQVIWGBAUxxljJOOCIN4b
	WpwqgYcVWFZw0Sp7kelvc+9yvgL1G6VaVbTeMtdGgVsR1sGde7f7dBTOeocVmz+xcR71UK+cA54
	12tJGiZmXU3+Up7A3D4ZdIsgcjLTRtfo=
X-Gm-Gg: AR+sD106Dcw0M9z/wDX+aT4R4zmvNP+2oFWYbgIgiuNMuQkNZtRknN/wmy+kMgbLEOD
	HnT/X3x8elQXghhGqbZZfLNXkTUQpQv3hY17slhjPybiA4gHtVC19Jw8VDMSfP5szIDxxcC2CmU
	bapOBEa4mYZP2U7QeLmphhmw8G/+LVzf6+G8COTcoVylJYuenEUVINrTUEkS/vnU/7zrqYyULOG
	trkezdVaSXXPgfW3XO1sTPBUbUO0byIejsJAV6a/tq5417pvqK5/zlkX5+gEP1MHzyxTNMEm+cb
	DnyceiBPaO9ZuTEjNtLkbXz+CEHoRlxmGOTn8UtNru9pBCnRTzAFZ92BlBLd/CpKVBUH2iWD1sq
	r2bL0uQjfvYI5LlZ1e9LghvrayuPnT9esByTfscYxB+2NP9hx0wdMB+246wynHzwPZ3wNtjm3CN
	YcyF5BBRR99PC0e8/lu3Qx4TmrYm7X6RRU8q+sHFD89SFmrUvXAy6LvsQ5sU2J1Ik=
X-Received: by 2002:a17:907:3e8b:b0:c15:d6c8:2816 with SMTP id
 a640c23a62f3a-c20239b98bdmr471522866b.27.1785851424918; Tue, 04 Aug 2026
 06:50:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260804-mcp47feb02_refactor-v3-0-97f8b81f3628@microchip.com> <20260804-mcp47feb02_refactor-v3-1-97f8b81f3628@microchip.com>
In-Reply-To: <20260804-mcp47feb02_refactor-v3-1-97f8b81f3628@microchip.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 4 Aug 2026 16:49:48 +0300
X-Gm-Features: AUfX_mwVvjiXqocsQ2YgwSYQ8gQZ7vg7rt96Z5KqVZBgWRn4HOmKB8EAjeAiNck
Message-ID: <CAHp75Vcd-A84KxiCsZpv3y=G-WW8H7GpZ2Y2G7BAnGsVL6Vjiw@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] iio: dac: mcp47feb02: refactor MCP47FEB02 I2C
 driver into two modules
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
> Prepare the driver for the bus-specific code by refactoring into separate
> files. The renamed file will contain the common DAC functionality shared =
by
> the MCP47FxBy1/2/4/8 I2C and MCP48FxBy1/2/4/8 SPI drivers. The MCP47FEB02
> driver was refactored into two modules: mcp47feb02-core.c and
> mcp47feb02-i2c.c in order to prepare the support for SPI MCP48FxBy1/2/4/8
> DAC family on top of the current implementation.

...

> +MCP47FEB02_CHIP_INFO(mcp47feb22, 2, 12, false, true);
> +MCP47FEB02_CHIP_INFO(mcp47feb24, 4, 12, true,  true);
> +MCP47FEB02_CHIP_INFO(mcp47feb28, 8, 12, true,  true);

You need to add a header for 'true' and 'false'.


...

> +++ b/drivers/iio/dac/mcp47feb02.h

> +/* SPDX-License-Identifier: GPL-2.0+ */
> +#ifndef __DRIVERS_IIO_DAC_MCP47FEB02_H__
> +#define __DRIVERS_IIO_DAC_MCP47FEB02_H__
> +
> +#include <linux/bits.h>

Not used

> +#include <linux/mutex.h>

Not used

> +#include <linux/regmap.h>

> +#include <linux/regulator/consumer.h>

Not used

> +#include <linux/types.h>
> +
> +extern const char * const mcp47feb02_powerdown_modes[];
> +
> +/* Macro used for generating chip features structures */
> +#define MCP47FEB02_CHIP_INFO(_name, _channels, _res, _vref1, _eeprom) \
> +static const struct mcp47feb02_features _name##_chip_features =3D { \
> +       .name =3D #_name, \
> +       .phys_channels =3D _channels, \
> +       .resolution =3D _res, \
> +       .have_ext_vref1 =3D _vref1, \
> +       .have_eeprom =3D _eeprom, \
> +}
> +
> +/**
> + * struct mcp47feb02_features - chip specific data
> + * @name: device name
> + * @phys_channels: number of hardware channels
> + * @resolution: DAC resolution
> + * @have_ext_vref1: does the hardware have an the second external voltag=
e reference?
> + * @have_eeprom: does the hardware have an internal eeprom?
> + */
> +struct mcp47feb02_features {
> +       const char *name;
> +       unsigned int phys_channels;
> +       unsigned int resolution;
> +       bool have_ext_vref1;
> +       bool have_eeprom;
> +};
> +
> +extern const struct regmap_config mcp47feb02_regmap_config;
> +extern const struct regmap_config mcp47fvb02_regmap_config;
> +
> +/* Properties shared by I2C and SPI families */
> +int mcp47feb02_common_probe(const struct mcp47feb02_features *chip_featu=
res, struct regmap *regmap);
> +
> +extern const struct dev_pm_ops mcp47feb02_pm_ops;

Missed header for struct dev_pm_ops definition.

> +#endif /* __DRIVERS_IIO_DAC_MCP47FEB02_H__ */


--=20
With Best Regards,
Andy Shevchenko
