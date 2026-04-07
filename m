Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 398D929B77C
	for <linux-iio@vger.kernel.org>; Tue,  7 Apr 2026 14:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775572139; cv=none; b=YTg7TqmrwUgUP/1npeRvxbkrGUtJC4LeMtaLARbdNi/HaNMjplfn7dHNC58Zyi4KLGjxM0uQTsru544UUH3Sx5vzB7W72Ymi6/OAOSd8+qEi+pcAOuBJ+ZfwN0qbYgNrMqasBObKptPA9JPVlp9Q55wXDBqmScLXsbks/sk6wws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775572139; c=relaxed/simple;
	bh=d7UpSrfbpI4G6p2BHH+mfddLQqZpbU5y2K5JYzeOLAE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k97iK4ekEE3BG7/E90fz7HC8L4GE9FzdYx9MImohX9rNRVQBCIESz6X/M+xemJApVUuV0EgzjKPrimOkTJafIchXWBPTDyY9eohmUndhaeV7B8fLg6Oha4YKboid3PJkyUXU2Kz2dh6V3f7YVplkAABeLEv356yFj0FxSPgw2Zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b=WGCmB85F; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="WGCmB85F"
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-7dbca22dbfeso1726297a34.1
        for <linux-iio@vger.kernel.org>; Tue, 07 Apr 2026 07:28:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1775572136; x=1776176936; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lTm18GHCQslKVGuSjQPscd80oIVhhMGMJSAKTiAZu2U=;
        b=WGCmB85F/JRaiozyDUF8VLFX2teESp26OzEiKtiR+BM0DSAz0xQjc/X4opso67fLYk
         G5dLJMzSEsuJTiibdh8CBHECoF79/w1JSnHvOeooemGQAGJUWVris27HeuF4jy2e1ugq
         qesy0WlKTg1orHYJDGcxDgtgIGv1WpQ0HI+82S/BDsGiA2EGYxwH7KzxdBYN8QejKobG
         Wcd+9AdxfA4jvevD0+cg+vomrd/fno0hFTcp0JIfPD8G1lhF7FlkUAh2oNm8bJ2qo3s2
         BNkcBjlQh+tiK2Xe2TIbF33AcSxM4jkpxqxzXOOHfH5ver0mmUbMqvST4KzE07J+2zPD
         2dcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775572136; x=1776176936;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lTm18GHCQslKVGuSjQPscd80oIVhhMGMJSAKTiAZu2U=;
        b=pG4yq2NJXzaTophVPKwjXoL+dcp8Xq0hl3WzA1SXw1UeCrnGsDRYNNuaOiAh2zqogz
         chR3DG0WeJXZAHJs/Pb+ExV0FcJBti6z99QfeGL9itLWxCjNDI/8ME3ShXLPxOWma4z7
         GOXLxCN4O4o/btU83A3Mb5+z8OvEkvg5T8vWG1E2I7a38rJkGXe71BzQKrRZexqPNAzR
         4KHM15rYzm8pzBwEuhfzjNfQWgAv9aZMhuCQWCiXF4D0UlSo0ixTywcGaoSDf8bd44Y3
         WEmTXjWPYSgOmBgpj+Opm5/Vee+2gnDAL93TQ95mzz1m4v+telT8YD9YZhDjL3Nxkxr+
         17Kw==
X-Forwarded-Encrypted: i=1; AJvYcCVbfMa8dRWb5Lj6uPaKNkKKUu7SoX6xXWe7lSqB7RKWBzK1mh/6PvTXNhtxibipfk3W6jXpsf3Gw2k=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeAKgS0x6BalLofni4s0nNZ+nOm6TRJWGKeXNUVk8S6A2p9lW8
	qtq0zgW5nXSS/NCPjxid9Voqn3NOLbgMI2fUWVgI5RDisxQFCqMKb64c9F9z2hkFN2g=
X-Gm-Gg: AeBDieslkxj6x6nsHaK+H1IU6ak1GME/EYoaSqQqQ0q13QfX7VomYYjDa//Pb5kIjbW
	6bONzjZUCx6dE20XK0uoNxd7htCRAKvS7Imy86XT6iFQc4RTNkLocPHjC74Ycamtmq/kGHeYjED
	XoAGwizfhVa0xuoAEta4CNf5byymayWAWjOX19qI5F0eoAtZnWkC2tPTdEFy5CjZnxJFuCQHcJt
	hnzPMFt2+urt52d1Kr2SCshWoGvpt8LOP2YzgAn8flD5D/zAiGK632Riot2ZfhDet519I5kAF1a
	970wFqmAwDxrPVGxbbDODbwJe1/dVhBvdi4NzLt3ONpAAr/jmEfMnwUjA16IOez5N2Cu71GVeZb
	+BX1JLzpQ6UbHkWIcnwY+RxvzN09L1S+C2D9aWTeexZXCdIENWLLCNvUg1DmXNL4AbWFy1PPPSq
	BST7X/Feyv/6ESKs2U7BfmVggFqMjXRgqRaRlHDX4sF29ayJsfITfo2MVM221evepBuiovyzfxQ
	g==
X-Received: by 2002:a05:6830:630b:b0:7d9:ad99:9ff0 with SMTP id 46e09a7af769-7dbb75c800dmr12345931a34.30.1775572136154;
        Tue, 07 Apr 2026 07:28:56 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:f738:1ffd:6365:30a7? ([2600:8803:e7e4:500:f738:1ffd:6365:30a7])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7dbfc1cb11csm965710a34.3.2026.04.07.07.28.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Apr 2026 07:28:55 -0700 (PDT)
Message-ID: <710e2da4-2815-4137-84c4-1f148ec0a23f@baylibre.com>
Date: Tue, 7 Apr 2026 09:28:54 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: chemical: bme680: remove unused BME680_NUM_CHANNELS
 macro
To: Nikhil Gautam <nikhilgtr@gmail.com>, linux-iio@vger.kernel.org
Cc: jic23@kernel.org, nuno.sa@analog.com, andy@kernel.org
References: <20260407090327.4987-1-nikhilgtr@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260407090327.4987-1-nikhilgtr@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/7/26 4:03 AM, Nikhil Gautam wrote:
> The BME680_NUM_CHANNELS macro is not used anywhere in the driver.
> Remove it to avoid keeping dead code and to improve readability.
> 
> No functional change intended.
> 
> Signed-off-by: Nikhil Gautam <nikhilgtr@gmail.com>
> ---
>  drivers/iio/chemical/bme680.h | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/iio/chemical/bme680.h b/drivers/iio/chemical/bme680.h
> index 7d86ed8b02e6..e10d3aaaca23 100644
> --- a/drivers/iio/chemical/bme680.h
> +++ b/drivers/iio/chemical/bme680.h
> @@ -68,7 +68,6 @@
>  /* Datasheet Section 1.1, Table 1 */
>  #define BME680_STARTUP_TIME_US			2000
>  
> -#define BME680_NUM_CHANNELS			4
>  #define BME680_NUM_BULK_READ_REGS		15
>  
>  /* Calibration Parameters */

It looks like it was intended to be used in drivers/iio/chemical/bme680_core.c:

struct bme680_data {
	struct regmap *regmap;
	struct bme680_calib bme680;
	struct mutex lock; /* Protect multiple serial R/W ops to device. */
	u8 oversampling_temp;
	u8 oversampling_press;
	u8 oversampling_humid;
	u8 preheat_curr_mA;
	u16 heater_dur;
	u16 heater_temp;

	struct {
		s32 chan[4];
		aligned_s64 ts;
	} scan;

