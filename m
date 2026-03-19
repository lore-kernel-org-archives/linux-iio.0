Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CA9C34D903
	for <linux-iio@vger.kernel.org>; Thu, 19 Mar 2026 19:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773947229; cv=none; b=FGOwEKCELML0K/Tecvr6UbdmdDFW7VlF2HBCEP67GChTesOnhRe7jquQds3sGF9m9sFqj+Pn1HQ5UlEGdNlbEvj1+dQFJb5GpBL6xg8oNlVq9ihHg6S2UJj52KrEp3+1ZlcmZnaQQ1tflZiVBfZ0/RkPCYtIxlBX73Djtp4S970=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773947229; c=relaxed/simple;
	bh=yW/IU3e25Zy4WJaB66NqymPliyoUarcBRbIx9wdpU0o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tF5q295ibVP6aZc/KFwhLLZfquKqIFKYVgAinXmGRNmfxMnRxWyIrW6FyYImVyxbRxBC9YfdlKYEoMLAZbczJg5+gLBwoqPUUIzeHsC8IsUDrh2cmqgGBMGO25LYk8qbQusV5xI41uCbiyW3z8HL8WP3etl2ZbyRPHNgp/A2Lbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=t1lzzWZM; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="t1lzzWZM"
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-67c1d6890f3so343305eaf.1
        for <linux-iio@vger.kernel.org>; Thu, 19 Mar 2026 12:07:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1773947226; x=1774552026; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0qCQhLNUlaK92jVRFmSRxDAiEZoE/HXa9IGlyqo2jsM=;
        b=t1lzzWZM5ng5qbMQmo3Orles0xIKvcsBntpdGd156f1a/3+T0aoVBC49MBXw6II3xM
         a8GLgmHLbgL8DSBiciq3XFuRlmtiLFDnQUxaymVDG2gNKhpG91/STY/Kjxj8zBFwzqNM
         ogiEzaGXs2+PsNZ+YYQyZWNk6x3Q32bGKzRiUUIRzfHeiXFcj2TcKjyedSMUvfL0TFQf
         rcRCRXUenUqw9wdRj4cQW12JSEjg/Onsb+KBYPWf65GKmn6Ex+NVAH/lsY3OI2rrMTJh
         LTyXVvpcmykCGXKtOxWs5xUMgdXb3BgAeMvxj2qFo/XJ38XiBuCVeUIBV33K4UHYfBe2
         zEKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773947226; x=1774552026;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0qCQhLNUlaK92jVRFmSRxDAiEZoE/HXa9IGlyqo2jsM=;
        b=pvrqukntrDvlc2CjSxCTwV4gta+VSxS7Du4cy/Nm/k/zqxy5y6XQgILo7VnaBufN2P
         HSe8e9m14MYgyFJwcqTQB9qJxgml5KvkhzewRcymXFSm08AhWhC1hiKlIK78KcHGcp4R
         1QEvPQ8sqyKVCZwCPNH/Uq9j4rOPuIDkxnvTNJRRzfKzgo31D+D/xYeKRXrbnyodg7tr
         Nf7tSiex9EdYKiwZ5CLPh3xKRdxVM/SHD18VfaC/0HGnHVbPO+bA9LnRLTILXSMFIFEG
         GAYq/MP6XSJz60y1quqCMQN+Wr0QQOn9hgh1MfeV4fgs2huXDlMx5Ii9aqlfcg9mJaYJ
         BcNQ==
X-Forwarded-Encrypted: i=1; AJvYcCWqBYQ7txVl+iBOiauvEP1/xnCFq3JfSonhK+zuqJ46rU6VwsTr/CdY3RKQTEHGmUp90rE1KRdGnxQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywrk9bgDSwFfHoV/4AYKinc8+q5AwjoFChh/Og4GPwpgUR8tfuS
	5itOvU3S40OzhuPGJJ13WxVD59fa71D5gI5IdKyO4gqUr6CpqiSBj4Ikc46Osd29W3o=
X-Gm-Gg: ATEYQzw+8YZy9mNiILPq8bjuJ8V8Ihz77IYZhNbfJ4w/ckTMTFDauzQWjX7mwSPkT2U
	s/049bNsZeMLv+JryaSGGHuQ4CZVgljwpUzOpI7aWY37rDq61SVvFRUrUVRJXzYJggr2jCYbgk6
	p/JQRU9+TNUyWZMAPDse0MUrSq935dUg6mHAo5o5JKyhu6f0AcudGpSdrUZG8fWXoyjEnVF5/HW
	QIvi1xbw/UOQu2Lf6f7/6c9av1xdEuKtTGw3Ma1p8Tb3E2JNiUCEZa5RVp2shFnOI7BccVw1aLm
	j/wakHgHAkjpGhiI46Xvue/LLxFnHmJdLa0n+NTdNasbu+MuyImUkts5nKYt/SskTLSwjs7e4v+
	mxjt3RnddkPdOUJA3rtxzc7h4I1nV+SC0stZrRwqVq6GqWPyG7TnWZdFvpMYgNsm/Z4OllA/0kH
	u+Vh0kkFQ3+qwKQfz3r7dc1pzppO7BNfmjuOweszJr/4sKk47uhCCGqZxfH9eAh29Gj2sXVPjr5
	4nJgno2ZcPX
