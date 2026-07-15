Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD91B244667
	for <linux-iio@vger.kernel.org>; Wed, 15 Jul 2026 00:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784076942; cv=none; b=mlmjJX9kf6rGtEStGqFj8QfYOZC61Z9PByWpvyxX2rxvOyyMG0+7jNV/uPbWnD8cy1RIJ85sMEgAXFzf2TAM46L2lUj4fxDWt7q68/Z8nSOgd9baWo5vV2ZbueOrLzxaQT4DbNaFupj6HnzkEknP2bBClyc+5cOyVXOMDzVncOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784076942; c=relaxed/simple;
	bh=51zK9CQAvxuMhMqwfTMeRUV9N2ZjY5sEn4e6pxRjvmM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PDEuf1a7ROul9pr2x12nFmPzFD+OA37wkndl/YFNLtL4pCPiuporKdatfs/ukJEDqbLR5ciYbB17zcphyWbKzK7TZQE3vqLs4e//vDKlU2AhPEbVsg1GNr8/T5rPuCmIFf0lE8C5YTPHpX5DEGJOKo1XAqCave0nEY3pFy9LojU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=feB7qRbf; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="feB7qRbf"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2ceaf8a1265so40122635ad.2
        for <linux-iio@vger.kernel.org>; Tue, 14 Jul 2026 17:55:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784076937; x=1784681737; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=51zK9CQAvxuMhMqwfTMeRUV9N2ZjY5sEn4e6pxRjvmM=;
        b=feB7qRbfijpoa9RWCoYAc9mSY0IAZoJduYrMAuu7tLOFC2y/BuI1S3Z8T2LxwHb45Y
         AaAO/RexjNGg+TBalQ4WlU03IO9ZN38gXhOz61lzuyglio4OmMPsNCPD7thYZsqZ7uq+
         f2VqU1X/NQmHYe+6wtUesUk4UgwqIkX1Zq8o6acc/BUQCb0bbHIFtGp/4pCHr7VDyxym
         2yiIZln4DlTRQspkZdXHSQbo0JGfYeObjQMwIZmR/FQxARRLMijM4NXoeI87x9M7ya5p
         /Qno2kJuXZlTjK2pNAWjE2PhXMakAYIB5FmSYbT/E6i580MARYs6y7jYRjpcpG+cK1fW
         geFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784076937; x=1784681737;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=51zK9CQAvxuMhMqwfTMeRUV9N2ZjY5sEn4e6pxRjvmM=;
        b=N3GUaHsLzYST+8TIUSt13Q9ikIyik9uY3GeLTDitWfMxptMLP5gXSRiQ27An4qBe86
         CGd/mnLLHTHYEelv6EfdeDhC/CPmRPi3lTLbNhwF6Mlm2sNsMsaxQ2mGvGymHM/jIhNe
         vu6FyR9dhMx2cE43bk91dNhOmN3N6/iuExAoMwinY+en5ZzplFBXKWFZurdBiN8EbQK5
         5SWEl3RTuHGab2CgagThTvQmd7r/EVgnWEAI20sWHD1d8NhGRU7qitkFsfvmPdrMN1He
         zwuapPqEgp2U1ewcgTWfvxX9+NhdfHvUXselPokFiu1Fa2SN47PgDHkmAuC8n4RSRuBX
         8I3w==
X-Forwarded-Encrypted: i=1; AHgh+RqwGx03W1LlciGKo/PaER5gdcMGfmMGvyEygSAjfrKW8Pw73CNWOkucRF4zC9RSjq+InWITUSdgVh0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMrnLlWM+qSptKK59xg+PhBGS6NKTDrwuOj2hgHrs3jUmcelWV
	djBrn14kjQO3Zm4G0dvAreXai72CH3c+aoOuAjbqZlOJh12suFkNlc/C
X-Gm-Gg: AfdE7cnt3eZFB3PUiLih31RNNhg32H+VvcRQeHTHl1sdTyR0xACTTmHrelFuYZIXNHT
	S49Ja6sDTGJ/+6s91juYILDFuV0WXCvG5cqhs55V1zNTn0wLz6eBkrBO7Xlo73PHRrs1SQYBSBR
	0S/lAVtyuOm38P52vi27H7YJulYiQ7c7xGDiLns864Rm7Rkd6JCoYt4GDAIOAZHUOkGS7m/OZgs
	mAReNKMnblN+qyuU5MkC7dwPe7WCmucxrhUYGMEXbEgEIJvyfggUtokcXUwRmgAosWMTiAvrEMx
	0p3wmnTFl2r3SOfmZABrva4xKs2LGfFBjEyu7Pp+2OOBgu2pHAtwAic0dEGZsjaki4jWVrD0tLy
	Me7vGEBrVEwgwzI+GNCruay2uZ/HZPjWB22434xrRU73eMonsFKAUoLIKAFgeSt5Ns/wd55zjUQ
	sYAmPgJiCuECme1wHqXwmS2hrxZA+0YKxPUFlen78IUMkGfvX5EGkMdP7y4s72x4w6
X-Received: by 2002:a17:903:2411:b0:2ca:53e1:b915 with SMTP id d9443c01a7336-2cef11ca8e3mr49241575ad.14.1784076937182;
        Tue, 14 Jul 2026 17:55:37 -0700 (PDT)
Received: from [172.19.1.42] (60-250-196-139.hinet-ip.hinet.net. [60.250.196.139])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9bdb86bsm125057185ad.11.2026.07.14.17.55.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jul 2026 17:55:36 -0700 (PDT)
Message-ID: <a883910f-b4c6-4ba3-b286-081dfc772f7a@gmail.com>
Date: Wed, 15 Jul 2026 08:55:33 +0800
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] iio: adc: Add Nuvoton MA35D1 EADC driver
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: jic23@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
 andy@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, cwweng@nuvoton.com
References: <20260713081127.115197-1-cwweng.linux@gmail.com>
 <20260713081127.115197-3-cwweng.linux@gmail.com> <alYqhghiVxVW2vQu@monoceros>
Content-Language: en-US
From: Chi-Wen Weng <cwweng.linux@gmail.com>
In-Reply-To: <alYqhghiVxVW2vQu@monoceros>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Uwe,

Thank you for the review.

 > Please rely on <linux/platform_device.h> to provide of_device_id and
 > drop the include for <linux/mod_devicetable.h>.

Will do. I will drop the explicit linux/mod_devicetable.h include in the
next revision and rely on linux/platform_device.h instead.

Best regards,
Chi-Wen
