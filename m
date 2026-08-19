Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3303A3C09EC
	for <linux-iio@vger.kernel.org>; Wed, 19 Aug 2026 05:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787116311; cv=none; b=Y0iJyt3aE4rMclqKDXjEg7TYkqQ14EpDrxgvOCBTtv/V8qa0hOqQ83yRmCWmllxb2Jg4fwP1KGPVHW8wjd2Rj0GLxvCwoeMJaHHszQ4xwPV10D2jAvj39xUb7UGAM5jkFY8/QZhLKoMOMe7RhetvTcgpcSbuCgR2rWzzShsX8jA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787116311; c=relaxed/simple;
	bh=+IB8gqdGZ0JYzzVYCdgm2UYJqdaxyEEi0fEhPwDIam0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WGgxfLSzgE82JuTgFTJvHJPxijivUlQUgf7QcaMbG6PYH8bJZ0BTGdyw7CvzaXKNDc1exzYuLJBcIB1m+I2ZE3inJpxtQBM53iGaVgm+kCqHEbCEGS8ONhZn5cjaeNNp2c01Ddf++nSuBhnqXUz1kulzNE+PlFUznaODBxQ9m2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KtqR/qnM; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KtqR/qnM"
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5b01910b499so496604e87.0
        for <linux-iio@vger.kernel.org>; Tue, 18 Aug 2026 22:11:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787116308; x=1787721108; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Xg/g0kI4FzGMX+GmBiCP3Ec5mfFhfZ7kmnQpf3eCjV0=;
        b=KtqR/qnMuC/QFdcwBbxwG17NwwTYx5GUcORLAF7N7kOwVpPZXIQsNFHfkPnCm2qFAX
         BCi92AYG2VaiVkrt8zRphGbCpy6pvKeYUYaByjhSMOI6rMlLgbbJ0dzniJM5Bb3g0sjv
         5HmfYjjwWcPcbJvFapZUewwJ5JbXn92i66VGno3E4CyTP0oxKGeLTX3h9iHJIlS/cy2w
         S+auxjpmLh7yRM5LYFsNhQRWKOEqwzBXvEeIgV7lqG/2NzMkhhGiogRszd+I2umAzaS5
         IuRtAygfberWrJujQg8Yhvrth/M87Y1kRgE8UiErbwCPWV7/8BY9R2UdrEWY4riPvfvL
         CnUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787116308; x=1787721108;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Xg/g0kI4FzGMX+GmBiCP3Ec5mfFhfZ7kmnQpf3eCjV0=;
        b=LS1/lKPC029vkhoHyXoCBrxlgJUG7ZTzfn+qmz+vby2I3PIWUbI9LaG1zwbp1VbhS5
         E6Er0DoGvGPtNsgGxQNM1uA1ISjxAYr3rJabLr3zDiI0Kl6irwWcV7ZL2HdaOMH1ha7/
         +u9/NMnGdk15XOojF7L9UHYY9DwsT4/4esQelhpA7yxWD5O7yQiSnVtOE8LVxuuhWvO6
         dCo0wsqFB8p1K36x+Zy5M4MdCOJi748hr3p/lhPN4TgHdz3iy5IdcPgf6Ud52JxSQV67
         36Y/UpkiR50i0e9ct3FrSNthcsetUHO0bClrS8HzN0gfDNRZrNt9vXm6jLj0hT+U39kK
         Htgg==
X-Forwarded-Encrypted: i=1; AHgh+RqoiGdYEsmC7Sx13kNegCZTyFMKPomHzTnW5Bsp7M7une8wSwnOvJ75ZBo6Pt2oDOuCrb98ETJlNaY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAs6cMS+eHiDZ1JQ/Fb49gIigqSsCX9qGeYDGHs9HaLX1B8dGC
	6FXV7b0lo0PSJnfDFQdKl+JtS3sWPbvmZMKRi0SY/hX0vCZ5VmIxSjLN
