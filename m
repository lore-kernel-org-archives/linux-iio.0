Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5974737C105
	for <linux-iio@vger.kernel.org>; Fri, 22 May 2026 12:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779453540; cv=none; b=CAwaI4QKVBOd5WklHebnWNzWymZnOlV4x+EPhAaXNbuwG1Z9jP1x/k8vV+FJZV77aaUjgC0AbWUCPkJruOhcoVbNt1f0fj+Njbb7D7zvi2+HQgO1Yl1zrV2JWIJuzCMRVqVUfiiKkv3hhmGGlJYtZDTXyVAXvBr9nQ5AE/NlJZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779453540; c=relaxed/simple;
	bh=Qe+U4HO7WD8KknELE7AjHe+LqmBJ+B1Rtp/U1kePi/c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hrBwmTEc3j5MzTH2lB/1iuzLV9GmIm7it6Kch2PYovxlPY7v/1Mbch8xpuFih+Nl35X+RHajWCMiM9syEkkmOi7IEpla2J2EggHWydhFJsYE+HHYy0L/y71E6fBqV5MUuqq+HusIvPwyF3YL1036gQ2WjU9u+AK36rgNLl+COl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=q887/Xbp; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q887/Xbp"
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5aa2c25c632so1872415e87.1
        for <linux-iio@vger.kernel.org>; Fri, 22 May 2026 05:38:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779453537; x=1780058337; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Tnfk/VbrXKWZP8/5WpIT3Z2vqg/BP7hHVgXBgV215sA=;
        b=q887/Xbp2Jg3CNQknKgj6q4gmCcLYdMh86TvnFQM2t8S7jv5GfR3idTji/XsaTkw9l
         CPq+r4rJB8YPIL/k83qS+wp3uSdLRf6+B0HrH8fXhyMscQ+cxMK5tA+RI9e0rzAC4hgD
         fzl6z85A1hxyZKhbkTsuEcZsBfz8h/3U/ntzI3GmJdVHudJ5firFN/BT1mc0GPzf02V4
         vazsD9GimzinylTK8K8QvbMQepqEkJ+M4+NtyjmLHjpbmFgZxuG1tpiOtDhODT+W5czI
         hO1SS0Wq8ANVXejr1GOQDOoH3c/P5PZHNX012O93OItHnq/kGvXJhjvl973VPKjd9g1q
         6Ayw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779453537; x=1780058337;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Tnfk/VbrXKWZP8/5WpIT3Z2vqg/BP7hHVgXBgV215sA=;
        b=BsLMQStelTBDrp+Q2b5jo19Dj3lwig0K/F3svtyzDwspAcfpo30mj4ctOXrUQGQiGs
         zSItndITf3Sj6YXMe0jYFn4EvOXBscu4kQm03SGuTbnZLErUmENHCzZFS4XQqDSOQ3I0
         eyE4kwqAdIz9mJIX5UfVC/1IjLibmY1Cr+DQFR/nPTPqCBSVJilzcx0S4Cg2DWGJ+961
         8NveeXfHrqEd8JNq/gszdO7qI2iS+hBe4Qz1Z0M4PXndk89RdV/ElQtH9SzYlIagk+Vi
         W1y9mkQbnA5OxOhioR7nmEeWr4nCrigxbtFJZHF+z54/dduCcb5PzS83LQTgUSrAYl1O
         QKCA==
X-Forwarded-Encrypted: i=1; AFNElJ8j+ZytwCwoOceURDCk/RWMsb6rsysWCIMkmP8v+71WhAeiDkas1By5nORNAwlNZLR6/2S4K3uk5Cw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKtSRB5ASwxiOAQt/KODjt/lIGRKYfGu43INXpUdXoM2DZzHao
	wC9Y+gIlWxh2ZHMQtA1oA8RgZJNAkdiAwyQNvrA7DU8MhnWHj4emanUd
X-Gm-Gg: Acq92OE8e8z9dWrseYH089ddwV6ZRq6Jn4+892lUw2SC+528CoojSiRIVXHnnZvC4KW
	vedMwlumzdHvNtjG/Ut5EHqdAdk+WsNvZLMXcDmMAODAVtrQIVvW/Kow3q/zsP5L5zbPN4Sj8Q8
	z3pp87qcBvslhPBKdYkLMTD3G/85rN1Lql7+G0qpkbR9CmY2FSVh6SOXD6lUWBvHfcwXFapPNlc
	qElHTMl1p4hgGDbwXrsTMKtoSghZzPbzirrJZYtPUawWhxQE82SzmATWSpyQr6dEjc654QkP8mV
	JFgeuhE5EG+8iA3rApXP/iQnUcBRXn17DKVGBWaypOZLdbKiFlttvy93LAhcmq3nKtLrrJ+vVqN
	cg6QBZLtZ7kOomwmF0WkiF/bHrPEquT+sX01bgEIlrhElrVlYRJ1l/jYcOh49EFQ0d8JFpLfN3B
	2T8KKaE4OwShdhkAJ7CaL9y0nrWeztayhWFdgv/25s+CD0vJSIE0LMgry5lfjZAnOc7YaZSmmiK
	rCmfIhE
