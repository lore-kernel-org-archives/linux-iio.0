Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DF323A9871
	for <linux-iio@vger.kernel.org>; Tue, 12 May 2026 14:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778595197; cv=none; b=EDGQlf5CsPXvlw2C4a8w49iNm3SKNqVDMFrkJvYmw6xz12hrYlbXJU6IGWgFxqglFre+2qodUOlXUoZ5VJjG+FeQtuuO6xwFMWTw0d7XwOD75qx3vdSkPBmWlNGFKqDxsBHt2KIgEuQmdd0kIxDKX84aLdT123X1I9H1Dddixzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778595197; c=relaxed/simple;
	bh=Dq7Xn2iwHrokGpyReWmPWnvaDDe9J7rZKMtFuqJTkzs=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=HPCk5Ut5w9J2vPhX/7a3bFdnZ3gS8JLqTx8sNNL7hzsPhOVMqv1I/N+sK4tpBkFN6FRVESyuFVfH3+4+/F0jfv7yHm7fg8W0oLsER6vi2ZWW/+tkWzQyydZOof+ED39a6zyzP7mImNa0iP7D4CjhkFd5n160RRRycNo4sqdZUDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b=wbjqGHqV; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="wbjqGHqV"
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-7dbcb467f2bso5050538a34.3
        for <linux-iio@vger.kernel.org>; Tue, 12 May 2026 07:13:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1778595194; x=1779199994; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kgNJhNIeorV7YFB4VYbzC5DWm0skgWvwJAbHsFTJdPA=;
        b=wbjqGHqV3gvG324B/2jF+Ak3z0wntnnoBWrQK8QCPEjhoaZa8Ivfz4uTCbvV833ary
         0gx0t03uRwfnSEX7zuTOxKDkGBHMEencVgQX7WU5vMfWlh7Jnly3gutnbYMr/gjjgXKq
         z7MdUK2YdvHr01ttKPadyb1uTOn37Pxi+zdrPh+QEkKee0qe4U0pl3tB+65TJXGsqKSK
         zOfEX2xNXMs/wDoKy2xrXeDFYL9BAVRUibTBHMBWNajU4W9/Gr0Q6PtouDwxVG1Cyn/2
         LVy5V+uMrO9+Gcrzqhb6oEaAR3yFVR0hr5KYsLdNXG2C4lTk+ViNswfNlyzr1TJg5LwN
         eYEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778595194; x=1779199994;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kgNJhNIeorV7YFB4VYbzC5DWm0skgWvwJAbHsFTJdPA=;
        b=b5KeXwJdGth0tIfsmehayzlzV0hmes8C4So66zxd8ByW+98vmQU6wJxv8UynkKqB93
         baTnHoU/MFTgtdGUmbzAqY7/ZPSCBBMBcueYeMhntp4xk6XT8Ap7TFxwxL/JsboLHJKL
         RN5HorWxD7u7rx+IIU/hXAXJuEN//Iaj+HbCw8h35THkOpvmffWPzxbhU04Xsxi8Ar2d
         k68Yiq7K8p8ydF/OAtWYUbgB3BYLCh7fGR6FgcCPjU+zBIe7AZNrx51z5zg7DsbV7Cp3
         5G3w0eF3gXoBElX4QuCmDWLnEsHfqHA8a//Zc8A4gFJWudrzW7UtzipXz2KcsbsQnGaD
         eATQ==
X-Forwarded-Encrypted: i=1; AFNElJ+S6jqTrY+65+SZN6NrHpHc0QEY3P09jiYOwqr4JtazdJiFGD8M1U0zy6ZxZGU5YhwA3fdVly80PQ8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzHbEU57wOto2HIE/hofzZ/VqBIhqwae+cj2eOn07pdN10doJG
	8FkiyeRKiZ7iObKNPwRQT9oCW8SdAdlDj6BEBbI4g6Teo8fWGmtztj3MyLRERngn93s=
