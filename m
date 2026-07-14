Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B6D841D633
	for <linux-iio@vger.kernel.org>; Tue, 14 Jul 2026 20:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784059492; cv=none; b=bgilcyFVzcQ9rwMPh6tDWb1XemBzJZ1ipC3e5U2eFVejMbWvFZvci5ZHYaZ5yimW4bYWetDkm0GQIIpRztm0Szg+lrNZy+1aojtkW+icR2omAUImQOWIHXFkjlEosWI63iEOIHxAKNEJ/CA2cVWjer9wP1mvlvRI88LnOcxTyX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784059492; c=relaxed/simple;
	bh=mlyz0pITWZURifv0t5t/tRwnR3AP8uFL+yB9c5Nmz+g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a4jupPhRo6ur4aq0sxfqh14BgkMFuOPG32sZmWUQI3rQg0YsAtriEeIwTVfvKfMqt5QuyP/aPLrl6nJ97tIQVA1cQSMgpA8HZOJ97MKTtYdedoFiC1pqPfAjsCZYwH7g6L5z45n4D8DXomHE6vsM/8DvImzZBpEu4W8BCtOa4Bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=EfbmWhbh; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="EfbmWhbh"
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-4a416619cb2so1020637b6e.3
        for <linux-iio@vger.kernel.org>; Tue, 14 Jul 2026 13:04:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1784059489; x=1784664289; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SBKshlNu2WOWV4tRMWzhVwxQQdrnAT+tDDiDT+ttOEU=;
        b=EfbmWhbh52LEnoc9xqfzbWu92rQFVaUfJ523Fhk3T8K3Sqkfpz+XzCNWILxSKs7UPP
         +hQJLeUid1c11TlzOX3cB5ZFpU7KhoFQanTnwm0/7Dl6iRa3cwz8di+m6+IY+DOKoErS
         oSKjKbKC0ykG4bZtib+nyN4Ig6zKLUHz7G61jgcjRCxmyUvVMjZWLG9XbfbDxaA7f++U
         ixiVomdxqI1Q1HRj5LTZgIClSu0es/SVoP0d9Y2AGJxdkpDtc3mmx3kIJVqOVBs8twq6
         Xy7WfpXAKTFhqrycdpC95NyFqls6XKcVN8HlHztemhtfyRFzfjPSCazchYDtGzeeyFVC
         9i6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784059489; x=1784664289;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SBKshlNu2WOWV4tRMWzhVwxQQdrnAT+tDDiDT+ttOEU=;
        b=T6no7BjMu8MS0xlIeDTIUhIhkRCNY/6s6m7nt3PSaEywFC0/CESYctfG4liNgJLZ/+
         uRUZhpz8CTCnZJX6Fi3Z6Q9fQnVblBT+r5R75TgIE5dXkKQH3PpMP0SncZU/NUnISIfv
         NnnjETTpw7GV39uCdy+y9PFUm/4fJtJ2PBq9MEM5+34Y6Q14nLlpqtdSIaMg8/NNUYyV
         wrypsX2gcL/SxxrCqi5xjDxJHW3jKoPKfpQAj/tljGDyKh7MKYj6XhiQZZmD/1J0OspH
         lClEFce+Y+PcaX5IfVRJSGUIgsE6kYjvNe/P6UyEDck5k6VL5BGnu+FZmu4YQBBmdXqe
         DaBw==
X-Forwarded-Encrypted: i=1; AFNElJ8JRf5lW1jl9cMTW8BghSw431rKKk2skdVy0Y/nwbtPopjMIFKLn79y6NMfrvqwPG5JsIhV67Xhq2k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYcv6nBCQJRnBNiRZZs3jhCy2+rh4J+Fznhqy0yObVvHeTWpSi
	lO3EHaToMUJAZayWpAUOIWetEavvL7K21pqmPcOg+SXzpZDbe5gmfYbg2zkS5cWqA+E=
X-Gm-Gg: AfdE7cmowcDlbQizbm2wBD24G//VAM8SWLg9Fzz5aj0/FbTq0Fhhfk8nRJ5ruwpRDii
	oUtITleudvhW0dyF/M2RIAn8jUJ6rj7Tfa55b20nroSHu2Z34EcQhPS1oVJuw5XvjUurO8Dyxz2
	qtGzgl2ftWKch6eA9zBdTPtwBCdeAZnk5e7kI0JF/oIKJdMMrt4MwBvafkwJ64MvimVOYPS/SdN
	NLmbgmVr5Yw1dPy7v/DsHKJFn37pHTNBjYuPDPpvtuV9XAMOXNjF4opYyN4tN/JVhZ4spp6MXG9
	+Xmyujomxd5+y/HbblkDvrdvSLugm3IaM6c/47lEaeZAZSjFm0Tm9NPGBVuvT3UhAr8liVWUNRw
	wOi5oB/mERLBlIICTaiZ8uXSoiFAIFog7h5HiDtN1csg0xfCTj0KI+IlmNFRhwdDjLAq4XCYoKE
	GPiej5FLMmMcBxEsvaGJYe/IqHrDP23XVHXBtl0LnWbP0c2zABiWw/OvYv2o5eIF4=
X-Received: by 2002:a05:6808:2386:b0:495:fa73:2e21 with SMTP id 5614622812f47-4a42b04ed3cmr10654616b6e.33.1784059489060;
        Tue, 14 Jul 2026 13:04:49 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:280e:69fd:7612:d5a9? ([2600:8803:e7e4:500:280e:69fd:7612:d5a9])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4a1acc82f31sm14743501b6e.4.2026.07.14.13.04.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jul 2026 13:04:47 -0700 (PDT)
Message-ID: <8d6d2236-bb07-43be-8b0d-5f6ff0752994@baylibre.com>
Date: Tue, 14 Jul 2026 15:04:46 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 0/3] iio: adc: ti-ads1100: Add support for TI ADS1110
 to ti-ads1100 driver
To: =?UTF-8?Q?Jakub_Szczud=C5=82o?= <jakubszczudlo40@gmail.com>,
 linux-iio@vger.kernel.org
Cc: jic23@kernel.org, nuno.sa@analog.com, andy@kernel.org,
 marcelo.schmitt@analog.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, mike.looijmans@topic.nl, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, jorge.marques@analog.com,
 antoniu.miclaus@analog.com, mazziesaccount@gmail.com,
 jishnu.prakash@oss.qualcomm.com, duje@dujemihanovic.xyz, wens@kernel.org,
 sakari.ailus@linux.intel.com, linusw@kernel.org
References: <20260714194717.596193-1-jakubszczudlo40@gmail.com>
 <CA+gq5JjVnLKW1WdEYzy279tqURXqqy+JNWn9zJPfXKGHUP5hCg@mail.gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <CA+gq5JjVnLKW1WdEYzy279tqURXqqy+JNWn9zJPfXKGHUP5hCg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 7/14/26 2:58 PM, Jakub Szczudło wrote:
> sorry guys I need to resend because of some dumb error
> 
> Best regards,
> Jakub Szczudlo

Too late now, but next time if this happens again, add RESEND to the PATCH
prefix and add a line to the cover letter that says why the RESEND. 
