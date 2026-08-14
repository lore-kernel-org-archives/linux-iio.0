Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D57C541B8D6
	for <linux-iio@vger.kernel.org>; Fri, 14 Aug 2026 07:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786693428; cv=none; b=tA3idNgJyznhRA7sD6Tj3hqinmhMY+3vqHg+5f4xrjnT7omXPb0oL1cfKNMLNPJh9dXJ2Zms+taDeYmPmH6YlJmgpSOL9EW7DDngAHuB7caBANKF29/lTaqCfIsi0LmWfiuEwLsGC5/o9AScE/Wh3i4pnwC74WilkRbpN6s8BIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786693428; c=relaxed/simple;
	bh=GqjoMUMUfH1THY7gZ5OCarTPqxYnJPuPFO2VO+3dYEc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UaZekh54J+4aolK2arGwiR9o+2z5dGLUqs3FsAQSFZiCwokD8UU6J27vVtOEFVmsP3pMAObHGgJwz0fu2mVMdRSiAArN7ZX+MDIONAs8UvvngT8vadOy417QeKDCJLBGMuC4Z/Gf1AcOuoaBz4atz5E8NPpgbe5EQrZdg62foy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=p3SNBNz9; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p3SNBNz9"
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5b0148201fbso609082e87.3
        for <linux-iio@vger.kernel.org>; Fri, 14 Aug 2026 00:43:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786693417; x=1787298217; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YSN8xaso/QPKNutWXjWaSBrVNaFA/0xO+0raYbAekrg=;
        b=p3SNBNz9fWWZLx28eZ6t1DltS83gr+vckStWrIGqPFlHZ4tkS+AtyOfZ/EjM4n/nk0
         K2i3ik3V6t/Z37JGoB2pQewMv3AMz4qYSpMHTUbqB0EJcQmCblk08ZiY2Lubao+xFj8S
         kftI9xYPRD3M19tOvYFbwV9fIpm8Ft64ABX9Mli/o5CzX85iZzmMPM1CuImuGwVinWAp
         6uDf+ze3laBHnO646t7nVXV22QAJtVQ9cr75gApRu396xVo9cmkaHNUQFM5tzIYGapPk
         yBQrnQw+hc2UAvY8SvdmCbf2heFYfa9J165EHSbrTA4vd5s5Qj/DQJIIw1VYgogySj2P
         vJag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786693417; x=1787298217;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YSN8xaso/QPKNutWXjWaSBrVNaFA/0xO+0raYbAekrg=;
        b=IfLm7jaiinJBKBJ07RwS7nnQex5k+qDx2K7TesPunf1ZMsyNuz+LPcLVPnPWwud7QC
         rFki4KTT7gM26K05gkUslApaHh9NecKELyIO47yH3KUFztz24l8bfmKp1CtuOYmPc/X+
         KARdSmwvQwwXIJytf+Ghaz1z6d74aGKwYNw+8CUMbHzmq+Kpl9S867yHydAMc4p6VIAb
         QX2kRggw2s6Z/YtiGHSZYgLABGBA+MntUAWNBg9/thlBE3WSHYFpvjiq8MKZPtL60U8l
         ZQqzJ3m27CX5wZvghYMi0CGmtBZb0ssBp/3UP2kW8jaUPFfsj9OkcAc5YfHXX6IjSycz
         QoeQ==
X-Forwarded-Encrypted: i=1; AHgh+RrSzvHvqnbcdtV8LyFE53m5a5tVP5wxzJnRo8Z3/IuobhI+Bgixrl8piUOo5M0n9e+kTbxbc2IuUA4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyKlcV3v6Uiu/aLSVb4ShiPddvzy3fpfeVRWTJ/riGWqEHy3ie
	7+mHidK+XUNZkcxcGUtL6ygLFGg1Oz4AqxkhPiiqtPbVr2BWd1o7Sz8r
