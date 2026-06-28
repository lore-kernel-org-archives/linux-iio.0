Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 689553AD527
	for <linux-iio@vger.kernel.org>; Sun, 28 Jun 2026 14:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782657250; cv=none; b=jwLR7OjJ0vbIa3XEbjjidd+BafOczGvubALL9I/NrdamXWGJFSdRiyvW3Gez5D+xJrxjQ7bB60YLPhCtsO1qRgeEz1G6WpJhs8sZjxECEOCfTazOKowo/cdQ83/RyTLQCfZ2MIXC66amRntTQM2oKZflgeDIsLDIqaHwb3mC7K0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782657250; c=relaxed/simple;
	bh=X6xTrQxudXyfaxRG5i5at9fGETYdYW9TPIX+19qLRA0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t5PlNjgcr1iUIOLXu6JvELUaq+0m1luE6EXgHHKyDuLLjaLpxPjAPjeoltIdSC1be+DhlT9xvWO0wUEtTttQ9TziFAsTgwEUiyIOb0iV5eQU5QVB5QfuySE91EWaNAnfHxpn9Jigqxh6vV8e3N0nVWEoff5DizChfUAT5Oh5fTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=U+W+wWC9; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="U+W+wWC9"
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-495bf7a71baso367181b6e.0
        for <linux-iio@vger.kernel.org>; Sun, 28 Jun 2026 07:34:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1782657241; x=1783262041; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rbOALEGU5h8PEFBnFCtxCFFHr0Kpct0HuRmpjhNUHoM=;
        b=U+W+wWC90+08sqwmHduYxuzf1J/+3Ncak4wgsZzWL09RyEzodgFuA5vkHGRJn732tb
         xDFP5b3YPxNnSIaW4OkMAIT+am1WZ1Ck9eTZW06b1ay/6ArwyPxkown4is3zhE9zAzih
         FCYeXCccclJ8cth88iE8suAZoEorG6e9jNR+8MGVgwvuRS+NvJb4doZ3pj0t2UKeULQe
         NDbxHEyPskqURU0mAPUyYeuaRNYKfy7usIa/QgH+Eub5/EIh/xZ5ftaTpk208PobHsh+
         tIXPjBqqx9hRt4xlrA9+ZwfGjuiw0N0+7UE9EWqUthDeRJKy3GflgDxLOFC2OWZGrmuH
         o3eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782657241; x=1783262041;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rbOALEGU5h8PEFBnFCtxCFFHr0Kpct0HuRmpjhNUHoM=;
        b=KvXkPY0VsgR1tzcZwL7t4/mqSszOnc/lzWzWWoSEETo0BrbEe+eAYaDwSXunp1InFC
         JKs0ga0OMELI+bOOQfmQrOc8IvwUl4tfELMybIgDi3WYKk30gUacpw7v8IKnZ/cXNWCG
         jbT6qDO9WVfihejYqHDNE3yjgxDqcxEnxI3NLE1bB/fq/nxdRqIu/LXg0fFT68tHggnf
         jx8pDZ4cUuWWNPWz0UuZpw3Q/w/wTdQdnl6ajOhUm8zPP+TtNQHxZWz8m3rU6TCE4K8E
         T8l2MGapCuPb74BoMe7kjD+ixr1YOAA2TV5x8dzFitxZUrOLzxbd+Ey0njOhv5VYnqXy
         /f7A==
X-Forwarded-Encrypted: i=1; AFNElJ+F+6TlZDCQie14S6wirFkePwz+mAu0qzfakussI0hwWXK6SmDD512BNjn8BVcEq/sl0zfClu1Hw3A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPZqb3c1EToZ8R3HQpmnZWiXAEU/dIM090W0dY19C7ZqPq5imK
	CjlVebdz005iNg6dfhnAM/M9MdwERzkzDlEfIdveSYcjlQ6PusTrvSP5BcaAE3Sjtpw=
X-Gm-Gg: AfdE7cm3iVcFgYM8zfrd70k4VqNodPUp2cYw2o2pj9PApLz3RIp2UU6tvIrFZvZ3ZIx
	bhUfiQ+SXSE3slk3E0DJO87vlvd+lLv338t3cRS7+FwwCSyXvmP+7SEAW3by2TF+Wkk5WkpynY1
	rbJ2tZ6WmrqBUE1AmEb8QZCEramd+H3D4+OluSq+R9QUlVsY6h6T6QdpaXIRSiKgj5W1FN1Ishn
	V9ke2gC/t8litWBZfjWJuF4p9ars3jxH+uZqHIUNuxLTPfWgDFThrXTeMNAo/ukixxeGpKg9uNu
	0fURfn7pfRec+WW3G75yHdce/okKwvL5G/IfXx/INh72RNzLyXKwvu2PhXkN4gLbT/3wYwmdBtw
	aizbvjUeH+zUW+ABAraV2jy5zKYAy05T6TSVCCzU3x9O3mS0b9wGbW+KSeNzp+YwaL+dgWaYERP
	bdL/L/qXouWrKmlVZVBAboLWX1Ab4cpF3ZeJ6lkajjXRBrtCMw8On146dVq5wWmlA=
X-Received: by 2002:a05:6808:c191:b0:492:c931:4d74 with SMTP id 5614622812f47-492c9316c3cmr10168764b6e.28.1782657241453;
        Sun, 28 Jun 2026 07:34:01 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:f242:ecd6:f61e:d764? ([2600:8803:e7e4:500:f242:ecd6:f61e:d764])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-49352b057dasm4998783b6e.6.2026.06.28.07.34.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Jun 2026 07:34:01 -0700 (PDT)
Message-ID: <2d478d88-807d-4eed-bcd1-a829d3cd12b6@baylibre.com>
Date: Sun, 28 Jun 2026 09:34:00 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] iio: adc: ad7779: Remove unused completion field
To: Joshua Crofts <joshua.crofts1@gmail.com>,
 Moksh Panicker <mokshpanicker.7@gmail.com>
Cc: jic23@kernel.org, nuno.sa@analog.com, Michael.Hennerich@analog.com,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 skhan@linuxfoundation.org
References: <20260627192638.5623df0e@systembl0wer>
 <20260628071405.51030-1-mokshpanicker.7@gmail.com>
 <20260628134154.39236df8@systembl0wer>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260628134154.39236df8@systembl0wer>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/28/26 6:41 AM, Joshua Crofts wrote:
> On Sun, 28 Jun 2026 07:14:04 +0000
> Moksh Panicker <mokshpanicker.7@gmail.com> wrote:
> 
>> struct ad7779_state contains a completion field that is initialized
>> in ad7779_setup_without_backend() but never waited on or signaled
>> anywhere in the driver. Remove the dead code.
>>
>> Suggested-by: Joshua Crofts <joshua.crofts1@gmail.com>
>> Signed-off-by: Moksh Panicker <mokshpanicker.7@gmail.com>
>> ---
> 
> If you're sending a patch series, please use a cover letter (if
> you're using git send-email, add a cover letter with the
> `--cover-letter` flag) where you can describe your changes in
> detail, along with additional useful info (testing etc.)

Also, please don't send new series or revisions of a series in reply
to other series or previous revisions. It breaks existing workflows
and tooling.

> 
> Nevertheless,
> 
> Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>
> 

