Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEA9B3191D4
	for <linux-iio@vger.kernel.org>; Mon, 23 Feb 2026 16:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771864533; cv=none; b=QyMJBYZ6+RpwZKSDeYOlvY5O7xbtnsOAG8LETAA1MZ9c42Ynl/4a9cmvWDEkh6y0cKb+rMBmaX6vcYcpVSJCuViyAJ9qME7b/TWB4KtBKoXLTaLMzHTK1gFDB1RaQUdXO/4We2YH3ytbLSaEp93zG9G7vGzZ0py5MLCOmns5y54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771864533; c=relaxed/simple;
	bh=RzLJyJMrOZWEvU2orH9rSolHnyyv/uE4hcEajLE45eo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JTHA1u1ZXNOpMHx8WHeqI1BWShOqd7YfrqYYMewEkcjuCXylvREHnrBuyTvA5ue4ZDE4g/zSH7EQv2jmOay2TGOzS0lkZ6TYoW2c6oCzXUsiVEUYQmG+yLPMHqatx8AlL/ZZ6kZ1/4LQLRxmjQNU2bgA4jMvypvDaXZcNrcAvus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=q0gUVq3Q; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="q0gUVq3Q"
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-676815e147dso2281799eaf.3
        for <linux-iio@vger.kernel.org>; Mon, 23 Feb 2026 08:35:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1771864530; x=1772469330; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qw0PtLgwjYOGFhAD47z9NDAK+061b5LRHPLtDWUE+V8=;
        b=q0gUVq3QK4NK18gn05kVZDfyz+6kJ0+DWcJmpNjcP7HFiZe6TZN/GPIdprujhuZP1x
         hs8GQy13rlKJzb4iNTzl+R2+u8+lGRuXe43hrcquBSWEO6TB+i9GaiZZjeaH/Jy4PcbP
         2KWUs7hH1AUXv0CfjDJlCV0lTPKa2Tlnka//kHQrj2huZ77y96BWkH+aWS4p/r+8VOUT
         80sG4Z5pp/mIgbH0H2iUxQ3z4xZCGVIod4xU+kKfdOr5ud/IslHY6EE27zI/lAXeCItX
         zNNLl5Hoik6fKMWvZ3SMij231hGSVkSxmXWgvbRw7RGGu9cDZBBqZ0ozK/YC1H0R0Q7p
         b5ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771864530; x=1772469330;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qw0PtLgwjYOGFhAD47z9NDAK+061b5LRHPLtDWUE+V8=;
        b=hrl5sGTLZ+T0ilNVy41Buz03aaV564B5Tmgva+jrDeIDvCRFtO+U5Wxx54VYVeKdYk
         QGXJ0MZxMljRZtYH5KPL3QkbDPv9XQH7wy3sv56gQU7nBvqOujCOMGNqfClaiz30k7MA
         7jmJsmgA8+M93jwGwbQ/iRNbrSNJtgexEEiZ5YvdKMHubJdolh6wBT+cS5jenpU89uvb
         yssSzIMtcjiWSmQbxvMaKVdSzgsi2xYlI+ZTpt0oS7wnxPmcC3NV+b+X6cnuO9XJkS5X
         epI83R4L3Qoyuh9xAITkHPh5Q/fsg/zKIhB2Xax90P+PCkKfIkjSB1gXN3JkKzB9CWM3
         TNwA==
X-Forwarded-Encrypted: i=1; AJvYcCW95ggjQKh/w86mSQRvn3619Zy6/1i09yoXcB7tB9QZuTiMiliHowWPZo4V8KfcQQRWo5SVrebNZYM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkN8Ic2s+p+kV836Mh2nqiRXFRhECyrKPvYY6cyCAy2p8AEZDp
	hLgurxPld9XfWqrYL2ybAW7kfi4WjhrNHTSK21Q9TW9not4QBCeFEhhXu/AX3oIvvzQ=
