Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21D4323EA9B
	for <linux-iio@vger.kernel.org>; Fri, 17 Jul 2026 00:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784249952; cv=none; b=RU3Bzkgj9/CyQjyLLkgPJv3/+6pzPmIUHXg5FsW5weFxQ0QqRZPX/nRn3UydVL3MjodH8m+tYVzP/HBGZc0DWnnVOEeq6UKS1NtwhECy7bDhD5y1mtg/lGKryjGt+xIWzBJefx+qcntq1u2aBkuj+AIAJyp3RqPCthqpbo3qXFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784249952; c=relaxed/simple;
	bh=wOMUXoxvykC4/rWvGhc8fYAEJsaFuo0l6LI0NYyXnn8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kcmZ7Ib8aBz0V/JRRd0bsBKjLfYPMWlfhSL3zi3AR4d9M4dIzUmoZJ0AvPE/ulBaYZ0qRYPvvj5CEwiWz9Q7SY/eXG1ruDG4ydb8iGu8WYkxJyFZmmXFRynSRvMGHJcE7qr+LFanOT9YXPFU4DzgzQmMgTz6nO3cl2P7d53IA18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Omyb8VtS; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Omyb8VtS"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-383b4a3755fso3827434a91.3
        for <linux-iio@vger.kernel.org>; Thu, 16 Jul 2026 17:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784249950; x=1784854750; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wOMUXoxvykC4/rWvGhc8fYAEJsaFuo0l6LI0NYyXnn8=;
        b=Omyb8VtStTBvzvltIMRUt7BGujcurkImwEf+/8tOCN4BQC/Fn/CCFTAwV1wzj332tY
         YKIfnbAKebFtvzpQYkeu301DkG/xiF7uRtYo/carlZXq/+hu6c916CkeIv4Z0aXQyjNk
         IXjoq5HRBsix7A6sUAA2rWnkuikkWzhav16VfaR2SdM8Iky6AM4c5jX0bPyv4QhU6Zl+
         vEC5yH+x1S9xnsrfwriKRVIzgdvfhuPLzhwxm5ScnEJ+OsczC5Um6H3Vb2LatqsiIwWi
         5qUWqA0QGaX/HnmTrzBJ+nVQOyPF0q67Oyt5gGgfxD2A8Bqim3Qdalbbf8H/EXtu8UIQ
         V42g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784249950; x=1784854750;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wOMUXoxvykC4/rWvGhc8fYAEJsaFuo0l6LI0NYyXnn8=;
        b=b4Z5vsi85+9arF2avO22G2iHhC70A6Wc5Ie+v7Bmt5sQH7jVCrEgtTaxxHyqtiV40B
         XJE64ZHHmcY/7C4ECVrj/KX0yGNySDlN6wZxmMUS44Hy4OgGGv29waKlWNpJaimEXCNs
         jr6Z/a7BoXOj0J1lEyYpA2PODC8omvel3J2LWHBwZewT3kKA4qHBKkoYpUx24dRUbNWq
         h+ifXlpASBvqkQGSqX9l8hG/NItPcJSaY5hRsVZEacxHsCUzB9AQuKAbmkyU2TK7PShh
         RzhnHa+BDaMlvzh68EeywebrCLJkQNmfdgRSCM2YPwcWAmeFGflUla1DfmisphTMesue
         JKVg==
X-Forwarded-Encrypted: i=1; AHgh+RouBhJv6/YMhofByZHYNwbDEab6iQI4iuNOHiNIIfe3LQIPTIWR89F4elSkgA7zm6zr0jj6Dm6BlL8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyAvz0+or4KYoE0DVszTw4JmIbKeb+GWLfB7SQ/sbhvBSm3ul/
	A9aR555wMvAMbjbSSAeFioGBqt3/QYqeTzLNmusV2yoqZcYtplx/UFWA
