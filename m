Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F4064231A21
	for <linux-iio@vger.kernel.org>; Wed, 11 Feb 2026 13:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770816769; cv=none; b=Gq99IFhGZJUTxD/DQ8PjNz+qETZmyQwSfZwPlJelVU7oBqsGlqg+oDN0HCFuDkqVOuVAtTkK3ZV3CxfzWsfklFVHESSRQtazzl2i3okWLAoPZdgtHZbXvejWWvI7lPqOGZv9smqewutaUtFAaIB23r+Zp3yOnMmIlHo8DGUbRDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770816769; c=relaxed/simple;
	bh=nO4RyeFHjHYIJrJZLaxwdROhYOsIjOdlkOslHNR92Eo=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=DSpxHtzvoJiUxUfYuZfi3FGU8Ke6ityUsYRgpNbNjJKlo/rvAojZv5aJFzn5rUM1kkK68FNWhs+JbEDbxZ5FhQpZ7ipf8HBWeeY23pKtdQ5e83jW4Z0j7W5aeWdP0n4xTV+DHT4H8swmcPss+RaCQDYwuZXR2EWEMD1WEVr4vSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UJNrpWfA; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UJNrpWfA"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-7963a209b97so20674697b3.2
        for <linux-iio@vger.kernel.org>; Wed, 11 Feb 2026 05:32:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770816767; x=1771421567; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KNjtiUKn9uwrlqe6xzKXcs6lWXAK19SBBem7iPc2udY=;
        b=UJNrpWfAC2RMn7VzuXlIKslf9yPpovbq1IdGTjYzOq44dp0vTCurHIVTP4v0wNGMsx
         2fd78RJazbNRY3bRfnY/w9R0QKwxwOvAD2jrLu6D9e0/Ho/C6lq6leQK8loxRb+1WPAb
         99RjR9L6IME6Pr8rbmY0H2fnfCm1NFyFdxv463m5II6LDpjODNkr0CaajrueqGusCObd
         qMYruQUL5cHChYvOgppuLVYoa1cublJxJgJ/BryXxFTrQugbAh+E+E8ePVxhnSTGMfaO
         IEt/Wv9exg8uE193ijN6v2YdXAbSkSq2VoBmY403mFepoEb5xYmMkB1AuwIfLLMCvlMZ
         59TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770816767; x=1771421567;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KNjtiUKn9uwrlqe6xzKXcs6lWXAK19SBBem7iPc2udY=;
        b=oK2OaJgpU5NId/sZAzGXGMktnNfxv/fZu+ZdeUZBY5JV/mikR5Cwdnjf6Dx+OV8319
         gy0MA7tjfKa+hjP3qXnHCa3SNLwNPP1wMOWxZsVO0KDG3v67RdEeMjXVgv8CUJbLSkeu
         oKPXWdrSd0cgmXaZ/RznvdStck4/+uv52xOreN7Iqp4JC937nqxfRZOJwaEDR/eJkO+0
         yl1L7e5yuGT8VFx2wp5/F3+UNEBE5tWbARwtQxW/L2O3W//24YZBr5zWh5WBQ+fx8eha
         YDp388v5TBQzRW3nLreitErE0kV8AzinKABF0fXe6xrjMxhSanxdirKjHubMrf9XTM6A
         10eA==
X-Forwarded-Encrypted: i=1; AJvYcCVKtmaPZuX4DXv5npkNiSI5waMrdbGDRa70aS2AQ8PA4/0DQlBftrcJJFGtFNG7+QKUmTc1wlBkTmk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNoxvyU9isRIBp32IBF148PTYy8G+67P/kjM3U4IOT4RcG7G4v
	eDpzZm5LCn+usQpIN+pAwD1QhFaJ1zvJI+6/gvSuJyuOfXeyuzzoSq8t
