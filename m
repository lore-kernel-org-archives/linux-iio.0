Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B8FF35F5FD
	for <linux-iio@vger.kernel.org>; Sat, 28 Feb 2026 19:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772306557; cv=none; b=InGG0Rwzf37pNKdsVQzZ8NKK6Hw9p390TEOZ/MTpP0metedB1/HrZr8n3OfRXR9gH19OXcSd3a5iXkTq7JHgti9Gpc2yr09EGDC4UE+WERZ4+ZTEQQlpKuBu5uRCMasyqisUkhW/AO7yppGM34J3VjkkIjopY+gS9Lc9Ch11Rqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772306557; c=relaxed/simple;
	bh=Me8n7owqfLJkYyvUXHQx2u9wWsIV5A0WiPjr8BtB/4g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jRQfmNmS01VMSDcIYj7VbC1qh8A5V2QL+EBMVpg56C9ZWHWPBhRdt5+JRA49ejoAx0rnqCHkoFYX3DXvU45/GPcZERFsq/w2+/xo7EH1TNhLgbUIMiIt2GvyLhty77cB0MkZph0MgvUnctR6CLoCfACuKP/SJFq3Qf37BR/s9Qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=y07saRYL; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="y07saRYL"
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-7d4c12ff3d5so3420645a34.2
        for <linux-iio@vger.kernel.org>; Sat, 28 Feb 2026 11:22:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1772306554; x=1772911354; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jzurjNKz+LVtj7mOsHnigyTZSCq1BtpAu09PeT2WHx8=;
        b=y07saRYLoCC2ntjKJ4b9npncuFpyHNGurAj1W9UU09TwMAemNZ7YdHqasUjpbPHhoP
         Fo3TQCv8IK+dIhba2YaT6OHJsuv8emGbaKn4tbR/7Igqk4HAowbAi3l8jHfrBaGTwu2R
         OUN3fM8MXJ4NUfpzhIasd3aAsR5AO9H4KYl+ygBFYz6xH5mnhgIYl5GFxKUrGJTlbuYF
         LAWlOmSnzgDZGPaJzNC1RYOoG5FaBnX6R0+adFDmi6s336sHxwtI27kq1Hebwz/5EgC9
         Z6ME29ppx85j1pOAdMC1Yy+PC83TPU2cJX65viqn4Urij04tDzURGJSdIijOnHThiZLd
         RUBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772306554; x=1772911354;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jzurjNKz+LVtj7mOsHnigyTZSCq1BtpAu09PeT2WHx8=;
        b=rNhG5liAhakAbUXtfNzspskj7aZBmVCz5cl72blbrl606QaB0gdColS01rR8a43Qcv
         zTYVQprYyWRcsZR1o8AKHQsOor17aOHLvyfzt37AhrSakN/W2O5beBgOG63j90cqraPE
         9PB4dfOMywjFlWEA6Al5S5KGmCdRQ0R1rTRLJ25R60zhmaDL4eTizZaZ3blbiiAli91O
         RjpR0rpk6VeDaa0FlQ4YVeXhtf7aoox4LToci3Lt9fBjcHxDhzqmyp+lj2098ssN2Cce
         SrXhmQf9wBRT05f4i5vs4xsmygbpL1pOIP60Yc43x6UH96X1fHadBi+9gHhviI+NJAV0
         lJIQ==
X-Gm-Message-State: AOJu0Ywm5o4j+NLUwK4q1nbeycLfdWA0KR4gQzgoEHL3YivHTWFsWAyB
	BgcPjcW3O+yD9TZLQnU+Jf6FT+YREOdRdV5FzJfyn0MKLuhumlS7ohVdab/dQm6tSyk=