X-Gm-Gg: Acq92OHgWyP9hxts+ieuWi7Hs5C3jYYFIf0jwwG4xoywq8WZBRR8/BMLhtEzowS6KmO
	KZoStb9y/cibwC62Vbl5aKcRK9tERH4iRxf8ckm2i3Wc/WI0a1YIw6p6HXF/KJp6G5KuQczzsAE
	V5Q78bJi6R1PPr9L3MYDueM7NubqXuAGu1nkDbmY7C7/ijzhHErczB9REFEaPFtJ0KG2+s44Ww7
	2KPRZ8Ldeq7rUyLIPrQC9MfUoCQmOTd16gG6YV/Z+GykfeCJx0phE+DILxy4qUbypLdph+24VcK
	Yb7My+qoqBjzuTi0yHvTSyZVWR8+A1Ah3YG/hyspZcla/ZMGCc2NAoWwMsIjecliqoMX5BATddD
	YZud/Rkm99lXaUZ5tORPKIfwvNHNUpxJza8zX6/dHnUCUTVYzVnztVjtRHfwDyTZetWnVsesC8D
	a2kDir2btQdeE7WyH4wFZTFyhwcvV3Qr5BMfGPHxchCWpi802uO/WhCl75TuvliuwKhVmBtmKU/
	A==
X-Received: by 2002:a05:6830:dcc:b0:7db:a184:2b39 with SMTP id 46e09a7af769-7e3c3d98299mr1933172a34.11.1778595194041;
        Tue, 12 May 2026 07:13:14 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:baa4:f7fb:528a:2457? ([2600:8803:e7e4:500:baa4:f7fb:528a:2457])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e367be1168sm8998431a34.5.2026.05.12.07.13.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 May 2026 07:13:13 -0700 (PDT)
Message-ID: <b90ba2e5-bec1-4acb-9ec6-97dffbd61182@baylibre.com>
Date: Tue, 12 May 2026 09:13:12 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] dt-bindings: iio: adc: Convert xilinx-xadc bindings to
 YAML schema
From: David Lechner <dlechner@baylibre.com>
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
 <a4ecfb27-5ef4-4682-b87c-24917f81b4f0@baylibre.com>
Content-Language: en-US
In-Reply-To: <a4ecfb27-5ef4-4682-b87c-24917f81b4f0@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 5/12/26 8:58 AM, David Lechner wrote:
> On 5/12/26 7:14 AM, Rob Herring wrote:
>> On Mon, May 11, 2026 at 11:24 AM David Lechner <dlechner@baylibre.com> wrote:
>>>
>>> On 5/11/26 11:15 AM, Jonathan Cameron wrote:
>>>> On Sun, 10 May 2026 08:01:36 -0400
>>>> Pramod Maurya <pramod.nexgen@gmail.com> wrote:
>>>>
>>>>> Convert the Xilinx XADC and UltraScale System Monitor device tree binding
>>>>> from the legacy plain-text format to a YAML schema, enabling automated
>>>>> validation with dt-schema.
>>>>>
>>>>> The new binding covers the same hardware and compatible strings:
>>>>>   - xlnx,zynq-xadc-1.00.a (ZYNQ hardmacro)
>>>>>   - xlnx,axi-xadc-1.00.a  (AXI softmacro)
>>>>>   - xlnx,system-management-wiz-1.3 (UltraScale System Management Wizard)
>>>>>
>>>>> Signed-off-by: Pramod Maurya <pramod.nexgen@gmail.com>
>>>> Hi Pramod,
>>>>
>>>> Something went wrong with your sending of v3. I have two versions sent
>>>> half a day apart and no idea how they are related.
>>>>
>>>> Anyhow one of them got feedback from Rob's bot so I'll assume we are
>>>> getting a v4 and wait for that.
>>>>
>>>> Jonathan
>>>
>>> I think Rob will have to fix the bot to make an exception for the
>>> legacy bindings. This should have been called out in the commit message
>>> as requested in a previous revision.
>>
>> The bot is not the problem. It just runs validation. The schemas will
>> have to either drop this check (comma's in nodenames) or exclude just
>> this property.
>>
>>
>> Rob
> 
> Even though this is an existing text-based schema that has been around
> for 12 years with this name already? Changing it could be a breaking
> change to existing users. Although there aren't any in any .dts in the
> kernel source.

Pramod,

Unless Rob changes his mind, the thing to do would be to use the standard
channels property from adc.yaml when converting the binding instead of
xlnx,channels.

We will also need to add handling in the driver for "channels" while
preserving "xlnx,channels" handling for backwards compatibility.

xlnx,channels will just be undocumented.

And all of this reasoning must be explained in the commit messages.