X-Gm-Gg: AZuq6aJ1S7xb2bewvvXTe4SmxWjcEG53vow1OJwV2LEqU3rjXZjDxgY+D6wAUPHXWcw
	0Z4N3E6x5r8jTIS6ZbUU5ajhZdFetrcQqGTcoQg7FKRzJlYYE9C+E1FYTut1xfNmZP8CVV7fqqG
	2Rg5GiP0NO0Kzkm+F7DxyIzH4zZ3VPHsqR0ggfiB8UZefrSGptnFiiKosIj8ihDKeTD79negAtg
	Ioo6IBlMGh+INDQTiMS41xNX80VwMUMEddamEVIF9ZN/ZaCnktk3GHwa0/ELRgpkoTziaB7BUBP
	cQQ9tfxtPQfc4nYTLslxAh3Iny434jEXac25c/UuUypAwYXLigkZ5t55i1zJ2/CPW9CvoBOtcaA
	4s1CckTAD9EozpLNQUW2Xdix4Oa58YwonJEyMgcmAC+4HdWqp4Y//GwGFRou0Kqz5BDiA3Fybwt
	62417HBgFlKww+ayjG/2LZacV3zQ==
X-Received: by 2002:a05:690c:39c:b0:794:ef94:1222 with SMTP id 00721157ae682-7952ab57b30mr352057867b3.55.1770816766817;
        Wed, 11 Feb 2026 05:32:46 -0800 (PST)
Received: from [192.168.0.40] ([79.133.247.80])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7966c267ba3sm15525077b3.48.2026.02.11.05.32.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Feb 2026 05:32:46 -0800 (PST)
Message-ID: <242d5502-bf58-4e25-8258-8a6c75ff3623@gmail.com>
Date: Wed, 11 Feb 2026 15:32:41 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Erikas Bitovtas <xerikasxx@gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: iio: light: vcnl4000: add Capella
 CM36686 and CM36672P
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner
 <dlechner@baylibre.com>, =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Peter Meerwald <pmeerw@pmeerw.net>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
 phone-devel@vger.kernel.org
References: <20260210-cm36686-v1-0-aef68dd46ad4@gmail.com>
 <20260210-cm36686-v1-1-aef68dd46ad4@gmail.com>
 <20260211-sceptical-frog-of-revolution-fc3cf4@quoll>
 <b95d7a49-6191-4d85-b725-4a941505b40d@gmail.com>
 <6f97c68d-0236-4d04-8199-768ecee7c4dd@kernel.org>
Content-Language: en-US
In-Reply-To: <6f97c68d-0236-4d04-8199-768ecee7c4dd@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


>>>
>>> Please implement previous feedback.
>>>
>>> Best regards,
>>> Krzysztof
>>>
>>
>> Since I am making changes to the existing driver instead of creating a new one,
>> I introduced a new patch series. As I mentioned in the cover letter, cm36686 is
>> fully compatible with vcnl4040, so instead of creating a new binding, I create a
>> fallback compatible for the device. I probably should have named this patch
>> series something else.
> 
> That's fine, but that's v3 of previous patches. Your work was to add
> CM36686 support. How you do it, evolves, but patchset/work is one
> continuous work. When you rework approach next time, you also start from
> v1? And then you go back to previous solution of new driver it will jump
> from v1 to v3?
> 

There has been a misunderstanding. I assumed that since I will no longer
be developing that driver, this warrants a new patch series. I apologize
for this.
Here is the changelog since v2:
- Remove the previous unnecessary proposed driver and bindings.
- Add a fallback compatible for cm36686 of vcnl4040.
- Add a new compatible for cm36672p.
- Add channel info for cm36672p.
- Remove redundant information in the dt-bindings commit message.
Here is the link to v2:
https://lore.kernel.org/linux-iio/20260209182432.00006c3c@huawei.com/

I have received some feedback regarding the changes I made to the
existing vcnl4000 driver. Shall I submit the implementation of it as a
v3 to that series of patches?