X-Gm-Gg: ATEYQzz0v9iwIKK8zQb5PLSC0Dr3y/Tik24ToRtPok1c3sgtl+2gSboOODQ36dlBCiF
	Z3BCHHYhe7BrlnQQUhwqImBOd3jaw0YGEJZgtkkWGIJxp6qR86if1WvO363poiEUbaed7+bG+m9
	CI/DCyRjreQUPW9k4TRP/3y4dOG54RKoq9oZ2CAu134ZsY6vVHsWIj5DFkbgaw21AKaWhqrMay5
	9Vjpp3hTIK32qsF9MTTJCW8C2b9wD7x9qhxMShAga/lBSqLEa+YToMCBdxeQLbGrsjyXW9zcmhc
	BI3wyx8RV3LPP1xonX9aqNPAXklqTaaSaOPoPYuYTqHjXNGkedq+gwbcoRpKvFFZCd63bfL/eqH
	tDgZ5lx9VYD5g3WmB/rj50ADZY6mhxextTKwqeozmAG573P27uAbeVWEQxa1E1I4Mk7+4una5iK
	kdkylgqCmXh6CCe7H8owRvNtc+GdAgFpt4lcfzSFAZ7fOY8DhTUS4hJeLgX0ibzh8FPIZA/LKip
	Q==
X-Received: by 2002:a05:6870:e9aa:b0:40f:e6a:c0f7 with SMTP id 586e51a60fabf-41626e15081mr3595917fac.17.1772306554592;
        Sat, 28 Feb 2026 11:22:34 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:1031:c44e:9f1f:17c1? ([2600:8803:e7e4:500:1031:c44e:9f1f:17c1])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4160d2cc08csm7236079fac.19.2026.02.28.11.22.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 28 Feb 2026 11:22:34 -0800 (PST)
Message-ID: <20195663-2091-41eb-b4b3-e8542d29ae32@baylibre.com>
Date: Sat, 28 Feb 2026 13:22:32 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: st_sensors: fix trigger allocation
To: Aleksandrs Vinarskis <alex@vinarskis.com>,
 Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20260228-st-iio-trigger-v1-1-abf5909e547f@vinarskis.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260228-st-iio-trigger-v1-1-abf5909e547f@vinarskis.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/28/26 11:11 AM, Aleksandrs Vinarskis wrote:
> Current hardcoded name prevents adding multiple st-sensors devices
> on the same platform. Fix by aligning trigger name with other drivers.
> 
> Signed-off-by: Aleksandrs Vinarskis <alex@vinarskis.com>
> ---
> Some platforms such as Dell XPS 9345 contains multiple accelerometers.
> Fix st_sensors that currently only allows one device at the time.
> ---
>  drivers/iio/common/st_sensors/st_sensors_trigger.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/common/st_sensors/st_sensors_trigger.c b/drivers/iio/common/st_sensors/st_sensors_trigger.c
> index 8a8ab688d7980f6dd43c660f90a0eba32c38388b..3b5615d1b6dd66ee0af6ccc83eb2fbd7b2c64d29 100644
> --- a/drivers/iio/common/st_sensors/st_sensors_trigger.c
> +++ b/drivers/iio/common/st_sensors/st_sensors_trigger.c
> @@ -124,8 +124,9 @@ int st_sensors_allocate_trigger(struct iio_dev *indio_dev,
>  	unsigned long irq_trig;
>  	int err;
>  
> -	sdata->trig = devm_iio_trigger_alloc(parent, "%s-trigger",
> -					     indio_dev->name);
> +	sdata->trig = devm_iio_trigger_alloc(parent, "%s-dev%d",
> +					     indio_dev->name,
> +					     iio_device_id(indio_dev));

Is this something that could potentially break userspace? Or are all of these
just "always there" triggers that userspace doesn't have to touch?

>  	if (sdata->trig == NULL) {
>  		dev_err(parent, "failed to allocate iio trigger.\n");
>  		return -ENOMEM;
> 
> ---
> base-commit: 3fa5e5702a82d259897bd7e209469bc06368bf31
> change-id: 20260228-st-iio-trigger-8ee1f219b566
> 
> Best regards,

