Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E634274FDB
	for <linux-iio@vger.kernel.org>; Sun,  1 Feb 2026 19:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769972804; cv=none; b=GdpBcThpnspdFI+CyBJBI/5kci4rIMbd6qL8F1N++Ab40EIPCH0jdtIeJ/Kq18PsbT6hvHfpf5jGO2DA/Vw5ejfVWasf0v5jP6XEEhF0LjfEcxx+e5Tpw9ThBq66c/n2Kp/S+5osArJ3aof95fciOBHcPChXXZ3wcgPUIo81ugI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769972804; c=relaxed/simple;
	bh=FHBCSbc/MBTQbG2EGdkEpIvHeDPYDnFviPtcBWuxs/k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RbZexsBbUkKn2uKF0IJhZ4tt0ppqOEnu4AaKV5X/jtlQG4Ic5H7/wQirX8vaq53mFicVzlVtEfdlkF364snqiiVMCDIP4rIkRXWJLzGs90ovbblQa1VSdx0bFWYzGH38Sy3x8LSdPw43ok1D+D+P/949btLy0MhPedSOrGU9ulQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=jjlI6WES; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="jjlI6WES"
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-66314fa03c9so1272670eaf.2
        for <linux-iio@vger.kernel.org>; Sun, 01 Feb 2026 11:06:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1769972801; x=1770577601; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3vpjgpzMDJ+JdTfciP67JHeLgUTGZm6k2MW+XRPJY1c=;
        b=jjlI6WESEC3BRPJEqcyxVPsuP5OPMWIvDx4cPtvODnxI4w6sb3Y/IswHc1KYwnP5o5
         XKebPsFrmrFRxhZ8BgPKDKfbqw9zuWRM0EGe0v5mC73+JrZaSilM0ZNB5V+lFsSuFqDn
         JLEkaxATTfpVy4gNNuof7/bGlk4LqRuDqgYUmhUZeJGMIB6t5EKD8Tb+cS7/HvkHfeOD
         8toJqTUYuMQW5A2qhstUX23Hq3nkp/Zueuuw7NF7yG5aoRR0N1Ijn8czfCX5xoN7yjXj
         MW4+BcvlHbVndaqHrlKSV1fxbYnmp5jUKTjqVt/z4FjDWlYo3vYFnZSzJv4hjCVn7ZCI
         sIgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769972801; x=1770577601;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3vpjgpzMDJ+JdTfciP67JHeLgUTGZm6k2MW+XRPJY1c=;
        b=TIblXUNMLEzVg5VWeIGspf9mVbZGMLeAp9VLzJ/wYRMpgWzSCmbCiowXRIvIHUdGKG
         03AO6cNarNyPksfGNBhCFp+zKtUPt3kqvNaoehnZwsGjldXfbbDP7hhsT4N2o34Os+Sq
         ZlAHzJM32jVHwBdYYTIn6KOab0skCKJYBSEJhpg35ivID/3vRDMNQanPPwubjDoOqOaN
         8YyOtWcvNbyUfP/6Y7qK6p1X3okFqtof8HL/q4ds3ovY46Io8BdVzF3UQM0FJkWfS47U
         tFlqxCt/coJrTzq5K20sBo/KiPg9bgKjQCcXMg1Nfcq8KSkwV127Vod3tcg9ETlJoU47
         jGHg==
X-Forwarded-Encrypted: i=1; AJvYcCX2cvBbBBd3nqVdyB8HdrukGWmFQTF+SRh3996VB3i3Vvq8eXgORpSg9XJ3QuBRxAOvFmV2fCMPDaw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzF0xGSavdkDm2Y2oJXTFhbLLf/Bg/mOcfcY9MYromONgY1Onmb
	QbLK3ThgWaQVUR22LuS0b4DZdrpC3XCMNZFzmAOURstQDlG0tHGH7rQYuPFcfPB41hryyMbXS9S
	LbKcb
