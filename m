Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FDB63DEFEF
	for <linux-iio@vger.kernel.org>; Thu,  9 Apr 2026 15:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775748320; cv=none; b=i/ts5LjxIzBtYG5i+wL3EOLKRBTe53tdPMG7dWwj5z5ob1pK/kmcKVtrTjx5cC2T9TVKRYuQUHV3iK8mSoANppLnPoMLl/O9G6kKOPpsBMinEf+ylVDblPIqmD2hfj23iyWPXLMOylLYBOT1ahZUmupDhW3JsshYMHy+I15el/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775748320; c=relaxed/simple;
	bh=AGjnYjPqVLDifeRVC4/yNZFHk+1e358dreo3JoaGM/A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bI7+CEzwWvX0dpS41fOfA5f5c7FUnSURHUlSoPljPprVcWpT/FhszNHEC2S8nM5TUCRXdvC/PjmLzPtX0lJVlM7ueozu07xs9Jtmtj1yCIFmjmApmGTy7kkXGMp3uKbX2zADfUXcjNh3ZuL1RjoUUcSf6AO3YASjI4m/9RpfLKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b=GoPqFCB8; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="GoPqFCB8"
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-7d86eb7c854so532881a34.3
        for <linux-iio@vger.kernel.org>; Thu, 09 Apr 2026 08:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1775748316; x=1776353116; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FN9TaQKqyBYuIUQ0wOlXr8V4u8AjLHkSQhs9XX2t4Bw=;
        b=GoPqFCB8oXKhKcGkFVVrBxA2ACtu6QbFh9sxSrU0YXjfmeoTQthI7n3YSsfJXGR4rR
         ku4DduN5CUfHYKJW3plSWwN2o4Zy/40DSbabyoEgo4ruOZ/4p7vWZWajgPCFqy04hwRf
         KWd/mLIevu0B0cuvUXQOgy/gVGYcUe8jcmG2cIesgKYZNequkEJv0FpNfytGBeyDE1ER
         nHBladWUYIHaHT2PKcrQczMlSWYr1+OqGQznAmsqqD9zbXjT9yFzhmxLHam0tpytAxzy
         2QiIAwJxQKt50lIVYhUlRkXdy/fVeHJhmTHCHUCU9vT0kecVz/CNwgFZSaURIwTRKY3C
         XnmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775748316; x=1776353116;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FN9TaQKqyBYuIUQ0wOlXr8V4u8AjLHkSQhs9XX2t4Bw=;
        b=YllSNVGf2ceCHmG3SAXrW5POxWGOV7pgwh9wH3LDduaLpIdTObtpbrm1bsT8bFhfgg
         PTkIeG63zQeTNVyVtGHiSJ8iIESctOuQh4oAeLIM6cZ0v2Bl2gKRD0417GFMl1ksIyEv
         nyXoXJyauub53WR87sDcSoDZCzyUnaFarbWoMBnXRCDdxHQvcirgTbmjDAqhRvRhl56Z
         eCkOSNV2WZDqjaczpz9HacngGs4V5AmqEfnBjxpkDjVRwOwLmwEatSpDQ7jGWUbJsI57
         6zLueGrwndWhXhDp6cvWm8mzm0mNLTCkuJHE5RIpdVpC09w3EnGos3O1nCydkvlYCcSJ
         qJlQ==
X-Forwarded-Encrypted: i=1; AJvYcCU4kvu6cLbW6wK6fCSZNdTUItyypKpfuDQjlbvDe6AtSs6DFPk+NpaIh3+63KiBzJSj+yppynT0xT0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxuw6sBTR0Y6dhQ2Q/2vNyLXgX77mNZjgh4uXiA3q4ErwcgAo8P
	877I9fi4bLWNv/AOPQeQ1Ky2Bxp5icGkThCSm5vjxeLJyFSWjMJuriigKBN0WXM87nM=
