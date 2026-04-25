Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 923E32BEC2E
	for <linux-iio@vger.kernel.org>; Sat, 25 Apr 2026 19:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777144870; cv=pass; b=WyyrGUM4faVhA4mYs3/pv0XK7c32upF5N+zVgPL4DFwgeALXlCE/mHgihlsBPrd/Ns6YPHXW+e2sAgizsARIZLbXyupg/QrtdH8XrIDNKibT2CJaXvlFwRmOOBy2TJq3CPdBKIqVotEKmbORAQPgq+RDpG4hjc0Qe9om3VuY7iQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777144870; c=relaxed/simple;
	bh=hT7uT12Ym1Ze59UVydbqPT27VupcEIbnHrboOUruYoE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=usCqVE3ToPDiFM5E/8tUTOnLJjfVk5Jg4MukZAs5bnFCvPzbFN3UTlxwA4E5HJwK7qk+AmukH/ihKvzHA1ZhMBO/1JXoJLThzkWhGHZozltITxUsLQg+rrf69uek5n9UlSanr+ykgD/TZk8B92OCk1wWoM6HIDLhYjFeomc/ViI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rD52IDsX; arc=pass smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rD52IDsX"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-ba8472c1613so1193833166b.0
        for <linux-iio@vger.kernel.org>; Sat, 25 Apr 2026 12:21:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777144867; cv=none;
        d=google.com; s=arc-20240605;
        b=XF9ahcFCJiZ7BMnucTRgIZ0CsGtpIaYwziOf3NztUUZyP+9EYHL7KbqRWEVJKUWr47
         VHpQEbyOVnh3sIuR0JAl0ddJyOFr00ZSL+STZ33Mrv/CNFRtZYLD5rLX3NzkMUiQyG8/
         fXuRP7on2Cgh7NybSdnjNBS9WRBKJo456/JfGGA1g6zeBJup5oZXy5O+NWsM454yzxjL
         1a4GNCIt6fOkEi+uF/zAa6OFnIrFgJxD7JJq+PXmnZjM4tdLDkzpCwFPVkQDi3RBFJbF
         xKdQ8zxpBf2tcGYzscWsQkUbl1LoKadvAIO9fjXaD+IUrWueK1dqHF6Mxblg+rbvgI1R
         nDyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+8c6yWGMQo5L1X5gw5Y++BUlPK4zJUB8QavkHYAjxYo=;
        fh=cCXpmUf+xiR2m3tf14z01jrHKmfHBwBVcsBXeeVsMPE=;
        b=JCqHPO9sh1+bUjcmXYqyRki00W0fuvDRXEp7ynK/D783BeKrelxbtkwgMdQEFO3XAu
         p/y7m/NfHiyw/k4UVeQ9SVOSqxwy8UiCqbbnIC2FqD1fAPOis0OheEgwRIOuSpIh4O6r
         zYKWPzOo8FGN9hpZABjMWHzYW+VcxAzOrArWStme7Z+MXAjYTpkU+tLaYVneqgE8CQYB
         ePuBjsPLkvtlvXaui0akpP5dsuomm2np64XgkYIKsFwVPS6zvCd9syALW3Agt2arIt2W
         G8xJGmjCqLchYITN6/VcjhIYcnBJZ5/EBKPNCffqgabWPJD0WIrSlRxl3GlMYc5jaKeh
         jyyQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777144867; x=1777749667; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+8c6yWGMQo5L1X5gw5Y++BUlPK4zJUB8QavkHYAjxYo=;
        b=rD52IDsX4t6ces7Vj+am1/6yHhRtEAgyqXe5gv3lbyk8uKLbWCa+PUHP/ycQnHYBtc
         mN4iuZpSxB39WIxB5CZ5ROEr6Riaxsg0tQBBuTWlFr+/uW35ZRsQsYkcuJ4Z/2rJDlwM
         CrjSgrBB3LODLSqsDyC3sGQT++zE/dsNUQQqXLqSUQ255lTNNzl/E9Ky7RFzJ3WVBMQb
         6Zuyf4dPCTvyfWklwiWz8YeAhZHa7VQ/8ahHlto1yjXPqI5aBjQ9pIuOu4nlrlo0+tYt
         Pe9eVljuVPryK3OA2lE76C3kRohRRy3EgzSNhqi2bpZdKVFnAYb8l2qT3RPwpbdYundC
         HF1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777144867; x=1777749667;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+8c6yWGMQo5L1X5gw5Y++BUlPK4zJUB8QavkHYAjxYo=;
        b=X7JLUjzGxa1wg0xWck8pB1sq2LGo66Vm0XCKwqWb04KgzwD479PtA6L6L9A3atdgUQ
         fdaVkpGibpdo6yqYjtdfvYLUIwUeUO9OGufXIGwRMtLgr0Pkc4hTx/aG7jV7FAe7++W9
         JRbUdr7d8BAmO7IzdEuH3Hm3CaXdemoi2GoAAmp4z3foNvvuQlTh4WzD9V0NDkXm63AZ
         80rKTe7L4ROcrXo6oN1fZw0IrDKEHnor7V3p0c3OXU6n8ZoqCdgy0WCJcTkVwpZGmNcU
         /HCEJqXYWOZza+WWPsAS9X6mp7rZQ4aQW5pnCYgna2vgPzXf4XfQubXTYNevsLdrq1sp
         l47g==
