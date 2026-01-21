Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3588D47DD51
	for <linux-iio@vger.kernel.org>; Wed, 21 Jan 2026 09:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768988202; cv=none; b=Dp1otqqhw2Vr/8Yibu14Duxpk2UBxArho7y1i9HHpnk2TIkxWZxXOXcJehG2574fvPSL3tDK/SwZRcDnzgP7E3Vbzka6H/ItXvzu8fLmjFrdwQZRZdXxgCISB5Vo1/snuWdCi7AXNauC+yrnRh1+kVHLhSc2Wi9JRQvXY0vfeqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768988202; c=relaxed/simple;
	bh=yE2jimWsaI2+yxIq+nktbusIlZVw+xsH1gxX33vVkVE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FOiwn3rYAsmq0O59kteAkKeY6fqkBmWJgaMtpzndAo9OEMn18doxydiGztsnKbhXUfBxyahWhIi545Z7fNj6yfxP8e8ni9wPQd+tnfpSJicF86evW7qSo2wMe3ghCPF6c1n9xcXO66Hdari5evvb1DMHC6+DvMK9g0MnS7/n1ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sp9HckxR; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sp9HckxR"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-42fbc305882so3588054f8f.0
        for <linux-iio@vger.kernel.org>; Wed, 21 Jan 2026 01:36:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768988198; x=1769592998; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yE2jimWsaI2+yxIq+nktbusIlZVw+xsH1gxX33vVkVE=;
        b=Sp9HckxR3dkTufTRNlf4+B9i7MmHdTa5nQGAMMg1esOg0ZMBsa1lzMMOGidMhkM0yi
         tpQ/A7MF4Ud8f0QO9dUuGWh6y+EGNnJdyZJO8ir3TWSxVrPPzZC1nhwTB6ltqbH79vo4
         cet5n2KcpxJaylyruLbdIoNh1wn0FaUoSNtKYnPWvTW8P1jM76KBByLJMDwMHceTkR6D
         HwyEpfFzNCX/PfIvw07M8CN8KKgimIe32VyDaQLw0txNb1YtsbopVH6bO61Pq0DibZNG
         OYbYKg2D0hAZG6Mrix4Cuhk3kar1XbLG2Wsz7e9Y8QzsXjtJoZ51wAaA/Ys3v92HsqUU
         6XoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768988198; x=1769592998;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yE2jimWsaI2+yxIq+nktbusIlZVw+xsH1gxX33vVkVE=;
        b=Pzk46bVexGIFxFwM2JP8XS5IfBTT6ky6J5al4ImOr09lULEbX/k6Yhw7SS6rp73yfo
         oVaz0CaLyJz2tqvtWybO2Rmoh7vUr3CdSqgTRhPmhYndycr5iDI7/2/nQMFgSvN/Hr0z
         r5rwBgyOjE/4m/hCiLUonLj/D3W2H0Qv3qAgWBbHBBIXGAe+mfQdd+jMASdWwumjPGl/
         4noLxFstvsJOakKIIBp8Q6S715E1lniwoS/yRRlcJo2gTznab6w0Eb6y6pAFTf7BZLJz
         JNLmeh72v7Zb8yBHclcYV97CJgSbxTTnl0O0RXA3237SCsCce3S2qs38Vt7P3RTAEbX/
         G7Sg==
X-Forwarded-Encrypted: i=1; AJvYcCVmHXkdRkYKe4/M2T1ys3NDdnJdZAFNOY+tx8Oy0TF+Ituzb1kq5XLsmD+WNMq9NVD1qWA3xyE/eV0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0Ci1uS2EIE6g+YlfjuMaqDJowi1hiHtTHJ892Fh5X6i9nRjbY
	a6m+qFVwsr/xuY01pCyV05zGHGQ7UFo8LDl6oUcQCmLYLaXv7CiVjterP3jFWw==
X-Gm-Gg: AZuq6aLD/XJmtE80s0vp3Qh+8qIdfvP5PFuz8pyKPbL6VNhlnlZv34JdfQnBmNgE6mg
	Vejr+AlGz7B+9hr6kgxkkcFXwS47a3I8hAzbUjUaHSscBlfPMyqak4w1k9L7H9guHnUoXVNk/IS
	Ujyrp00FcRbrDmn9FEr/OGA11crMFf/GK8Kemq7mGV3GqxPigbUXM7Ius0QhKAoaBiUvh0WWVdw
	bmF0YMdvneUWWv5nk8ZJdOYhYTjVZW7RyFnxJVj59XlvZ5iK8wV4wCZKLi0WcWZ7BNoOYz6dJF4
	/HrRG9mMHeU6a190fyiGfSdhV7A20b0bvWtYVW1sI9NsS02WHZ+4ajz8ukMBrUTmJjwyH7rq38N
	FGwO1no75spq/GPxOh275bZfVYUEBsfKfqLHTfHuxiMv0aJnQ17/txba+Esq1ga/n9YBb9fXN9v
	r9VCYfYiuXgVmtHcKtyqQ=