X-Gm-Gg: AeBDievjmOwSFrJ4Af7BV4C90+fIxUWfuHRDQIF91k85tFrG2zsr4CX9LVSADEJDUSX
	zCcHCwMX80036p+7O1ssYCcHekHdkHECnCL5vP9Vlwtqc6BiAw7nwXzxtMRnM/DosSQLz9rYDtJ
	L44TQCSsOIBW0ljp77T95zvY1PJufySJG2JBDQYD02lsWULDQFm3Ob9ehIMY7p4RzQCBfmsjlE4
	XNcyA/JgonMjzEwIBjmi7oKBYOfd1p6XvGoxh3bXodjKzIxsnJbVMFCTM3k3NxnKyrb/YX+r28g
	lmqYX/0i89ZSS/8E3FHFEeQbHLMRVbObTF1V1Qw9OzzqiFKvr3mJ4O+PS7lVhotxqwzD1MW+IlT
	neZKSgEDAjjiMkB7wJmIvqr7S8PlMXpxQiz23+a3jdfV80LGA+InDf9uTSnx4vB46Tj1DVnWBJF
	Tp45S0+ujNp65JB+GHwoSJEO+s4IDl054cS+c6HbRPo9Uam/BcnHjm/O1Xw8r7/8wseMU+1ZOdD
	18zl3sqPP1D
X-Received: by 2002:a05:6820:134c:b0:684:7d3b:4378 with SMTP id 006d021491bc7-68a605ebc5cmr1959172eaf.4.1775748316533;
        Thu, 09 Apr 2026 08:25:16 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:a548:cf0c:d054:fd01? ([2600:8803:e7e4:500:a548:cf0c:d054:fd01])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-68bc491592csm120eaf.5.2026.04.09.08.25.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Apr 2026 08:25:16 -0700 (PDT)
Message-ID: <590ff995-00c6-44d5-bc24-d4cc2b7547cd@baylibre.com>
Date: Thu, 9 Apr 2026 10:25:15 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] iio: imu: st_lsm6dsx: fix stack leak in tagged FIFO
 buffer
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-iio@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Lorenzo Bianconi <lorenzo@kernel.org>,
 Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 stable <stable@kernel.org>
References: <2026040947-overhang-fax-02d0@gregkh>
 <2026040949-ferment-reload-abcd@gregkh>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <2026040949-ferment-reload-abcd@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/9/26 8:40 AM, Greg Kroah-Hartman wrote:
> The tagged FIFO path declares iio_buff on the stack with __aligned(8)
> but no initializer, but there is a hole in the structure, which will
> then leak to userspace as ST_LSM6DSX_SAMPLE_SIZE bytes (6) will be
> copied, but the space between that and the timestamp are not
> initialized.
> 
> Commit c14edb4d0bdc ("iio:imu:st_lsm6dsx Fix alignment and data leak
> issues") moved the untagged FIFO path to a kzalloc'd buffer in hw->scan,
> but for the tagged path it only added the alignment qualifier and not
> the initializer :(
> 
> Fix this by just zero-initializing the structure on the stack.
> 

Reviewed-by: David Lechner <dlechner@baylibre.com>

> 
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> index 5b28a3ffcc3d..48291203d1cd 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> @@ -609,7 +609,7 @@ int st_lsm6dsx_read_tagged_fifo(struct st_lsm6dsx_hw *hw)
>  	 * must be passed a buffer that is aligned to 8 bytes so
>  	 * as to allow insertion of a naturally aligned timestamp.
>  	 */
> -	u8 iio_buff[ST_LSM6DSX_IIO_BUFF_SIZE] __aligned(8);
> +	u8 iio_buff[ST_LSM6DSX_IIO_BUFF_SIZE] __aligned(8) = { };

Looks like a case where we could follow this up with a patch to
use IIO_DECLARE_BUF_WITH_TS().

>  	u8 tag;
>  	bool reset_ts = false;
>  	int i, err, read_len;

