Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94BFE339875
	for <linux-iio@vger.kernel.org>; Mon, 22 Jun 2026 16:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782147562; cv=none; b=d+BfJpGuYzWmp/AYvzvyM2vzLGAnqrs9eP0cKclULwzwpOUTEfznO4E9zj/KwsgCdCtx7iMGtKre0Le+jtPu0gtsC23pF+GAGZfaWKz2AJEeRijjIz4mYkSjbxW4y4IUX+DgYMn5rzD1ysF3mdbLPZixAKEC4++F+dxwIPGV+HM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782147562; c=relaxed/simple;
	bh=VwLgvQ79ZYX2f+aOk6E45c43BgvC+vyBko2Cz5vJ+KQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TDfsOH5YI8WM0pOFrWAIV4tU/T32CxBchC/ypong5nbO79pZBMKRrJ7q+/01BbAyKIyZjCQSE5G/hCkFWKDO6zTBWDSdftZ4EgrmTu4VZreGzdClrFR19Bo7G1HlZGmuDHby5DA4E2GHpgFXYDKSfIiceRe2M7q3+EHbHOj2UBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=A7SEhHJ3; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="A7SEhHJ3"
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-7e94cd6f99aso1574672a34.3
        for <linux-iio@vger.kernel.org>; Mon, 22 Jun 2026 09:59:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1782147559; x=1782752359; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LgjPu8EjLkNonMouFLLepbJvfLSQfkmj1LSsNNlmiCw=;
        b=A7SEhHJ3bTDgTFtOLfjzVo+enj32EmRN7j9vN8mfVTLTFBbFTQoP1NNWZLIxDMIdFf
         8rGbvLK5qEA84k08RntU8Nqb6SYvzP3oV69vbQOi5nTBSypzEFWOXzlsap2nPRPuOivW
         VFZguAQJrr8HtWuWJf2+xmEb9zVOU/XPQ8YOKGVkIDMLIMPeFVD1Jo66alTdg6r7IUhT
         m8nPZyEC/6/fSYX7nhtf57t9Skt5FJjwsaV7v6zlBZhMGHdOk0x5aN2jbO8JFO3pql1A
         nn8rQvedogk9ksTzGl4R8QNKZexSHbw1GE1H4/pJK42pi3ZSu+S+4+KEQ59+c4RFPoAv
         Va1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782147559; x=1782752359;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LgjPu8EjLkNonMouFLLepbJvfLSQfkmj1LSsNNlmiCw=;
        b=X+iQo0Mw+kgKVYUKO5VHCMG9r7poA6Bi3/3MiipdElphVKKoyuI1rwnXf+dtAyvB3S
         D8pfi9SaAFyPUp3DoojImPqbtyoZLMiTbzYK3Pk7ddyFhDQgvZ6sfB8HfHngCrQLZLVC
         CeyBjODgb89VEQGc2j0VDetaXtyuE9+M2RIYinQzgPc+E6zIg/GHu9+qFgwyCm1FjIMJ
         PcvrUKdE9C6+oUd0qhcUgVtIMO4nmvTVDlygVWdum1GB+fL+iTPW3RosPt6pvVXqBOcv
         Nn74XcFVi2SXqd3n3GszZ9HNeCKfd5rMF0euZ5uHUZhKoCKOLGfNhiA+4dPdegUttN9m
         PNfg==
X-Forwarded-Encrypted: i=1; AFNElJ/Y5+du7HSgJEs80EWRZAWX60AijNggn7hp6vL+cITdXJfbRmGPWDdnssJqMhsoaqXRr36r1MiG1h0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHd8H5sZqgWI63XiZ7UeGc3/PcrfkJkJV9lDZGAiJufEtQKhaq
	VxWGhNVpvoHq2EDD7WlbvTjXMQkDTyKaIvbDXbS53ZCB7zw1B5HVXQTyQ0sCy3wjfyU=