X-Received: by 2002:a05:6000:26c6:b0:431:8f8:7f17 with SMTP id ffacd0b85a97d-43569972bcdmr24393323f8f.10.1768988198312;
        Wed, 21 Jan 2026 01:36:38 -0800 (PST)
Received: from [192.168.1.187] ([148.63.225.166])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43597bda41esm5655062f8f.28.2026.01.21.01.36.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jan 2026 01:36:38 -0800 (PST)
Message-ID: <89701e42f0481cb964c2077071a2ca75c95e6b13.camel@gmail.com>
Subject: Re: [PATCH 04/11] iio: adc: max1027: Improve include relevance
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org, Andy
 Shevchenko <andy@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?ISO-8859-1?Q?S=E1?=	
 <nuno.sa@analog.com>, Mike Looijmans <mike.looijmans@topic.nl>, Liam Beguin
	 <liambeguin@gmail.com>, Miquel Raynal <miquel.raynal@bootlin.com>, Ibrahim
 Tilki <Ibrahim.Tilki@analog.com>, Cosmin Tanislav
 <cosmin.tanislav@analog.com>,  Alisa-Dariana Roman
 <alisadariana@gmail.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>
Date: Wed, 21 Jan 2026 09:37:21 +0000
In-Reply-To: <20260119212110.726941-5-jic23@kernel.org>
References: <20260119212110.726941-1-jic23@kernel.org>
	 <20260119212110.726941-5-jic23@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2026-01-19 at 21:21 +0000, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>=20
> Drop kernel.h in favor of more specific headers and add includes that wer=
e
> previously relying on other headers including them.
>=20
> Whether to include device.h or the relevant sub headers is non obvious.
> In this case, there is an access to struct device for
> spi->dev.driver->name which is used to name the irq.
>=20
> The justification from iwyu for the additional includes is:
> =C2=A0 #include <asm/byteorder.h>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 // for be16_to_cpu
> =C2=A0 #include <linux/array_size.h>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 // for ARRAY_SIZE
> =C2=A0 #include <linux/bitops.h>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 // for BIT, GENMASK, fls, hweight32
> =C2=A0 #include <linux/cleanup.h>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 // for guard
> =C2=A0 #include <linux/compiler.h>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 // for __aligned
> =C2=A0 #include <linux/completion.h>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 // for complete, init_completion
> =C2=A0 #include <linux/device.h>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 // for dev_err, dev_name, devm_kmal. ..
> =C2=A0 #include <linux/errno.h>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // for ENOMEM, EINVAL, EBUSY, ETIME...
> =C2=A0 #include <linux/interrupt.h>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 // for devm_request_irq, irqreturn
> =C2=A0 #include <linux/jiffies.h>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 // for msecs_to_jiffies
> =C2=A0 #include <linux/minmax.h>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 // for __cmp_op_max
> =C2=A0 #include <linux/mutex.h>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // for class_mutex_constructor, cla...
> =C2=A0 #include <linux/stddef.h>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 // for NULL, false
> =C2=A0 #include <linux/types.h>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // for u8, bool, __be16
>=20
> stddef.h not directly included as few drivers do this.
>=20
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
> =C2=A0drivers/iio/adc/max1027.c | 16 +++++++++++++++-
> =C2=A01 file changed, 15 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/iio/adc/max1027.c b/drivers/iio/adc/max1027.c
> index 913665b52cea..22d90efc9ab6 100644
> --- a/drivers/iio/adc/max1027.c
> +++ b/drivers/iio/adc/max1027.c
> @@ -12,11 +12,23 @@
> =C2=A0=C2=A0 * Partial support for max1027 and similar chips.
> =C2=A0=C2=A0 */
> =C2=A0
> +#include <linux/array_size.h>
> +#include <linux/bitops.h>
> +#include <linux/cleanup.h>
> +#include <linux/compiler.h>
> +#include <linux/completion.h>
> =C2=A0#include <linux/delay.h>
> -#include <linux/kernel.h>
> +#include <linux/device.h>
> +#include <linux/errno.h>
> +#include <linux/interrupt.h>
> +#include <linux/jiffies.h>
> +#include <linux/minmax.h>
> =C2=A0#include <linux/module.h>
> =C2=A0#include <linux/mod_devicetable.h>
> +#include <linux/mutex.h>
> +#include <linux/printk.h>

To be consistent, the above should also be in the commit message.

- Nuno S=C3=A1

> =C2=A0#include <linux/spi/spi.h>
> +#include <linux/types.h>
> =C2=A0
> =C2=A0#include <linux/iio/iio.h>
> =C2=A0#include <linux/iio/buffer.h>
> @@ -24,6 +36,8 @@
> =C2=A0#include <linux/iio/trigger_consumer.h>
> =C2=A0#include <linux/iio/triggered_buffer.h>
> =C2=A0
> +#include <asm/byteorder.h>
> +
> =C2=A0#define MAX1027_CONV_REG=C2=A0 BIT(7)
> =C2=A0#define MAX1027_SETUP_REG BIT(6)
> =C2=A0#define MAX1027_AVG_REG=C2=A0=C2=A0 BIT(5)
