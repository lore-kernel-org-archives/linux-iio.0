Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8007537F74C
	for <linux-iio@vger.kernel.org>; Fri, 10 Apr 2026 21:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775856370; cv=none; b=bgNsjtzeFXilAe7sAA/JQlfsHwqTmjevKRhQFjiszUBGOpiiK4jvjgAyZQet6p7BcELgDgwz6mfLKRI/VlamfuBbvAtmHEMxTI9+TY5CIsbU0FMmwSYdMgdVHXqH8wheYHUUL5B3OgvIqkJu/vYtGZkJtmt1hCHLJFSzZRqPqZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775856370; c=relaxed/simple;
	bh=blbVsdWwZIl4tvIa84LRRiprRTeKBNMZ9YgODcExhkQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ei5Hg0gkWUsKPiscPfdY+ebBsrLZI1KVIeW6qUflPX2VCJzbb7jWYAR2D2F8smpe/c7MjWPVtbEA49dxS3v9Ad4U2P9tQlKJXQufmII1lu24TixKH/JbbAj6LhFg5RZYAMfpM2gXz208E35pWLGsS7EdAqb22nHGMMw0AjvHqRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b=Q1bahBu4; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="Q1bahBu4"
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-7dbccb6ae20so1221242a34.3
        for <linux-iio@vger.kernel.org>; Fri, 10 Apr 2026 14:26:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1775856366; x=1776461166; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VpKT+sFosZszFJqskpECRNRkBhOriLvsoW69QUfLXmw=;
        b=Q1bahBu4y8rDVFSekbafL1tohH8YeTvyJLe9q35c3gHpjCMjJtkBuYNM/xd/T/iajw
         kaEp6rSKszpyEWi0rdNKV8FQx/SK/pAQQ0/904njU7vowuN2M0E2ee2Qor+bI0o/XTE8
         RYgNibXBGCLKnVCegi7lrlIU6+CfaW1+o0C10zpNvcr0wXNi3UO5Wt3zRA3W2I4qU52R
         VahaxjrF4MWFcrLDi9m8lrNWEvzY/01aS6/KDqS5+kX0W0MGMMr1bcMWBnPVOmjHJEVf
         EyYb4dS+j7yDatpaPAXUvawwUrWJ3SuqLZm7ufpNEZsNqZKZMeAuBm1o0uWFOSr0mYJ3
         /foA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775856366; x=1776461166;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VpKT+sFosZszFJqskpECRNRkBhOriLvsoW69QUfLXmw=;
        b=VIwsS6A3NcEVRrvd79aZwyt6ArEzeEndAXXLbxCH7XI8dgLE+VuQGH42Jn7jb/zD19
         4vjH4hbzxm3KnT5JHkgzQ8QpuHuEc+qRMTNFGpnyqt/yVaXXyypTtBymZ6w1NT1moSPq
         mQewR6De2yehOxSDex3j3ZJah5IQ724PjpJz6qrIgJPTbuYqR2Z0q1w6qxUYmjsFuzg1
         9Gx3ZxdQNxdQcYjOTt2tM9GS6LFdJ/VYVnkhguNBu3EmKWf5R6LSc0FhiliTCpL+gwUq
         /Uld3gk3EbAxQ2XCdLt23kDZlvZgdpFM5mr0Lut3FzL1iZexQfB0eFcx3Y5Ls/4xGeN4
         2CnQ==
X-Forwarded-Encrypted: i=1; AJvYcCVMPKB3W8wOHqNZVS7aOWE5DRFB7Nn+2CEUOqGtbk7cb8KKoLynQYyJUU6/UGQpBw/aoxoJykdnBoo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLfYlzd1O9OesBGnwk97KGvI4tg4NVDPZa55Aw2rvBlq4eSIdD
	slq/usyC3zaNkpQpOO8O55EFTapWmVc9r/AEYGkfwHm5mmA7jV+GpnS972HHSLEg4dY=
X-Gm-Gg: AeBDieu8gGo2GaZZmYrCQJtzUUetE0HM1jXcUa7GWJc0OaSPpqVRnP5LKRDeP4NQZwM
	X9mXy/RdzG0fajFsMvCUTs65wi+DiLqVBKJ34I5j1kgMqt9Y3YjzF2xVstHFlONAL5g6sWSBzI8
	1dYk6R9Li5NWHIIoku0ueTOmkAWkWyV/tWAXpNtUhDQC4EbqPTPoceDtLdhIHYkYyRu8ULAZp7O
	5cVFJV6yU/kHomqxsJIXslEyuemw1h9ywCguH0nh9nZRu9VP2mn++GoFH7Te3uBvEQgcvqdjj/I
	q/5tK9JMOiecZI/asq4pFZtnE1jSvIy4qi+cd8z5L2rJEHRczhMG0PYxXrbLOyZXak/AlbIKZ9v
	pi5S3lwhRoKWO+Brk8J5t/ADke8EO8XR0Sc+zGgOO2x/RvblH/r+ll7mkvQEDTf2kWZl007E8TE
	DwT76cQe5PtBVnf6KjROkJSpWGQ4d0CMxhb3nvkl2CUGeGi/nQBwYW3qZ7gcSDWXOhxytaamzLe
	Q==
X-Received: by 2002:a05:6820:3014:b0:680:17e0:4435 with SMTP id 006d021491bc7-68be7ee695cmr1705903eaf.31.1775856366448;
        Fri, 10 Apr 2026 14:26:06 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:b75d:2440:dc10:808b? ([2600:8803:e7e4:500:b75d:2440:dc10:808b])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-68bcacc9925sm2108544eaf.9.2026.04.10.14.26.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Apr 2026 14:26:06 -0700 (PDT)
Message-ID: <c885c62c-f0d0-4dae-87d2-e6fb7257cafc@baylibre.com>
Date: Fri, 10 Apr 2026 16:26:05 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: adc: nxp-sar-adc: use field_get() for EOC bit check
To: Piyush Patle <piyushpatle228@gmail.com>,
 Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc: =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Daniel Lezcano
 <daniel.lezcano@kernel.org>,
 Alexandru-Catalin Ionita <alexandru-catalin.ionita@nxp.com>,
 Felix Gu <ustc.gu@gmail.com>, linux-kernel@vger.kernel.org
References: <20260410211329.185147-1-piyushpatle228@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260410211329.185147-1-piyushpatle228@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/10/26 4:13 PM, Piyush Patle wrote:
> The driver uses FIELD_GET() for constant-mask fields but falls back
> to a raw bit test for the per-channel EOC bit, as the mask depends
> on the runtime channel index. A TODO notes that this should switch
> to field_get() when available.

Could drop this first paragraph, it is a bit redundant.

> 
> Use field_get() here now that runtime-mask support exists, and drop

We like for commit messages to start with the verb like this, so
this would be ideal for the first paragraph of the commit message.

> the obsolete TODO. Since NXP_SAR_ADC_EOC_CH(c) is BIT(c), the
> resulting !-test is semantically identical.
> 
> No functional change.
> 
> Signed-off-by: Piyush Patle <piyushpatle228@gmail.com>
> ---
Reviewed-by: David Lechner <dlechner@baylibre.com>


And if you are interested in doing more like this, search the IIO
subsystem for __ffs. If it is used with << or >> then there is a
good chance it could be replaced with field_get() or field_prep().