X-Gm-Gg: AfdE7cl4MkPmQO0D3FTi6COMP8riZO6w7oLRPVcXZ2SJKbymRmKNjf4Eb5e5rc7otuq
	GXUck93B2Toyp8+qdu0xSMmxcppADaFtNqwT/CJHiv0Zb3B4Sm+yPkbM6Ryl1jiJKnkl8eJTnRG
	EYWoOUP64UVNeoVs5rSTNkpK7C9BIl0u2WEoZm731VNxi+bwB0p0/C5LVZ8r++KmtjtuX1sPqCZ
	uy7V/gWBMuEqMqmaMkJ+MXNuGbIUTHyc4rISI2er1ESwsCMyUhCW6U0FgWan1w+N/oCFZETgA/y
	3jjqE56TMncKpHgM2NqimtWXnvMBtSxX1oNzlAjXjmiKqvbhFBI+doAeeJHpaucT1+3XdiIxBLW
	uzMRd5siCWN5OoyqpT3HTan9cvTx5Pdx1Z+NVMzYZcXEv8O/8uWIXDI1/RFb3bsD6z1PyYSfM62
	W+ZbPpOw5bvgYdPfKr7kcnRB1FobPpSJnzg+ooOTPdlG+kDZIlHh3zPfc3IJoXHYo=
X-Received: by 2002:a05:6830:3892:b0:7e6:ece3:80ed with SMTP id 46e09a7af769-7e92d9c6f71mr13440607a34.21.1782147559630;
        Mon, 22 Jun 2026 09:59:19 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:b69c:5a77:b8fb:a5cf? ([2600:8803:e7e4:500:b69c:5a77:b8fb:a5cf])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e944007d74sm6772717a34.5.2026.06.22.09.59.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jun 2026 09:59:19 -0700 (PDT)
Message-ID: <78d859ed-61a6-413e-9ecb-6af177f2f9ae@baylibre.com>
Date: Mon, 22 Jun 2026 11:59:18 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] dt-bindings: iio: adc: add ti,ads122c14
To: Jonathan Cameron <jic23@kernel.org>
Cc: =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Kurt Borja <kuurtb@gmail.com>,
 Nguyen Minh Tien <zizuzacker@gmail.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260615-iio-adc-ti-ads122c14-v1-0-e6bdadf7cb2b@baylibre.com>
 <20260615-iio-adc-ti-ads122c14-v1-1-e6bdadf7cb2b@baylibre.com>
 <20260621194102.08d7fdd6@jic23-huawei>
 <da875b00-6f93-444b-982c-30b8001dd8e0@baylibre.com>
 <20260622105546.69c6b4bb@jic23-huawei>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260622105546.69c6b4bb@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/22/26 4:55 AM, Jonathan Cameron wrote:
> On Sun, 21 Jun 2026 16:14:57 -0500
> David Lechner <dlechner@baylibre.com> wrote:
> 
>> On 6/21/26 1:41 PM, Jonathan Cameron wrote:
>>> On Mon, 15 Jun 2026 16:59:59 -0500
>>> "David Lechner (TI)" <dlechner@baylibre.com> wrote:
>>>   

...

>>>> +        description: The current output of the excitation channels in microamps.
>>>> +        minimum: 1
>>>> +        maximum: 1000
>>>> +
>>>> +      current-chopping:
>>>> +        $ref: /schemas/types.yaml#/definitions/flag
>>>> +        description:
>>>> +          If provided, the two excitation channels are to be used with current
>>>> +          chopping enabled.  
>>>
>>> Can I have a reference for that? My initial read suggests it's the input channels  
>>
>> No. :-)
>>
>> I must have got two ideas mixed together in my head to come up with
>> this. Clearly this should be `input-channel-rotation` or something like
>> that (we discussed in another thread already). Also curious if you thing
>> any of these properties are common enough to promote to adc.yaml or if we
>> should just make them e.g. `ti,input-channel-rotation` (you might not have
>> had time to read the threads on that yet).
> 
> It's turned up in a couple of drivers and the concept is fairly standard I think
> so I'm fine with promoting this to a top level property if the definition can
> be generic enough.
> 
> For a non TI example, the LTC2893 has this as well for it's thermistor settings.
> It might be worth comparing the approach given here with what we have there.
> In that case there are specific node types for different types of things that
> are wired up with constraints on things like excitation currents.
> It kind of constrains things to the sane known use cases.  However that is
> partly because that device does (I think) more type specific handling than
> we have here.

LTC2983 has current source rotation, so it has a adi,current-rotate property
which would be the same as the excitation-current-rotation property that
we have proposed here (named current-chopping in the patch, but better name
was suggested in later discussion).

So not quite the same as the input-rotation property that we would need for
this chip. Although ti,ads1262 that Kurt is working on will have both.

> 
>>
>>> that are chopped.  For GC_EN
>>> "When enabled, the device automatically swaps
>>> the analog inputs and takes the average of two consecutive conversions to
>>> cancel the internal offset voltage"
>>>
>>>   
