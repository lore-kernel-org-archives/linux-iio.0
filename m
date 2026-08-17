Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A4473C3F69
	for <linux-iio@vger.kernel.org>; Mon, 17 Aug 2026 11:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786964638; cv=none; b=QkJGk3paTOCqAEYUIrjRWo0zwRGtdE978XKvgspJtOhCnn4dd/hG4KNl/2kzAowhdATayyBd6qY1a8lDJQPN7pH2PVwLYntjbWeaUy0ZVXP4ea2OcCCJtAN+OSQdt/zdbNS0oo03o1JSli39aU+F/7wJ+Lk5ZViXa1z8Q6rRU6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786964638; c=relaxed/simple;
	bh=UVOCMtcyrfHs/Axz/F/mt3T12esPR3HkihmXhokS90k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LVIVTZs69k+kYj8daGbNGs0ecm62A/i9shv3UULUH8rVKtI9Ila9NtHR7yS6dNRyHZYAx/vJ4oBhmj2hiMar7+ZfTk4yeNy6MFyOVG3m00lk5c6KcG4Vet/se4WGpEg4gGgeNaae+7Db++i2Ins37o8si2GUKnN6fWOOCQOCl+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pAvJo8WU; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pAvJo8WU"
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5b29599b81cso4499714e87.1
        for <linux-iio@vger.kernel.org>; Mon, 17 Aug 2026 04:03:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786964635; x=1787569435; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5roxsSwPYXmdBRG7+L0luHhV1ywCWm3yG7rXSaCHp/g=;
        b=pAvJo8WU+ZEoxbj0AhDNp9JFeiAbxjm+qOaUTbuE87KAzHHFNyGijMgZZUs1+O1as8
         6Fmp4uU3jLVN3/17YMUEVHtp8t7XwCqDyksEELv9HDQOz0kV+7EvaCi6biFa/dEIMr4Q
         1EaPRUpghXUmTkTRdiGXt9FHiEeP3IfqWsbk0Eigj8BMPlUT54RzaKutm5fVjwSWdPdA
         /tOER1VbQD1T0JAsh09lVEwlBQ7zMJcQ9uFGy7gktZY2/NFUWpOGT3rAMYWF7ENBbMln
         YXrTlefsDj6UdKLRSjltLdBxxkq8kUCrplDCwj/PIu+DgH4DQ7Jwugfz4B4KRgr7tXv6
         cv6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786964635; x=1787569435;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5roxsSwPYXmdBRG7+L0luHhV1ywCWm3yG7rXSaCHp/g=;
        b=nNIbxMjvKodkGqtCBzZVUXT9zpgBwz1XGw5kRQXcJ2VML0aGt7e3ByGOe8vWMIOJNc
         uB2mOrnBxHif5fwLXRki/yhADJ+4k1h83SbjwPWFE01HKZzi1bFLJbuTJUKM1XE3//N/
         0IQ5fqpNM3nBwOiX+u9kv3UFYWlshHZgKoEG1ybfSFBhtElOgR/DetZpdxa2v8mY9Gek
         wHCu12SZApNGa/8r+QrTbMZYuwm/2lGFjyiHx4X78tcUvGGtifn0Wivp90zx3jiynvBX
         +WnWy13THBqGHIaG6PHewejfELai90JKpnJjDR61mappo6mVJBN0X5zv/P10BiGV29g5
         Q4gA==
X-Gm-Message-State: AOJu0YxwYs/cGvPHGgUbgppdj7gyUyvLGaTlw0iFBHBo+mebdiUtcqfF
	j91NGgsBD49FYIzxR/GNlYA6BLcW6EXMNiLb9kQKE/0Wts0RZ1DxBbne
