Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A246121FF30
	for <linux-iio@vger.kernel.org>; Tue, 10 Mar 2026 21:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773179554; cv=none; b=HsiBfID7LeHorneSgRC7FmFrE+nBsia/UzmBQQvHAPclDKL+47saK0kkjhr6F3vvA+FjlmmmU3Xib+Ipt4IEb5s+z5JQy8r9S//BJwSmtUCDHgBCI8UhWAX60LSrBoo5l9lbLHf+1FmG6/Bu7BkEX6zgjY1eyz2ueAs3OwROCJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773179554; c=relaxed/simple;
	bh=y84qubhrfr3cMc6nAC3U/0mPJebsA1MPz29TDYveouw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ipk+AdC8rxx1EtRVTZ8uMQKS/hkYXiZdV5job+OD5i2mWszt+qTpM/7bRRjlVfqhmuZJ5P8FP4z5My1sn7V0JnCcInKJXzi/d6KuNGjnwOEhtrU92G+GLBgFDXi18lykjfTd4Lf4dF6t7EICQmLnLja/YHyeFVgSpwQTl0Xs1hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=VBgXmYF6; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="VBgXmYF6"
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-467161c4a1cso828300b6e.3
        for <linux-iio@vger.kernel.org>; Tue, 10 Mar 2026 14:52:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1773179551; x=1773784351; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KrG0m0+wGAmylYP6HW5DIMPVkIxjVDO5lBH833IMH8c=;
        b=VBgXmYF66HCQW3EXVqSV8U+tAEba1ONLGiCRwPrRVN3xpnc2IdkJECTwYeFFSkzZM0
         XnjK0Xt9b9K/59rLA1o1zNQ7u6wsYJH4mG0j37Vr5xesm4W3iEq091pkeYZg0a67qDD1
         hocNFYmo3Smn3MLcsrotD984wrOcKCEx6Dhn3CIj92tLlAzn+FqfOuViMmy9OknvJvkz
         yCGrPbYQxPN+4stePPOnP8LvZA9PGG0iNG9nbzGwgglag3qYh3T4sPUqjTgI7v5HqY+8
         6GwjPYqdeW42br2RjquUUPCYvhCY6dYJ/A7NUoHgmQIImtaqqUfvOQGPCzXLg5+OPo16
         ZtkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773179551; x=1773784351;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KrG0m0+wGAmylYP6HW5DIMPVkIxjVDO5lBH833IMH8c=;
        b=fxkccj6R3DHCYHpIqGwg1sLOW+Qub+eqJW1mPO5D1OrQfGWnPiNzC1/wN2D5ijMy/s
         7gqkddmhgzyjYOrHXywcvZGtOIouW93SVb2O6vG04vhvP5Cg50DK0kR6bnE1zog5CV3s
         tqInzPl7R8udkcV8TJ4bpzjUSulTBZR4iz6ku3yuj8SUwFUS8HjxTrRNCRhVn6hX33Q6
         hEhRxMfithny6X7zEeXwPECvHCxBGX11E5O4br+p6jHKXkDODTy8w37KcVnQFzfclAYP
         9owpXlqxlmaPrl7aJcBi/+Jelnr2kOe8W5Lvo9NbVBNzD3xO+bpnXvBkfo8RbSUCeWXy
         NxJw==
X-Forwarded-Encrypted: i=1; AJvYcCWC6ktJnxoQM99kMDZ3TJJjj6ThbxoWWgIC7dxoDm7sGs6pxnU76d1O0FQruPKwcK+JftpwgjI7l8U=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZctvzT1283TVwDhOK7MWYw/IBNs2rkwsahGKwe/W8ISuYaqeI
	w8tV3RDlMg4tei/Bg1OPLQRvPpU6d+/3PRzWkDjWYfImaFejk9dJNVzkqMSPjLTFqsE=
