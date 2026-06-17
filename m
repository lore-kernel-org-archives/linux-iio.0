Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0769B2E7366
	for <linux-iio@vger.kernel.org>; Wed, 17 Jun 2026 22:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781735989; cv=none; b=gVZTIN1J8cqkvExdpjsNQ1Ah9np37hvuOqm0RiqdSKkN/F1A8SXHpOr9OVemJbXX+OLsawINCHiLWh2JAaMAbQ66FnBx23JeqQcDk4NNBKv+euws014yLgtEZnXFWxW74E15nhXGJUBXHq26MNyoUs6Ggl44sWV6MF6nQoX2mGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781735989; c=relaxed/simple;
	bh=dK3ZVHC2+yjIeAkZAQyp5QYaZMYe9UWFF9c+QJVlVB8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MpC4yI71615JKyKqsP6keIqzSBF5Z70ca1TeD4u1AvGGwgLrUUfDyjxIruHehOnkC4vjGR3D1lGnfobnV/Fgx6jEegTehIPwwLpXdMgHkiYCMf0CTPX23AG5cWRUA1vzyZ3Tn1m0LhDVXIF5YXJV3PqSFmeycfRXVdU741IzXVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=YZggMySd; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="YZggMySd"
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-441b5b4af7aso137030fac.3
        for <linux-iio@vger.kernel.org>; Wed, 17 Jun 2026 15:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1781735986; x=1782340786; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nF/Q+/JmKyCTSBbxyYiT7cadNyPaZLke2/CQXqkm8VQ=;
        b=YZggMySdA9ULGF4Hcl2egzvgkrzF2hR9WcVO7txWuohatKtEMau8a2fS+HJFIc9c55
         CdFx8Iqe9sn0rQF8+ktEtpmad/Od2afqCzyoX5xhdaZ1OwBv/yD/ZimZjgVfYLw1iS6G
         heMV6ERXTu5SjmeoEv/xdkrrfy7glBaY95iPYyG8yKVm8I7QM3k/N6ACpPZn56Unyj06
         yDHX8T/5LWygNh9YKjAMeoASeOBVtOty+9Cp6WRgMP+hcQ0BOY+FY1yfP+yqjjqdYlIo
         ni2p5C8uRGGg1YCnjjs79kwx/BC51ezyhmXT0/efkDQWoOXqNJuuUtpmL0PqMO/kfDRu
         Ey9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781735986; x=1782340786;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nF/Q+/JmKyCTSBbxyYiT7cadNyPaZLke2/CQXqkm8VQ=;
        b=ia2dv5mg+AllxWLNiFTJhGV0nvM5oXr02vH7fU2Umy392WEoWP1yTfH8qr7dzpq+Gv
         z7xwBr28fojGPN+ehpw11PQLrX0wyZ8pELPjr0NvZ5zcR4jxR2h6lxKVMc+CxtGsm/yJ
         UC8jIcLMlthPnv9BFvEtELHUKlj/EGPTmjz2DqZsz6zgrNShdZCGxVbNuU9axiA/VDPe
         zazi9qhLn/TSbHP7jl0bNvRoIpTNV1y8cW83577Vhg5zdiDvkwzIHBL8MM+89NWFPdgj
         rKQ+MqRwLjfrWm3u6sgx8NuAZiPRnNpwYWCttHR98GOhCW10/LXO8mwFki3nnOJSL1H+
         ebow==
X-Forwarded-Encrypted: i=1; AFNElJ97vZHenK0VzAshoPDIV9tH6qu84aGM2u2xqgmYdvzKVmH8N0sWEQgDRbhFYb5rhSz4gy+eFdR+npA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJFb2/cfFVg0Jdp3jxCvJRNG543UgwAJNtqbfODWHAZmRSGfhR
	SvaOD9vYj5zVWCc17nxx8oI68H0C57+607n6j2yK+OBF1MNNcrZ6SNcMNCY/MoUz9HY=
X-Gm-Gg: AfdE7cmcEQg+2Nu+ZEfyS2fmTGAyLTQ9Zj8vCWS6IULGWhQUe1xAPsPQWccRibuhCO/
	ya/XZO+uf8sO6JbWS0bJXKxczgSGQOCxJIoTpzmzkIpfov65beh0H4jv+76sd/P60ptQoxRsFjl
	2iLh7oBAOhdJYYubiINvy3JwWf0MaWQWASNXmVKwo1+kyMmAgwPkhyNWtGSYc3YPmlVKcTaw+PF
	6eS/GKjqW6xIMCXmqG2dX6cVbe2r3+/iVWhKES0R4PhYhBLJrPDVjaVzJY5ZYql5KnxKW4jl2Kv
	U47J2AjbNyNS1iEjhPYCEEi+uZadtR1o2PHoWkmHTgmz58wdpEy07u/t+S38zVAUaWwZ4YvJnhz
	opI/HZGDXcAUGAi5IdcJjlJF1IN2D0ITrRnXkai/+mSOxuEcJg5tc7ySGSXJ579R633o6jzSVWq
	g1AnNC+gZqMApMS3EY6AsjDYR23PhwcfgL7oN4nJ3+vOSGsPIHFwJ28etDNC3tzaU=
