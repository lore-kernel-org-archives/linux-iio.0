Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D57F33921E7
	for <linux-iio@vger.kernel.org>; Sat,  1 Aug 2026 14:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785595781; cv=none; b=TlOof6NCw5PR/dtjRTYar7YGlQc79gtQbxqpbQFpEpJLd7j70wIfxHdGSycZJQGxSwtMcWzg0YFFrsjQOoBR1Dw+ZBueHrNVC62Ivirk880mr2q1ol2TTG5eY6WnW1HCFIo2gs6GwrJMkosuWJ8PxPc+YE9FL6J/77y5JbCM0r0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785595781; c=relaxed/simple;
	bh=28Y+sWkH9P3E/k3LwvQBJI9J+bYooDRpslXmWz9AndU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K/6aek5kqx4G0qh99dqHY1fRIbwdjh38j3JV9naKRtDjr3rE+izpzQJoViSjck/tIVdgbOzbpPVQTi2pIwfNkUAcFrz+s6lKrRp5fBeY0bw2A+eH3BO/493ux9FldTtnteILvmlZT24Ie/PDdTvB4DKFqVnmPv88XvkqlDUqEtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=DiF1QBFI; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="DiF1QBFI"
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-497d6c2d000so1151994b6e.0
        for <linux-iio@vger.kernel.org>; Sat, 01 Aug 2026 07:49:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1785595777; x=1786200577; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MMZw+Q+C27X+NpDBF0JL+cOPjhTz7PFEJuuJRyBNMQw=;
        b=DiF1QBFI7u65suCEcA1RHz+bv5OsGO/IRZY/EANBp/QOKo9nMr4ScIBU4ClqKYz4a6
         9Uqx3xeRjccR9NWsX4VzJvzqcMPUbMbb2qfM3SDfQs0I8AGileefiawI6DuAHmS07A4/
         noEzuHXUqANnq+wy6BV4JHS0UcdEv7eZKB5rCY80M5daGVKGMIzunC1iOaof91daShKe
         QKaHPweltilhH0gltM7r+gFkTdZ2r/ItaAVFO77oVLNalB53EN4b04sppuvoB59Q/wKK
         8pW/B+Hx90fe1kYviIw8a53eVRtVQyuKMENsCKrq0Qfx85BEL/04/n7lz/3hXOhVUthF
         oEng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785595777; x=1786200577;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MMZw+Q+C27X+NpDBF0JL+cOPjhTz7PFEJuuJRyBNMQw=;
        b=FHljduWQgrpCLEIq6H5KiZeHlA6d62arbTU7mIcKgtc1US4Tw2zWjBZfTw2zYQCqso
         TgEy6IeUjQDB09euu28e0mwInLtjZIpb3QcAPejiWBlrZs1QK+51n6ZbBl+sJWJaw2xR
         3dEDSPRC8gl798jTIgivhDM72la18FR2qDjhtEAqkqVvg3qGNt3rbTo7FmQ3kAzeoLe/
         pQ1Snf43vuT1xrlB1xsn+/cRaXOWriqBZkFNPjTkntz9mVgBf5BF9+VYGSv80rXGlvlM
         QpHeGh5aS3UTVWFKR52Ch1aOaImI40wuV4/AcNip2vKYPYkKpBaMDf5HjK4Y3l6UZ8fY
         +Jzw==
X-Forwarded-Encrypted: i=1; AHgh+RrVFBdGpm4JWeP1403c45SKOFXu4damQlsMpuMn9IBr1ND8CqKTc0Drz33AHhMM0av2eAbNqxlk29I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx94pRNng0sNvZjt3mt1MZuQk2WSYjdXJPBOZe8jNG9cgO6JX5P
	5Rk+3Dl6EY2PlTKgqqSq7cTljqdqwbwjL7B51nB2HIQWikmVGY6qUxwFU6jNaFPwVQ4=
