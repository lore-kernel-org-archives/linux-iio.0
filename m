Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17782342CB2
	for <linux-iio@vger.kernel.org>; Sun, 12 Jul 2026 16:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783872466; cv=none; b=rfbVZqzG200YkkOOicvT1iJ3v5/zZw6lAIX5K5DSV82EZKeIgoxBuqv9FbHa1hiIPl0aQef6YuyaIpMB6K7xpiJIwcP7GGsBr37Dw8omQxLCiBFeQ2JNYdKGbAMq6FaWvQfoO9CL3To1gez2/9T3wfB/4h2hG4v6BXqhEEBoGW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783872466; c=relaxed/simple;
	bh=/Lvsg/ZJR/lfpgoUMIiOWitMqmPb9MoVhYs6ClRrfg4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jufNjZYR9Ql82O033BBmhmp0pu7ErULs7cBxUKi8T0Ply7VbyzzBaEDX/xnS3FBoR7zJjOfDZ6fIHmid33rcpR2quyOpFTy77glaLuT/rrFfaQgjxSAH2xQarxNIeV9/WyHRVupWaQrQ1xo+BK8G+MfhVyaCvetKjysDx4UymqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=bS5NqABn; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="bS5NqABn"
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-4472500e25fso1151965fac.1
        for <linux-iio@vger.kernel.org>; Sun, 12 Jul 2026 09:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1783872463; x=1784477263; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uVpYadVTuJ7Oa9ZoTB5rgj6lqcEBWKLs7QhoK6MvLlk=;
        b=bS5NqABnb3IrzzCXGNzFQUFOq3VQgzYZKi+bhB+usfs5AjjguDll7xUPIPvq64mD+Y
         VZCN/PjROGVKPdWskoa3068iA253zDh6Da6mCDh1pmmOmmySOw6I/CaQJSJplgpIjCen
         xmIBp3/rG2TOu1xICOgMeFMyFYM/DvtqqkvMlVdqKvZdlxNNpI5C61GK/EblxEzFp6Ju
         RyzT4/IhGjkMraU9Y+u0RF6oYavekZxC9fxJJPcDFi+pL2pxXpDnrL3dQyR+ktGLQaKM
         uAds6MENRCW2CHoKYKDEt4MGjsE5YTeZnfPU0dGZZ4W3Tp3KXR2oep2ud39/+RsWx+1j
         qK3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783872463; x=1784477263;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uVpYadVTuJ7Oa9ZoTB5rgj6lqcEBWKLs7QhoK6MvLlk=;
        b=GdPdHl7b4Ksn4+C8LLr3scS0Xzt7vM9LoiGKAp2PHVWdIS1dRuwvRYsxHD6wgfrtcc
         TJnWB6+5CBgdcRtd2aEu6kZke/3POlt9bOBzyWpCgCZOCZSjL7bgnodUYShI8Rubjmw/
         UdocVSP33zciuAj9bgdYyoNRQROX817C0ykhqxxtzeU1HxCqVKiOxKqPBslioYEKyr2M
         9oSuqNo4lIsrtdg/LbRhOMO2/fW144P2CB5qh6ikJGdddGT8MArNThha173eh2q+XiKq
         Ju3diLRBqJw6/jEkXuKXOz4uo3bG8Oq0QVocp+/SeSVu0Fz14CUxCshPLt9IuZkaQz/y
         1Sug==
X-Forwarded-Encrypted: i=1; AFNElJ8Y7w0A/Koz5OA9mQf8iO4eF7tfr57gJPk0ZH9YnS1n/892t3H3Q6WsQWA1TcmfdeXYKgFf5gaD+Do=@vger.kernel.org
X-Gm-Message-State: AOJu0YwL/nkflcBDvmgQWgeQQ2PmddofkhHBLbbuMupio0EM21Ya+ZUb
	JiA+giCVXjIR/Q1YH42nmkA4q/ysHDg+Q5c3fvUzwSae2Jflo7WOakNSqV+a2MzZwfo=
X-Gm-Gg: AfdE7cm5MhQdDxIXvXsx4kPsh8sDw+5Sxkt23FX4pdaghKeXvOwyXJnXuNc9HtWv+s8
	VYITv/VpN99Hmp4BDQGwTcnUIGRaNJgSBD6kp4zA5lXYDErX0j5WvI+YEZAL7+0jiaAX7XMJhbq
	i4oJ04a1g7955uBrQkfzLpEVjq+/C7btykv0kFFwM2KkWSWY8v1zS41Ubi6wKXkVz8twvSD4izT
	J1QU1Fo9VnZm7+uLD6T6CvdIV/Df4xgxRfsjBgtKsA2U/UhMjVRm1joTPUMnR/22w+9zq2ATmAj
	YOD5wrPKzBxikN08PfT4bXPR3ams88LwiF97lnpLTgxHsF1AinhlBVMF/4aSXVCo7EM9kyf75gn
	irLkFGCjxwlvArlhTSUAuOdsQveq+YZTdH1cNtOX5nrwnwAOF45csLy4xTJbIm434lhR3n7z9ED
	ODEdwzMRfUsMi0gEpVAsLXb16E1qxtGzXKrDwCrjoBPmHrxhx7+hSrrvAS+euAj4A=
X-Received: by 2002:a05:6870:e187:b0:449:a0db:5917 with SMTP id 586e51a60fabf-451f1445225mr2893250fac.41.1783872462881;
        Sun, 12 Jul 2026 09:07:42 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:3af7:75b0:bf02:8cf8? ([2600:8803:e7e4:500:3af7:75b0:bf02:8cf8])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-455c73a335esm321788fac.12.2026.07.12.09.07.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Jul 2026 09:07:41 -0700 (PDT)
Message-ID: <4b548db9-323c-4754-8e91-26ce94669600@baylibre.com>
Date: Sun, 12 Jul 2026 11:07:40 -0500
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
 <a96caaaf-5cac-4bc0-9e74-e48b6fe0afc1@baylibre.com>
 <20260712023918.119fbecd@jic23-huawei>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260712023918.119fbecd@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/11/26 8:39 PM, Jonathan Cameron wrote:
> On Sat, 11 Jul 2026 09:40:32 -0500
> David Lechner <dlechner@baylibre.com> wrote:
> 
>> On 7/9/26 7:33 PM, Jonathan Cameron wrote:
>>>>> +  adi,common-mode-output:
>>>>> +    $ref: /schemas/types.yaml#/definitions/string
>>>>> +    enum:
>>>>> +      - avdd-avss-half
>>>>> +      - 1.65V
>>>>> +      - 2.5V
>>>>> +      - 2.14V
>>>>> +    description:
>>>>> +      Common mode voltage output selection.    
>>>>
>>>> Why not using standard regulator provider bindings for this?  
>>>
>>> Interesting question.  If that was done there would need to be
>>> a consumer which means explicit modelling of any analog circuit.
>>> We do that in a few cases but so far (and yup this is a driver thing
>>> in a dt-binding) I don't think we have any way to consumer data when
>>> a backend is involved.  
>>
>> There is also the regulator-always-on property, so strictly speaking,
>> a consumer is not required.
> 
> Makes some sense I guess.
> 
> How would the voltage be controlled?  Set min and max to same value?

yes

> 
> J
>>
>>> 	  
>>>>  
>>>>> +
>>>>> +  adi,vcm-power-down:
>>>>> +    type: boolean
>>>>> +    description: Power down the common mode output buffer    
>>>>
>>>> Is the buffer separate from the output? In that case I would expect
>>>> buffer to be in the property name, otherwise this should just be
>>>> part of the enum options above (and the default one at that).
>>>>  
>>
> 

