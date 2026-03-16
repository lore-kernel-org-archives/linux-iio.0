Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 474A734C83D
	for <linux-iio@vger.kernel.org>; Mon, 16 Mar 2026 20:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773692459; cv=none; b=Td4U5kvFi7RBWTRxUgWvixEVnCkSq5SQLyb6SMIYiByYbKwbw+9D8c+GGxKBGs3xBOibrYVMhq9uvC3JznnBVrB6TH4n+bDrTMyC19kHYObPMeM2TTOqTY3pNQs6YFyp/VoGofR1Vl1TAQmDxhtzCdkv0oxLH+/kchTa5XQ3pHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773692459; c=relaxed/simple;
	bh=J9Uib640/uZ9Y68E+/FhFk+s+Wvkj5et2AsL214hxDU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CYxscZ2wIxlpPAFR4iFijJLD862rq7mnGg61t2xxGzaDvjAJiiCOLt+h40V8NuyKIdaH9DT1axVWtYwxwgMiDik4QKUGQSRP4SRc+hbqgw89erlI28K/8B0ZIfxU7x70f8m3CEXTLLx5w5cK7vGFO97STkF1T+9h3Kx1DVSUSbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EsHuI44q; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EsHuI44q"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b79f8f7ea43so833503966b.2
        for <linux-iio@vger.kernel.org>; Mon, 16 Mar 2026 13:20:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773692457; x=1774297257; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EK50oCppLfVEmX9UiOHb2vRevLeFvTSXkedS8zq8Z8U=;
        b=EsHuI44qWZrFuDBdX08ldG+47qQx6FiwWYAvCk3kGRxKX3pr9hqskPAIfc5xwdHbjF
         39r6JUidgSpKf9ErN4an3ihn2WP4EpU4PG9BVM+o5A0zpyANr7esG2V0FGiwFQPVpuZd
         H5nD+H+jia/P0QfNZ83DnuFa0R5qGE6HSabfoMNCgDrszvu5baZRIiwbJHGZduxAL6RY
         W7s7Sg6VMm5GZg+1R0lx8CBBkYFQFOpS8KQSpOP/I4Qx49BZxXob3g064prr6x/OhNv6
         Dbpp2NSh2ZadaayEoBzBxP34REJADe8OCq/89K3AJf8/AeX2jKIHxvBIEXmlmenNeJwR
         GP7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773692457; x=1774297257;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EK50oCppLfVEmX9UiOHb2vRevLeFvTSXkedS8zq8Z8U=;
        b=BWt+yiQF2W8o7iUNtzr9iyPPfOg+rXReQ3ue79QJWvb/3cFxHfBgZCgp95Cl/ieQe5
         f5C2aYQwSy8eq7JH8Q+kKjE9w0cfu0cbcFqcam9BI3DkSnWT6bgbZ/bJ4Wd5ByuVTS4R
         frMnpN+z7nV9YI6EFv0XKs6crw2W8ciFLuOGGlUl2tsO/qZAPX/AcEjc+k84LvaPVE4w
         D8EelH8c+ixIOqrL8+FekgYIAzDcqHfbf0mwjovNyq/YPfMuwQcStn5PW4qfJeIx6TrR
         QyjInhSVHpyW3PYq3zRjePjz/WWYulrolAt1qgQWVMH+A6mpWZqMQFPQdA43sRqEbK1f
         kroA==
X-Forwarded-Encrypted: i=1; AJvYcCVaR2ju3+Qc+QEUMslywFZ+0h/zTE57sk4OKrUqBHJCDbUK84jALoVG30m1NFYSAlubr3bh6Ad4oF4=@vger.kernel.org
X-Gm-Message-State: AOJu0YylkD/MsX5dHhzVlCSu9FAEOpPWxnvVHQZ0sdGUVrW0iOUWVb2P
	CXeBNgFwyeJHvDtBWoNDEG26TXaB5gRxBUSbSTFwPigk/wYW71FXLaMu
X-Gm-Gg: ATEYQzw4s/R1ZuSMjupKh30DsEoj10cHQ251wOTkRuBK0CrszYKFh+NMiOF4EZ9cFPG
	PtcuHTgRgkAxerFOix655TiLmvBt5CgIh9ss59Ecd5/0H8kZKf+OeTX20rzyzjNjOWJI5eFL6SW
	jBHkb+cIlOck/aBUgdlQFBMuV0H6/QUHPqd/HxVNpwfPNGDkLV0F3e3Xh12QAV+xSM5peh8UKa+
	rIciaxJwmTTGZwoG9QF258rGNI5tLQWdCXs2Sb5qLkqvhfyb13qwruI5DsgEyqjYmSiHJnkBDpp
	Ixj/mOc2h+GbDQPVAC9bR+pUeVtL0dVFSjKl8MoUffiVkNCoPSF5V2l15tuc3TOFFxLYzrSZcww
	aeZeLIt+JfKFoJz5E+YLIZmQLCttOUh2VED4ZNYZ2kht7acRb4KIPdaCO1N1YFhGI+KybvWBjLE
	43pG7H/Iq7yiUhOXCRIBrPZwPfxg==
X-Received: by 2002:a17:906:c3a3:b0:b94:1fb3:155d with SMTP id a640c23a62f3a-b97653d1dcemr552544566b.53.1773692456428;
        Mon, 16 Mar 2026 13:20:56 -0700 (PDT)
Received: from [192.168.0.39] ([79.133.247.80])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b97cb0d2e1esm127505666b.55.2026.03.16.13.20.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Mar 2026 13:20:56 -0700 (PDT)
Message-ID: <ea623eb6-2f63-459d-a1c0-afffd2428426@gmail.com>
Date: Mon, 16 Mar 2026 22:20:54 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/7] iio: light: vcnl4000: add regulator support
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner
 <dlechner@baylibre.com>, =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Peter Meerwald <pmeerw@pmeerw.net>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
 phone-devel@vger.kernel.org, Raymond Hackley <raymondhackley@protonmail.com>
References: <20260316-vcnl4000-regulators-v4-0-854fc2eaf54b@gmail.com>
 <abhhPnvQwpZozHPe@ashevche-desk.local>
Content-Language: en-US
From: Erikas Bitovtas <xerikasxx@gmail.com>
In-Reply-To: <abhhPnvQwpZozHPe@ashevche-desk.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/16/26 9:59 PM, Andy Shevchenko wrote:
> On Mon, Mar 16, 2026 at 07:19:44PM +0200, Erikas Bitovtas wrote:
>> This patch series introduces support for voltage supply, I2C and cathode
>> regulators. This fixes an issue where if a regulator is shared between
>> the proximity sensor and some other device, and the other device is
>> powered off, the proximity sensor would be powered off as well.
>>
>> One of the commits includes a Reported-by: tag without a Closes: tag -
>> the report was done outside of LKML.
> 
> You mean outside of public web access?
> 

The report was done in a Matrix channel. I could provide the link to the
report for the Closes: tag, but it requires to sign-in to view it.