X-Received: by 2002:a05:6820:806:b0:67b:a4cb:293f with SMTP id 006d021491bc7-67c235fb70fmr249017eaf.17.1773947226499;
        Thu, 19 Mar 2026 12:07:06 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:244c:fc8c:8216:1344? ([2600:8803:e7e4:500:244c:fc8c:8216:1344])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-67c0d724e53sm3921843eaf.0.2026.03.19.12.07.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Mar 2026 12:07:06 -0700 (PDT)
Message-ID: <faa4e46b-1cc6-4bab-b13e-c527a67ec4c4@baylibre.com>
Date: Thu, 19 Mar 2026 14:07:04 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] dt-bindings: iio: adc: xilinx-xadc: convert to YAML
 format
To: Krzysztof Kozlowski <krzk@kernel.org>,
 Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Nuno Sa <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Michal Simek <michal.simek@amd.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, saikrishna12468@gmail.com, git@amd.com
References: <20260220053941.611415-1-sai.krishna.potthuri@amd.com>
 <20260220053941.611415-6-sai.krishna.potthuri@amd.com>
 <20260221-dancing-papaya-wolverine-db8afd@quoll>
 <b89933a3-5f25-466c-a2f5-6e231aa12749@amd.com>
 <21d425bc-9406-401b-9817-7255ba3d31fc@baylibre.com>
 <e4c9729f-1785-4d10-a337-37b0d26fe30b@amd.com>
 <f1706ec0-3995-4fdf-a9fb-8e1e688438a7@baylibre.com>
 <05bcc5b7-b3e8-40fb-be70-413c74afcfb1@amd.com>
 <cf749e8c-f141-4367-81ad-827e02273ec5@baylibre.com>
 <6a4e3d95-875f-4c2b-8443-c2f2b19ff166@amd.com>
 <12a06779-cbbb-4dc2-b564-7b9cdff6796b@kernel.org>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <12a06779-cbbb-4dc2-b564-7b9cdff6796b@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/19/26 11:49 AM, Krzysztof Kozlowski wrote:
> On 19/03/2026 16:49, Sai Krishna Potthuri wrote:
>>>>>>>>>
>>>>>>>>>> +
>>>>>>>>>> +$defs:
>>>>>>>>>
>>>>>>>>> Why this is a def, not used directly? I see only one usage of this def.
>>>>>>>>
>>>>>>>> I am getting the below error if i define the patternProperties directly.
>>>>>>>> Seems like complex vendor peroperties should be referenced via $ref.
>>>>>>>> Please suggest if there is any better way to deal this.
>>>>>>>
>>>>>>> It is hard to say without seeing the new version of what you wrote.
>>>>>>
>>>>>> In v1 series, i created $def and referenced this in xlnx,channels to avoid the error that i mentioned.
>>>>>
>>>>> Is the code below the code that causes the error?
>>>>
>>>> No, the below code is not creating the error but Krzysztof asked the question on this code,
>>>> "Why this is a def, not used directly? I see only one usage of this def."
>>>>
>>>> I am saying if i don't use the def and use it directly i am seeing the error that i mentioned. So, asking is there any better way to handle this case other than using def.
>>>
>>> If you could show us the actual code that is causing the error, then
>>> we could perhaps spot a mistake or suggest an alternative.
> 
> Thanks David, I am surprised how many emails we need to exchange just to
> see the actual code.
> 
>>
>> Thanks. Here is the code that is causing the error
>> ("properties:xlnx,channels:type: 'boolean' was expected").
>>
>> xlnx,channels:
> 
> Device nodes do not have any prefixes. Just take a look at any DTS or
> any binding.
> 
> Probably that's the reason, because nothing in this code looks
> particularly odd. Anyway, please do not come with odd syntax in the code
> without any explanation, just to make it passing the tests, so for
> example ignoring the checks we have.
> 
> 
> Best regards,
> Krzysztof

Since this is converting existing 12-years-old .txt bindings, I don't
think we can "fix" the bindings by dropping the vendor prefix.

I think in cases like this, Rob will usually fix the tooling to ignore
this as a special case. (I had a similar case last year on a conversion
I did.)

So I think the right thing to do is to not use $def and explain in the
commit message why the error is expected (we can't change existing bindings
even though they are "wrong" by current standards).

If this was a new binding, we should be using the common adc.yaml for IIO
ADCs which already has patterProperties for channels and a bipolar flag.
But we are stuck with this vendor-prefixed one here.