X-Gm-Gg: AZuq6aLySghORT+pQ/g1GSUA4o+CcuTMXkXYldNUwRmgJDZb1LhtJTVQO6kebcQTMAD
	4fkFthwalnFi78i1ogcdhWdsPqyEED3FNAi0bUa0S5WzjvNN22XlOcUuK+1CkTzmetUyQgnQKat
	pLQvGt36y03b3JgjRoK9hLLAjHC9V01F5EV1PXZwI5QDgeg98CIws38JRn0a3EFvlRPxWw0kBqj
	0gYEw1BePuFD2n8tcbqkPYvcOsdEGxr26MIgKgI6z/JXL335EPkrqxH6KJwfngrLXmkGM7IcaiO
	wSJOQdY/q8+1IiAUasP1vCV4ydf+T9+7Odp9OqlDxHbb/Se8rw7E9inXPseVqfEABAS7qQsMxsp
	aEdp+lvLrG3l/Fx4Du+7P8lTzIbuIm96acC7Ui3fXtQ+RvNyhK3BKXRnBw2jcFNcq2hlKvVqvZo
	e548X0W9/MYLRoEK0peY4mhP1XwjJL9voeHPejdCVAb43VVEBA9bEri7IjjhKt
X-Received: by 2002:a05:6820:623:b0:662:f452:648d with SMTP id 006d021491bc7-6630f01c0e0mr3876565eaf.9.1769972801465;
        Sun, 01 Feb 2026 11:06:41 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:66ee:10f7:4858:7df6? ([2600:8803:e7e4:500:66ee:10f7:4858:7df6])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-40956cd8290sm10089242fac.0.2026.02.01.11.06.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 01 Feb 2026 11:06:41 -0800 (PST)
Message-ID: <afa85a59-07c7-46c9-990a-b0b34599cdc3@baylibre.com>
Date: Sun, 1 Feb 2026 13:06:39 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] iio: core: Add IIO_EV_INFO_SCALE to event info
To: Taha Ed-Dafili <0rayn.dev@gmail.com>, jic23@kernel.org
Cc: me@brighamcampbell.com, skhan@linuxfoundation.org,
 linux-kernel-mentees-archive@lists.linuxfoundation.org,
 rdunlap@infradead.org, nuno.sa@analog.com, andy@kernel.org, corbet@lwn.net,
 lars@metafoo.de, Michael.Hennerich@analog.com, linux-iio@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260201183320.27023-1-0rayn.dev@gmail.com>
 <20260201183320.27023-3-0rayn.dev@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260201183320.27023-3-0rayn.dev@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/1/26 12:33 PM, Taha Ed-Dafili wrote:
> While implementing event scaling for the ADXL345 to match
> the IIO ABI documentation, I noticed that IIO_EV_INFO_SCALE
> was missing from the internal enum iio_event_info.
> 
> Add the constant and the "scale" sysfs string
> to allow drivers to expose these attributes correctly.

I think this could be worded better. The enum member isn't really "missing".
Are there actually any users of these attributes that have implemented
it manually? Or is this something just in the docs but not actually ever
used? I didn't look very hard, but I didn't find any drivers with these
attributes.

> 
> Signed-off-by: Taha Ed-Dafili <0rayn.dev@gmail.com>
> ---
>  drivers/iio/industrialio-event.c | 1 +
>  include/linux/iio/types.h        | 1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/drivers/iio/industrialio-event.c b/drivers/iio/industrialio-event.c
> index 06295cfc2da8..5096baf233f0 100644
> --- a/drivers/iio/industrialio-event.c
> +++ b/drivers/iio/industrialio-event.c
> @@ -256,6 +256,7 @@ static const char * const iio_ev_info_text[] = {
>  	[IIO_EV_INFO_TAP2_MIN_DELAY] = "tap2_min_delay",
>  	[IIO_EV_INFO_RUNNING_PERIOD] = "runningperiod",
>  	[IIO_EV_INFO_RUNNING_COUNT] = "runningcount",
> +	[IIO_EV_INFO_SCALE] = "scale",
>  };
>  
>  static enum iio_event_direction iio_ev_attr_dir(struct iio_dev_attr *attr)
> diff --git a/include/linux/iio/types.h b/include/linux/iio/types.h
> index 34eebad12d2c..4e3099defc1d 100644
> --- a/include/linux/iio/types.h
> +++ b/include/linux/iio/types.h
> @@ -21,6 +21,7 @@ enum iio_event_info {
>  	IIO_EV_INFO_TAP2_MIN_DELAY,
>  	IIO_EV_INFO_RUNNING_PERIOD,
>  	IIO_EV_INFO_RUNNING_COUNT,
> +	IIO_EV_INFO_SCALE,
>  };
>  
>  #define IIO_VAL_INT 1

