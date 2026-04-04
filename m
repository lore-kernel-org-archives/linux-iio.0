Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3450382F1F
	for <linux-iio@vger.kernel.org>; Sat,  4 Apr 2026 16:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775319019; cv=none; b=m9IpHxL6gVyeoHVFLWjn6Vwrc3T1gQ6MYuomXmlYc/VP+JR6mTSAP1pP5YaDuPcjvA1oy/43sCfAw2I60etPYVjrovF17fhA6j/mNS6ZFx5eLVhSzbrHwlVs6rphiO5UnCobODglZRfOkGJMo/MbThwYhi4KeoDakZLGpDLr4lM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775319019; c=relaxed/simple;
	bh=hjPEy70mUXLcslJ0t2mj4bKh/eMqc7Q8gFVAwOUC9Ig=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nvPJXt1B2/v1KscaKhxZPfztCdBk8bixlgO8MAnLHC0+cAboE82FKJd662plrxZA/Oh9y2ln3IJ5TOR2qL09+esYSDRmLl7DQA6RkennZAZ46aIOnT3Vi1xOGOsgi2DFd6g5CeeKxF9XqQ9NFzurqJO8egWfdOrtcVTEek6Q8ZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b=x1b5jymu; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="x1b5jymu"
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-4710c186d15so179158b6e.3
        for <linux-iio@vger.kernel.org>; Sat, 04 Apr 2026 09:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1775319014; x=1775923814; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BdCZsH8kHIyYRew43dIsbVCYzLIwfqAbpvgS+GNindQ=;
        b=x1b5jymueKRMnhnCwMre+RHGEBZ2Bls1jmiffx7pf4kxkvzQ+9iyxO5npP/O8PnLoQ
         sEejeSTegpdeN0z21vwZ3q0YHj64c7NPAqRdF2PHhLYQe8YLRwh201OGV4rhdEdw6zsL
         jFNzFKHaL5cqmvJgPaTkjmwwOkCj9qv0cL2XGQFUbbvU5vGZbiLEbzpmD06TyGDFxSLK
         76rPWCQclRf5oyIBJo65dX4WRPBlpO1dC42MDo2ayKKiwDosKkYJ4VqXJ1oWqqn1QkEt
         N17bf8sDgmEoZbG61uQqZ1BFcmVCGIHG+8sBx2qjpIpztH9GkQkbNpXqIy7ONNtaW5S+
         QAJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775319014; x=1775923814;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BdCZsH8kHIyYRew43dIsbVCYzLIwfqAbpvgS+GNindQ=;
        b=SYE1YfnB4r69W6NPsK8EOrownLC8EyOyXMKEjN7sJEHOZ8Gi+4tUPrXJH9D+AKk1nJ
         wcifo2AEsodrfuGUIJvu9ZuAtdIoi2od9kEtYpSAmS1MLlzeuUgkYmLNf4rrhq1/xCBU
         9CwVsS2wfIU1hU0k0m6v5CItJhQwBXBs83wArWjW/oZWum5RbtZK2iLZ9M02BpxTtix4
         9OkjGXL0+8XCnYMLq3/P/vdbPptKwJIk05Z2X3b6uz29ifVBeqCdCRMGKK0icaZ4hq29
         LZDsSbXht4f8xFhVrVPFWyy8BK+bz9GV28sgGOkGqmL7NB6VIB/aIDrSntqfTTTiTLFc
         E5ow==
X-Forwarded-Encrypted: i=1; AJvYcCUDiTyK3jON2ViALCNAY78oHtkjQk9pTciJZWnmq6Sy/uy47DVDMMM0Amq+zwj2oicZD2tHgg4lEtQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzI0NKXAYxNkfhHYyWkDWCmQeilNxeoATzlUO7obYpRF4DOKiDd
	phWahdspDbQMas22/L0uNFwoSLVmJs75zRvlw1JKS5WjSaJY4wu+22CCa8NmWPOnLTM=
X-Gm-Gg: AeBDieuW55sydsmrkiOMiHx4KnHEQV2F1dwvH4f+5WxX7wb5vs5RPNpQUedki0VCQOQ
	iUN7qG2CNiVAypKrp0o9WMZXA0P6besFcibLCh788ZNdaXs8Pc74GtAc7ViX8eo3o6R2m7Kb/tE
	ykyg2E5UFzNALSpKdDWWakApAsj+TUUMYeYRe4k7toLiTMlX6SuA96higJ+MsR9uXp2bXk1oaJQ
	AXp1BxPtAOIpqtmv/2EJvmUvg9PGHQrb8SV050mOOboK/v6pHcGpSKC1YFWn6IHcN+9ECmvDrIC
	2n6BqbcMd4GgYeFUq5k4eT0Ro+kZSWcmklhhaWMRrlLp0WYi2JkK81bAIHFMA5n8rbyIt3YNDH8
	o8tz78YzDy28DJyQp2sLSPmj5BTfieUxl/b9uzLPe9tBsenoO9EfPDhlBaDyIH62ALaOUTJUqYR
	jAmzBYOwVDeLtMYZXS8eW4n6d7D6GjX8FzrJM3UzIkRowqRK9lDyZMlzTLRgwXmPbTrQzUtJHqc
	s8RuKsSrAER
X-Received: by 2002:a05:6808:c191:b0:467:ebc8:6b3b with SMTP id 5614622812f47-46ef54f5dc6mr3740653b6e.4.1775319014505;
        Sat, 04 Apr 2026 09:10:14 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:e14e:bcc6:3f95:26eb? ([2600:8803:e7e4:500:e14e:bcc6:3f95:26eb])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-46d93271094sm5291748b6e.15.2026.04.04.09.10.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 Apr 2026 09:10:13 -0700 (PDT)
Message-ID: <053e2938-9579-44c6-86e0-743308468ce4@baylibre.com>
Date: Sat, 4 Apr 2026 11:10:11 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 0/5] iio: adc: ad799x: modernize resource management
To: Archit Anant <architanant5@gmail.com>, jic23@kernel.org
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, nuno.sa@analog.com,
 andy@kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260403080614.14213-1-architanant5@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260403080614.14213-1-architanant5@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/3/26 3:06 AM, Archit Anant wrote:
> This series modernizes the ad799x driver by converting resource 
> management to the devm_ infrastructure. This results in cleaner 
> probe error handling, the removal of the ad799x_remove() function, 
> and improved overall code maintainability and safety.
> 


Reviewed-by: David Lechner <dlechner@baylibre.com>

