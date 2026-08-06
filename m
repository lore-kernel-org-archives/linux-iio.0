Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21B083AA51F;
	Thu,  6 Aug 2026 02:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785982731; cv=none; b=m5N/sWUZ/qZsUmx0i+JbMkp+ERW7gG+VZqwBMx9ntxp9Y9T/6SXK6PLsP2ZKVX0wspu9r3DNTXWga++WH9zOeRrsIGryo8Tl3YZLxzxaBNth4v4PVguZSB8dcjn/fSiAzJAJ5rM522wYVxFMUJh/MDN1xWNkGp5wnHmRTjKoUq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785982731; c=relaxed/simple;
	bh=2GItBY+7mC61eIc1WnawU1HoXWKYUAH4NXg+MGvzhyY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XgTWDlrB5QEXPxh6bhljyDueiozghpRkwKqq7pS5DiMvESsfBPkKxN+ktG0+tynWT50H4IPwmERkRWSJZggiYYr+sLOVpm5TIvYWSjB+tmtlRaptuxek8slVcwrHoPV/DSM4htJBeONxGPa6xFM4iHKGTgrb+6+dneTONdcoS30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 24231fdc913d11f1aa26b74ffac11d73-20260806
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:1707c9c4-ba84-4377-9478-49ec63736df8,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:e7bac3a,CLOUDID:7b60ace3d7fdcc7f8ff96baea4633948,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|865|898,TC:nil,Content:0
	|15|52,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,O
	SI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 24231fdc913d11f1aa26b74ffac11d73-20260806
X-User: lilinmao@kylinos.cn
Received: from [10.0.2.15] [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <lilinmao@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_128_GCM_SHA256 128/128)
	with ESMTP id 173047761; Thu, 06 Aug 2026 10:18:41 +0800
Message-ID: <242703f7-fe26-4aca-a256-65b31dfbbe47@kylinos.cn>
Date: Thu, 6 Aug 2026 10:18:37 +0800
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: flow: slf3s: restart measurement if VDD disable
 fails
To: David Lechner <dlechner@baylibre.com>, Jonathan Cameron <jic23@kernel.org>
Cc: Wadim Mueller <wafgo01@gmail.com>, Maxwell Doose <maxwell@maxwelld.cc>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260805110255.504576-1-lilinmao@kylinos.cn>
 <1ed98f0e-04dd-4cbc-ab08-96d076e77da0@baylibre.com>
From: Linmao Li <lilinmao@kylinos.cn>
In-Reply-To: <1ed98f0e-04dd-4cbc-ab08-96d076e77da0@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


在 2026/8/5 20:59, David Lechner 写道:
> On 8/5/26 6:02 AM, Linmao Li wrote:
>> slf3s_suspend() stops continuous measurement before disabling VDD. If
>> regulator_disable() fails while the supply remains enabled, the system
>> sleep transition is aborted. Since the PM core does not call the
>> corresponding resume callback for a device whose suspend callback failed,
>> the sensor remains idle after the system returns to the running state and
>> subsequent reads fail.
>>
> Was this observed to happen on real hardware or was this just deduced
> through code analysis?
Code inspection only.  I have no SLF3S hardware and no way to inject a

regulator_disable() failure, so this has not been reproduced.


Thanks,
Linmao