X-Gm-Gg: AR+sD12xc+d+aI66FGGO59aKfeQ0pLC7RYEY7ssmwSP3ZpeWayOgyFECf8jyqs+w7Cq
	5ITtAxJmeRAUMivzrRdOhIFBNZuW6GU2d7lvesaGtNqMqBewZgrfNhwuu78L1/XGGtY+1Y01JSP
	TRNpnmc0NNl5LYtSEueYgm0fMWzgoRDN7VCJPp35S2gLMEAl6vHvK5CcKKUn7vbUT66D7L4zA+H
	20IdEcIo695PhZXL5bPVwrzDJvLgdj+oAYt8+7X4078q4mIlauw5xZgJsje6aC62IJsvh5KLlKl
	Ad5dhpT9SA87gqDqfgNjvUN31GpArBZvtXPkPNifptga0pIe5dxlfJ0/p2V7kroS38/u13/htGj
	ozqp5DJoO+n6ZNO+a6qdpFVoCL+DR/mcahU/+wQU2+vWD4+wt7UmE+x/GN0z1YUgfOgV4ltuf7X
	QizqCCmgNMjyRVkpjjgwK3lJcjL6IqzmC/iU2aFkLJ12cm2gpOygyYY4kdA0WTXR/DQbXrG67a4
	vkzAl8YZ9/OESQ3HaSzEvNPEZiH+LUm9OglzF3HzqoL
X-Received: by 2002:a05:6512:159c:b0:5b1:5a31:85fa with SMTP id 2adb3069b0e04-5b459112f5bmr3161805e87.16.1786964635159;
        Mon, 17 Aug 2026 04:03:55 -0700 (PDT)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b46cf95db3sm306642e87.12.2026.08.17.04.03.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Aug 2026 04:03:54 -0700 (PDT)
Message-ID: <7155f6fd-435a-4176-aa9a-79888e0b5ccc@gmail.com>
Date: Mon, 17 Aug 2026 14:03:53 +0300
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: gts-helper: fix error headers
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>,
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260815-iio-gts-err-headers-v1-1-3a668373aaae@gmail.com>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20260815-iio-gts-err-headers-v1-1-3a668373aaae@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 15/08/2026 01:23, Javier Carrasco wrote:
> Both industrialio-gts-helper.c and iio-gts-helper.h use error codes
> defined in <asm-generic/errno-base.h> (usually included via
> <linux/errno.h>), but only industrialio-gts-helper.c includes it. On the
> other hand, that file also uses error macros like IS_ERR() and
> PTR_ERR(), which are included in <linux/err.h>.
> 
> Add the right includes to provide the used elements from the error
> headers:
> 
> - <linux/errno.h> in iio-gts-helper.h
> 
> - <linux/err.h> in industrialio-gts-helper.c, which in turn includes
>    <asm/errno.h>, which only includes <asm-generic/errno-base.h>
> 
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
> ---
> I stumbled upon this while refactoring veml6031x00.c
> (which uses IIO GTS) just because clangd threw a couple of errors where
> -EINVAL is returned in iio-gts-helper.h
> 
> In the end everything compiles anyway, and therefore I have not
> added a "Fixes:" tag, but please let me know if that is really required
> for something like this. It is also true that if the gts header is
> included first, the compiler will throw the same error clangd showed me
> and the kernel won't compile... Unlikely to ever happen, though.

Unlikely or not, this sounds like an error to me. Hence, I don't think a 
fixes-tag would be wrong either.

Anyways - thanks!

Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>

> 
> I have compiled and tested this implementation with the driver I am
> attempting to upstream without any issues.
> ---
>   drivers/iio/industrialio-gts-helper.c | 2 +-
>   include/linux/iio/iio-gts-helper.h    | 1 +
>   2 files changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/industrialio-gts-helper.c b/drivers/iio/industrialio-gts-helper.c
> index 4f52dc373abf..af6ed37fb34a 100644
> --- a/drivers/iio/industrialio-gts-helper.c
> +++ b/drivers/iio/industrialio-gts-helper.c
> @@ -5,7 +5,7 @@
>    */
>   
>   #include <linux/device.h>
> -#include <linux/errno.h>
> +#include <linux/err.h>
>   #include <linux/export.h>
>   #include <linux/minmax.h>
>   #include <linux/module.h>
> diff --git a/include/linux/iio/iio-gts-helper.h b/include/linux/iio/iio-gts-helper.h
> index 66f830ab9b49..f63a482b82b8 100644
> --- a/include/linux/iio/iio-gts-helper.h
> +++ b/include/linux/iio/iio-gts-helper.h
> @@ -7,6 +7,7 @@
>   #ifndef __IIO_GTS_HELPER__
>   #define __IIO_GTS_HELPER__
>   
> +#include <linux/errno.h>
>   #include <linux/types.h>
>   
>   struct device;
> 
> ---
> base-commit: dc59e4fea9d83f03bad6bddf3fa2e52491777482
> change-id: 20260814-iio-gts-err-headers-d7ecb6b5ebb7
> 
> Best regards,


-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~