X-Gm-Gg: AR+sD11PB1Cyl2dgA1+Z4ooOYeizpnaTzi2LIrB/T1OaN/ohvg2qU++ogMPQd7kQX2H
	/QaQ6hNNLJO5cznMjV07LZzBPv8hlAf0s7F+nzLsjaDQYq/bhG7W0n4WblVPA9h3cRKTMZnNOrT
	QIwEwS3e7h5f1fBu3dtj654EtllFfFMnAL2WsRd5nQAAr9ScXvIsoO16ga5Il6m2DBxOGL4aFz+
	9A1EdmKVpiO5HXJlZTt3PVsKJKfzndtKhVeS4eKcHiGpceTCuVGj8Gj17Cs3qj2YAMWiGe/f9de
	1q8uzNVipuuQI9blWgopQNg3En+z01AwL9kv5GVgQg3ro2f3S0FiSrpqfPrAJLN6LKIFHQ9jBkr
	2h4jQHwI8hyMeQtHbYvv8V6NqhcCbSekHvDGcaPDmLz56Ml8fol3d+mGwogZGfoZ4k0t/9tBetG
	nde4RSnOY/7eqHQokEVmOBWOEvf//9vVf1ihFZjscVBfzXyH1pKhvy82ttLlbv2QP9ge0TtEj+x
	8W6i0vKSxWe35sLWyQsvL9JzopZ6I8KAMnsil/19OGv
X-Received: by 2002:a05:6512:8388:b0:5b0:1c19:2cf8 with SMTP id 2adb3069b0e04-5b45910e188mr407290e87.11.1786693417300;
        Fri, 14 Aug 2026 00:43:37 -0700 (PDT)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b458bed947sm382657e87.44.2026.08.14.00.43.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Aug 2026 00:43:36 -0700 (PDT)
Message-ID: <6e82d7fd-37f1-40fb-9c5b-aea753cc0a13@gmail.com>
Date: Fri, 14 Aug 2026 10:43:35 +0300
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/12] iio: accel: kionix-kx022a: Fix IPOL macro name
To: Mehdi Djait <mehdi.djait@linux.intel.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
 Matti Vaittinen <matti.vaittinen@linux.dev>,
 0012-iio-accel-kx022a-Fix-IPOL-macro-name.patch@mva-rohm,
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>,
 Javier Carrasco <javier.carrasco.cruz@gmail.com>,
 Mehdi Djait <mehdi.djait.k@gmail.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Kalle Niemi <kaleposti@gmail.com>,
 =?UTF-8?Q?Topi_Sonkaj=C3=A4rvi?= <sonkajarvi@hotmail.com>
References: <cover.1786347811.git.mazziesaccount@gmail.com>
 <c26c2741ca11adf7a089c094d8648f4ec6cbab54.1786347811.git.mazziesaccount@gmail.com>
 <anxdf0ee_-CpDU1S@mdjait-mobl>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <anxdf0ee_-CpDU1S@mdjait-mobl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Thanks for all the reviews Mehdi. Much appreciated!

On 12/08/2026 14:53, Mehdi Djait wrote:
> Hi Matti,
> 
> Thank you for the patch!
> 
> On Mon, Aug 10, 2026 at 10:55:25AM +0300, Matti Vaittinen wrote:
>> From: Matti Vaittinen <mazziesaccount@gmail.com>
>>
>> The "interrupt polarity high" -macro for KX022A variant is defined as:
> 
> -macro ?

Yes, the "interrupt polarity high"-macro ;) I should probably have used 
the proper name of the macro here ^_^;

> defined as what ?

as "KX022A_MASK_IPOL1". Seems like my brains moved to the next topic 
before hands finished writing this one :| Thanks for pointing it out :)
>> However, the KX022A_MASK_IPOL1 is not defined anywhere, so actually
>> using the KX022A_IPOL_HIGH would produce a compile error.
>>
>> Fix the define by using correct mask.
> 
> Reviewed-by: Mehdi Djait <mehdi.djait@linux.intel.com>
> 
Yours,
	-- Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~
