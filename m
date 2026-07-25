Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC015372B27
	for <linux-iio@vger.kernel.org>; Sat, 25 Jul 2026 21:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785014866; cv=none; b=bRgq6nSzUQT4g/oX9Ca7FyTMx+9Czs5EaeSB/5C1lBzo/9BcM0H5QM5AUlQGGO+amY/X9DQD6qaNwrHnRMf08AtRnnhnbE2CGzQ7W/EELtl73T9T9EJFFIVl5mHRAmv/i8maLSWaAqp7nKc/sFFqsOq5pwOHp4PnYcyGc+klVcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785014866; c=relaxed/simple;
	bh=bbm4G5+H9qfb8kAzKuMXadu3Ig3vcGs1sJQxmJ+HtZg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ty/L1efquzZhYqjm4AY1PAIUVuxS6u5mvja+JDIv1bjzAgWnXmGVSFnLQFnQIXqOe0YUj7dMOOmOT68/hz2Nty5bq99g2oMjlgZiBZlqLFBGgUg6ggL+6h20dd9WJ1g32wuekkP/UwoMk0uLtJv3KZip4mmzVYlnR3vnvqcYodI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=C584+aqt; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="C584+aqt"
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-7ee50eb2db4so1322663a34.3
        for <linux-iio@vger.kernel.org>; Sat, 25 Jul 2026 14:27:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1785014862; x=1785619662; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iTxBT1gKsJ/ZJU0nGnVJ/OW01XixCAwYOpDLYsOlEto=;
        b=C584+aqt62LUgakZB23AVgf0PSafz0GxjMEXqoScfI9910wbp1R3j32/1TNjnquq7t
         hBTV+ihYU/EbDN3z6/roYkNFxqxsVkYMZ2PXdMmj2Ly0Buf/am9NEdV1hZYGdqU6qeoo
         gaf3y8UVty2tF0db25jg/mFPrrhCGM8+9MS+apMlevtH08r75jfJNRTTlqKrKoP07w+U
         NNHV9jTt5f2ieSUIQpDLMF9mI+GVwdQYWKabF4VAnmusoceRSWRBZ60oZDr8BepQuNHv
         25dEGKetu8kosQFDLjkU6+yce4PZKPtjH+r77JjPVLeIW68fxO3tWKP0ouiUm4pOtDRl
         Cfng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785014862; x=1785619662;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iTxBT1gKsJ/ZJU0nGnVJ/OW01XixCAwYOpDLYsOlEto=;
        b=ToJ6vqL0Wij53TzXmNkn/qzm1FkvVyGSsnNIk1cba5Ae2XSZI84CtknL38EPr27+W5
         q/PUfKW3SL/RkEwOB9wLw+U4RHTfROqR7qcxtdx7+XlwCqHIDQDqLvw1AC9GvAfVWHFs
         VnvR8VQM6KlZ3sv9kY9ZV6IzK9W2ECn4tHdNF/JWYjpEdCgs3xWssNvcG/b4YtHcw9gq
         6rUqum8EFwJ69O6ZtUz/iygjKrZ86AKRMcuiA+NnM1psy/ffpOY5o6tFg13My19nH7c0
         EqYOnlWmy5CDcGOWXW6YcWgE4k889ZqC/T01+YxqVYoxrU5/VNjo77TeZFgWt9Pdwnmf
         kkiA==
X-Gm-Message-State: AOJu0YyiDea3ghDSuWJ57EkSjeD3IGJ6hgE1UEsxqWcRSrRwlBXsHUN7
	Qn9vEipnAnP06IUdUMoTDOmgDCc/qZuajTdj97Y3DGaPgDqq59bTKmlfbVj8/00+cfg=
