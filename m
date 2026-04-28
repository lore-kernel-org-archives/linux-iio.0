Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 830D232ED27
	for <linux-iio@vger.kernel.org>; Tue, 28 Apr 2026 16:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777394992; cv=pass; b=eEZzcKzu5/8rGQX3hVYVOUxxvong8Ez6d1fm2xWQSKSL2XHRDX+qv3WqpOdhhQJs9QsC3WiE9vDNaRxhffEaqKe3JuZUTdx4sYz3L0Oiz86BcmbXL8LSeWaw6Ptf1z4pkNQBsCaWlIExGEWHc/zAiDB6JGVxcl5fBfdyw/E5PLI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777394992; c=relaxed/simple;
	bh=2vNGay5mqRoDd3U60Zt0Mlbr/ZDYwk0AWSo3BUdrsbE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=onR/RBnCyyvm3rn0YvvaheYKNDGmK+1Kteo/K6rUCv+qoGClcHwLg5MX9xt4oIUg2AlK7y3vxu85jD9UXAvj5OWTxWgxgdC7QnfZAVcpj7S6R8jb2WRKGKEOvauRkczTOxy4Hf/b/xz6rfXIW8VRIsvZcdSnLOvBnZYdQNxwWQE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bq6iByU0; arc=pass smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bq6iByU0"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4896c22fcbaso88608745e9.0
        for <linux-iio@vger.kernel.org>; Tue, 28 Apr 2026 09:49:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777394989; cv=none;
        d=google.com; s=arc-20240605;
        b=NAIn/qc89FXBV4qbpfQkZWPTdorVLRSMqUMXARSuI81rLjgRNByw9l95iLLGrC8GVT
         9irPRT2XAmiVynqdpGn6iSL79KRAucVczkmM29+xjXgItr5hzPomcB+/1svMhyPBYus/
         13tEyxbvVjXyhbE/z32Sp7jqhoC1F5X7u914oGrQMgf32q1dOHj2MvVF66WCbP7BYvTC
         UKsCbLDR0VoH3DCzgxnm1PYV4W1eeUXYrukwzvskKTpUqu0/AEFAPIY0t5Xijr0hCT3V
         G+a/QTEj9uObsgEkHS6eL5kKbxgLsYcGpVzJmL5UqsL3d/H0hcaaPG/CrvgbnBiIemh+
         AIlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=yMLdFwFZqE2g2YQ1WeyEPYor529ffnzJsuhBVNNHsfg=;
        fh=MUuYALaGrpTfLnFzfm3UNElEbrCG92HtVrS2edDnp18=;
        b=C7qcAL3ZQQ8+SqbHLq4p5mOmZ4MarYaYyXmhzKpxkN/yfJ2sfeBk5jijVhWo/wUWJ/
         RGQ7JbB+3niwdDc0nQj+SkH093OCLAN0mgeeyq6+8BpsVTSmBvz3kORffNE82VUHgwgs
         aB2cAJVhNtlH3k7t3pwyCfGu9Ds5KR/9cE5nxPvEYcBLbTxFeF2tEljhYQ7NjeWwlPau
         KuRHsJ6bUb445fba9UhEwyRnIBmZdKO78+NcLVwisFL5J1KBn/PJ5VR/G4O5+8XzTe1B
         gaOCP7SXk8rTLC+QDJTHGUA2PACDnmPZiHGPrEYaGJlippBBtB+THSrQmTq+DazHVlNE
         NQSQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777394989; x=1777999789; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yMLdFwFZqE2g2YQ1WeyEPYor529ffnzJsuhBVNNHsfg=;
        b=Bq6iByU0z6r16mwMNefHWol8x8iqGWi9tIxKsPrppCFyG6OyjqeeD4q6H2moZRLTNU
         IHRZxoJwvwp/iM7xgrcapd7yhS0gmwxucPNEoTLWiOoBcLhryF+hWz7tmJTYGzk9ZvJG
         6pG0elcB/bYpIAH6OexjWHmk9SFJi/NP1VR/p2Z7FI1SKGtG18RE/yTvi8LFJouLpSgy
         4mERO4LsRZzg+BcvoReLnZVNbuIphvKXtPGiGnprAjtgi5ooeac0yO5aPbc/vnFa47P3
         /vimZcIazoQvJ2lR2lSQaYz8c0oL6+dqloBDqgHXSWfeEGARKbWxlX5TNtDeRxUEzhk1
         jgfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777394989; x=1777999789;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yMLdFwFZqE2g2YQ1WeyEPYor529ffnzJsuhBVNNHsfg=;
        b=bebJ3jU10um9/hxqNMfBu0NjW3znFcyl7PnkD5fWWqRi4uBmRL1vM/Pj33sJm+96IT
         HzjFZAla1y8QhWybGqNptwDveQZaP0lsOoJ3uGk6v/1yeqWyR7SqnKlG3uiV7hzHqS2w
         EhvEb0UQFDNrOrfCfs+/8nzilOCHB8i++8T3DCjnmFgi2fiSo/t2LKrowki1pkF2J4g2
         W3BPwbGwusJshem0uw+15TdtWt/fO4DhCKHjgYzyiMvhR+b+hj5IwSpJvkWpkJ1a3DeS
         LMk9F9zMKgQxbtBjFX0sI2rND8k4LIipShl1FLFcTfEljmvWjE2ru2VINkF8ySUPYkMw
         y4yQ==
