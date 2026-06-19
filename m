Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03E5933CE8A
	for <linux-iio@vger.kernel.org>; Fri, 19 Jun 2026 14:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781880132; cv=none; b=NjcD7mzzwcHFCO9v/5XlgJcBAMmuXet3mGd1amMvOIxbjP5LSurUE1oVNgfMd7SPhWRvy9nBxlbRMGOEFeUFMnPqau1hgtvPzlVslXIY+iEWjiowErsdUVX7O/VbWEOyKGn373hphsXvkJwG9OB+a/EQmPYIVWduouQ5BkWVe9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781880132; c=relaxed/simple;
	bh=EITmngCCMhar0hLU+x6qvbIAa+DctYKdDcsgG81q2Ps=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=GGDqpcTsmVfNX/jUW+WPGlIZ8hPbhuLZEq1HzdxWFdJ/aXInvsX7Wz2VB/E4jeP7RV/hiLda30vNH7xVpo+hbmwhYH07KXgARBaHhN5cCcuVuR8vl5cqtsC7WIunSM8SmuuGzCbfNPSpshFeqFBHxFStOluPX2si5vs1uAZsGFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=hF0T8MCf; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="hF0T8MCf"
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-7e6e9408e30so1997290a34.2
        for <linux-iio@vger.kernel.org>; Fri, 19 Jun 2026 07:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1781880129; x=1782484929; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FKnVjGucb6IkF6/IYcinWjlII+ulFbmjFsYIvp41Gig=;
        b=hF0T8MCfMlcEX0q1bEu53byi+U/rZn+Uuz/YulvDqCYdyXZp/pYwScegTC9oVKHdEg
         14R321KkBcxXVSMmnXt4d2zjid7Mzr370IKO0BZOB+4WZaaiZqOrOnrX8tb85CxTforg
         QSFoT528CjPoMgWtTNRXHu6g2sm7vObutThSX+uTqgAQKWSPhItbNbQYOItsVgy/w86U
         fPbPx+fg6+9eGGsr4oDhWiiHXlot4XwLq56oxTVxMCokk3sSvDNBBH4E73cWnKDVgX4k
         WobNMB8RvKAT65lIKRJa6emae4tbrFo77HKgCWvJuDORKVpsFkL8MyhaOMQkIuuKeFwE
         qrhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781880129; x=1782484929;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FKnVjGucb6IkF6/IYcinWjlII+ulFbmjFsYIvp41Gig=;
        b=Wn8/uz2QK1MO2U+35n6FzA94bdYi4cn66qReqRhtYgh/CHp+lotm/kH83VDVcM8y74
         /u7GMyREa1XP2fO4IcpHB5Hg5YGa18TPSNQVWIKYk00Qic0iJG4Up5A2zQ/GTKVtGjH5
         SBIh1FD/GocjnnHuMpRkU5jGnqfaajwfypwd/Wc67gNlguXM7TLL1FP1jx+0FkGHcv8a
         TdfySfdAP97plbXAJ3F2bUqcIMiB3oyKIpnp9nO6zyFSCbLNro6q0eDiQu77ClE5GnyG
         586gaEC68O2AXfLIyINarrtl6oaEjzpkNh3kuvtJqCnsFtLwoNcOl1WHTLJPZbwJUDi5
         pz0g==
X-Forwarded-Encrypted: i=1; AFNElJ8a+dAsbylgEwYIl2V8/qWy3hO4hOqVfETFGoRGtHBOE9EIxVYeF3CbBHsZekfrcgckkChB+dtNt0E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKruA91YNPZtM0GK3z2oX/NCfjOEH6faEAXcz7e++jYe6gGBk3
	IM0wsIYrnVzjLeiniwsw1VuswmjpQsvXWJI9MSHF+Y48+j12Y5FZhbCkVra0QMoN5Rs=
