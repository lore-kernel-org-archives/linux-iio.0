Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D68B379C21
	for <linux-iio@vger.kernel.org>; Tue, 12 May 2026 07:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778569541; cv=pass; b=lACdz2p8+BID/IUkbysaE/JZFH4tWaGBtxfaMlHZi7jJUvXInNSGpmJ00ExZtxCasGXMPw9+sDd9hjJlGII+HFs0Hnz3uXJ89l7zYvbXsTsoRqb+ktfsjfM5CtRP/5QEuSrthxfFreWaPjCJq3o0yGbXFqfM0ffnSpWTbrOrfPI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778569541; c=relaxed/simple;
	bh=iUA4KanOx+PRFfzuu3dxsfCzyK7fuN7zilHuCkz4ENU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pFsZXAFApXn56mokypMZ2DX3ePDkKw3dFKlyAN2jUqf7yW6caCQSbK++WBosJyzz3jqe+d/1kuf3xpEPGcEsGut/Y99WwmYjNLUYW16KhjsAz12K5DyC+VW/JwhfZmqzJ8MNSixwKxfV5/ks+sD74OBJ0WRot7MTGv7jEyWbYyE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rxYqZB+/; arc=pass smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rxYqZB+/"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-67e2498f3a7so8535366a12.2
        for <linux-iio@vger.kernel.org>; Tue, 12 May 2026 00:05:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778569534; cv=none;
        d=google.com; s=arc-20240605;
        b=E6H0jmEx6YqmhwkMjlHdJj8VOdk1Dq4U6danbbPgydJBtqMhDXHvCUQbPDij2oiaAb
         OHg4N51qp6ULc/q4ivzUaBPHcdmzXByy/kuv+O058QfbylrQUeKmDioizk49eNAJnpN/
         GUagkqYFLNEfu7RuQmUgIcM823/2/STiZ1zfV8DVND+OayAsg1blUBZh71lMbousIY0V
         WWuxfbsAz24eE4j1CFQJmRkbJVeCw8LbDq+r7Ktjz/aPHwNM19y/k/c7VRnU+PJ/jFvE
         zs8SjMV76MA46yg5k/Q3qDX9psR2AOle3zeBOw19SBqwRYL1lP/Vv1U4fTay3H00po36
         K40Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4WKO48wCVFVY/Q3lQzIe4xzewKQpps/o90phN6WWe98=;
        fh=HV/Ky/zEVNHnO7G1I7EWhh66JfR/aL01V+sA3ShjNDo=;
        b=KXkXkoLXV9zU4fHspPWWRjWOvPa8Zm2c0VniyuJPg1u3EoS5N0dDxBDXVT/TYsjh3P
         lX7ml5/FlyM3a6GtlTsKubPM3ckYlm8sLhxEHKf6t/uWf3+mY2JIJPlbRgP5AslqPMrj
         /3ZDlvHCJHI+IWoevQo/KLv5lWjRHCq5ExKEXXX1xhjLIKX8giR4GD9zc3OXz8TYTn4Q
         YM8+Sq8CNVyJnFJmLtnNeUFViazpBhqosNQReF/8bFhIPpr4eVyK+gyxh13lyNQN+J3K
         g4V/KxQ2LMuGif6o/1ds6QAdGOHwDuC2/KiKKcAkl1kRJqo195ldX6y2d/vBTCysm5TB
         7AYA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778569534; x=1779174334; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4WKO48wCVFVY/Q3lQzIe4xzewKQpps/o90phN6WWe98=;
        b=rxYqZB+/UHFvOKizRzFW+V6ETszlYvcxLmNJyeZiLpObexJbJF04PmilU8HL5ysClb
         P+bWv3h2BLwYiI0+XqjR6wCDWdJSO32OOH4hzcuYXcFyD7gtQYBmVINNd4EiqMVS/ern
         4utktMp9gVUDnsM8TOIf6dbKmPPyZySlhmbfyy7D5lxJsc4Y4CQ1o4PGAbnxJaDCCSyl
         sIYyHYjZ13Q0RJ+mfzVDtX3H+6RW7nInH5BpyTb6/Y/F1TIATduf7V54wT3mhq9hEQqX
         wm4s0g9PXWmGppFSCReIatjLiMQ0XsDThgBbJjPbgM5j/Xhx+EmIXwTDbI/p9hTTC2Jb
         9w7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778569534; x=1779174334;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4WKO48wCVFVY/Q3lQzIe4xzewKQpps/o90phN6WWe98=;
        b=oi/e9APITQ0ev6XaEvPZRfqU2ADafgr78G+dTjHhlDKVgkK9qJgUjXG6aCxw2YXTel
         g5YMpifFFIfsQ4BYiNtBK31j6DpaPz8WWMUo6r8oDTpfG/LPPhTTrSbEQLOFZCOjjRZY
         tIgc+GAIlFj7YzJ9eEC2vuXWMZqYRyBb318MUglL6idyKDT2khO5SP+6+x/svR4R06tR
         LXRXjaIyRuXFV+GQSESieVo4IATA9Bajp7QqeWwOQVqnQl8T8SrzIAtzCdSwbPABxJFj
         eJfFcvIMNT41lewxO/0qeukX/k1jPO3l7dKRCE04/La2Z1it2maXGjQGz/5LRPL6qS7R
         +mnQ==
