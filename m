Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D79C3DE43D
	for <linux-iio@vger.kernel.org>; Wed, 11 Mar 2026 11:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773230315; cv=none; b=YKeJ8DPSh5WKOH73RmAM6CWzTcMt4BjyiG6r547KCCdISoD+vd2/ux7LD3F+9LdU9oOTA5VuDR/Cc9+mDV9DDjESxHb1pyEiUCyE8kr+9P6iu6VzP8/AUae+/xWImkDnHZMWRsa8/XDcASy5X+y4QEXBC2W8tHChKjYqo8zkoVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773230315; c=relaxed/simple;
	bh=mcUVNnzpe3gSLeudat/9NanXNzDk3rC08yiK2QQcH8g=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mZgPZT1zbQB2De6RDJOj2xbH9BtNl9eM1RuXx2fG9ZJxJcbaotrwy2M5TP5VMfhKRhB3ruzTRukxeeesZdFcfc/p4HzKoahOHUVGzVuEr7dffrfi47E47Rq5daZ/7VH2wt4ysnisTUjRiZeqpZX1ywGWVnSXk5e9zvDkWSG64Cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QvojUTFv; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QvojUTFv"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-89a0ecbc713so11459626d6.1
        for <linux-iio@vger.kernel.org>; Wed, 11 Mar 2026 04:58:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773230313; x=1773835113; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Kzn6AZnRX682NhBNc83If833FpVW7jRXEbyOc+GAJ9E=;
        b=QvojUTFvQZ479hDVjlaWEl4GXrbgwQMHFr/QZx1DvYem+JuVOnvAhpQgVUrJa39fIO
         OBncVvxYKl3rYnrIrHgr+LYt5SIDT7B983E+sTIRIQF8ZsA8FUbxqgVzzqaPXJM1MUxJ
         fAs6/mX4vCo5wwMdBfudNU802YWgmhv63DbJcrag/FkHQjdnMHOw+tkyZruWBOLQeBNf
         MK9RkDPO9shwux7gUxAMuFi+l4nP0UtvnJTXN/HKeGNa9CMsSidJG9km6w4tC7hlhaqz
         Pfyk669nCQ86E443PPk8AUslfVzdVBSK6oVTogG3ClDKX1eamBBnC7DEhBCRqOBspZBk
         0SzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773230313; x=1773835113;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Kzn6AZnRX682NhBNc83If833FpVW7jRXEbyOc+GAJ9E=;
        b=pcWrM2PcBBRY798g4JCDS1cmQlVYkecFFSz3U7vnvaWQewppvru7zfe2IRzelJNVUC
         NWfh+xnDjayNW8NZczneRboT6lOwxl6SUFKatwFutUWPF5cBicfZUgf+lIefT5Zv1kEO
         0vFYFQq03Ib2sEnZ27hT9jgUJjYJVvyv5VEBtkipOrHPikEgIucNq65wtgg0YCiHMn4I
         rQd156BQtg43EWCPIN4qHgulauHcksBo/8q9vwQ/JRtapR/k395bByi4cG+qek+dbKAm
         NYiStBDehHs7gruyv/IH5hBBVWJ8U1TKvM6+fBhHlFhmqer3EVDBO/WwoNWaDPbuc0AX
         T2Zg==
X-Forwarded-Encrypted: i=1; AJvYcCW8srPZ8V6UpVf0oE4I+vGLfQuNQUBsa4217qqhM2Ie48scoUWnl4ENT4txU7XiZBb3kAAsHCXHZ/k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRd6wJgsv/0RQBsEO73lfnZ1bY7x1cHfECWwbqsFrP3X6VQgPJ
	brgEV92jrXX9epyid6dhuh7mC8xqssXHkDB+4aidF8FJ8Y9iBOOKJ/YBR6hlhmST
X-Gm-Gg: ATEYQzx+LfIKuQD8SjSA1xEhSuAg/uX8m+m+IJbB9PJWgfUPcvoYdNXArwV2ryI6b3J
	goJ/cRDGVksA6rSwIqa/AVDav7TCHGOEFsBBFzIaE1vwwTYMFLkCRl65PIVaL9Dsy6b6bQS4xnV
	ZA1JMS7x7wKJt1tU7Fxi6HkQhnx+/4K1x29wYVzYSGISnVPy3YvYWKCz1KfeXCiyYI0vwJAVc8e
	RDXEFk0BXT7DYliwNeK+zQTAAuCfFfgPD7GM8+3hTYsHhP6gVVPPuQGpxaVPLgRv4Gk6cxFfriE
	QLbFOdGd5nTZSS+yQ/AdpR1QYqiye1520iJtyjk0fg719dxPpRNL15SJqfRlBKxdvN9NZ975Zs0
	D56i9Lkxj3dQeHkSGXyLJPRm/d2ZMiKd6tDPpZu8FjjBH+li7fQYzp++JOByq8f1M+xqP/Z7chS
	MNC9VQoRhGiD6YMZkbdq9dyl/j+ODxxg8=
