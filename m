Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89A312BE7BA
	for <linux-iio@vger.kernel.org>; Fri, 10 Apr 2026 23:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775862769; cv=none; b=NQ3rJSs4Hn09SbgPMHH9WN+Y8xSY5QsWCLXtCADS2oMS+tMA4efvFp6tK927FNYf6vn9dfr62g5Rlgil/OZCYW4AlhcC3LnUuieyUTVMELBV6mdWrv8glOrXiUKOgV8i+YQWJ/UwM9EPbDVx36AhzriYmQCdxPizE6ERhmdYRZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775862769; c=relaxed/simple;
	bh=nGVHNncwAa0jMZa3Vi8mUSp64Rk5osX7WE0UhHCcqeU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=I3M6/yFauRB+9763u4aMPo2hgyAEctLPL3qbEmqAQRdkw0vdBrrKcDhB7A/IzMZ60AEYhb8mF+ZpKyp2vuffRVGDhwZOZJoR2qkaF/l3NNtQymAHxsVh3IzsKpYNPHjxrSz1G6SPobc8eWQhRXCqtzqaRlgGZeS4CAzsI1VNCs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b=SJQgym74; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="SJQgym74"
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-471bf5157d7so1266515b6e.3
        for <linux-iio@vger.kernel.org>; Fri, 10 Apr 2026 16:12:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1775862766; x=1776467566; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=L3ewuuDvvgDQq9A8j3yrls/qrp3b4gmrpAafPjJScy8=;
        b=SJQgym74MzRfX9A3WMH3k51oe5KzmEld4FjHPXTnmonHZiBRiDQaFjdQyNdp1ixdNQ
         8K3Gbwy44bzJrfVcCSXGX0IIwoYg0iWgQC8l/SXHlwH6rjAG34sHjyxFC9zxC5aoA6WR
         OrLyiNmMzq90f5S3230ZiYHzkVAoW/F6uzfnbUVLNgyG6EMhgNxis0cLez44kCKUXMcp
         z9vZxj5gxZPwbrS7taMVcBOQxj7ChOkxXjUoUx15Bxpv7VCDsEgwuM8JgIY4LeJRKPU9
         3MQIhueNCM1CQRhewnbY0eg2VSQ40/HlnmumGnLwLT1qbBYBCNA2hTIGh/swVdFA63Wp
         rLCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775862766; x=1776467566;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L3ewuuDvvgDQq9A8j3yrls/qrp3b4gmrpAafPjJScy8=;
        b=QrJgOJrkc03mBa+RkFo/HXyGqploRtaQ6WQ5uOXWyrJPi9kAPkIU6PP+od3/oTjpHV
         pV1yykoTmeNWhyYaUyMEjG+pUnIuL+c0mYC7nJbRncrss9C5ursxS1qTjH/bh/J8Ddy9
         TMNSo8nPkcpg5XwVXUUWkLFLsRFnjpi3QhPLLxTSiwQrcWxYRWgK0TtsBMWt84ScfY96
         OZxjqkTTq34hRqo7IbqXtGCLLlQIQK4941IzTe4hbMATzd+LSMDLSbvwvEHciNUcjnXY
         mD22obJsnhY8RNqKsACkOwPF2psnobLAVUBtxFBckkKFIg14IMBsY377D5LdTxQQ3q2v
         HU+Q==
X-Forwarded-Encrypted: i=1; AJvYcCVyPbqqQqBhmwz2UgPuJUZnsBrc0+5YlYwt2wu8hUHGjlF8LiVveZLayPDtIJQnrsThIi+CeGEuDBk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVRDCC8OivV+IMuh9Ao44Rt8xQPzf+ZS/z6gosATbfTEBElkqm
	YZpsstNwPKZzxyzY5FL5LR2YjLzjNdQmHRqwmDv+Jnig9g4QXbOZoVRdj6Bu/3f8J+I=
X-Gm-Gg: AeBDiesc0WbpWUBC5K1aVh2W0Ab/G76a4xVLVcaBSdcrMP+8lpd1V3DcYiSc0GoRe8j
	McyuY/9PoH7GYzp7mFDOSp+yQeQF+nyNqDA8v7rb7WLx3juYxvxqklrU4m3rzoIDY3ne+761a/0
	dKjJJlxKKVdk5XonAKSH9sCXpyTVcfxEtXgPhib4RB62VLBgRKSwtNAJgyotemcmMNCVJQgx5sJ
	2Tb3y3lPg7/r2rsKZTHqmjIYTjXuPXOd8iswTSCw3kG52SXtpv2EyBB4vMnrsbN3y24UOczWp8C
	RRGEwDpdzyT+fYgMKssadn0IGPEeRWd14FB3DPge36VJHaH4slXOG3zXPQ+pnRL5USFKUj+NJEC
	5+TGiqyK5T7nEE6Aw9nYwSlupOS+itedqMGUQYoGdBPglasG78WFWPARGV5GvK76lljyTUMfNb+
	a0AneH+RTrR9xOgYDBs9fCR0p2iz3njZ49z5yz5ptaGIQfe5uj7/wzcb2vmQKl8SbgIfDNAb/ll
	Q==
X-Received: by 2002:a05:6808:1395:b0:464:74e1:45a0 with SMTP id 5614622812f47-4789f10c384mr2468825b6e.36.1775862766490;
        Fri, 10 Apr 2026 16:12:46 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:b75d:2440:dc10:808b? ([2600:8803:e7e4:500:b75d:2440:dc10:808b])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4789de4cfe9sm2277744b6e.0.2026.04.10.16.12.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Apr 2026 16:12:46 -0700 (PDT)
Message-ID: <b875ec1b-7b97-4118-ab6d-10a8b34e6ee5@baylibre.com>
Date: Fri, 10 Apr 2026 18:12:45 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] iio: imu: inv_mpu6050: use devres-enabled version
 of pm_runtime_enable
To: Andrey Skvortsov <andrej.skvortzov@gmail.com>,
 Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
 Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 Jonathan Marek <jonathan@marek.ca>, Brian Masney <masneyb@onstation.org>,
 Rob Herring <robh@kernel.org>
References: <20260401082737.781018-1-andrej.skvortzov@gmail.com>
 <20260401082737.781018-2-andrej.skvortzov@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260401082737.781018-2-andrej.skvortzov@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/1/26 3:27 AM, Andrey Skvortsov wrote:
> That allows remove driver-specific action, that does the same as
> default action.
> 
> Signed-off-by: Andrey Skvortsov <andrej.skvortzov@gmail.com>
> ---
>  drivers/iio/imu/inv_mpu6050/inv_mpu_core.c | 12 +++---------
>  1 file changed, 3 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> index 5796896d54cd8..84eb0ee770086 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> @@ -1872,12 +1872,7 @@ static void inv_mpu_core_disable_regulator_action(void *_data)
>  	inv_mpu_core_disable_regulator_vddio(st);
>  }
>  
> -static void inv_mpu_pm_disable(void *data)
> -{
> -	struct device *dev = data;
>  
> -	pm_runtime_disable(dev);
> -}
>  

I think this leaves too many blank lines.

