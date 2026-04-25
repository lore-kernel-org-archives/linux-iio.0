Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5AF41A9F90
	for <linux-iio@vger.kernel.org>; Sat, 25 Apr 2026 16:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777133844; cv=none; b=lrRh8Hp0qsYSRUoeAGMznOdV/ZxUF9Ct9Mr8yWDBLJzVzFeZfQ9CeylyjhylkID+DX/QgHzR8AiqhmvPa0sCN7SGjX/YixSc/PRpHK/rjjESZ2gujuIgzEvWfmIAJBElZTW19+uYdxu9BqLmCEnk+rmYRtzRZVvFp6pEfH9K7ZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777133844; c=relaxed/simple;
	bh=P714Idt1/wUElBaW+LenXDSfh/3pF+qhjIPw26muR/0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I63hwFSjTFgm16nkEq/4+RlsigqiEDazTEqAz8DYlCVG3aG8PeHNp+9yR/CQ54mjzIQLmgh4kkpjWpYhcDiG9FVCvAoyO3ejk7J42A/HWbM+0gEXyk9aAihCmq09v9tIWReVX6ygsfwp98srhn5l8OTo+PUHAEA0Tu20iN0ivBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b=tTAVejJy; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="tTAVejJy"
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-409de4132b5so5705892fac.1
        for <linux-iio@vger.kernel.org>; Sat, 25 Apr 2026 09:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1777133840; x=1777738640; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=f0RshBZIRutdI+obaiuuk2MoPoQSldBM8MBOZQb6H5Y=;
        b=tTAVejJyI73dOxSLfD4jMXwtJEqTrHe3cKuBQ20AaJXB7vJ/CeMWK5Lmz7eM+bxjVy
         DeCKohXZTx2MwH1dsl0TAoHHmzezNf3FR7wMjLjF70al2gls0NQHla6Xtyj7RmXEpsh8
         vvnBXyY7ocD3GQO9k4734MClMSBjnvPO9sWg/tSaAr2Q32XPKHSuMp3Db4nmBRRzK34A
         Z+Rb/T1xqXjnK3U3p8bF2nVd48VpkoVwaEtnT+GEkxHVFuq/Tq8oj7C9Hf4InFp1tMzT
         YeckLu9woZ6jTAAyRvQT2tgiH6L9Xmf7UbkroYjPtJNNUXmMA99U7xQ+teyeVJ+Rzp+r
         +FMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777133840; x=1777738640;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f0RshBZIRutdI+obaiuuk2MoPoQSldBM8MBOZQb6H5Y=;
        b=nTQ1t8qsVGjGrcLR2xklQNQ+QNHdT605iYZQXjUJTKX0fbDMQn65P9WGedUwDdqYx+
         GQkLBUdBxQ0pREvGSUnay3TXVPpetTU/BkvBC0a+0awb2fjJkfaQeYSN+brGLxahk91I
         7xOqP3xRM8Bwi7vEwOIg17KeTVyPvfpNAW42U/JP4xukc1HxIyXUEjgZVGwzvxMVrt/L
         RqK/qSEwax0ZzM+393/2pteV1dzAxoWi8YS8MbDxmhIoBjwhtBujrjvD/HGqXDDSKeEK
         q440qTw1Ptocuz5e67EGVqDtjaVNF5VDAemrL82dbJ6eBH8w9AKUwCej3zP2W6npC/Uu
         vDQA==
X-Gm-Message-State: AOJu0Yyk/gOpmT8mOrdY+MJ2cOwjx83+CjvpjE0MlqRZBnV4CLOic3Iw
	kZd88B7c0QW0ERqSSnFa+qe1hL6Gla1bQIw80oFlsF/KKZtIeGWAxiA4FzUrAwkfwpo=
X-Gm-Gg: AeBDietYyF4Q8Qs3AP1BcVaqBPRBV2/a3hcxx13IPLVr2dLPVozPGiU2JDp/NBQkK74
	PM4jFiJqt9GPLCs5AwZoi7ycfQh7eMwf2RWbNJLCumttNbmRTbByvDDCaFMRu/WPWBuGh5avXpX
	ul/+w0W4GloDrJKh6OdND3Myn4pa2DKaC7fGclK16v3jpqJD5x3OG8eTxBCHfOvZrNQ+2eANffF
	4Mc4YHeCFAsCNOem2vMNwZolCqJkdiJ95TRDSJ3L3/Ov+c527XrImhjmZ0GA0ng4gAwC9LucKcP
	oFElhS/Qep0r0J1rYuYy7qgmNl4MMEfagLRYC7diPXx7802dv+eYLkPITRduFFZEvuQOaduL2Yy
	IPorHPt6lSQDX83DnZQyk0bQXx/6M+0zAK3zQA5s6ptwdkQnhY0J1bPxnWLZDzCx1JSNp6KOENy
	qLlyArTELuThg6CuXdPDkT4aTOJyYlux+Vb0i2trp5oyMttKgoC6Qi66+PnIg86sOaoXoFE5bnU
	2Xi65YGaZpx
X-Received: by 2002:a05:6870:9f86:b0:42f:cfae:b54 with SMTP id 586e51a60fabf-42fcfae0ec5mr9611847fac.32.1777133840390;
        Sat, 25 Apr 2026 09:17:20 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:4237:7c82:cb4f:1d6a? ([2600:8803:e7e4:500:4237:7c82:cb4f:1d6a])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-42b930bd9f2sm21717224fac.8.2026.04.25.09.17.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Apr 2026 09:17:19 -0700 (PDT)
Message-ID: <84cae83c-2d67-4927-aa40-6c416d4f862d@baylibre.com>
Date: Sat, 25 Apr 2026 11:17:18 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: adc: meson-saradc: fix calibration buffer leak on
 error
To: Felix Gu <ustc.gu@gmail.com>, Jonathan Cameron <jic23@kernel.org>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Neil Armstrong
 <neil.armstrong@linaro.org>, Kevin Hilman <khilman@baylibre.com>,
 Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Rosen Penev <rosenp@gmail.com>
Cc: linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20260426-meson_saradc-v1-1-6e96b2982c43@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260426-meson_saradc-v1-1-6e96b2982c43@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/25/26 11:07 AM, Felix Gu wrote:
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
> diff --git a/drivers/iio/adc/meson_saradc.c b/drivers/iio/adc/meson_saradc.c
> index 23991a3612bd..9708ddcc4919 100644
> --- a/drivers/iio/adc/meson_saradc.c
> +++ b/drivers/iio/adc/meson_saradc.c
> @@ -786,7 +786,7 @@ static int meson_sar_adc_clk_init(struct iio_dev *indio_dev,
>  static int meson_sar_adc_temp_sensor_init(struct iio_dev *indio_dev)
>  {

Nice to see one of these cleanup.h patches that is actually fixing a bug.

Should `#include <linux/cleanup.h>` though rather that relying on it being
included through another header.

With that fixed...

Reviewed-by: David Lechner <dlechner@baylibre.com>

