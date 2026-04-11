Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2B26181334
	for <linux-iio@vger.kernel.org>; Sat, 11 Apr 2026 18:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775932291; cv=none; b=N/tGpHyBod3qrIietExNa+MiQnr8rhuOKqvQo3Fj6C/b0Kp0f6Q31JRnaacZiMq/q387layKN4l//vWiRfhUt4hZ+vuHyrcuuMBTkAeFjiUOg2xxOWzVh7InJifCn71yzA2PHQ5zh9ErENN44ksG+SFCMovYQYvCvT+h2WSES6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775932291; c=relaxed/simple;
	bh=K+LbJi9Q2nNfdpoYLOs2Ras6NtL8QfnPjJNG1Dsm0zo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f3Km/sPJshYjMw9jxxwSav5jl7iN5+j4E3TnQergt4/NQPJsjf3nwWHijR18pMHxxzw8j3vYXeKZUyuBMq+Egk9bRFSR7E3MMdrtndYX9D9zhqroXny34J2sfcQJp6+WpzjYyj+daY3at5HlYXVxzuH7AsCggzYTmJnmIFNVDD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b=qMPPdZpR; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="qMPPdZpR"
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-4094b31a037so2186166fac.1
        for <linux-iio@vger.kernel.org>; Sat, 11 Apr 2026 11:31:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1775932288; x=1776537088; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0DzMsJPPPMYUFtln5PgT+zleGuRHIg6SW2JnBC2MMj4=;
        b=qMPPdZpRi6o4hJ9kDIfsvybcXVc9QzTR2dCQD3vrwW6sRqhXhDi3UGwogorAUXHmCf
         jzBZ1lw2+oTGSMkXz772C5/RymvYfJsBJlzSJLedsBMG+2badu33Vaf9RTQxn+v7f8sj
         QKw5bXTHkyU3yJbrn4B0agsO6CyEgwED1/VNNpsmkQyrIs4djCtagTk4ZJGkfQ4/Pwaq
         OVsinXbVPE5uglXzsozwkbNLWs7xrJqrYmULeWOg22Ch4QOuqbFY5ZdHjEeqoW/CKJFs
         ULDkTdeohNmSPtj3/GDYPAaEN3AKf58uAY+YsPCmfqApMoJbK4CXd9JWDTfCDLJdRsn8
         CbIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775932288; x=1776537088;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0DzMsJPPPMYUFtln5PgT+zleGuRHIg6SW2JnBC2MMj4=;
        b=XGcZk8NogwGAxeOXP1QBEjFT1Tla3Y1YE9/SOMWk4/nPklAc3c561obn8Ph9x/GOBm
         lIkoRWveQMn3MQOqrUz9hNoBrbYW6OT8M/f8ELq9/8/yKLJ16g1ZDtLZaNfgjy6nu+UV
         6tvwtsbR70BUCcweBHiglGnzvWiLoxQwu8dP1QFJ4V0ARMf655pWBh2QT/YfviEx1Gyo
         KeeINYv86OIsMZ+sR8ih1l45YwhPhj1V5rWpteEBLqNMlp+h3ku3B5dnEupkc76N7Vik
         iI5iEx5wWxuqTwz8TVvDGVdbFQ+hj8om/bOOJL9+KVXoxSZuW/2c2udtLdjLo4bcJkKZ
         BaEw==
X-Forwarded-Encrypted: i=1; AJvYcCX3asmHA/Ikt8ARlyLYXgnj2SU4OOvcXj1GgCQmA4iK65Gs9L8JxB/FL0BLnyDRghc1PPDB8AJkysY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqH0MzYZ9HZabJngQNnfWnqdWW8wh8onkO7C951LgosVeKPwlQ
	56QI83pIIC7JRhrcO6cTcCM20+yLcyJRr9pMI7DLwqWX0DW5hU+ojJj5UVmQZyypCFM=
X-Gm-Gg: AeBDiesOrQMmiucxucDDdXfkIXh64MjE3Kh4bDwU53KMH6zUQY6Azf7hFw1iszU28eP
	OCGsadSALLfkkRH9aKiTBx0k1WuU+Dwzelqo7GLr9qr1yWWcEcxa3wQSmM5euJ955Jm0rfkTBRe
	wkOAgjS/kTCZ6K8huPYFZuYTXkcokPCV+Gdg2C4aSm37A7HkxeZEh4G1oVpJIDuya+dfWiW2GoF
	F6TdZZNW2UbiUU3Ee7LQdnV7qPa4rC+Q2ajJyHHvtQtlpHjpq1XDuoU7z8nWijtqLlxDA9A6Mtl
	9QWNO9N6DFMFrpuqvxEibtOk9FZ2UkhETyJPOeX7AaHipdlh85JHiF8OoHOThPUllz4TLmFEcjW
	8KltpercB58iQ6tSjHPrkQgYRH7sDOSBIf0rCTDVrjyWMxYtTjGdYzYfyLOefMb2ioqlptx49uA
	m/1OTz/aX4tX5g+sthhF+RQkjuNwI078l3f/I0vCqwwLvmq5XMEgEsjgfgJuNzL6x2CLGdVZPK3
	Q==
X-Received: by 2002:a05:6870:1b8d:b0:41c:573:aa5f with SMTP id 586e51a60fabf-423e10a163cmr4452659fac.31.1775932288671;
        Sat, 11 Apr 2026 11:31:28 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:d2e5:c81c:5b23:fe55? ([2600:8803:e7e4:500:d2e5:c81c:5b23:fe55])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-423dd420bd2sm4678542fac.6.2026.04.11.11.31.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Apr 2026 11:31:26 -0700 (PDT)
Message-ID: <6479ec7b-a8b5-4154-8857-9e7c9af7ecc4@baylibre.com>
Date: Sat, 11 Apr 2026 13:31:24 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 4/5] iio: ssp_sensors: use devm APIs for mutex and IRQ
 resources
To: Sanjay Chitroda <sanjayembeddedse@gmail.com>, jic23@kernel.org,
 nuno.sa@analog.com, andy@kernel.org
Cc: kees@kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260406080852.2727453-1-sanjayembedded@gmail.com>
 <20260406080852.2727453-5-sanjayembedded@gmail.com>
 <e7ac60dc-fcf6-4ed8-847a-dc29ecfca142@baylibre.com>
 <438F2B61-7F4D-4488-82D0-E1EE23FBF766@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <438F2B61-7F4D-4488-82D0-E1EE23FBF766@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/11/26 6:35 AM, Sanjay Chitroda wrote:
> 
> 
> Also, I observed that in remove() path, there is duplicate of following with ssp_disable_wdt_timer():
> 
> static void ssp_remove(struct spi_device *spi)
> {
>         ...
>         ssp_disable_wdt_timer(data);
> 
>         ....
> 
>         timer_delete_sync(&data->wdt_timer);
>         cancel_work_sync(&data->work_wdt);
> 
>         ...
> }
> 
> static void ssp_disable_wdt_timer(data)(struct spi_device *spi)
> {
>         timer_delete_sync(&data->wdt_timer);
>         cancel_work_sync(&data->work_wdt);
> }
> 
> At first glance looks redundant, do we require both ?

No, this sounds like a double-free bug.

