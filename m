Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 198133E49C8
	for <linux-iio@vger.kernel.org>; Fri, 24 Jul 2026 18:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784918087; cv=none; b=Wxu7y8hkbD2HmoOP1K4RfRnbGtLGDmySLzCQDsKtsv31+QRRyEH1oXGJk5nSfflKcuUzIa7xw9jcuSXPbyP/2jPpg6rTILztgqDMhXKtp+INbsVD0BL/ivsJ9wHgYX4ONWzD5AIHquwmC6SUdmmMAYrI/6JjlekytzqLWyzqT7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784918087; c=relaxed/simple;
	bh=iZ7vQH8peAhqHqNDGABkJ+YljfQupn5WXRIhTxPm8RQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ScIJDghTfbOLfbXCe0Ov73JzoDbREWT7xHsH7CkITpZmIq13Cm5+KY9ExM6Qk3fWpImt8UpEcfCJ3D6k8weaSDquqiuRn/bxsHyn5UiRZJ5fuwaA2ebhTuJ27vF0D+3IekUO+P+Qcdlghnop6a4G6l9p+r1l+BFdMpStSDcwa8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=g9f6MLjr; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="g9f6MLjr"
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-7ee50eb2db4so614480a34.3
        for <linux-iio@vger.kernel.org>; Fri, 24 Jul 2026 11:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1784918084; x=1785522884; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dAXLRJ9/PZ/rI2vMByWvFT9Fv2LJeEhr/b/aoSJgCw0=;
        b=g9f6MLjrM57Ck33CzzmJUC94KEwMdbmwV2bUFwHp0FdGu9rJczOoyHU1DVR6dDIy1c
         DUVtRm1KrajanEwbsoqjFM0KEJFmqZLbnHNHckvXZowSD+oA+tgHJwqAU0M2s3IbG2PZ
         XUHmUnd3a3gEz5hJf4kRiemNxvOZJ1ylO9NCSLEKrsUO6kwgkJurChgLrlggZhZwgM4X
         bLaNc8jtWwUDnHUc5PPptF5gKYvv5JipXvLMuYkwmivCfQbikIGMZx0eUlJdNYIGAdNK
         U02OqatpxJxd8f0aYeb9Nrr42kdhNV7L53+ur1yNqYUVSoL1Xg8bKdDt6RlyjEdkVGS1
         W2nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784918084; x=1785522884;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dAXLRJ9/PZ/rI2vMByWvFT9Fv2LJeEhr/b/aoSJgCw0=;
        b=Lly3PBlOGciCqgAQClf2czeDyGDVKV8j+/5vff3UuyiKz6tER+oc/Y+LZKO65Lehne
         zPMEnhJLDYuxMH1Ypw81f2demsmqe2rAPV1tXFE4pjJ4cSZFd5cijlagEABJuKTpyeWB
         VJJJSO3wjeUHOxaPccfBKs9kX7tXjrA5EWdFdbkg1jGnukeaQhKTeK3hOpNyPVdkmEfy
         DojuuoHEPfyMWEKBDdGYvSOpPiCX3lrZ2Hh85kQuZ1tYSXpf8e5G4WTRpdr4Q2Dt2Wsf
         52SpVOVTmS6s2dWaESuIT7Z1jctTOZ4fVZqtWDiX+f27KC8noJzslxUt2sWXckWIAjJM
         +49Q==
X-Forwarded-Encrypted: i=1; AHgh+RrKr1sxkWKBkycDqixLbMzStiXaCXfUh60Mq9+khy+HPN+OIKcGeusUmQouvlIgs66Dy6Nf/mN4GCM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxyEshXu2atoGypc1M3wApv3jX0bSw3Jnye/PENiuOKIfW/t7B
	6P6bmfcqUGadwB/PnAwA39QK7DE8rJeU5CbOHMBMYCTTHTluGJK0uo3kfYs/m+yNDP4=
X-Gm-Gg: AR+sD12i8+pzFd4CKnsen/56TryZM5l0PstzSamB2j/zkQctotND1WoCX1Y1ui40Kb2
	APCht2xCRx+ORJPfSX8UzZAvK9BjP1dXWFM7NqBhOjdRmBYwY8+rqsYXcZTgZ0crwYKONftGkj7
	89YroKZG739AoeY5sOyEf+5ZviB50IGYcvHg897k3GlajHM4oCaBmCD5pLqzHdymkz4d5AkP/RF
	lAq8EkX+6vbs7QINxy7kKRrYqiZs1Q+2POG+JTqSDufVCCd/eKAmS91aIgSS9iS4hDxDOwzzDka
	yom5BPA64biKKOneQPDbErRCEWu07YPg6LXS8dWtjI3FGJBi7zuFuOVg2/Ws405aLBokX1nHgUE
	qrv3n3eTZdy5Gg/hbqMtmUdxK3AUphJk8eFb9QzgeV8l8fyMAZBYTJyyQj5fPYHIkqbTZvv+rS6
	TJxk+2o6WBb93cBsMOZvs91AKCKGh1CcEgOiEQcTFqXXJbKcrQbw==
X-Received: by 2002:a05:6830:6017:b0:7e9:b4d1:78af with SMTP id 46e09a7af769-7ee43e30760mr5632329a34.29.1784918083982;
        Fri, 24 Jul 2026 11:34:43 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:b635:d463:c98:cc75? ([2600:8803:e7e4:500:b635:d463:c98:cc75])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7ee29db292esm6534098a34.6.2026.07.24.11.34.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Jul 2026 11:34:43 -0700 (PDT)
Message-ID: <4cd1c123-acd2-48a5-b2df-8e7a247f25df@baylibre.com>
Date: Fri, 24 Jul 2026 13:34:42 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] iio: adc: ti-ads112c14: add support for buffered
 read
To: Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>
Cc: Chris Hall <c-hall@ti.com>, Patrick Edwards <pedwards@ti.com>,
 Kurt Borja <kuurtb@gmail.com>, Nguyen Minh Tien <zizuzacker@gmail.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260724-iio-adc-ti-ads112c14-buffered-read-v2-0-98b06f3d47d9@baylibre.com>
 <20260724-iio-adc-ti-ads112c14-buffered-read-v2-2-98b06f3d47d9@baylibre.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260724-iio-adc-ti-ads112c14-buffered-read-v2-2-98b06f3d47d9@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/24/26 10:55 AM, David Lechner (TI) wrote:
> Add support for buffered reads using a triggered buffer.
> 

...

>  	data->num_measurements = i;
> +	if (data->num_measurements >= ADS112C14_MAX_MEASUREMENT_CHANNELS)

Sashiko caught that this should be >, not >=.

> +		return dev_err_probe(dev, -EINVAL,
> +				     "too many measurement channels defined\n");
> +
