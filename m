Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FACC2C234E
	for <linux-iio@vger.kernel.org>; Fri, 10 Jul 2026 15:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783696877; cv=none; b=b1O5QEIqUHhxA03FKOfSPdfYevpCLrrgeHjdkLIQDHSGJkQWbZjCXd9Gz41j7Sd73KB2nkTVKqMHmrgYnXJpH05W8Oe8ka+8Bc5lOPgl9SWAkUQljBTh65kiemte7KIOXaHkr/eWkd28vxLn+OXk+/fe4ux3xXEe7X02nQ7OL34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783696877; c=relaxed/simple;
	bh=SqJcUT73x7eoB0S5h/3ctXw/oHOCbm6jUb+xoKd9M6I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l8Jqr0GGxhYUxGS3iuBN9T6zRIsFF/kWuI3Tph6S695aobY+/lPWn4uGXz0/6HzOI2r1DVIm6KLuTdhSw3PqRbJ6LC9lwrrDWCPiUo7Sl7qCTd02LeAZz4+RgKxGc9ai8NPVLd5XvohVH7/nHO4lcEdRHallkm9yoz/FYUDBlss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=lJw+CmBZ; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="lJw+CmBZ"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-81e771226b0so15656007b3.2
        for <linux-iio@vger.kernel.org>; Fri, 10 Jul 2026 08:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1783696873; x=1784301673; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5W0IIRCYefamj/FFcBfXSVL6e8CmPqSzJFbWhXGilG0=;
        b=lJw+CmBZ9FEP4GL6shV82q3d99qFztcwUAo2haH90jFQwAq59YWNOUuWuW5h7DlV3Q
         mvyNRRZevHvyWNX7mfl7fIJ1+SVRZllPyY+yq/rLeFk0xzSiFHodV8jS3t+bUxDNNaHA
         q9i7pCs0Q0ACKCR684kue7mKQUYkBAk1ydVpuCAuwu7tbuFsCqVCjGt1LAQX52yC6AKq
         f6D5xdIPitr6Tos9dGYmykfDEGRtp2svX/bIiMKc3BRDpB+6UvJjCpuG9L/C8ubqduQV
         ZT3DARzw2I2KbBnH9ObLQlshfYQh+oQvc0zVtejG+/5VZ8h9XvbryzMCajVdq0brfuN+
         5l0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783696873; x=1784301673;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5W0IIRCYefamj/FFcBfXSVL6e8CmPqSzJFbWhXGilG0=;
        b=l9bGQAtOIBjnvbCEzYyTOGzp5tqY97DWdQu4kRGZrlQ/6nF4ulPr6q9ZL/lu0NlC+W
         u22w+T9BmmF5KEBvcO0RYZzW3VdnTHvqXriIeNF6dxP5+I/lzRQy5RZM2SOCyoduOnC1
         gGXtIIC8sMjf60rl1mefOI3llyBxy+pSRndtb091M1l6QMbb+vAgKwvvIT6BQ3ZM2ola
         ibsT6LE3aJKyGv3qNAv4nQwNFc9k02qtCP8fNlLD0v38AXzmTGxH0qxcHLMAcMvChwoA
         UBrGtvenSPFmeiB5Zyu9Zy1nhUuGOwGyzHMMuQbcPLrc5TysSmFiw2pA43HqhY/9kBhk
         IjdA==
X-Forwarded-Encrypted: i=1; AHgh+RqshZEseREetUxeQSxP4sq+FBliJYM4HxwZXtUNkiV38wOm3lV7Oq2XGuv6ZARZj/0krcfZZyfaCDA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+wibFRW/QHZhSJFyuhi/ugIyO4xoc1r21Yu+VsUY53p6OiB58
	+UCleGsVwCuYnGNkU55fqOOyr1VPCXIG6ZtuO63ZDYGJNxcrqfmzN/UuqR+bQdVy8Ez6eWEdd/6
	OROCj
X-Gm-Gg: AfdE7cklRHQV242sWAEG+I2yRyb2pE3mpbMh9KjOqEKNVUHLApdRw0iL4Uundh70DYo
	pZwfCHSIJDG1n6wB8gzLV0PsNKmd0iJgtXPZarflq/l8oT4rj7aUxzXhDFMNi7qSf+LNNApmr2A
	A1gqs4/GEx7YkXWaeefzmg12bsIIiIBgytobB5KiNa+FWyCorT0jTaxd1uMxlZUG9htzLo3i+UO
	n63Ot0TN2jFcORt/5eUjd0xAKvEY4OS38Wu0hFH6hBuSK1vI3mGXiofWWsx76bwErQhwlrAFSlh
	xOe2SzsinZwmG4akUXgP01Q7r0QedZeYVbruxT1vG1MxcLkw5GCDkQeN9Dq1z4j3NvJ5bqfC9mp
	fsnGyHAPQKU5nLcsgTNnKbpuDE8V+Voh+RpyTl6n58dg2ADw8IirhTrqOxLKJP6CEP9opuJKayL
	82h/ORUcTSTu3EnpPGAKVm9Q2JFQh5brq/3dIlNHc9rFvyQ+47GzRmzEKiZVDm