X-Received: by 2002:a05:6214:1946:b0:899:f495:1a17 with SMTP id 6a1803df08f44-89a57c3b5f2mr94078516d6.15.1773230313230;
        Wed, 11 Mar 2026 04:58:33 -0700 (PDT)
Received: from [192.168.1.187] ([148.63.225.166])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89a65cd7f49sm12612136d6.34.2026.03.11.04.58.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 04:58:32 -0700 (PDT)
Message-ID: <de45c101d1e54b5aaff94326708042f90e8aa74a.camel@gmail.com>
Subject: Re: [PATCH v2 5/5] iio: dac: ad5504: add optional GPIO control for
 CLR and LDAC
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Taha Ed-Dafili <0rayn.dev@gmail.com>, lars@metafoo.de, 
	Michael.Hennerich@analog.com, jic23@kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org
Cc: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org, 
	skhan@linuxfoundation.org, me@brighamcampbell.com,
 linux-iio@vger.kernel.org, 	devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Wed, 11 Mar 2026 11:59:15 +0000
In-Reply-To: <20260310174835.24209-6-0rayn.dev@gmail.com>
References: <20260310174835.24209-1-0rayn.dev@gmail.com>
	 <20260310174835.24209-6-0rayn.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2026-03-10 at 17:48 +0000, Taha Ed-Dafili wrote:
> Add support for the optional 'clear-gpios' and 'ldac-gpios' properties
> defined in the device tree bindings.
>=20
> Use devm_gpiod_get_optional() with GPIOD_OUT_LOW to ensure the pins are
> initialized to their inactive state.
>=20
> Signed-off-by: Taha Ed-Dafili <0rayn.dev@gmail.com>
> ---
> =C2=A0drivers/iio/dac/ad5504.c | 14 ++++++++++++++
> =C2=A01 file changed, 14 insertions(+)
>=20
> diff --git a/drivers/iio/dac/ad5504.c b/drivers/iio/dac/ad5504.c
> index cd563460fc0a..58538f5263fc 100644
> --- a/drivers/iio/dac/ad5504.c
> +++ b/drivers/iio/dac/ad5504.c
> @@ -7,7 +7,9 @@
> =C2=A0
> =C2=A0#include <linux/bits.h>
> =C2=A0#include <linux/device.h>
> +#include <linux/err.h>
> =C2=A0#include <linux/errno.h>
> +#include <linux/gpio/consumer.h>
> =C2=A0#include <linux/interrupt.h>
> =C2=A0#include <linux/kernel.h>
> =C2=A0#include <linux/mod_devicetable.h>
> @@ -48,6 +50,8 @@
> =C2=A0 * @vref_mv:		actual reference voltage used
> =C2=A0 * @pwr_down_mask:	power down mask
> =C2=A0 * @pwr_down_mode:	current power down mode
> + * @gpio_clear:	GPIO descriptor for the /CLR pin
> + * @gpio_ldac:		GPIO descriptor for the /LDAC pin
> =C2=A0 * @data:		transfer buffer
> =C2=A0 */
> =C2=A0struct ad5504_state {
> @@ -56,6 +60,8 @@ struct ad5504_state {
> =C2=A0	unsigned short			vref_mv;
> =C2=A0	unsigned			pwr_down_mask;
> =C2=A0	unsigned			pwr_down_mode;
> +	struct gpio_desc		*gpio_clear;
> +	struct gpio_desc		*gpio_ldac;
> =C2=A0
> =C2=A0	__be16				data[2] __aligned(IIO_DMA_MINALIGN);
> =C2=A0};
> @@ -299,6 +305,14 @@ static int ad5504_probe(struct spi_device *spi)
> =C2=A0	if (pdata && pdata->vref_mv)
> =C2=A0		st->vref_mv =3D pdata->vref_mv;
> =C2=A0
> +	st->gpio_clear =3D devm_gpiod_get_optional(dev, "clear", GPIOD_OUT_LOW)=
;
> +	if (IS_ERR(st->gpio_clear))
> +		return PTR_ERR(st->gpio_clear);
> +
> +	st->gpio_ldac =3D devm_gpiod_get_optional(dev, "ldac", GPIOD_OUT_LOW);
> +	if (IS_ERR(st->gpio_ldac))
> +		return PTR_ERR(st->gpio_ldac);
> +

Fine having the above in bindings but as it stands now, not seeing the purp=
ose of
having it in the driver. We're not handling these gpios at all.

- Nuno S=C3=A1
>=20
