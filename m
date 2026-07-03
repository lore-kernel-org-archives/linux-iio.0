Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 391863254A8
	for <linux-iio@vger.kernel.org>; Fri,  3 Jul 2026 20:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783110596; cv=none; b=K3yznbzCkYNDSmmiAJtNqOutnSoNaZufSZspjWYK+A2SgNKiPGB9YWUwgmEHfPJG4DE8q4hRm9zz9NyAhpJbVOCL93V8H/Ovt91ra7glSvngAccqhSxGxIjAsXJJQ0+LGLe9sKI0/DBK0W0z7T/FdvT5DFaMcO7gOPkMYBnOaXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783110596; c=relaxed/simple;
	bh=TJ1Yp+Qwil//MuisP32HdTlaRDeb8Set3TLhKZIhdN0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IwIrKWzqF24aMQ1kzWL1JGIzg5Z+gxwVNFWHeDbo50Wm70q5812MLzyY1jcza3IqL2DqvDQhq5NuLUYWpQwLvHL3LFTwdTXHEfh1p7yA5pr4qGdzcLZ/XXAEw7F/ISlyIb3T1UdVEELOgePcbvRt4rl5ZVXYJSldUEOt/SyAhmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=oV3DrLZ+; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="oV3DrLZ+"
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-7e9f6b94a49so476081a34.3
        for <linux-iio@vger.kernel.org>; Fri, 03 Jul 2026 13:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1783110593; x=1783715393; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Gw65i8xoQ4Rdi81NgA4DFcrACy+bTuTMIx3V9X+aMLw=;
        b=oV3DrLZ+enF+1OpejGNA+zZ9DyoawFqu0KnsySh3cZzAdNPuJsZr4r7cq3Vh/oXevc
         J+jcF0V9yV/Ej+klr3zbkcbqPzYyboz9W9/aEH0Kd/QJlZY0uZ2U0TlcVUUo80MWrl5J
         i6aZAUNTtXFvWzMe5sLl6UM8KrNxrRkIkaeAMV7TQabGNihvml5on4GPA19vpBl2JIPc
         qpy/OilSxfFJuuzuLVk+ai0It1pXTCzWQxytZqfCfxOxlI2Eo3ZNY368khcMhiYFXq2s
         XqlcGzVeIZYwP60XLgEv3MZObb5b4LuqS2KHUBbb4U2ahydRmmmdr/r2cVseB1KykT4s
         cS+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783110593; x=1783715393;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Gw65i8xoQ4Rdi81NgA4DFcrACy+bTuTMIx3V9X+aMLw=;
        b=ipKHevgA6G50EZlFDIMiuyXymkIm5Q1YVOSGR59/CGFmLrmXSVGQI2KwC9+u3IWdIm
         Z/DcCLK8wSfoBSQknESE4n6pJcDhK6QnRygwFnGjfY6P1EzA8X7V4brY/w204RJJf+iL
         KzO0sYLEMAEb05ivR/PBPRRh8nmnnhdvFnI8NlANQx8cbCgVwemWpz3kaIpm5hMVAatO
         O9S5HTcpuFLom/mV91zzqvvtLITt/OH9NCvI8mZ7X1mCkUyewbi662ny8IOOqrwASdqP
         i0JC9EzGAmwnsR+4QthS4qE0XUYEA46ZE4n6xjxsrxNDHusQ8J8J8uFmzjXPvuJMJe4C
         6xVg==
X-Forwarded-Encrypted: i=1; AFNElJ9Zzkpo4wg8KmOikHC7QBUWzsAMsSjo8wGubqMyKedD8vZssyJggrbG5ztlyCjJwPLE6AmX3abXYKk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0IC+znGT+qqjKSBeUZlThFfpq7ggPc80pa/5bPCKZPQnipLqi
	6JtsaPBq/LiIZBfh2OMiMgFA+JX3fgjxVtsqcF1I8ZZkVvt2gULpm2io2uPjeMx55r4=
X-Gm-Gg: AfdE7cnw0o4cDahBRKDoA8TmuRwm9FPvelp/GFiV6K/0uokWWW/NMIMygWFWjO2bR7a
	OdmK+AXT6tBGDQGa+UjdX9Imas6RC0f/SN/b9bfGNNXQZk6iNynxxGBC3RpbMGR3oJuBPoykuJ3
	eaeKpS43rV4tBSJDdUOtgO6+JAVaJBz5dch88jBYD/F5/SlbvQ7iPkXZvPzjEFtLouy4On1N2mY
	OH2I+eHgw+6mcT3vrZddp7t+JvhwCIN3gFxuujBYyEU8MY3jshrQU/n3nDU0lKU7hTNi4FF9j36
	Cu3VOr7/q2nooWotyRP2GZakiArBzq6smk0OSSePU/mouBg2NXjF2BJIJBde75VLG4SE1wk1fKC
	9ftbTFDzQIqoiqGasxzWSC4JO+s9Lg+4D/moSb5Md6OCVbC1c13FiFyRffJZFyTTfIHX7l1jfGX
	mgTgzHeKUNVC1XNdLqdxWyhpya5aTbyF6Wt1blaUAqJhUYVgYqcordulprCGoELzw=
X-Received: by 2002:a05:6830:2e07:b0:7e9:b4cf:683d with SMTP id 46e09a7af769-7eb7ff7c01cmr704096a34.29.1783110593167;
        Fri, 03 Jul 2026 13:29:53 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:6af9:a9d7:17b5:2644? ([2600:8803:e7e4:500:6af9:a9d7:17b5:2644])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7eb54292d5fsm5785830a34.6.2026.07.03.13.29.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Jul 2026 13:29:52 -0700 (PDT)
Message-ID: <b88ae0de-fb87-4812-98b7-59459ed7cf39@baylibre.com>
Date: Fri, 3 Jul 2026 15:29:51 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] iio: adc: add MAX40080 current-sense amplifier
 driver
To: Siratul Islam <siratul.islam@linux.dev>,
 Stefan Popa <stefan.popa@analog.com>, Jonathan Cameron <jic23@kernel.org>
Cc: =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Ciprian Hegbeli <ciprian.hegbeli@analog.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260703102941.1141341-1-stefan.popa@analog.com>
 <20260703102941.1141341-3-stefan.popa@analog.com>
 <9878f042f424bfbd7fab24175298224b58e87779.camel@linux.dev>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <9878f042f424bfbd7fab24175298224b58e87779.camel@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 7/3/26 2:42 PM, Siratul Islam wrote:
> On Fri, 2026-07-03 at 13:29 +0300, Stefan Popa wrote:
>> The MAX40080 is a bidirectional current-sense amplifier with an
>> integrated 12-bit ADC and an I2C/SMBus interface. It measures the
>> voltage across an external shunt resistor and the input bus voltage,
>> storing the results in an internal FIFO.
>>
>>
> Hi! I already looked at Andy's review and decided to add a few more stuff.
> ...

>> +#define MAX40080_REG_CFG		0x00
>> +#define  MAX40080_MODE_MSK		GENMASK(2, 0)
>> +#define  MAX40080_PEC_EN_MSK		BIT(5)
>> +#define  MAX40080_RANGE_MSK		BIT(6)
>> +#define  MAX40080_FILTER_MSK		GENMASK(14, 12)
> Should be one space after #define, like the first one.
>> +
Actually, Jonathan likes to have the extra space to group the
fields of the register under the register address like this.

And even better is to include the register name in the field
macros too, e.g. MAX40080_CFG_MODE_MSK.