X-Forwarded-Encrypted: i=1; AFNElJ+X5cg5HKVu1gxXN6WsepsZYlSeooVwZczcIXbnL91KdPM5AU5bNy3Vok/gN7x7bw2X+rGjByJHmV0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxI4GU4tYGi3/om52XRFX+ymxIRGG3NbHOuuEuVSZipgW4MxVJ
	bVUrwaoakq/DkyIZrP+u0ZUfkNgwXWK0MvXWSjT4y6gkj7buHYVcdf5U3svzJaFbwpBisRwyAuS
	GmN61SrOL97k6tog9ym/ZD+Yd0hM8Kxs=
X-Gm-Gg: Acq92OHCH2SHeTZD5sFFq0BuK8u/LfoZG3/o9XHFhbeQQeWhxa+7qNjZuenf8E9fppb
	uJumL6q/rTm050DCdwwumh/p+MRwDJHlQwi2sfyGgaxzeaDJBC1dj1l833GTJqSBwgORAgN2ozB
	gYWXW9wH4UmnGGHgIRjIByojRg8xXYe6A3MN3sgxjnIF48aCFLo/p6xHrBorXea+07iB+pU+Evs
	aCwhUcRJRN96RY7RgJzDyz1V8CitPw10KOXaT/oTJsOd8RZA7m1Y8uL0hQpeSE6nUVC+HWb/jUC
	pnGQBcP/5MCJs3gJCDI3ShaLzLv9V3d2SYBa728NY0nsTLv4r/NtdRXt4jAtVHnBN+rOmRpmVlO
	KLE/NMp4=
X-Received: by 2002:a17:907:8b87:b0:bcd:2dbd:8241 with SMTP id
 a640c23a62f3a-bcd2dbd8f82mr647649566b.5.1778569533677; Tue, 12 May 2026
 00:05:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260512-mt6323-v2-0-3efcba579e88@protonmail.com> <20260512-mt6323-v2-7-3efcba579e88@protonmail.com>
In-Reply-To: <20260512-mt6323-v2-7-3efcba579e88@protonmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 12 May 2026 10:04:56 +0300
X-Gm-Features: AVHnY4Ir9Mq_UQabCQBoJYVIwG-u_PpfuUXY4u_xRVfJJhNKJhDnleR-UqRVa9w
Message-ID: <CAHp75VfgrbEDLavMKFp2maFCH08RBUxF2wYhh56GG1HCq4ogmA@mail.gmail.com>
Subject: Re: [PATCH v2 07/16] thermal: mediatek: add PMIC thermal support
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
> Add a new driver to support thermal monitoring on MediaTek PMICs.
>
> The driver retrieves calibration data from EFUSE, calculates the
> temperature using a linear interpolation, and registers the device with
> the thermal framework.
>
> Initial support is added for the mt6323 PMIC.

...

+ array_size.h

> +#include <linux/bitfield.h>
> +#include <linux/bits.h>
> +#include <linux/cleanup.h>
> +#include <linux/err.h>
> +#include <linux/iio/consumer.h>

> +#include <linux/kernel.h>

No way the driver(s) nowadays use this header. Please, drop it and add
the ones that are really in use (there are missing ones).

> +#include <linux/module.h>
> +#include <linux/nvmem-consumer.h>
> +#include <linux/platform_device.h>
> +#include <linux/property.h>
> +#include <linux/regmap.h>

> +#include <linux/slab.h>

Is it used?

> +#include <linux/thermal.h>

Missing types.h

> +#include <linux/units.h>