X-Gm-Gg: ATEYQzxS0V6KRQsPiAHVKFkpjkXb9s4uVJRQaPpSCf4eEL3MGGOiDdcjbQbG6qyqsz9
	eL8+42XJ6NPwcfcT53jetoJHjIATdUnsL5YDjoiGMOuKZmop2tpFRzzT440lX8vrmksc3UZOt/J
	2J/JFQ0mZLmlefI4yLLfdwbNkINpZgdEBL94O/31nAzPfleu1J+LgrHjVxfF8GIO0yebDH3hqXq
	WP7eCp6XvVXxXxnbBJKRB00uQ0fpHiPJ4SYw+YwpAZ2WTVAeG9M0JVBSGn6UFDbD6Q3tmnkHSzC
	QjdfMfbeQwmdX9FymdW0Pdm3VxSYrbuYeeBHRXUYxEEpIc5X5C/4A6EMkRu7Ah0FgiQ10/Othnp
	9XxjFc6YV0exov33ta1FDsIH0xsIMISbenl17L7y20iNWoN89FVMEzF7gzJp1IP/IGDKfGxOKDT
	BvB716voee987dZMXKQZTS+9li5IEvvfvp7ZsD6XusJ5EM+1ocVWN0oS0EsVZNtJ0Nv4qEGAOeZ
	g==
X-Received: by 2002:a05:6808:1929:b0:466:ecc2:6f47 with SMTP id 5614622812f47-4673354b18amr144459b6e.31.1773179551449;
        Tue, 10 Mar 2026 14:52:31 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:78e2:51e2:14b8:2e10? ([2600:8803:e7e4:500:78e2:51e2:14b8:2e10])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-46734160cebsm48179b6e.7.2026.03.10.14.52.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Mar 2026 14:52:30 -0700 (PDT)
Message-ID: <79bfac24-dcb4-4fb9-90d8-3ef2393f51e3@baylibre.com>
Date: Tue, 10 Mar 2026 16:52:28 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/7] drivers: Simplify cleanup paths using __free
To: Sanjay Chitroda <sanjayembeddedse@gmail.com>, jic23@kernel.org,
 m.tretter@pengutronix.de, mchehab@kernel.org, p.zabel@pengutronix.de,
 tiffany.lin@mediatek.com, andrew-ct.chen@mediatek.com,
 yunfei.dong@mediatek.com, matthias.bgg@gmail.com,
 angelogioacchino.delregno@collabora.com, johan@kernel.org, elder@kernel.org,
 gregkh@linuxfoundation.org, pure.logic@nexus-software.ie
Cc: nuno.sa@analog.com, andy@kernel.org, kernel@pengutronix.de,
 kees@kernel.org, nabijaczleweli@nabijaczleweli.xyz,
 marcelo.schmitt1@gmail.com, maudspierings@gocontroll.com,
 hverkuil+cisco@kernel.org, ribalda@chromium.org, straube.linux@gmail.com,
 dan.carpenter@linaro.org, lukagejak5@gmail.com, ethantidmore06@gmail.com,
 samasth.norway.ananda@oracle.com, karanja99erick@gmail.com,
 s9430939@naver.com, tglx@kernel.org, mingo@kernel.org,
 sun.jian.kdev@gmail.com, weibu@redadmin.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
 skhan@linuxfoundation.org
References: <20260310200513.2162018-1-sanjayembedded@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260310200513.2162018-1-sanjayembedded@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/10/26 3:05 PM, Sanjay Chitroda wrote:
> From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
> 
> Hi all,
> 
> This patch series replaces manual cleanup and explicit kfree() calls with
> the __free attribute from <linux/cleanup.h>. This modernizes the memory
> management style and simplifies common error paths without altering any
> functional behavior.
> 
> The __free attribute provides automatic scope-based cleanup, making
> resource management clearer and reducing the chances of missing cleanup
> on early returns.
> 
> No functional changes are intended in this series.
> 
> Testing:
>   - Compiled with W=1
>   - Build-tested on i86_64
> 
> Based on:
>   <linux-v7.0-rc2>
> 
> Feel free to share your valuable input in context of the cleanup API.
> 
> Thanks,
> Sanjay Chitroda
> 
> Sanjay Chitroda (7):
>   staging: greybus: simplify cleanup using __free
>   iio: ssp_sensors: simplify cleanup using __free
>   iio: st_sensors: simplify cleanup using __free
>   media: mediatek: vcodec: simplify cleanup using __free
>   media: chips-media: coda: simplify cleanup using __free
>   media: allegro: simplify cleanup using __free
>   staging: rtl8723bs: simplify cleanup using __free

There is no reason to put patches from different subsystems
in the same series when there is no dependency between them.
It just make for more noise for everyone.