X-Forwarded-Encrypted: i=1; AFNElJ/UUeD+YvohBXdgqbQoQ2O5horxmtVfQZ9qO1WMEhbjgPx2W373+oXYWqGpgez1XHVueNjYj2LIZWk=@vger.kernel.org
X-Gm-Message-State: AOJu0YweS6Tt02kz/+i/F0qS8CyEMSXpw8Gr80YXcZpJy0QHn1P5rf55
	364XPyxXyVuk+a+h6qkU8Xxla8wTWS1lfcCwTavxPnLbtPNq41BXxtqgJwtZJZnjVnp/8n9Tfp2
	UCi7eEBAoE+E0LDLXiNWShPrqc2e+SAs=
X-Gm-Gg: AeBDievfLidhXwygj2KdaEP4eiDPyey/OjAuDqIfEc/Ge0qFu9UebnOvDWFWNy98B5m
	Hu2siY9yeN1F0EEUxLrFVrri5YOXBH65S6l4Lt93tHsyV1MF7b8GD1ZMSCzuV0lfnUdTMKHMrsb
	bZos3pQxD8jdv/rinjMi8Mjma4h0xQ//9T95CcsHy7Yn41v8WiCxX1asbPtiWL1hUOB6AQPWSdv
	O5Gqs/frSIKqxya7bBwTfBH/EdyEixNhEbnk+U7/HohAFJYs4gfyaCysmlRQ1GBGi1goAnjhX0n
	JQp+44PJ3X645vLzWwAyq8OCKfWv5tWy+9XMz0niFgkZcDL0bTAvn0r3yLvXJMNSC0x3nuDacKy
	TfO4MRVOVqe768KN7HwLwEhPuoevhzVVs/9Kkacrv4T5dlwJ5
X-Received: by 2002:a17:907:7f86:b0:bae:2aac:3cfc with SMTP id
 a640c23a62f3a-bae2aac3d84mr333598766b.3.1777144866692; Sat, 25 Apr 2026
 12:21:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260426-meson_saradc-v1-1-6e96b2982c43@gmail.com>
