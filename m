Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12C094570D2
	for <linux-iio@vger.kernel.org>; Fri, 24 Jul 2026 18:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784918004; cv=none; b=fHD4fuY086F10Ax7F/zO4/THwazkun3liHhAZLCyZUT4XJuxv/ZOBONXUNI75EnRLAoO776KTs3KaUJjTbxUSiSh8c1o+cFasrMkqeU/K17gUEPfNqyHQ2G739AP1jTN8/Qts0YiKk2ChWk0RXY1AHj0lF+QUGZGZHqBjS4Ulmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784918004; c=relaxed/simple;
	bh=x8/UntL1Po/lMOr6CVjff3qaQuSWWq0O+WOfbRG/nRY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nOhgYXkHMT5T5vvbIrkKCWePH+U2h4p68R4imhldMLetaPpzNmQk/SMw4RuD4nKGG1nv+E+41Ftb4l62ttpT1TXQfUFT3MgJoelZpdTblU7BXvxlmEdOVcC4yi4p6mJ9V4S80/lvl6PgBLi5QkME3NCDbXvtu1/UqkW+pnkA+/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=YRUgcS8I; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="YRUgcS8I"
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-497d6c2d000so369624b6e.0
        for <linux-iio@vger.kernel.org>; Fri, 24 Jul 2026 11:33:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1784917999; x=1785522799; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aW6dFYX6mI/p5G00TKxQUJlIB80DTem0GH9shFlvm4I=;
        b=YRUgcS8IPouceq1XiGh5PlbZdkaKV2lH0WsXU69DhF/rITpC1wq6b+Yt5uKI3worjc
         Pim7R1PnTfHVQWaBvV44F2oONvVH1T49EFOY9FI35LSTcn1xSjMCMj8BXzmn2NHEr7Er
         t/Y9ASgr8mJLEly/YYkRzsu2K8l4eeFuO/EEekTutklhQJlcFw3SIn7bDAqfJGrwSKmA
         vWdLrHhPzQc3aw6LvG2ne9TrItAVdpBu8enRBxjnev45Ypjj87+gsMMP/IfGvEu0zUA2
         AwgvZiWtE2qJM5z2mLyUOaqFsYyg8IWJW3b4zjRECCssHnoQyXmq7vCZFjjsDMg/G5wV
         KYNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784917999; x=1785522799;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aW6dFYX6mI/p5G00TKxQUJlIB80DTem0GH9shFlvm4I=;
        b=nezVXJqWT8Qiap1v83UlC2XrddnAynXd8AXGCLLnKDLfdulwCW6bxuBOTz/XacRIHc
         qRDXb4TDR4Hu06T0r+9J1A5XYuQomaXQXtA1rG41ugpA2MGoZo9PRmruBnW5sxaeU54I
         Z8RlmZaR2jS1IT0bE7rUyiKrp24qorPO9rTvClWD+ZbFCKevrK9Jy9TnDS40VEEiObSa
         TVoa83skUhEvjuDSH6IflrCh4wajzpEJ/pE/FYtFO2uy1BxJvMBoCogWv5J6Ihqtjs0D
         2XRN+QVfK9DLqjua43NUNLrKNm+jTECbR2ljB9l2WNkqdCSNUS+a7gWTW0Z9mTxvSLeN
         SDIQ==
X-Forwarded-Encrypted: i=1; AHgh+RpVVL5rIAPL33uX/h6Kylc9XtpMG4ew2VpErq2MvlCYSNcbh0/8phxU047IPdCQVTpCZaQaAR9jILE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDwetEda6TIySz+W9gPfMCS/at9Xd5GfAs9nmpTkQwNnOQwghQ
	5PzNGnaF32u+Oa9W/qv01vGOZmr9gCMIEBM8N/tXVntA04dmwQ5AYg5Z26pOPIM9cWM=
X-Gm-Gg: AR+sD10+OzEdW4ELnBVOlABlsUKcNk3R3oOjPwMLA672Bx88sgsIOYdnO7rWMd9mI4r
	zot/ChwF5Hy7rMAhroic6kNcEbySyxfl5XTxxROJhKz7W8c8ZarUclLJgDxrZEzqgMWZyVQ0LbB
	th2LBO8TA4YQHVLcdfmyVMFe7M7+iFbl0GPUb7dCCZ6e0GPDvv1i4MFbNBEBeI5kfXt8UKxytL4
	50MeoZE9gVqzybDFEaPLZr9UFJHYdZ6weP1BIEIkoBbXtPltOs6YT7H6Xh81bXPBZjwb0aUeMsQ
	kcpVUsWkZYwavB+9PFo41R7qgrP0b6no+NM5zBdljQG82s7I5JGTx38UsOtplOeH3kbFKQ7jIVW
	Q8dz72Pad6A7r2s5NqiJ2MIo95UE5X+S3+h5IUQJm8BPDo025We/oZrvletQIVXIosdN2MnMxoO
	SBwIma3rLNTkVUojwfFDHuDOfvjl2V/qxPW7lKTOHgggxPl/m0eQ==
X-Received: by 2002:a05:6808:3012:b0:495:e1b6:2c5 with SMTP id 5614622812f47-4ab35260c9cmr5560674b6e.1.1784917999317;
        Fri, 24 Jul 2026 11:33:19 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:b635:d463:c98:cc75? ([2600:8803:e7e4:500:b635:d463:c98:cc75])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4ab55d820c7sm1521185b6e.12.2026.07.24.11.33.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Jul 2026 11:33:18 -0700 (PDT)
Message-ID: <eac82930-bcd9-40d7-973e-89787bd178d2@baylibre.com>
Date: Fri, 24 Jul 2026 13:33:17 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] iio: adc: ti-ads112c14: add support for I2C CRC8
To: Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>
Cc: Chris Hall <c-hall@ti.com>, Patrick Edwards <pedwards@ti.com>,
 Kurt Borja <kuurtb@gmail.com>, Nguyen Minh Tien <zizuzacker@gmail.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260724-iio-adc-ti-ads112c14-buffered-read-v2-0-98b06f3d47d9@baylibre.com>
 <20260724-iio-adc-ti-ads112c14-buffered-read-v2-1-98b06f3d47d9@baylibre.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260724-iio-adc-ti-ads112c14-buffered-read-v2-1-98b06f3d47d9@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/24/26 10:55 AM, David Lechner (TI) wrote:
> Add support for I2C CRC8 to the TI ADS112C14 ADC driver. This verifies
> data integrity of all I2C transactions with the device.
> 
> For now, it is always enabled, but it could be made optional in the
> future if needed (e.g. for higher-speed data acquisition).
> 
> Signed-off-by: David Lechner (TI) <dlechner@baylibre.com>
> ---
> v2 changes:
> * Rebased on iio/testing.
> ---
>  drivers/iio/adc/Kconfig        |   1 -
>  drivers/iio/adc/ti-ads112c14.c | 149 ++++++++++++++++++++++++++++++++++++++---
>  2 files changed, 140 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index 642c42b1fae7..4ed6f01386bf 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -1802,7 +1802,6 @@ config TI_ADS112C14
>  	tristate "Texas Instruments ADS112C14/ADS122C14"
>  	depends on I2C

Sashiko correctly points out we should select CRC8 here since
it is always enabled to avoid random config build failures.

>  	select REGMAP
> -	select REGMAP_I2C
>  	help
>  	  If you say yes here you get support for Texas Instruments ADS112C14,
>  	  ADS122C14 ADC chips.
