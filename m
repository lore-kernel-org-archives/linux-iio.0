Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7358C3A2E03
	for <linux-iio@vger.kernel.org>; Tue, 12 May 2026 13:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778594311; cv=none; b=U+ktKqe8h2srUOFD1/CKhT2J9qwG0uWnemohWsm5dTav3dW/+ZsPPTxV4cAKzJ0MWxribR9VfnLAmUWq16X51znoxRsO2dh5fmYukjgrymkyy+fi7lho9B3RDRQeqRjbOYx8s1fhopG87nb1oL6OcP9WRMj3wIEFgLPesoOvZoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778594311; c=relaxed/simple;
	bh=a4HxmRePg579v/b8gM9feacNUVnpKNRtdZ9UULWANTY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rOMXfxGv2Kp5ceXHVmPwNAcYokeOn7b964LVWuInksdIBAMmSWhAh5QZLtvFW1e5dVUs//eYjq14dqorbMZS75SbS8UTIrPbZxrq+2T7wJ8GKLO8PuhMDG86qOjfdN+rqICRWSkH0SQu2+p5LhqJNKy2AuSGxZby5FvtzREs36U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b=XDS94KA2; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="XDS94KA2"
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-47c941f7213so3368658b6e.1
        for <linux-iio@vger.kernel.org>; Tue, 12 May 2026 06:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1778594307; x=1779199107; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4qZUPICcL2SqDibVA/1E3uKAtRLts6kMoCRLGyFkOb4=;
        b=XDS94KA2a5mhRLuFxFO/nEidomi7TW8/ycnSN1MqzEnnAfc6t2tT9dPIxKEKipoF92
         Aoa2ucEswLH1Kzl1jIINz4riQsZDWOfKdCvzKRsxl1wS4UEVSWwnW576ZrZY2XwIO8Pz
         3b8MLmMRjemcKSt4e6k+bSdhX5eeUSIcOcOF2+C6F8wcLDJYsHeK+XnrCfM7JF9fG36w
         eu7lUbVH70sPPDL02+X+7VG5wM7E24WsymTHHmioFjlkQmTfjIg+hDUHX4EHvkkunMYQ
         vVs5TUApmg9sjbMLDrThQ1QGYoh0JNl/eIc+v4uk2l6SVvwcsn6kwSqgFSJn8i3PbrCF
         T7NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778594307; x=1779199107;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4qZUPICcL2SqDibVA/1E3uKAtRLts6kMoCRLGyFkOb4=;
        b=TcIX7VDGQSFIGOSI6zQGG09nYRB8UthCOpw8V3uDBja6u1q83MZnP5hlYZtslXHNMQ
         g74joGhlQdIIzRd2Z4rWp597Tt5ux+VUzl1pTGEOxJeVlvVjvYGAF7xJaNxybQf9CvvL
         WcQ0HswNDoWvAy95p1IoY/0Yq5VBXsnc5ABCQfmwcrMj5d9Wnys+tQQ6slEAPHjDKsvV
         phMVhq6ufC+Xdv44JD0iNOjE9MNf6veJ/KiN/MD1uRujc3Pll36K0jpRSFFfxZnAexVb
         GWryonm4fstjxFHDbMCCQAZaxn0uhpQPgQiHe6enasPd6TT44ORMe3tWkx48DDso2KnM
         uVjw==
X-Forwarded-Encrypted: i=1; AFNElJ8dOFpS2EiRdnDjuVuGl5pSj8UJ/y9e4uU6hKLtBbxyQ7xQ9YFsaa0q8/6Eln2njponepjtTEKyxEY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMlOCuj3g/4MAW5JibyfnJKk2OWVqs9QFlPRFWLY8HuCf4/OoC
	oiPolBgtfe4IBl8uoopxG15jiAOGXVX+GIIXe/5QxbJ8Na4lht+jeIuVKtYwaUmuZ/KItR91bxi
	g6VQS