...

> +#define MT6323_ADC_VOLTAGE_RANGE       1800
> +#define MT6323_ADC_RESOLUTION          32768

These two ring a bell with the first code patch. Are they the same?
Can they be deduplicated?

...

> +       ret =3D iio_read_channel_processed(sensor->adc_channel, &raw);
> +       if (ret < 0) {

Do we need that ' < 0' part? What is the meaning of positive returned
value (if any) and why do we ignore that? Same question to all similar
checks in the whole series.

> +               dev_err(sensor->mt->dev, "failed to read iio channel: %d\=
n",
> +                       ret);
> +               return ret;
> +       }

...

> +       /*
> +        * Temperature coefficient. The o_slope is a trim value applied t=
o
> +        * the base calibration

Respect English grammar and punctuation. Here is the period missing.

> +        */

...

> +static int mtk_pmic_thermal_extract_efuse_mt6323(struct mtk_pmic_thermal=
 *mt,
> +                                                u16 *buf)
> +{
> +       u32 reg;
> +       s32 vts, degc_cali, o_slope, o_slope_sign, id;
> +       int ret;

Better to keep reversed xmas tree order.

> +       return 0;
> +}

...

> +static int mtk_pmic_thermal_get_calib_data(struct device *dev,
> +                                          struct mtk_pmic_thermal *mt)
> +{

> +       void *buf __free(kfree) =3D NULL;

This is a discouraged way of defining variables with __free(). See below.

> +       struct nvmem_cell *cell;
> +       size_t len;
> +       int ret;
> +
> +       cell =3D nvmem_cell_get(dev, NULL);
> +       if (IS_ERR(cell))
> +               return PTR_ERR(cell);

> +       buf =3D nvmem_cell_read(cell, &len);

Should be rather here

       void *buf __free(kfree) =3D nvmem_cell_read(cell, &len);

> +       nvmem_cell_put(cell);
> +
> +       if (IS_ERR(buf)) {
> +               ret =3D PTR_ERR(buf);
> +               buf =3D NULL;
> +               return ret;
> +       }
> +
> +       if (len < 2 * sizeof(u16)) {
> +               dev_err(dev, "invalid calibration data length\n");
> +               return -EINVAL;

return dev_err_probe(...);

> +       }
> +
> +       ret =3D mt->data->extract_efuse(mt, buf);
> +       if (ret) {
> +               dev_info(dev, "device not calibrated, using default value=
s\n");
> +               mt->data->precalc(mt, MT6323_DEFAULT_VTS,
> +                                 MT6323_DEFAULT_DEGC_CALI,
> +                                 MT6323_DEFAULT_SLOPE,
> +                                 MT6323_DEFAULT_SLOPE_SIGN);
> +       }
> +
> +       return 0;
> +}
> +
> +static int mtk_pmic_thermal_init_sensor(struct mtk_pmic_thermal *mt, int=
 id)
> +{
> +       struct mtk_pmic_sensor *sensor =3D &mt->sensors[id];
> +       struct device *dev =3D mt->dev;
> +
> +       sensor->id =3D id;
> +       sensor->mt =3D mt;
> +
> +       if (mt->data->num_sensors > 1)
> +               sensor->adc_channel =3D devm_iio_channel_get(dev, mt->dat=
a->sensors[id]);
> +       else
> +               sensor->adc_channel =3D devm_iio_channel_get(dev, NULL);

> +

Unneeded blank line as the above and below are coupled semantically.

> +       if (IS_ERR(sensor->adc_channel))
> +               return dev_err_probe(dev, PTR_ERR(sensor->adc_channel),
> +                                    "failed to get channel %s\n",
> +                                    mt->data->sensors[id]);
> +
> +       sensor->tzdev =3D devm_thermal_of_zone_register(dev, id, sensor,
> +                                                     &mtk_pmic_thermal_o=
ps);
> +       if (IS_ERR(sensor->tzdev))
> +               return dev_err_probe(dev, PTR_ERR(sensor->tzdev),
> +                                    "failed to register thermal zone %d\=
n", id);
> +
> +       return 0;
> +}

...

> +static const struct of_device_id mtk_pmic_thermal_of_match[] =3D {
> +       { .compatible =3D "mediatek,mt6323-thermal",
> +         .data =3D &mt6323_thermal_data },
> +       { /* sentinel */ },

No comma for the terminator entry.

> +};

--=20
With Best Regards,
Andy Shevchenko