X-Gm-Gg: AR+sD12SuhkmAMgduGBptUrE1WoEbEygMqqxapfb+n+wOr2LOJPAwRKY69v+y415eHu
	S3aowPGYYJqf1URo9LyL9zjgUQHi+wgFOrI6sqj3haVNny61yFqBs27ddaIysNcGdg2BisWfRV3
	q0CtSBamlV9vKJN0+0ZPi7hnR8XixPCLpz5VvJajK/cSkUWdUEIyDxAm1hIokB1zJHJLdUDgCHn
	4EVPTBYnHoRG2Mdz8y3+5iKKPx2q8VNCGl+T+OctBpMHAME5RKHIE0UdgP963xwvz5BruIQpNYW
	A9biiQn5G+cYAiKgVTOSc0FocfrvEwpHaKzRxF4/YyB4GEn080JLtA91zh/o7AY8T1oU89O8G2S
	bfpiDfbBQw/00AjhWuXsYpxIjhHTRrslWO2fy/CfYbdDdSvCSvECiSK3zRhLedXpCJGcxM3cJZ7
	YNMsuX/ia8+Le6AwHL1f1JWHIuXeIJcde3WXQ8HaslpB8pyEvl7VJKeiJFTLZ4IRy/eqrDFrkYt
	ZGPVYXgGccYW0jZmwuFxLc1WmSh6EcQX9mgBsBAyM2a
X-Received: by 2002:a05:6512:6404:b0:5b2:aa5d:9ce7 with SMTP id 2adb3069b0e04-5b47868b81bmr396488e87.10.1787116307910;
        Tue, 18 Aug 2026 22:11:47 -0700 (PDT)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b478853ac7sm232490e87.7.2026.08.18.22.11.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Aug 2026 22:11:46 -0700 (PDT)
Message-ID: <c4606bde-6132-4407-9fcf-32ec35b1ed1c@gmail.com>
Date: Wed, 19 Aug 2026 08:11:45 +0300
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] iio: accel: kionix-kx022a: use
 iio_push_to_buffers_with_ts()
To: Gabriel Rondon <grondon@gmail.com>, Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260818215122.52715-1-grondon@gmail.com>
 <20260818215122.52715-3-grondon@gmail.com>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20260818215122.52715-3-grondon@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 19/08/2026 00:51, Gabriel Rondon wrote:
> Replace the deprecated iio_push_to_buffers_with_timestamp() with
> iio_push_to_buffers_with_ts(), which takes the destination buffer size
> and checks it against scan_bytes at runtime.
> 
> Both push sites now use data->scan ({ __le16 channels[3]; aligned_s64
> ts; }, IIO_DMA_MINALIGN aligned), which is 16 bytes and matches
> scan_bytes for the 3-axis plus s64 timestamp layout used by all
> supported variants, so pass sizeof(data->scan).

Eh, what is this explanation above? As far as I understand, the 
iio_push_to_buffers_with_ts() has a safety mechanism of checking the 
passed buffer size. So, size of the buffer must be passed, no matter 
what the buffer is designed to contain.

By the way, to my eye the commit message looks AI generated, which is 
perfectly fine. But AFAICS, AI generated patches should be tagged as AI 
generated. Hence, if you use AI to do the changes, please ask the AI to 
check the docs and also add necessary tags :)

> Signed-off-by: Gabriel Rondon <grondon@gmail.com>

Other than the commit message:
Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>

> ---
>   drivers/iio/accel/kionix-kx022a.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/accel/kionix-kx022a.c b/drivers/iio/accel/kionix-kx022a.c
> index cf2cb751b4e8..86f17431aa23 100644
> --- a/drivers/iio/accel/kionix-kx022a.c
> +++ b/drivers/iio/accel/kionix-kx022a.c
> @@ -863,7 +863,8 @@ static int __kx022a_fifo_flush(struct iio_dev *idev, unsigned int samples,
>   		for_each_set_bit(bit, idev->active_scan_mask, AXIS_MAX)
>   			chs[bit] = sam[bit];
>   
> -		iio_push_to_buffers_with_timestamp(idev, &data->scan, tstamp);
> +		iio_push_to_buffers_with_ts(idev, &data->scan,
> +					    sizeof(data->scan), tstamp);
>   
>   		tstamp += sample_period;
>   	}
> @@ -1033,7 +1034,8 @@ static irqreturn_t kx022a_trigger_handler(int irq, void *p)
>   	if (ret < 0)
>   		goto err_read;
>   
> -	iio_push_to_buffers_with_timestamp(idev, &data->scan, data->timestamp);
> +	iio_push_to_buffers_with_ts(idev, &data->scan, sizeof(data->scan),
> +				    data->timestamp);
>   err_read:
>   	iio_trigger_notify_done(idev->trig);
>   


-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~