X-Received: by 2002:a05:690c:e3f2:b0:81e:79f0:48b8 with SMTP id 00721157ae682-81e79f04e78mr35781247b3.7.1783696873086;
        Fri, 10 Jul 2026 08:21:13 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:1b03:95c:fbd4:4d00? ([2600:8803:e7e4:500:1b03:95c:fbd4:4d00])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81e6be9834dsm48620217b3.9.2026.07.10.08.21.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jul 2026 08:21:12 -0700 (PDT)
Message-ID: <9845b343-8138-4858-93a2-df8e01c7d64f@baylibre.com>
Date: Fri, 10 Jul 2026 10:21:11 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: proximity: hx9023s: validate firmware size
To: Laxman Acharya Padhya <acharyalaxman8848@gmail.com>,
 Jonathan Cameron <jic23@kernel.org>
Cc: =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Yasin Lee <yasin.lee.x@gmail.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20260710142212.52225-1-acharyalaxman8848@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260710142212.52225-1-acharyalaxman8848@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/10/26 9:22 AM, Laxman Acharya Padhya wrote:
> hx9023s_send_cfg() copies the firmware into a counted flexible array and
> then reads fixed offsets from the copied data before walking register/value
> pairs starting at FW_DATA_OFFSET. A truncated firmware image can therefore
> make the driver read past the copied buffer during probe-time configuration
> loading.
> 
> Reject firmware images that cannot contain the fixed header, reject images
> too large for the u16 fw_size field, and validate that the advertised
> register count fits in the remaining payload.
> 
> Move release_firmware() to the callback so the firmware object is released
> on all hx9023s_send_cfg() error paths.

This could probably be considered a separate fix (and therefore separate
patch) since it looks like there is an existing code path (return -ENOMEM)
where it would not be released.

> 
> Fixes: e9ed97be4fcc ("iio: proximity: hx9023s: Added firmware file parsing functionality")
> Cc: stable@vger.kernel.org
> Signed-off-by: Laxman Acharya Padhya <acharyalaxman8848@gmail.com>
> ---
>  drivers/iio/proximity/hx9023s.c | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/proximity/hx9023s.c b/drivers/iio/proximity/hx9023s.c
> index a6ff7cbe9e6..a2f9c077e58 100644
> --- a/drivers/iio/proximity/hx9023s.c
> +++ b/drivers/iio/proximity/hx9023s.c
> @@ -18,6 +18,7 @@
>  #include <linux/i2c.h>
>  #include <linux/interrupt.h>
>  #include <linux/irqreturn.h>
> +#include <linux/limits.h>
>  #include <linux/math64.h>
>  #include <linux/module.h>
>  #include <linux/mutex.h>
> @@ -25,6 +26,7 @@
>  #include <linux/property.h>
>  #include <linux/regmap.h>
>  #include <linux/regulator/consumer.h>
> +#include <linux/slab.h>
>  #include <linux/types.h>
>  #include <linux/units.h>
>  
> @@ -1031,8 +1033,12 @@ static int hx9023s_bin_load(struct hx9023s_data *data, struct hx9023s_bin *bin)
>  
>  static int hx9023s_send_cfg(const struct firmware *fw, struct hx9023s_data *data)
>  {
> -	struct hx9023s_bin *bin __free(kfree) =
> -		kzalloc(fw->size + sizeof(*bin), GFP_KERNEL);
> +	struct hx9023s_bin *bin __free(kfree) = NULL;

We don't initialize autocleanup variables to NULL. So leave this as-is
and just put the size check before it.

> +
> +	if (fw->size < FW_DATA_OFFSET || fw->size > U16_MAX)
> +		return -EINVAL;
> +
> +	bin = kzalloc(sizeof(*bin) + fw->size, GFP_KERNEL);
>  	if (!bin)
>  		return -ENOMEM;
>  
> @@ -1041,7 +1047,8 @@ static int hx9023s_send_cfg(const struct firmware *fw, struct hx9023s_data *data
>  	bin->fw_ver = bin->data[FW_VER_OFFSET];
>  	bin->reg_count = get_unaligned_le16(bin->data + FW_REG_CNT_OFFSET);
>  
> -	release_firmware(fw);
> +	if (bin->reg_count > (bin->fw_size - FW_DATA_OFFSET) / 2)
> +		return -EINVAL;
>  
>  	return hx9023s_bin_load(data, bin);
>  }
> @@ -1058,6 +1065,7 @@ static void hx9023s_cfg_update(const struct firmware *fw, void *context)
>  	}
>  
>  	ret = hx9023s_send_cfg(fw, data);
> +	release_firmware(fw);
>  	if (ret) {
>  		dev_warn(dev, "Firmware update failed: %d\n", ret);
>  		goto no_fw;
> 
> base-commit: 0e35b9b6ec0ffcc5e23cbdec09f5c622ad532b53