X-Received: by 2002:a05:6870:f624:b0:434:482:ecbd with SMTP id 586e51a60fabf-4466bee8fe4mr4406884fac.6.1781735985994;
        Wed, 17 Jun 2026 15:39:45 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:9458:d356:778c:22ac? ([2600:8803:e7e4:500:9458:d356:778c:22ac])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-44308a66401sm5452397fac.3.2026.06.17.15.39.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jun 2026 15:39:45 -0700 (PDT)
Message-ID: <4f7f50ad-c305-4947-b4e9-3666a4f31031@baylibre.com>
Date: Wed, 17 Jun 2026 17:39:44 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/5] iio: adc: ltc2378: Enable triggered buffer data
 capture
To: Marcelo Schmitt <marcelo.schmitt@analog.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: jic23@kernel.org, nuno.sa@analog.com, Michael.Hennerich@analog.com,
 andy@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 pop.ioan-daniel@analog.com, marcelo.schmitt1@gmail.com
References: <cover.1781661028.git.marcelo.schmitt@analog.com>
 <22248e8ba646fbe8edfc87e2b9be527632d5b48c.1781661028.git.marcelo.schmitt@analog.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <22248e8ba646fbe8edfc87e2b9be527632d5b48c.1781661028.git.marcelo.schmitt@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/16/26 9:04 PM, Marcelo Schmitt wrote:
> Enable users to run triggered data captures with LTC2378 and similar ADCs.
> 
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> ---
> Change log v2 -> v3:
> - Extracted from main driver file into a separate buffer-specific containment.
> 
>  drivers/iio/adc/ltc2378-lib-core.c         | 17 +++++++-
>  drivers/iio/adc/ltc2378-triggered-buffer.c | 49 ++++++++++++++++++++++
>  drivers/iio/adc/ltc2378.h                  | 15 +++++++
>  3 files changed, 80 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/iio/adc/ltc2378-triggered-buffer.c
> 
> diff --git a/drivers/iio/adc/ltc2378-lib-core.c b/drivers/iio/adc/ltc2378-lib-core.c
> index 1160f4324d01..ec83e9f2ae81 100644
> --- a/drivers/iio/adc/ltc2378-lib-core.c
> +++ b/drivers/iio/adc/ltc2378-lib-core.c
> @@ -18,7 +18,7 @@ int ltc2378_lib_buffer_setup(struct iio_dev *indio_dev, struct ltc2378_state *st
>  
>  	ret = __ltc2378_set_offload_ops(st);
>  	if (ret == -EOPNOTSUPP)
> -		return 0; /* Let device setup complete without buffer support */
> +		goto trigger_buf_setup;
>  
>  	if (!ret)
>  		ret = st->ops->buffer_setup(indio_dev, st);
> @@ -27,6 +27,21 @@ int ltc2378_lib_buffer_setup(struct iio_dev *indio_dev, struct ltc2378_state *st
>  		return dev_err_probe(dev, ret, "error on SPI offload setup\n");
>  
>  	return 0;
> +
> +trigger_buf_setup:
> +	ret = __ltc2378_set_triggered_buf_ops(st);
> +	if (ret == -EOPNOTSUPP)
> +		return 0; /* Let device setup complete without buffer support */
> +
> +	if (!ret)
> +		ret = st->ops->buffer_setup(indio_dev, st);
> +
> +	if (ret)
> +		return dev_err_probe(dev, ret, "error on buffer setup\n");

This is repeating the code above. Seems like it would be better without
the goto.

> +
> +	st->chans[st->num_iio_chans++] = IIO_CHAN_SOFT_TIMESTAMP(1);

Adding a channel here seems messy. I still think static const channel
data would be better. But at least would be better if this was moved
to the same function as the other channel setup.

> +
> +	return 0;
>  }
>  EXPORT_SYMBOL_NS_GPL(ltc2378_lib_buffer_setup, "IIO_LTC2378");
>  
> diff --git a/drivers/iio/adc/ltc2378-triggered-buffer.c b/drivers/iio/adc/ltc2378-triggered-buffer.c
> new file mode 100644
> index 000000000000..d1d788fb5cb4
> --- /dev/null
> +++ b/drivers/iio/adc/ltc2378-triggered-buffer.c
> @@ -0,0 +1,49 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (C) 2026 Analog Devices, Inc.
> + * Author: Marcelo Schmitt <marcelo.schmitt@analog.com>
> + */
> +
> +#include <linux/iio/buffer.h>
> +#include <linux/iio/triggered_buffer.h>
> +#include <linux/iio/trigger_consumer.h>
> +
> +#include <ltc2378.h>
> +
> +static irqreturn_t ltc2378_trigger_handler(int irq, void *p)
> +{
> +	struct iio_poll_func *pf = p;
> +	struct iio_dev *indio_dev = pf->indio_dev;
> +	struct ltc2378_state *st = iio_priv(indio_dev);
> +	int ret;
> +
> +	ret = ltc2378_convert_and_acquire(st);
> +	if (ret < 0)
> +		goto err_out;

As mentioned elsewhere, SPI xfer size may be 2 or 4 bytes, but
we are always pushing 4 bytes, so this only works on little-endian
architecture.

I think best would be to have storagesize = 16 when appropriate to
avoid having to manually handle this.

> +
> +	iio_push_to_buffers_with_ts(indio_dev, &st->scan, sizeof(st->scan),
> +				    pf->timestamp);
> +
> +err_out:
> +	iio_trigger_notify_done(indio_dev->trig);
> +	return IRQ_HANDLED;
> +}
> +

