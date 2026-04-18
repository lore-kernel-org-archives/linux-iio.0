Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65BDA2E718B
	for <linux-iio@vger.kernel.org>; Sat, 18 Apr 2026 16:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776530087; cv=none; b=YUODfdG50SmvUgqcQBtJXYVg0ZJkA1rlLWeru174iuMkJbIB9m7j9uJgpItFYI6RN1E4M89i+x6EIGW1unrq3l6dUgk0WEToU4z59gWMAp5J0ySPHdnd2NgC16cWr41L9xE3z1ZXy2EV19eJwZPQbvNbViswtrkm8ZNkWFRsIRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776530087; c=relaxed/simple;
	bh=JDb1n0t863YlJpB5pT612flyJ3Euv3WQtPT8N/udF8Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uEWMSMhaT8bRsESDZJsTsgo2tFC0hhOp69OaPa2GYnetQloPabDrIJ9/ZhlONbU2k/GQnar7nkyDGR/nCE3D4snjQ//zhuOH4VAnnSgIqdidFRGhp8fBFcNFEfFtty2+Y6u5FT/l/WrDFS191UjyIu0mek37Q2PnozMQQwEQfqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b=bUhH5EDV; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="bUhH5EDV"
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-7dbff06e4a6so1734128a34.1
        for <linux-iio@vger.kernel.org>; Sat, 18 Apr 2026 09:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1776530081; x=1777134881; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UX2ZgJgegyCweH5KbrBLfo8wosIMbfIymwStHkqgwVA=;
        b=bUhH5EDVTURdBhZEaKuXgXyf9/+3rlJNzWbIvrbeTMjzYTmFHEXkVRiT461cfA8Afp
         WHshbiUH3ykhsrKaU8HqvhmxW7WVmHI/tLL12HAlmB1AZh9oTD0islkUJ2D06wSeG6DY
         5aIEgAjODXG1WFP6Ndj05ocbOkvrW0VHHb18bFgqfwjnaJXmQVjsy/W38NbhA0iRYfuD
         kDdQbMfo0eaSFEOi5ybYZ0HncGKPpybVQMoFueNWtugCEiSoFfmS9ks4tIdZttinAgDh
         UMDZRzUSsB+yFM910cR6OQo2afvsDJX1nHaDytd+0JPAhNI5DJNR/hQ7XDalU2wHlYke
         5i8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776530081; x=1777134881;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UX2ZgJgegyCweH5KbrBLfo8wosIMbfIymwStHkqgwVA=;
        b=Ae2dW1dqWB+fTZZUYDxzfqMugjyAEfSkygg0dflQzO3uCevFRfocJxi6o7/U2mZEeW
         By/kSagFAGECuiYTr2+LN6njhY2iQ38nRN9+/gOJH/jv9+i4uugh7Y01Z+ZnuTjfZqpk
         MD0iCHb4LijyGCXM5YzTPa9J6rVHNRtu3x4mQaSiIFujO8H4AkdaePqZR19ZqlJCsq6t
         c0WvV/a2zchsHYBdzeBMAouIRclTvqWcfdOahLN7962OeqUPXNoq4astHhCDPQ8u9Zce
         ahvBtQXirHYnnGSqqtMSW4oQuENR3uNVjZDOVrOYIvQipNPu2Dh/tkaDnIROVku9Ya4Q
         lI6A==
X-Forwarded-Encrypted: i=1; AFNElJ8kgq+r2VqdXXAuODuVFtoETIHmWrxsfPN7jrWtd2wu1t8QklRyP9LfeXaBLuQPdTWNzkZcfBFgkLc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCs+sDReV6WPhRM+/18c+LGHyEzwwKtmDewy2a8jGLscDgbVDI
	ZOIjwnLR4y/NpeKkw0UoAWsZArAgfyojqOiu2elG2ma7+nb22zipU15L3I4szSjp1fU=
X-Gm-Gg: AeBDiesRR/I015V34K1iM7W6P5FZRkhrsW/iKJbFK+mSTpAoztclgVYmq8VrCwW2JYu
	fga+gWsieCl1iixSREAfsbSIfKAmc/hhQoHbHZf6L1KR1mtD4DN6/rk7tAE7xlE5ZzXOnvZ5CNx
	1VOhsM0Qb5xoeHDDMw1FClqZa4aPcmeI4lMvc5iYnesS4vgSB49QPRsLnks+1KxH7Xu2mJ7eO2J
	ItXcGj3WmfdRQafUYNKnNQSjkINc9ixWbI+k4WfXOWnqrINVe1O4Jq8VxRt1zCBwj560K2NC9/E
	f2Paqeweu9ISj6EyZM4jsx9ly7usgUPlMkRikcoPVP2YhgtsZoz8R9AOUPBYNtzmNDRJoQDtFRc
	h7ZC1PrehqQxfisf1aoeGek49wCXRxNwbyFWQhWB4+WFiNdMmMVoyOo2BK3zngCcX565FmpfjwL
	bCKucIAAELVaJZSyln55xnxBJhrq2JTVOo7Bo6Q+kbXLl2BR0p5OsOKBRBDJBVP6GIXB2qGNYG7
	Vi84AbEQg+8