X-Received: by 2002:a05:6512:31c5:b0:5a8:f04d:573a with SMTP id 2adb3069b0e04-5aa3232b465mr1276360e87.17.1779453537271;
        Fri, 22 May 2026 05:38:57 -0700 (PDT)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5aa32cbaaf2sm404364e87.33.2026.05.22.05.38.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 May 2026 05:38:56 -0700 (PDT)
Message-ID: <0d58842a-aa5c-4d12-9435-3264070038cc@gmail.com>
Date: Fri, 22 May 2026 15:38:55 +0300
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] iio: pressure: rohm-bm1390: notify trigger on all
 error paths
To: Jonathan Cameron <jic23@kernel.org>
Cc: Stepan Ionichev <sozdayvek@gmail.com>, dlechner@baylibre.com,
 nuno.sa@analog.com, andy@kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260517160801.269-1-sozdayvek@gmail.com>
 <20260518094238.1986-1-sozdayvek@gmail.com>
 <20260518161516.53f21777@jic23-huawei>
 <61d9cec3-6aed-416f-9604-94fe94cb2e3b@gmail.com>
 <20260520120822.351aa58f@jic23-huawei>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20260520120822.351aa58f@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 20/05/2026 14:08, Jonathan Cameron wrote:
> On Tue, 19 May 2026 08:48:13 +0300
> Matti Vaittinen <mazziesaccount@gmail.com> wrote:
> 
>> Thanks Jonathan,
>>
>> Your post give me something to think about ;)
> 
> This is a can of worms.  More below.
> 
> I'm unconcerned as long as (and ideally someone should check it)
> we can get of being stuck by unbind/rebind of driver.  Anything
> else is best effort.
> 
> 
>>
>> On 18/05/2026 18:15, Jonathan Cameron wrote:
>>> On Mon, 18 May 2026 14:42:38 +0500
>>> Stepan Ionichev <sozdayvek@gmail.com> wrote:
>>>    
>>>> bm1390_trigger_handler() returns from three error paths without
>>>> calling iio_trigger_notify_done(). The success path at the end
>>>> does, so on a single transient regmap or read failure the trigger
>>>> use_count is never decremented, and the !atomic_read(&trig->use_count)
>>>> guard in iio_trigger_poll_chained() drops every subsequent dispatch.
>>>> The buffered-data flow stays wedged until the trigger is detached.
>>>>
>>>> Funnel all returns through a single done label that calls
>>>> iio_trigger_notify_done() and reports the outcome via IRQ_RETVAL().
>>>>
>>>> Fixes: 81ca5979b6ed ("iio: pressure: Support ROHM BU1390")
>>>> Cc: stable@vger.kernel.org
>>>> Signed-off-by: Stepan Ionichev <sozdayvek@gmail.com>
>>>
>>> These error path 'fixes' are fixes for hardware failure - so if anything
>>> they are hardending  against a possible error condition. I don't mind
>>> that bit it's not a bug to not do this so fixes tag an stable are not
>>> appropriate for any of these.
>>>
>>> Note however that hardening against these conditions is not this simple.
>>> It takes careful analysis of exactly how the hardware behaves and what
>>> each error condition 'might' mean.  Whilst they are probably harmless
>>> I'm also very dubious about taking them without comprehensive testing
>>> on the particular device.
>>>    
>>>> ---

//snip

>>>>    
>>>> @@ -639,7 +642,8 @@ static irqreturn_t bm1390_trigger_handler(int irq, void *p)
>>>>    		ret = bm1390_pressure_read(data, &data->buf.pressure);
>>>>    		if (ret) {
>>>>    			dev_warn(data->dev, "sample read failed %d\n", ret);
>>>> -			return IRQ_NONE;
>>>> +			handled = false;
>>>> +			goto done;
>>>
>>> Hopefully all this stuff is unrelated to the trigger.  For these it is fair to
>>> ack the trigger and the interrupt.  Curiously the driver does it partly for the
>>> next one (IRQ_HANDLED).
>>
>> I would keep the IRQ_NONE here because, if we keep constantly failing
>> the reads, then the bus is likely to be unerliable - and disabling the
>> useless IRQ is probably very sane thing to do. It should help debugging.
>> What comes to acking the trigger - I am starting to agree with Stepan,
>> we should probably ack the trigger in any case. If we don't ack the
>> trigger, then the IRQ_NONE does not serve the purpose it is intended for.
> 
> The interrupt that we'd get spurious detection on here would not be the device
> one it would be the software emulated one deep in the iio trigger stuff.
> 
> Might still be useful for debug. Anyone fancy hacking an error in and reporting
> back what we actually get from the debug hardware?  (with that trigger acked
> as you suggest?)

No promises but I'll see if I can try out something next week...

Yours,
	-- Matti

-- 
---
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~