X-Gm-Gg: AZuq6aL0v9QwD8gwA/+mZ7EmYvnOyRijNbsevebSHhEyOcLhGZ8ZUdo9G7LrP5lIbFV
	two7VRMW6c6Zb/xtFkhcmZ7Sx2LfWy2Qqt/P7vr3rwq/zW/5P6etGh2f8QzBoc9um8bDmNcSrUa
	lXukyqRXQDyH1HL0i7STffpN/lp5E6o8FBMM/G1KDyLxNxwLkzRlecEyk0pGEFERTa+0UCrAFm5
	ySNVinvFsoRpkgre/iMrgGQ3h2R0J0kl+RN52vrCmsLsmGkICeEMsOLLfYlmpN0Vyv3FXjzkhWi
	wOqFNKTaasYFqueaEP7yzX3HLsUWSVM7keG/LSQv7Vk7+SufuCiJJocAf92RHvN0Vqs+vA/rj1E
	tsW+kPO1iXcnObVNWcvMAHq/LHvAmn+ZUj3pmDBL1Zk7iQeWl4JsUx5CAWoJhEP3AMLgd//34c9
	9wX7DOjH6933Eldj8t81eOsQOn6NWy
X-Received: by 2002:a05:6820:2912:b0:679:96f:3f11 with SMTP id 006d021491bc7-679c450663emr5290621eaf.64.1771864527664;
        Mon, 23 Feb 2026 08:35:27 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:e37:2309:3937:4469? ([2600:8803:e7e4:500:e37:2309:3937:4469])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4157cf9a388sm7837314fac.6.2026.02.23.08.35.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Feb 2026 08:35:26 -0800 (PST)
Message-ID: <b1470903-f703-4408-b009-a4bdbb9ca4cf@baylibre.com>
Date: Mon, 23 Feb 2026 10:35:25 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] iio: adc: ti-ads7950: switch to using guard()
 notation
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>,
 Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-gpio@vger.kernel.org
References: <20260219022929.3558081-1-dmitry.torokhov@gmail.com>
 <20260219022929.3558081-4-dmitry.torokhov@gmail.com>
 <aZbBGomQi0l84An_@smile.fi.intel.com>
 <b36307f9-c4b6-4242-9cf1-838799a926ea@baylibre.com>
 <aZt0IGNW2hddXvRZ@google.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <aZt0IGNW2hddXvRZ@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/22/26 3:31 PM, Dmitry Torokhov wrote:
> On Sat, Feb 21, 2026 at 11:20:42AM -0600, David Lechner wrote:
>> On 2/19/26 1:51 AM, Andy Shevchenko wrote:
>>> On Wed, Feb 18, 2026 at 06:29:27PM -0800, Dmitry Torokhov wrote:
>>>> guard() notation allows early returns when encountering errors, making
>>>
>>> guard()()
>>>
>>> // strictly speaking
>>>
>>>> control flow more obvious. Use it.
>>>
>>> I like the change, but...
>>>
>>>> Also variables that now only hold error codes (or 0) are renamed to
>>>> "error" to make their purpose clearer.
>>
>> Normally I would not give my opinion on this, but since I wrote the driver
>> originally, I will say please don't rename. I prefer to always use "ret".
> 
> I hope I can convince you otherwise.

I'm afraid not. "ret" is used > 35k times in IIO and err is used < 3k times
and error < 1k times. So I am really used to seeing only "ret" for errors and
"error" looks very unusual to my eyes because of this.

You mentioned valuing the common pattern in your other reply, so I hope
you can understand that this is what I value more here.

> 
> IMO "ret" or "retval" should be used when the returned value is intended
> to be used during normal operation. For cases where we only expect to
> have an error or 0 for success "error" or "err" is more appropriate.
> This allows you to write
> 
> 	error = do_action(...);
> 	if (error) {
> 		// handle error somehow, typically simply report.
> 	}
> 
> This also helps when reading the code as you know that there is usually
> no reason to care about the specific value in this variable (maybe
> except -EPROBE_DEFER).
> 
> I will push the conversion ret -> error to the very last patch so it can
> easily be dropped if I am unsuccessful in swaying your opinion.
> 
> Thanks.
> 

To give you fair warning, it will still be NAK from me.