X-Forwarded-Encrypted: i=1; AFNElJ9Rg79jIbEQBqyJZtEsyzqPDm+p0BzouJoxfOISuMoWQkEmi6HlzIMhHRWIwDT9WVFV5YbH/2arckQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOPHIyvLXlxjvYn7jstnIisVRfrxCzd7HjBe/H0PWmTqplIWae
	Ro8UnWDmmavxJ6E96YyiwhjhQUDZhqv0nj+lQsHObvQpega/T9hfd4OKBzwPxplQErvuhgx/mQk
	L/8KoeREX95jFHBQofydIM3Tk0/hIFL25tb9X2M1eDg==
X-Gm-Gg: AeBDiev0wpj1OIpc3w6KgD1Qk8o0jmNMOBMzcGrzUbbirDFXVZLPJAqghh1byfbE+HC
	nsaZyDl/+gEgiAHFvHvLLKLF7j4nAqdgJwB8/R4kVStnx+GUU/nFgxquCC72OPmXUXhAf64eRNn
	h9KdbuVy5/bczm9j+Jhg1KE/PV+dXZg3Rgbeq4rLSZJtoq+2s2+Cnm7cY9HhRaD9ylqfptmY7LN
	yIRbyRmydinqtK4nqFveks1p2EwZVvhkdcINwRnOJj9fsBefHzQikc+xw82t1CZijVXRcRTTU7D
	cZty9mmcZSPEQEqeNbTQJxhAslW/Z6aTHZp8nStU2PfE8By5MNYQkq5OyUUsFptzUmJ+nNJLBdG
	RIowYOicDCmEaeOf6AaVb8QZstWgLWZPaZp/3Hr6VRXa2h7hMQ7VRXXGeOKnoMajRlh5p/u8Zc1
	sI7WjbePGH9fk+xmm8ZmrmFAFALXKV3/mKrj7EOT7/VzoHFkBQOg==
X-Received: by 2002:a05:600c:1d0a:b0:48a:5342:36b5 with SMTP id
 5b1f17b1804b1-48a77b1e8b0mr64913905e9.21.1777394988719; Tue, 28 Apr 2026
 09:49:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260428161339.1187956-1-rafael.guimaraes.dias@usp.br> <20260428161339.1187956-2-rafael.guimaraes.dias@usp.br>
In-Reply-To: <20260428161339.1187956-2-rafael.guimaraes.dias@usp.br>
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Tue, 28 Apr 2026 18:49:36 +0200
X-Gm-Features: AVHnY4JUpI-SD36ZJEMOtYLfoUC2N36QicSnswHfOUP8nrFW8-4nTFtZE9R_sRU
Message-ID: <CALoEA-zxZgPwgb7o_=F9Q=bQSYiQi=THtCpgu0mW3EEzbXEAcw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] iio: light: stk3310: Update includes to match IWYU
To: "Rafael G. Dias" <rafael.guimaraes.dias@usp.br>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com, 
	andy@kernel.org, linux-iio@vger.kernel.org, 
	Felipe Khoury Dayoub <felipedayoub@usp.br>
Content-Type: text/plain; charset="UTF-8"

On Tue, 28 Apr 2026 at 18:14, Rafael G. Dias
<rafael.guimaraes.dias@usp.br> wrote:
>
> Clean up the included headers in stk3310.c according to the
> Include-What-You-Use (IWYU) tool. Remove the generic <linux/kernel.h>
> header and add explicit dependencies to improve compilation accuracy.
>
> Co-developed-by: Felipe Khoury Dayoub <felipedayoub@usp.br>
> Signed-off-by: Felipe Khoury Dayoub <felipedayoub@usp.br>
> Signed-off-by: Rafael G. Dias <rafael.guimaraes.dias@usp.br>
> ---
>  drivers/iio/light/stk3310.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/iio/light/stk3310.c b/drivers/iio/light/stk3310.c
> index 1fad9367c2d4..37b7b9367269 100644
> --- a/drivers/iio/light/stk3310.c
> +++ b/drivers/iio/light/stk3310.c
> @@ -7,16 +7,27 @@
>   * IIO driver for STK3310/STK3311. 7-bit I2C address: 0x48.
>   */
>
> +#include <linux/array_size.h>
> +#include <linux/bits.h>
> +#include <linux/dev_printk.h>
> +#include <linux/err.h>
> +#include <linux/errno.h>
>  #include <linux/i2c.h>
>  #include <linux/interrupt.h>
> -#include <linux/kernel.h>
> +#include <linux/irqreturn.h>
>  #include <linux/mod_devicetable.h>
>  #include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/pm.h>
> +#include <linux/property.h>
>  #include <linux/regmap.h>
> +#include <linux/sprintf.h>
> +#include <linux/types.h>
>
>  #include <linux/iio/events.h>
>  #include <linux/iio/iio.h>
>  #include <linux/iio/sysfs.h>
> +#include <linux/iio/types.h>
>
>  #define STK3310_REG_STATE                      0x00
>  #define STK3310_REG_PSCTRL                     0x01
> --
> 2.43.0
>

Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>

-- 
Kind regards

CJD