X-Gm-Gg: Acq92OGx1fG3oC354GP6rPjm7yrzVOW8SE0Rd/YzHiO3Cbgpkbd6RKKIpoWhCRK+pKs
	AqOdoPMfp4OAnUV+YpXNViSL91dJSo4WRJwxGKMhj75cshdJTHrf4g4yx84JWzke77H/rVKJ8Sz
	v9CqtRPw4l4LIMsaWOX8GOKGfri/v2cjda9zzkcqpyDv9/wX/lfxqgaj8K3wEc8/KV9xdz8h8VB
	yBH8M5q/m9R94BMvYXo1S/ukpbUabOt1h2OABkapOG4ksT7LaXAf7WoSU1gpxZ6xc6+H9J5ZdvP
	8TGfeBKsJmmYXyQ65fGZ9AfQSX7WDzuDkeiSS/jV9xAJyjHnyu4ptXLxodJd4NXOPjGgtAG2SWg
	nErcQAxL7Fm6Y404l74INj+chn+X6OGv4swJBJTVaPwaMXZbOWOZo3eBHXWbsfk2Dvd4EAO8KsB
	aNCF4e7RP9pDsrXkRLAEv161QSiXH87iX0Om98ktV8JxPUNQIgUJYHcKdqzhNc0pxMSBqZDHa70
	A==
X-Received: by 2002:a05:6808:508b:b0:467:23e2:5097 with SMTP id 5614622812f47-480424a4bc1mr18863086b6e.37.1778594307354;
        Tue, 12 May 2026 06:58:27 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:baa4:f7fb:528a:2457? ([2600:8803:e7e4:500:baa4:f7fb:528a:2457])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-47c763b33c1sm22558261b6e.1.2026.05.12.06.58.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 May 2026 06:58:26 -0700 (PDT)
Message-ID: <a4ecfb27-5ef4-4682-b87c-24917f81b4f0@baylibre.com>
Date: Tue, 12 May 2026 08:58:26 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] dt-bindings: iio: adc: Convert xilinx-xadc bindings to
 YAML schema
To: Rob Herring <robh@kernel.org>
Cc: Jonathan Cameron <jic23@kernel.org>,
 Pramod Maurya <pramod.nexgen@gmail.com>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Michal Simek <michal.simek@amd.com>,
 Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20260510083219.70224-1-pramod.nexgen@gmail.com>
 <20260510120141.118057-1-pramod.nexgen@gmail.com>
 <20260511171554.6541042b@jic23-huawei>
 <7baf9ca5-50ff-4131-995b-70ee094ed247@baylibre.com>
 <CAL_JsqLxtWLR+jxRXt7Uz6dcF-90NYmfyGWYQk9um9TYHSWbTw@mail.gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <CAL_JsqLxtWLR+jxRXt7Uz6dcF-90NYmfyGWYQk9um9TYHSWbTw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 5/12/26 7:14 AM, Rob Herring wrote:
> On Mon, May 11, 2026 at 11:24 AM David Lechner <dlechner@baylibre.com> wrote:
>>
>> On 5/11/26 11:15 AM, Jonathan Cameron wrote:
>>> On Sun, 10 May 2026 08:01:36 -0400
>>> Pramod Maurya <pramod.nexgen@gmail.com> wrote:
>>>
>>>> Convert the Xilinx XADC and UltraScale System Monitor device tree binding
>>>> from the legacy plain-text format to a YAML schema, enabling automated
>>>> validation with dt-schema.
>>>>
>>>> The new binding covers the same hardware and compatible strings:
>>>>   - xlnx,zynq-xadc-1.00.a (ZYNQ hardmacro)
>>>>   - xlnx,axi-xadc-1.00.a  (AXI softmacro)
>>>>   - xlnx,system-management-wiz-1.3 (UltraScale System Management Wizard)
>>>>
>>>> Signed-off-by: Pramod Maurya <pramod.nexgen@gmail.com>
>>> Hi Pramod,
>>>
>>> Something went wrong with your sending of v3. I have two versions sent
>>> half a day apart and no idea how they are related.
>>>
>>> Anyhow one of them got feedback from Rob's bot so I'll assume we are
>>> getting a v4 and wait for that.
>>>
>>> Jonathan
>>
>> I think Rob will have to fix the bot to make an exception for the
>> legacy bindings. This should have been called out in the commit message
>> as requested in a previous revision.
> 
> The bot is not the problem. It just runs validation. The schemas will
> have to either drop this check (comma's in nodenames) or exclude just
> this property.
> 
> 
> Rob

Even though this is an existing text-based schema that has been around
for 12 years with this name already? Changing it could be a breaking
change to existing users. Although there aren't any in any .dts in the
kernel source.
