Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6E9626F476
	for <linux-iio@vger.kernel.org>; Sat, 11 Jul 2026 14:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783780837; cv=none; b=plMmruUwRFbhc/mepX6x220uu4PxbHekiexAkEEqAVwnXOHAu2gTKqRhoOS+ykmgBeVic5d2SWL/LPXbwUf7xglAy6Jmld2pzY5zOirEVwWbwHTQd6ynJvJisgzkPlKHzHf9PDMLBTHM49xn2eV1fV47A+P0rPRBlXNHyLQbiHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783780837; c=relaxed/simple;
	bh=9tEQngaiXFQ6p90XQLZu9+Hlb+ftUsJNMXOIDlcHt1Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k6/bxiyZIGsupzLex/5p+pOXQFabNFpd3q9gHD5uLTplZTqTkgIWx2LPeVG+gmTViWzJ94/K5Nbs3vkORZA+TbQYFdII/XILNToc2AKz6hoXfVi7HHcExgdoYxZ1tvrOsrhw3CJ9+tPtoaeax13z41LCTdS3Ktjrsyd3tej0Fg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=MPtg9XWD; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="MPtg9XWD"
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-495c63c41ceso999532b6e.2
        for <linux-iio@vger.kernel.org>; Sat, 11 Jul 2026 07:40:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1783780835; x=1784385635; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1w9ieWr9XroIO1XxDfVO0TVOPppCJVnMpU4FYzzgrNE=;
        b=MPtg9XWDV0VpnvaPqQpCt8aW3ICQydJvTC5FuGx3Myn7HWv9DC8F4C0Vdfq85mRkiW
         CNmQCWqI6xw0x+8VvmJbCJcvwxu8DhPb5tj76Me3y2u/GCR23e1Nd9fAlwhbz/moMz/I
         H+h1mfk0KTieAQl+TSLOoZjajaDMoIhy0kLZsEaRp1Fi8AQoHXHcvFG8kAoCgWFaAPu5
         F3AFt81ANdpY6p5T5FP2QpTD6h5j+BbkwNMOvYYvf5/GN5Rjukk1XXJu0yxPo7WR1a4z
         a2q+HS74apXBF+mohkocSRmtgmCAeBDOcBMKKaCtNsVdg88TXEVxL+4prGYcDVQM7+Ul
         o4Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783780835; x=1784385635;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1w9ieWr9XroIO1XxDfVO0TVOPppCJVnMpU4FYzzgrNE=;
        b=GD3Dtsq5ADT/1giJcIHKd43CcJsvyura24mXExpJ8wLLLsSEM+GLfEhwp5Wooj2ipK
         L4nKp/co65rNuf8/MeIr3nMpkExBeF4Ki3uJXCs3tkydnuAR5lPLk7MmAP36sv4oG1sy
         lz/o+V6kPpZ6+sdUR/Gh2XVf9gF4Ci49kt5Ao9HWHPzdCeC5lMUodjA40Dvlo6EHciy2
         aQFZ7KPxOlUySZtDqgjeZrjWI1y2fd6p8pH773i+2M0x4PVgjc6ymN/fNM+/XmfbMt/R
         MU2LDRhHSVffSXFA3u6sChVGD9TCYmr2HSPiPLxrG8wqAFYAGy8ZP2qTDhd901h7Dw6h
         o7Ow==
X-Forwarded-Encrypted: i=1; AFNElJ+hDih9FBQy8Nami7wf0E73a6atQqYrmg/Pb6Fz3WFs5Lq+2IEQlX1u/HlEEmFp75ILRR06MyLhSEc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDc5FYNn94ELrsBVAn/xK16FUyimR45xlGVdTSO7HegeqCWhK3
	YlHZk4qHHfKMMJ8AS7583aipE/KaFjAgUUusPi+Qg6nEkMJpia8587vRMncwv4pEufk=