X-Gm-Gg: AR+sD12ccZvU78rz/DoUhzK01TjLLGxFyZUPxGXzRUNxCPfI0eoFBKSsz3cwmuBgX1D
	N9K5GGFgi1moVeAKC6VlnRq8124CPpWZXd8fLjyUWk4avopTkmniXgcQPZwbnTte8XbybYBBS3a
	2u0cYctVhny/4LVuA0UuKHe+4vBS4a0ayqi/ug09SzJMIsN2X5vM0ufO13krORPwCe1p6v8P8wv
	dp3SwJ87UcM9hL6GiApEXEU6Soai/37BBJiQsit1qVcvy2NkkAjUGDU7zbSREhphkMhAisT6lbp
	eYn9bFuxIgL/tPYLeeqjqKSOrxaImWJmBi3aYzvHe4+rUzOcPg+7EUo2VlfUPtWIoc4NTXYdvu1
	a4VrNNwk/xVbDYMKIQKkyTxLWoaMJWX2x4NR7npNzSAEQLJuc5+E3J6YETOq1RSRhg4i+fyja1D
	21n1fYv3l29+aAZQjj/ivigaWiN4wbFqbtcgGBDpqd3MY6VSRpckTRNFMKKP08maoQjSJUhQXVi
	4l0dda6ubuWjDA0zRZgknHMzMZretL3LgUIIJU=
X-Received: by 2002:a05:6808:d46:b0:4a4:a930:1f76 with SMTP id 5614622812f47-4af5e20b693mr6486505b6e.11.1785595777592;
        Sat, 01 Aug 2026 07:49:37 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:359b:17f1:d4f9:4949? ([2600:8803:e7e4:500:359b:17f1:d4f9:4949])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4af58e9568asm2968074b6e.9.2026.08.01.07.49.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 01 Aug 2026 07:49:35 -0700 (PDT)
Message-ID: <36ce2fd3-9a98-4212-8de3-c17fc368b196@baylibre.com>
Date: Sat, 1 Aug 2026 09:49:33 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/3] iio: adc: bcm_iproc_adc: Introduce local device
 pointer
To: mdshahid03@gmail.com, Jonathan Cameron <jic23@kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Joshua Crofts <joshua.crofts@broadcom.com>,
 Broadcom internal kernel list <bcm-kernel-feedback-list@broadcom.com>,
 linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>
References: <20260801090953.61603-1-mdshahid03@gmail.com>
 <20260801090953.61603-3-mdshahid03@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260801090953.61603-3-mdshahid03@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/1/26 4:09 AM, mdshahid03@gmail.com wrote:
> From: Mohammad Shahid <mdshahid03@gmail.com>
> 
> Introduce a local 'struct device *dev' variable in iproc_adc_probe()
> and use it instead of repeatedly referencing '&pdev->dev'.
> 
> This simplifies the code and makes subsequent error handling changes
> less verbose.
> 
> No functional change intended.
> 
> Signed-off-by: Mohammad Shahid <mdshahid03@gmail.com>
> ---
>  drivers/iio/adc/bcm_iproc_adc.c | 17 +++++++++--------
>  1 file changed, 9 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/iio/adc/bcm_iproc_adc.c b/drivers/iio/adc/bcm_iproc_adc.c
> index 7c2e2770cd61..4acd9c3f089b 100644
> --- a/drivers/iio/adc/bcm_iproc_adc.c
> +++ b/drivers/iio/adc/bcm_iproc_adc.c
> @@ -506,9 +506,10 @@ static int iproc_adc_probe(struct platform_device *pdev)
>  {
>  	struct iproc_adc_priv *adc_priv;
>  	struct iio_dev *indio_dev = NULL;
> +	struct device *dev = &pdev->dev;
>  	int ret;
>  
> -	indio_dev = devm_iio_device_alloc(&pdev->dev,
> +	indio_dev = devm_iio_device_alloc(dev,
>  					sizeof(*adc_priv));
>  	if (!indio_dev)
>  		return -ENOMEM;
> @@ -523,14 +524,14 @@ static int iproc_adc_probe(struct platform_device *pdev)
>  	adc_priv->regmap = syscon_regmap_lookup_by_phandle(pdev->dev.of_node,
>  			   "adc-syscon");
>  	if (IS_ERR(adc_priv->regmap)) {
> -		dev_err(&pdev->dev, "failed to get handle for tsc syscon\n");
> +		dev_err(dev, "failed to get handle for tsc syscon\n");
>  		ret = PTR_ERR(adc_priv->regmap);
>  		return ret;
>  	}
>  
> -	adc_priv->adc_clk = devm_clk_get(&pdev->dev, "tsc_clk");
> +	adc_priv->adc_clk = devm_clk_get(dev, "tsc_clk");
>  	if (IS_ERR(adc_priv->adc_clk)) {
> -		dev_err(&pdev->dev,
> +		dev_err(dev,
>  			"failed getting clock tsc_clk\n");
>  		ret = PTR_ERR(adc_priv->adc_clk);
>  		return ret;
I imagine some, if not all, of these will fit on one line now
without going over 80 chars.
