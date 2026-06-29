Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6394425CE1
	for <linux-iio@vger.kernel.org>; Mon, 29 Jun 2026 15:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782746505; cv=none; b=iExUTtk6/t8dm6P7bWwBmv7HAzfsyH7un5ZUC9WUl5FLWVz1aWJoGA2oMNpD7kseHrgPF0g1awqLC/X5FptEbDBy39Ae2Glnd0aM+bAO5sGK2f15x2J8gJnxKJOKNrlOjK4u0IH8ZH6UQ2Nbw+r+9mDY3WOpT+49/UjG61ya1eQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782746505; c=relaxed/simple;
	bh=GqLnvZkmBn/+jdSRiIjOQLiMbdgqd/ohJyb5VcFNH64=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=czRZMFNyXiIKbT/xtYVBRWAGDA4n8jFL4ipzw9ryrrTT/ExUw5g4LwGDYXSBWpuZyhkO2WV2Kme6hwJJvD2BWTL6yRp2kfuK3Rz0zqcXaZpUDkRA2pMVqV2zXdVW7q2rpzqIcihK16dQudYfHXEkaIkrEiSyWyZ7jLEnjyMVevQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=SRryUTWy; arc=none smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="SRryUTWy"
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-69eb8b6bea8so1649505eaf.3
        for <linux-iio@vger.kernel.org>; Mon, 29 Jun 2026 08:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1782746503; x=1783351303; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RoN6vMVFKf7cav/D/vQQNE2Ex9fB7yojp9INli3pPQ4=;
        b=SRryUTWyUOERn3+W4f25FkqSBAp+0GXtS2Zd/Xot/JtAesczfApSwHDdR1YDv0VlGr
         SENJ1C3dBorbPEx15kid/EeVhgvFQYcaEJYv0M2Ufb6ZnjCaV58f+6ExW0aoB3zr9KOj
         f4/4DpR9/1/EZLg1AVw+lHO7pN00SsuIhx19DdZdHMYzwNnulG4bF7hVg+iJhqaBZV6F
         s8PCjW6SYFfnCdRhdK2KcEIVmXBw1OKHLaxEDqSTr9/OBYusc2G5wWW2M/q+uNxAfL7W
         EqIkn0sNvUWjMQkw/pLwUZR+MvTu6AUCkqeecdHrBtXcirwAl9NpN2GXWNtZSHwFU8cz
         Ok7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782746503; x=1783351303;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RoN6vMVFKf7cav/D/vQQNE2Ex9fB7yojp9INli3pPQ4=;
        b=IHUZBZSotSvngEhLvzd6kWm4fETj/t0DVBu2mH1fxJd2Tp49qZxlQ7UYammt8QKBdT
         PffZjEnLG7FqExc3Dw4rJN0G56Q5YAdobb1KEWTFA5C+DBy35vBSmJNQf8vHavD+Ryam
         lsWy/RThe8bKcWz78VEk9YwzbsK59BzujPRSO9yZ1lbjzJ8tCsXHog493dKx6nPEs/l7
         9EC3khrIZ5dcSPCU2ujEskR8zajXoHO5KM4OQIsRyECuBB4bS6GPMVbYhGTIbBuHK/Y5
         E+Mx2FyviHR0TrhzWQ1rgUe54OwPOEDtWIHxeVvNERAxHQzZgRIQN840OQPcKHyINY9w
         2nvw==
X-Forwarded-Encrypted: i=1; AFNElJ+H9Fwl7LKU5MrDzK1zgHDx/N6Zhscvs04EqiotLjkblSO8furmLR/UijCl4PLZtC6Aoxd70DOs/IY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwllqBJ0S/A/jSc3rIadHi2sdu3n+QfZW7+y57SyWLoizuPQnuc
	4/AAwVq9eCflnexVd0JnP/IeEe5Z/XZFam+NOOULC+u0KhCanT2XXty80yZ0mfiRSaI=
X-Gm-Gg: AfdE7cnH5XQqwDkoHnMaY1r/KSPgzA6sTYKS+kq3CdbmwdGhPxYUDEQ14QwQz/GnTVf
	cnxSQElLEcVeCK/sMoQb9yBwfA1MBUUQeJgmjUiUkGCKEbea8QHNW9/yIqxd7hijdZ3C01bRO/z
	6ATi/XsLF+DP46zVlPbmBaTT8BDl0xJ5QKjVBHVxXtezeINy73Akm5krSFQoIa57H8lB0bzYwVJ
	idAA1v9QnSNEdc3vLhJeAJXxFuis9tQRVJ6/66SZeS+f0muvvSTPDYpfN0vUVays4eKnKsANQNU
	WsJmUDHp9K0kNAVABKsZdo0/zN0rxx7E/lMgBWSWc8BPQ5mRqRUoxPiBkWF4d034BLZNNn8lz5j
	3FFmp81YyqsAPmIiYK47SalJYzxUQsby8c/lAsj0j11SsrAk16qD+yeUMXMNB56lnzm51yLBNwk
	L8zijirN7AAiAhRzNaFRlcidCRRmXHrbVOeHgJQuinhQXrqzG0Zeh/XTjHFRYAb+JOQTJExjXUt
	A==