In-Reply-To: <20260426-meson_saradc-v1-1-6e96b2982c43@gmail.com>
From: Rosen Penev <rosenp@gmail.com>
Date: Sat, 25 Apr 2026 12:20:55 -0700
X-Gm-Features: AQROBzBWERVyzPtDfabAtbUn-NQMbd1-MjW_pzWLW_K4WY_b7oYxhF49AZGCCKg
Message-ID: <CAKxU2N9_Nmk_apUZLSCGssXpwxYOz9k99ggRcUM3EPGUzaVi7w@mail.gmail.com>
Subject: Re: [PATCH] iio: adc: meson-saradc: fix calibration buffer leak on error
To: Felix Gu <ustc.gu@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>, linux-iio@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 25, 2026 at 9:07=E2=80=AFAM Felix Gu <ustc.gu@gmail.com> wrote:
>
> meson_sar_adc_temp_sensor_init() allocates a buffer with
> nvmem_cell_read(), but the old code leaked it if
> syscon_regmap_lookup_by_phandle() failed.
>
> Switch buf to __free(kfree) so all return paths release it.
>
> Fixes: d6f2eac64403 ("iio: adc: meson: no devm for nvmem_cell_get")
> Signed-off-by: Felix Gu <ustc.gu@gmail.com>
> ---
>  drivers/iio/adc/meson_saradc.c | 10 +++-------
>  1 file changed, 3 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/iio/adc/meson_saradc.c b/drivers/iio/adc/meson_sarad=
c.c
> index 23991a3612bd..9708ddcc4919 100644
> --- a/drivers/iio/adc/meson_saradc.c
> +++ b/drivers/iio/adc/meson_saradc.c
> @@ -786,7 +786,7 @@ static int meson_sar_adc_clk_init(struct iio_dev *ind=
io_dev,
>  static int meson_sar_adc_temp_sensor_init(struct iio_dev *indio_dev)
>  {
>         struct meson_sar_adc_priv *priv =3D iio_priv(indio_dev);
> -       u8 *buf, trimming_bits, trimming_mask, upper_adc_val;
> +       u8 trimming_bits, trimming_mask, upper_adc_val;
>         struct device *dev =3D indio_dev->dev.parent;
>         struct nvmem_cell *temperature_calib;
>         size_t read_len;
> @@ -807,14 +807,12 @@ static int meson_sar_adc_temp_sensor_init(struct ii=
o_dev *indio_dev)
>         }
>
>         read_len =3D MESON_SAR_ADC_EFUSE_BYTES;
> -       buf =3D nvmem_cell_read(temperature_calib, &read_len);
> +       u8 *buf __free(kfree) =3D nvmem_cell_read(temperature_calib, &rea=
d_len);
>         nvmem_cell_put(temperature_calib);
>         if (IS_ERR(buf))
>                 return dev_err_probe(dev, PTR_ERR(buf), "failed to read t=
emperature_calib cell\n");
> -       if (read_len !=3D MESON_SAR_ADC_EFUSE_BYTES) {
> -               kfree(buf);
I don't like this. Just add the missing kfree.
> +       if (read_len !=3D MESON_SAR_ADC_EFUSE_BYTES)
>                 return dev_err_probe(dev, -EINVAL, "invalid read size of =
temperature_calib cell\n");
> -       }
>
>         priv->tsc_regmap =3D syscon_regmap_lookup_by_phandle(dev->of_node=
, "amlogic,hhi-sysctrl");
>         if (IS_ERR(priv->tsc_regmap))
> @@ -835,8 +833,6 @@ static int meson_sar_adc_temp_sensor_init(struct iio_=
dev *indio_dev)
>         priv->temperature_sensor_adc_val |=3D upper_adc_val << BITS_PER_B=
YTE;
>         priv->temperature_sensor_adc_val >>=3D trimming_bits;
>
> -       kfree(buf);
> -
>         return 0;
>  }
>
>
> ---
> base-commit: 7080e32d3f09d8688c4a87d81bdcc71f7f606b16
> change-id: 20260425-meson_saradc-54abc52d9b31
>
> Best regards,
> --
> Felix Gu <ustc.gu@gmail.com>
>
