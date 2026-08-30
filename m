Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29C743A5E97
	for <linux-iio@vger.kernel.org>; Sun, 30 Aug 2026 09:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788082402; cv=none; b=iUWtpOQ35RV1Lqrvdh0Js1FKudtpRfMrGsONrGkGYMR8AljNC1tU1k6KH8xxhAc1MpV5ITu5Es6DhRooDDapsfo+YvlKPGZHbKR/xAlqA54GuAp5oqOdPqQTbxbTv0ERe+XXnSnNBRuisMkFFcssMZ5WaZMdzgilXLGP0/CaJ/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788082402; c=relaxed/simple;
	bh=/DKnhV0MmVJPWDzTPG3icFO2F50OI3OFtVu85d9jTUI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HmVchgdn30sRv9RmO1cavcBTy6wu+BhYgFhmrghprWR/giLeUhxO8RAAOyCetVEnwPK/trsY3PjWbnSdkIg8gtpfKdFfhFrp+4OA8CLV0ifC96Vwej8kE3wgCU4Ed1GmlOCKGT2yd6kuxdzYKcTnj9iWlcCVBgk/jF3uBo+W10k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hEJsZqkR; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hEJsZqkR"
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5aec201b582so2947158e87.1
        for <linux-iio@vger.kernel.org>; Sun, 30 Aug 2026 02:33:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788082399; x=1788687199; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mA3g2yHDcdRcBYbXDsH8zS7Qjtttirgrx3DJv7xsWNs=;
        b=hEJsZqkRaf97G+Lauk+gTXTBDrIqCAOrGe1skn+JGmhIzeChV2icg3HwQm+780Wo9T
         Kk4R7LZHboDevYCcVO1zoeqItVK0ZduMCiyJQB0pPFg+gGUtlG8QHJsK6yRF/oCtzvOM
         kXHvxyuMJWY31mnPbs3mcub2216ppx+X3Fkj63UbD5eMWAxRhyPJRFak2h9BTUc1pgUx
         cCWxhwt4jMElWSm/t2rMt5Cb2P47a7sTDSW/Z+TMqtSIRs0EzTl9YfKBW89bfK+XOuZO
         i25gL3AXLboIl54f/7nSu/TVeMqrKHA2eLifmIJeoZobAKBACR/KoUvDW0Rf1eKJG5DC
         eQRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788082399; x=1788687199;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mA3g2yHDcdRcBYbXDsH8zS7Qjtttirgrx3DJv7xsWNs=;
        b=GObKyknfG6aOsuJ0fq8hmdee+/CcKKMN8j7bCKA2nHa18+0j2HiU/oHIW/e9Dx7CZD
         wxVIer9XacvDe11M39uRqw+RbzIT/j0mJZdHKOa/q+ZWsvu5iunxJQGUg/3+b1NNeGkP
         pNUqgBKXV6bpIPTBQLtCkbwA61v+5b07AhmJ6G5ufo2MfeFVuKQYXDuOWxudmVrGyZwe
         UBxFDnscdGd+CI2oDr02xg+pAfPRn9ueZX5+7Yva6ZFgem6V1ULujMFa6WSFwE+DzGt4
         AexsLnFK0AOyAZFrKQa5JTz4+jNBdBYqEZlsWJc9aXuKu4Ze6MkGy75GCsWiReo+L4Gu
         Jvsg==
X-Forwarded-Encrypted: i=1; AKwUvBwTJSWIE9dDyYIH6NGbPaeFu8md5dA8IAY806gXszLSC9LQrsmoGRktk+7WIX5yVFblGV+d2ZxhJbM=@vger.kernel.org
X-Gm-Message-State: AFuF++l7bweAXT+JxQCpvAV9kDGoqhvgDhs4o2n29AXBSduvTSlnXcg+
	ck9ijCpR02HyZhUL1quux2h5vWF7TXGf0imcGETHAwYmDkVKecDZCs/y
X-Gm-Gg: AYBFou2FN/1azWuJxJvlMBCd6XbGExe8fibuIqK37YgbTY1snqm/jmt3wOLq0hvUGkY
	8EiAdLeyAGs1ki/A5n4dawcIQe4RJSM8tL8tBFPZY9KJrdfcfbQBor5gdnOs/Vx6iBnQGsRC6X4
	4eH87Pmpt6Yo2gWjdKWVP9BzPTF5HmWXlkCSvY6qllMACMn76PFESwqgQzuG+pMoqR1uiY5qHWQ
	WV2t2wsPYwUYDHSOX208aPzUAwgcriI9fmcKd1VvhFuViR3X7XXxuVmX4Mhsm30UVxcYIHnp8go
	VhzbR9QyXnA3RYFAfPuTBxg7MnDyNros88edYtzrjtr4n3C4xb0qGP58hxL1z5C5sKoAQrIg+s0
	PR59h01n8OqVud0EtvaoH78omgScpxu5WCFuP4/zOXacg8ch8iEXmg0vS6CHv3jYuMYsW3aSb6m
	otoLjA+beKMpRyYw+Eaub3zB4azXQPV9dlhcITgkf2AIKM55f//quxZgQfS4VAR2IFbaH9QjiXS
	Sw+THb3jvmfeIOCvH8qRmYQQJt2tQHB9xfZ0rZI2JlI
X-Received: by 2002:a05:6512:2396:b0:5b4:5f6b:d43e with SMTP id 2adb3069b0e04-5b5e68d9e4bmr5364758e87.14.1788082398764;
        Sun, 30 Aug 2026 02:33:18 -0700 (PDT)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b5e89c5ad9sm1477182e87.7.2026.08.30.02.33.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 30 Aug 2026 02:33:18 -0700 (PDT)
Message-ID: <ab8f1a0c-0666-4b7f-884a-55f9f26a1ac6@gmail.com>
Date: Sun, 30 Aug 2026 12:33:17 +0300
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] iio: accel: kionix-kx022a: Prevent memory leak and
 fix state
To: Jonathan Cameron <jic23@kernel.org>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
 Matti Vaittinen <matti.vaittinen@linux.dev>,
 David Lechner <dlechner@baylibre.com>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Mehdi Djait <mehdi.djait.k@gmail.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <cover.1787901813.git.mazziesaccount@gmail.com>
 <9e4453fcc00df6ec988207df8916226d18aecb20.1787901813.git.mazziesaccount@gmail.com>
 <178805296127.2788519.3966625158499254314.b4-review@b4>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <178805296127.2788519.3966625158499254314.b4-review@b4>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 30/08/2026 04:22, Jonathan Cameron wrote:
>> The driver allocates memory for samples at buffer enable path. If regmap
>> operation fails in the kx022a_fifo_enable() at the buffer enable path, the
>> allocated memory is never freed. Furthermore, the state information and
>> previous hardware configuration(s) aren't undone, potentially leaving
>> WMI interrupts and buffers enabled, or driver state flags wrong.
>>
>> Free the memory and revert the hardware configuration and state flags on
>> error path.
>>
>> Fixes: e7123a4dfcd7 ("iio: accel: kionix-kx022a: Refactor driver and add chip_info structure")
>> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
>> Reviewed-by: Mehdi Djait <mehdi.djait@linux.intel.com>
> 
> I'm not happy with the label naming.  It had me very confused!

Hmm. I suppose it could be more consistent :) Thanks.

Yours,
	-- Matti


-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~