X-Gm-Gg: AR+sD11nxQPjfpeQYpbpCWbFDAfxMIWeJ5oZEWlwVQD59Nt8du674g+RJ0psRZKQu8t
	5Ke+98f1scKaDAOLK7Z8WQ1FbOUp2bEHMhVoWziqL/q9WaM5zgEfT7wo6Lyr56BkLMYFU8NuW00
	QJJlOsgAocbG4m4azrnVnc0lFx3HDE+CoaJqbTITVzn7hq+7IAXeEyuT5MBQMKpKTa1awCkIRSS
	DB3/JbtWc+4AP3IUFcZHFiyHkgpZi+a7SO9X+B2WjPPIDOXjfyfVqaEDv/QtxcZUmjMWUx+Ufwq
	f5ZrIC2VVx8ZGyVk4OkSMYWvUCziaMIfkPa/gZ31Cs5mk98tNDnM60KRw15Z5H92++hCnQYukZP
	Ly8TLM45W8cxhDOsdjhDPNxPp5oHBbKorhYo6YdKjkQgtcWNid60VsvRc5vrvPS261bRvLsQCvZ
	qZmAN6sKRTlnUh+jq76ciUg4mpfzmkJCigP0auypURGh9pkoQ=
X-Received: by 2002:a05:6830:6687:b0:7e9:f6ca:e59d with SMTP id 46e09a7af769-7ee78d635ffmr2550024a34.19.1785014862492;
        Sat, 25 Jul 2026 14:27:42 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:105e:29ca:45cc:c7? ([2600:8803:e7e4:500:105e:29ca:45cc:c7])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7ee29e2643fsm8885592a34.9.2026.07.25.14.27.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Jul 2026 14:27:41 -0700 (PDT)
Message-ID: <99422b78-20e7-4222-a2d8-ca778a3a618b@baylibre.com>
Date: Sat, 25 Jul 2026 16:27:39 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: light: tsl2772: fix ALS calibscale readback
To: Yuanshen Cao <alex.caoys@gmail.com>, Jonathan Cameron <jic23@kernel.org>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260724-tsl2772-calibscale-fix-v1-1-00a7789f4deb@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260724-tsl2772-calibscale-fix-v1-1-00a7789f4deb@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/24/26 6:46 PM, Yuanshen Cao wrote:
> The read_raw() implementation uses IIO_LIGHT to distinguish between the
> ambient light and proximity channels when handling
> IIO_CHAN_INFO_CALIBSCALE.
> 
> However, the ALS channel is registered as IIO_INTENSITY, while
> write_raw() correctly writes to IIO_INTENSITY. As a result, reading
> in_intensity0_calibscale incorrectly returns the proximity gain instead
> of the ALS gain.
> 
> This causes the following user-visible behavior:
> - Writing in_intensity0_calibscale appears to have no effect because the
>   readback reports the proximity gain.
> - Writing in_proximity0_calibscale causes both in_proximity0_calibscale
>   and in_intensity0_calibscale to report the same value.
> 
> Fix this by checking for IIO_INTENSITY in read_raw(), matching the
> channel definition and the existing write_raw() implementation.
> 
> Signed-off-by: Yuanshen Cao <alex.caoys@gmail.com>
> ---
>  drivers/iio/light/tsl2772.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/light/tsl2772.c b/drivers/iio/light/tsl2772.c
> index 244f44379c36..2287585711c6 100644
> --- a/drivers/iio/light/tsl2772.c
> +++ b/drivers/iio/light/tsl2772.c
> @@ -1274,7 +1274,7 @@ static int tsl2772_read_raw(struct iio_dev *indio_dev,
>  		}
>  		break;
>  	case IIO_CHAN_INFO_CALIBSCALE:
> -		if (chan->type == IIO_LIGHT)
> +		if (chan->type == IIO_INTENSITY)
>  			*val = tsl2772_als_gain[chip->settings.als_gain];
>  		else
>  			*val = tsl2772_prox_gain[chip->settings.prox_gain];
> 
> ---
> base-commit: 1590cf0329716306e948a8fc29f1d3ee87d3989f
> change-id: 20260724-tsl2772-calibscale-fix-0cc42518d5fc
> 
> Best regards,
> --  
> Yuanshen Cao <alex.caoys@gmail.com>
> 

Reviewed-by: David Lechner <dlechner@baylibre.com>