X-Gm-Gg: AfdE7clprjBpzKR0m2ER5gbcDhfIm3hSpHhFdaJzZeBi+M9nHmSjv6TeZc475Own226
	HJTO4upNpe9wyDo6Fbxwm78TXYDH91NV0zCPNhRUjL6rABuanpFYMROKNzxq40CgWthqYA6DHiU
	w36nFeYjkDI2Q/kVctLagRWHnjkzg10IxuUT2XSGAy7If4/Qs/8qkMOMzu6LwcrdHEr5Ezrw6E2
	vf9Or2I5GHIw1YM9WL0GYeSWNpZFAql2zNmrQK4kLYaVkzbB057sn2nLmFIstqQE9yb7lOSwiZs
	zNa1uKx5eWpllGSkKUS6/goyepnffTLap0W3qAotASVYAWH43/zsuxaVbTSCef88CfEoemAQCRR
	mQxj3zlAAo4y1G0PvGgbrkQcVk2WaiNMU985o4/ylqQFotIGECDsHyAYYhS12vN0jYqBfPVX4kt
	B45TXc9w/qz4LL0pGCkPagxZ4LeKTBDTIiaZnlY10IpM2Hf279sJ4Xkw==
X-Received: by 2002:a17:90b:4d09:b0:38e:2fa0:491b with SMTP id 98e67ed59e1d1-38e4b594eb3mr346658a91.31.1784249950264;
        Thu, 16 Jul 2026 17:59:10 -0700 (PDT)
Received: from [172.19.1.42] (60-250-196-139.hinet-ip.hinet.net. [60.250.196.139])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38e4aff1545sm151892a91.5.2026.07.16.17.59.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jul 2026 17:59:09 -0700 (PDT)
Message-ID: <8d757505-ea93-4dd4-a374-79f143f6f949@gmail.com>
Date: Fri, 17 Jul 2026 08:59:05 +0800
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: adc: Add Nuvoton MA35D1 EADC
To: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Cc: jic23@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
 andy@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, cwweng@nuvoton.com
References: <20260713081127.115197-1-cwweng.linux@gmail.com>
 <20260713081127.115197-2-cwweng.linux@gmail.com>
 <20260716174237.00004b79@oss.qualcomm.com>
Content-Language: en-US
From: Chi-Wen Weng <cwweng.linux@gmail.com>
In-Reply-To: <20260716174237.00004b79@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Jonathan,

Thank you for the review.

 > Not sure this doc helps. What are these interrupts for?
 > The driver only uses one of them so why are there 4?
 >
 > May well need interrupt-names to allow gaps in the list to
 > work but hard to tell without more information.

The hardware has four EADC interrupt outputs, ADINT0 to ADINT3. The
conversion-complete source for each interrupt can be selected through
the EADC interrupt source registers.

However, this initial driver only uses sample module 0 and routes its
end-of-conversion event to ADINT0. So the binding does not need to
describe the unused interrupt outputs at this stage.

I will simplify this in v3 and document only one interrupt entry for
ADINT0. If support for the other ADINT lines is added later, the binding
can be extended with interrupt-names at that point.

I will also drop the redundant maxItems from the interrupts property, as
reported by Rob's bot.

 > Do you need that explicitly. I think adc.yaml already brings that in.

No, it is not needed. I will drop the explicit diff-channels property
from the binding.

 > For these take a look at the description of diff-channels.
 > It states that where the pairs are hard wired you can just use reg
 > and not specify diff-channels.  Seems to apply here and will greatly
 > simplify this binding.

Yes, the differential pairs are fixed in hardware. The valid pairs are
0-4, 1-5, 2-6 and 3-7.

I will rework the channel binding to avoid diff-channels for these fixed
pairs. For fixed differential channels, reg will identify the hardware
pair. For single-ended inputs, I will use single-channel so that the
single-ended input number is explicit and not confused with a fixed
differential pair index.

That should remove the large allOf block and make the binding much
simpler.

 > What are these channels?  There is a reference to one
 > internally wired one so what are the other 3?

Channels 4 to 7 are external ADC input pins. They can be used as
single-ended inputs, and in differential mode they are the fixed negative
inputs for channels 0 to 3.

The internally wired channel is channel 8, which is the VBAT input. This
binding only describes the external ADC input pins, so I will clarify the
description to avoid confusion.

Thanks again. I will address these issues in the next revision.

Best regards,
Chi-Wen