X-Received: by 2002:a05:6830:929:b0:7d7:cf7f:6fd with SMTP id 46e09a7af769-7dc95273245mr4540726a34.25.1776530081368;
        Sat, 18 Apr 2026 09:34:41 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:b1f8:aabe:74d7:21ba? ([2600:8803:e7e4:500:b1f8:aabe:74d7:21ba])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7dc975034e7sm4027334a34.6.2026.04.18.09.34.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 18 Apr 2026 09:34:40 -0700 (PDT)
Message-ID: <565d1633-0f6e-4364-8dbc-8995595f8c12@baylibre.com>
Date: Sat, 18 Apr 2026 11:34:40 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/7] iio: light: HID: Replace method
 prox_adjust_channel_bit_mask()
To: =?UTF-8?Q?Nat=C3=A1lia_Salvino_Andr=C3=A9?= <natalia.andre@ime.usp.br>,
 andy@kernel.org, bentiss@kernel.org, jic23@kernel.org, jikos@kernel.org,
 nuno.sa@analog.com, srinivas.pandruvada@linux.intel.com
Cc: Pietro Di Consolo Gregorio <pietro.gregorio@usp.br>,
 linux-iio@vger.kernel.org, linux-input@vger.kernel.org
References: <20260417225959.16688-1-natalia.andre@ime.usp.br>
 <20260417225959.16688-6-natalia.andre@ime.usp.br>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260417225959.16688-6-natalia.andre@ime.usp.br>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 4/17/26 5:58 PM, Natália Salvino André wrote:
> Replace method prox_adjust_channel_bit_mask()
> with helper method hid_sensor_adjust_channel_bit_mask().
> 
> Signed-off-by: Natália Salvino André <natalia.andre@ime.usp.br>
> Co-developed-by: Pietro Di Consolo Gregorio <pietro.gregorio@usp.br>
> Signed-off-by: Pietro Di Consolo Gregorio <pietro.gregorio@usp.br>
> ---
>  drivers/iio/light/hid-sensor-prox.c | 13 +------------
>  1 file changed, 1 insertion(+), 12 deletions(-)
> 
> diff --git a/drivers/iio/light/hid-sensor-prox.c b/drivers/iio/light/hid-sensor-prox.c
> index efa904a70d0e..61f4627cffab 100644
> --- a/drivers/iio/light/hid-sensor-prox.c
> +++ b/drivers/iio/light/hid-sensor-prox.c
> @@ -67,17 +67,6 @@ static const struct iio_chan_spec prox_channels[] = {
>  	PROX_CHANNEL(false, 0),
>  };
>  
> -/* Adjust channel real bits based on report descriptor */
> -static void prox_adjust_channel_bit_mask(struct iio_chan_spec *channels,
> -					int channel, int size)
> -{
> -	channels[channel].scan_type.sign = 's';
> -	/* Real storage bits will change based on the report desc. */
> -	channels[channel].scan_type.realbits = size * 8;
> -	/* Maximum size of a sample to capture is u32 */
> -	channels[channel].scan_type.storagebits = sizeof(u32) * 8;
> -}
> -
>  /* Channel read_raw handler */
>  static int prox_read_raw(struct iio_dev *indio_dev,
>  			      struct iio_chan_spec const *chan,
> @@ -250,7 +239,7 @@ static int prox_parse_report(struct platform_device *pdev,
>  		st->scan_mask[0] |= BIT(index);
>  		channels[index] = prox_channels[i];
>  		channels[index].scan_index = index;
> -		prox_adjust_channel_bit_mask(channels, index,
> +		hid_sensor_adjust_channel_bit_mask(channels, index,
>  					     st->prox_attr[index].size);

Make sure to fix the alignment with `(`. Check the other patches too.

If it makes the line too long, just use one tab indent more than the previous line.

>  		dev_dbg(&pdev->dev, "prox %x:%x\n", st->prox_attr[index].index,
>  			st->prox_attr[index].report_id);