X-Gm-Gg: AfdE7cmR4lT1sLOYlqU1JimsGMfLrf+6djuCu5aHLB2Btv2Zdblve8Yns2fMNZ70Ctu
	LXuoD0aj5GF6VzXKV9d1/t0O4VXVMTMRoohj6YtoABbBKAzAVC5GLq2uNDFAK+kex27r++eF3gv
	3nze8UC8LPJljOP7w2WrMHD4N6PVmziu1QCDHjZkkCgUagxociP31nktdxpU8eJLlxMXfceuZ+f
	rJGQPdmDnvKz9Ows0Oh03jfjh4ctADwHUlLcI2e1ZMzgnnXhE9JOzbOSKdUzsAFyJF8tLLUR2nD
	z/8O4Ulo8sHPFHq3rhgAwSNkR8BSC2GaIP+piDFIr5wQbbMiBxz/r9CvpHCOrgX6jf2sYYx3t1m
	bWuW1AXEY29fHjyxnsBvasgVWzMHhGRUPHXPbvSGYmSXkSt875glZA6JauHdk6l9QTHq8a71b/t
	dMCBEYeXSdmmg0OUs053DaKxSy9DHgQ0UQsqzVEWwWbyanqqxbdEIlzM03V9wpcGo=
X-Received: by 2002:a05:6808:178f:b0:495:da89:c578 with SMTP id 5614622812f47-4a42ace7138mr2433350b6e.9.1783780834868;
        Sat, 11 Jul 2026 07:40:34 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:a950:74e5:81f2:8c89? ([2600:8803:e7e4:500:a950:74e5:81f2:8c89])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4a1afbf92b1sm7672879b6e.10.2026.07.11.07.40.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Jul 2026 07:40:33 -0700 (PDT)
Message-ID: <a96caaaf-5cac-4bc0-9e74-e48b6fe0afc1@baylibre.com>
Date: Sat, 11 Jul 2026 09:40:32 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] dt-bindings: iio: adc: Add AD7768
To: Jonathan Cameron <jic23@kernel.org>
Cc: Janani Sunil <janani.sunil@analog.com>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Michael Hennerich <Michael.Hennerich@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Olivier Moysan <olivier.moysan@foss.st.com>,
 Philipp Zabel <p.zabel@pengutronix.de>, Linus Walleij <linusw@kernel.org>,
 Bartosz Golaszewski <brgl@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>, linux@analog.com,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
 linux-doc@vger.kernel.org, jananisunil.dev@gmail.com
References: <20260709-ad7768-driver-v1-0-44e1194fd96a@analog.com>
 <20260709-ad7768-driver-v1-1-44e1194fd96a@analog.com>
 <36df7c4f-82ea-4ed5-a4f9-3a29c75dc99a@baylibre.com>
 <20260710013322.595f8ee4@jic23-huawei>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260710013322.595f8ee4@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/9/26 7:33 PM, Jonathan Cameron wrote:
>>> +  adi,common-mode-output:
>>> +    $ref: /schemas/types.yaml#/definitions/string
>>> +    enum:
>>> +      - avdd-avss-half
>>> +      - 1.65V
>>> +      - 2.5V
>>> +      - 2.14V
>>> +    description:
>>> +      Common mode voltage output selection.  
>>
>> Why not using standard regulator provider bindings for this?
> 
> Interesting question.  If that was done there would need to be
> a consumer which means explicit modelling of any analog circuit.
> We do that in a few cases but so far (and yup this is a driver thing
> in a dt-binding) I don't think we have any way to consumer data when
> a backend is involved.

There is also the regulator-always-on property, so strictly speaking,
a consumer is not required.

> 	
>>
>>> +
>>> +  adi,vcm-power-down:
>>> +    type: boolean
>>> +    description: Power down the common mode output buffer  
>>
>> Is the buffer separate from the output? In that case I would expect
>> buffer to be in the property name, otherwise this should just be
>> part of the enum options above (and the default one at that).
>>

