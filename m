Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E43BDF72
	for <linux-iio@vger.kernel.org>; Sat, 22 Aug 2026 18:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787423347; cv=none; b=iVMSHx+DnWA90jMb1FNYEIzOZi+9N5cpa/lheKLePUCuBBD+qNRI8gJmQEwcE4TH45WlxbAFlP6qOafL3Wc/++i8N+ZbJ5c3Bo1BZfUyw94sLdg89x1mMHUzlcxgJ6jiI/2Q/ea5VetLjbwC3LtnnPE+M0O7b2Y/wnSrP11/EQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787423347; c=relaxed/simple;
	bh=8eHyr2cLpU40ZlcSQTJudIZpy7jaZmy8Ix31z0SfeYQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q1qy03YYoXWYXRz3ZNg/3ipEYDKUXdlJ/6qAVKwmASqyNgxaE1dleEL3+9EVi9iXe3kgoCQlHIywZVLopNIpn8dmvmvd4wO6kHjYLXyf2Hh60c+t61rc7OfEkacoF8CtvpnZLa0AyTT3f4eKueclPTxP3nJ0Kei6DlzCM7pY0c8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=mel/ykWB; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="mel/ykWB"
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-7f18c0e03e3so1368294a34.2
        for <linux-iio@vger.kernel.org>; Sat, 22 Aug 2026 11:29:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1787423344; x=1788028144; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rZDUDDqQBTf2cGZ/TzEkaySKSdO2kJb56NJwzuqq3UQ=;
        b=mel/ykWBLp1ZIETZLywL7eFDfF/9pP9sKMFB2mWLjMcpy1HaprCvf++Lwedu1oGXKS
         Wzz4tXPTy2zF/Dkip8GzSaJsf8VezjBylKiV94d6TM88Sei0prDH1A0Ee4RYxdYUVpiW
         zSow/erJ00IvTocJB31oKX0vQFE86D4dIq/cAJHNmpxIJ3hicA7AWi+cCRq6ev808C1z
         pWhb4Ugu9BeOFAqiuhATaTz6b4DcWZiFuLQzMpUw9F975UGsfJAlQPMzg7rfeSSW8o13
         ncRvNxWaYgylvZXK6lNiKmLGeOBcIEe/8Vy6HSV50jWgyhFnyUT+TtJnpYdQYtjFlo2e
         6zEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787423344; x=1788028144;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rZDUDDqQBTf2cGZ/TzEkaySKSdO2kJb56NJwzuqq3UQ=;
        b=jHRB9pnGtq2we3E5geHOrk5F/n4AiIfDv0Bi3Eq/KY6r1/m8WMJZbquEmz71u6GEKM
         uhmLVqqlxD3XvXAWKRyPt77RJZ8p3ITf+MKUMgF2oK2b2Qajt5YJWmkPFoU8pvR7CHEF
         rFgcGg9CRocu0hqkWxV5B2rWZyR4sJRz77ZP70+W4YkDarkmeNOOkV4PpGX9hXg57Hxx
         DedswM+yuwrC/EY5g3GRfOno7C4XlgzeLYaBPJJzgWwTELF2YCpR4sExnRklsW4CB93u
         mfYgqiM5cFgc3A4jzWfJLF01YZ99p1TC0CzlgvBBeD6S7UO8I+2BhY60h4eVbvcKHJ2G
         9SLg==
X-Gm-Message-State: AFuF++kZzitJZBZ+bO48XtXVNWiC8yUYQzlnsriIEgj1+XmQRuOc3Qhk
	o5l7VfMk+j3o7G385IzTqvAk7Ve2hzWnmDVk+jeXQG/vwY81djSZK4wi8HCFwQCz43s=
X-Gm-Gg: AR+sD13kPL7SUEyIj/sfRtPF6OAJOnTHnVDN8DGM2X3iHfqyEG6F+gU9EnDsQ/f1eWc
	/Mrz7z2VyUUQnBxqIGIKmZGc3bOYBHtiVI/BxAIOSFCYVDZS+cY43CiRtQwiUP/t4EceIraGaxU
	06qSB1OTRca3my42UtB6hdDydIiLPdAvOHfCGLAfB3tq5nZeemMjTyUto45SrqqW+CKSGrz6Oaz
	2OPlU/J9lcmt9qM9EgqlohvSvbW3YpJixI4ne40jsi2nc+beEXkilzA3HhTONQVDqyk2HoH8rKd
	O0ZytPoLhXmYLGpHfI60Bvgeu3j94oUlWt1Ivg4jkFaLlnlU7oLs7EZK5lgXbxWKJuXsBkRIuGl
	m1iIxQmNCUSUnZVYzecdLqIhF8g/9up+fjQgDxHbBoVO7Tpz9RzNTKhC4Ji3G1SdyD9Y7A/IDEC
	mGiy801fNKUwwyib1IB+RmVKjLTTmoLPN34kkJz7vjorEUu4gy9BSEBCvKZH5sPFp470rEtYlxb
	5r9LcSJiz4RRQTCti9W5NXZI0ptgs5hoYwwAW0=
X-Received: by 2002:a05:6820:8590:20b0:6b1:4173:ca4a with SMTP id 006d021491bc7-6b16b2293eemr5582477eaf.11.1787423344245;
        Sat, 22 Aug 2026 11:29:04 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:e0ca:316a:4629:d835? ([2600:8803:e7e4:500:e0ca:316a:4629:d835])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6b13cbd4f12sm12426234eaf.6.2026.08.22.11.29.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 Aug 2026 11:29:03 -0700 (PDT)
Message-ID: <1711ef3d-727a-4898-9aa1-887369ddbc06@baylibre.com>
Date: Sat, 22 Aug 2026 13:29:02 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: temperature: tmp117: fix calibbias cache update on
 I2C write failure
To: Salah Triki <salah.triki@gmail.com>, Puranjay Mohan
 <puranjay@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260822004929.13643-1-salah.triki@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260822004929.13643-1-salah.triki@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/21/26 7:49 PM, Salah Triki wrote:
> The calibbias cache (data->calibbias) was updated before the I2C
> write to TMP117_REG_TEMP_OFFSET was known to succeed. If the write
> failed, the function correctly returned an error, but the driver's
> internal cache had already been updated to the new value.
> 
> This causes the cache and the actual hardware register to go out of
> sync: a subsequent write of the same value would be silently
> skipped by the early "if (off == data->calibbias) return 0;" check,
> since the cache matches even though the register was never
> successfully updated.
> 
> Update data->calibbias only after confirming the I2C write
> succeeded, so the cache always reflects the actual state of the
> device.
> 

For fixes, it is always useful to know how you found the problem. I'm
guessing code inspection here.

> Fixes: df041e737a38 ("iio: temperature: add driver support for ti tmp117")
> Signed-off-by: Salah Triki <salah.triki@gmail.com>
> ---