X-Received: by 2002:a05:6820:4de2:b0:6a1:7644:772c with SMTP id 006d021491bc7-6a18939bcb6mr63450eaf.63.1782746502661;
        Mon, 29 Jun 2026 08:21:42 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:3533:aa22:9a69:df1c? ([2600:8803:e7e4:500:3533:aa22:9a69:df1c])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6a189173c3bsm53188eaf.1.2026.06.29.08.21.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jun 2026 08:21:42 -0700 (PDT)
Message-ID: <4d81af47-277d-40c5-94d5-8c7d59dbd0c4@baylibre.com>
Date: Mon, 29 Jun 2026 10:21:41 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/3] iio: adc: Add support for TI ADS1110 to ti-ads1100
 driver
To: Jakub Szczudlo <jakubszczudlo40@gmail.com>, linux-iio@vger.kernel.org
Cc: andy@kernel.org, antoniu.miclaus@analog.com, conor+dt@kernel.org,
 devicetree@vger.kernel.org, duje@dujemihanovic.xyz, jic23@kernel.org,
 jishnu.prakash@oss.qualcomm.com, jorge.marques@analog.com,
 joshua.crofts1@gmail.com, krzk+dt@kernel.org, linusw@kernel.org,
 linux-kernel@vger.kernel.org, marcelo.schmitt@analog.com,
 mazziesaccount@gmail.com, mike.looijmans@topic.nl, nuno.sa@analog.com,
 robh@kernel.org, sakari.ailus@linux.intel.com, wens@kernel.org
References: <20260628194341.66752-1-jakubszczudlo40@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260628194341.66752-1-jakubszczudlo40@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/28/26 2:43 PM, Jakub Szczudlo wrote:
> Add support for the TI ADS1110 to the existing ADS1100 ADC IIO driver.
> The ADS1110 is pin-to-pin compatible with the ADS1100 while providing
> higher resolution and an internal voltage reference. This patch series
> extends driver support for ADS1110, updates device tree bindings and
> Kconfig text, and improves the overall hardware description for the
> TI ADS1100 family.
> 
> Tested on: Raspberry pi 3b+ with 7.0 stable kernel
> 
> Signed-off-by: Jakub Szczudlo <jakubszczudlo40@gmail.com>
> 
> ---
> V4 -> V5:
> - Correct pm macros to be more generic
> - fix variables ordering in new functions
> - delete unnecessary casts

Either this changelog is incomplete or some of my comments on v4
were not addressed. (If you disagree with comments, that is fine,
just reply to them with your reasoning. If you don't reply, then
we assume you agree with them and expect to see the changes here.)

> - Link to v4: https://lore.kernel.org/linux-iio/20260622221550.374235-1-jakubszczudlo40@gmail.com/
> 
> V3 -> V4:
> - make fixes patch the first change in the series
> - correct error handling when short read
> - use ACQUIRE macros from pm_runtime.h in new functions
> - Link to v3: https://lore.kernel.org/linux-iio/20260613190957.654798-1-jakubszczudlo40@gmail.com/
> 
> V2 -> V3:
> - clean patch from unreleated changes
> - divide adding support for ads1110 into separate patch
> - add missing changelog
> - Link to v2: https://lore.kernel.org/linux-iio/20260607183542.368184-1-jakubszczudlo40@gmail.com/
> 
> V1 -> V2:
> - go from creating new driver to extending ADS1100 driver to support ADS1110
> - Link to v1: https://lore.kernel.org/linux-iio/20260527164312.355729-1-jakubszczudlo40@gmail.com/
> 
> Jakub Szczudlo (3):
>   iio: adc: Fix incorrect reading when datarate changed in single mode
>   dt-bindings: iio: adc: ti,ads1100: add support for ADS1110
>   iio: adc: Add ti-ads1110 support to ti-ads1100 driver
> 
>  .../bindings/iio/adc/ti,ads1100.yaml          |  10 +-
>  drivers/iio/adc/Kconfig                       |   9 +-
>  drivers/iio/adc/ti-ads1100.c                  | 145 +++++++++++++++---
>  3 files changed, 135 insertions(+), 29 deletions(-)
> 