X-Gm-Gg: AfdE7cnzXgR8LKz7oIZUvmveASkuH4/ZQoiUSpjEv3xIGCF/NXmivUII5GYoQIegkV0
	6e63UHA5SBUE2xYLR56Xj4R4xXeBNfmjZTLgDESULjWeW6SWpoBvrO6G6RAp4od2ZrQdZwTdrO5
	5qh+/FYZlbF+A/y2JG4Dp0XjroN4ic3C7DrgEK1Wbk2LsS3V+ZU6pujdycsGa8YWDK+aQp5JE3X
	OPzk3I1hNVFPAwGqLOMNHHlEh7OUy0fmTFq9n/xG60RlHrYDlKeZxhGvLFxxhlr90X3Eh0em7kW
	NKg+qaU3P+BFBl2vR0alGsl4Q3R4rYfpGIDhsQZGv19GZfVtiGM/xurdiJobzFs+EGTmHxVCs4Q
	MT9S3iDBodCo8O/wFyLgvDHzDCxkBDvZZMc8ydYpMzLKDd7r3aiTN0GzkM49zBODjTqF6vWIqk/
	qGrqvb2HPkES+v5n9cd7MBWVa9Niz6q8UFAuzFmT1bAjmfPXp914VV+BVMxQ==
X-Received: by 2002:a05:6830:82d6:b0:7e6:50c0:87a6 with SMTP id 46e09a7af769-7e92d83a030mr2776195a34.8.1781880128987;
        Fri, 19 Jun 2026 07:42:08 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:dd8:d93b:3cde:c07? ([2600:8803:e7e4:500:dd8:d93b:3cde:c07])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e92e031985sm1998461a34.0.2026.06.19.07.42.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Jun 2026 07:42:08 -0700 (PDT)
Message-ID: <af4dd7a8-4823-4f84-bc88-4b5d8d35237e@baylibre.com>
Date: Fri, 19 Jun 2026 09:42:08 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] iio: ti-ads7138: Disable STATS_EN bit while reading
 conversion results
To: Paul Geurts <paul.geurts@prodrive-technologies.com>, jic23@kernel.org,
 nuno.sa@analog.com, andy@kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, tobias.sperling@softing.com
References: <20260619090004.355053-1-paul.geurts@prodrive-technologies.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260619090004.355053-1-paul.geurts@prodrive-technologies.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/19/26 4:00 AM, Paul Geurts wrote:
> The device might update channel data while it's read by the host,
> providing a data race. Disable the update of the channel stats before
> reading the values.

This description seems a bit short on details. It looks like this
driver doesn't support buffered reads. So if we disable statistics
during a direct read, why would we want to enable statistics in
the first place?

(This driver suffers from the comments say "what" rather than "why"
/* Enable statistics and digital window comparator */ so it is hard
to say what the original intention was.)

Can you explain more what this race condition is about and what
happens before the fix vs. after the fix? People generally do this
with two columns showing concurrent function calls.

It seems to me like disabling statistics would break IIO_CHAN_INFO_PEAK. 

> 
> Signed-off-by: Paul Geurts <paul.geurts@prodrive-technologies.com>
> Fixes: 93a39542d3c3 ("iio: adc: Add driver for ADS7128 / ADS7138")
> ---
> 
> V1 -> V2: Checked return values and prefixed iio: in commit msg
> 
> v1: https://lore.kernel.org/all/20260619075646.4100193-1-paul.geurts@prodrive-technologies.com/
> ---
>  drivers/iio/adc/ti-ads7138.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/iio/adc/ti-ads7138.c b/drivers/iio/adc/ti-ads7138.c
> index ee5c1b8e3a8e..81380fd2badc 100644
> --- a/drivers/iio/adc/ti-ads7138.c
> +++ b/drivers/iio/adc/ti-ads7138.c
> @@ -237,11 +237,21 @@ static int ads7138_read_raw(struct iio_dev *indio_dev,
>  
>  	switch (mask) {
>  	case IIO_CHAN_INFO_RAW:
> +		/* Disable statistics update so the value is not updated mid read */
> +		ret = ads7138_i2c_clear_bit(data->client, ADS7138_REG_GENERAL_CFG,
> +					    ADS7138_GENERAL_CFG_STATS_EN);
> +		if (ret)
> +			return ret;
>  		ret = ads7138_i2c_read_block(data->client,
>  					     ADS7138_REG_RECENT_LSB_CH(chan->channel),
>  					     values, ARRAY_SIZE(values));
>  		if (ret)
>  			return ret;
> +		/* Enable statistics update after read */
> +		ret = ads7138_i2c_set_bit(data->client, ADS7138_REG_GENERAL_CFG,
> +					  ADS7138_GENERAL_CFG_STATS_EN);
> +		if (ret)
> +			return ret;
>  
>  		*val = get_unaligned_le16(values);
>  		return IIO_VAL_INT;

