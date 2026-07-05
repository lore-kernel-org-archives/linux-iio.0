Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A91636074F
	for <linux-iio@vger.kernel.org>; Sun,  5 Jul 2026 07:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783236839; cv=none; b=X+mc0PE4C/gnkTjMWvTiRZRdWOGC/zVZ+uPWjhL+pTpCSQ677fUqevUqmUTFB6eKBgNVcJuHGLjo/GwSmgm9k/fcrWqBiWnd37OWVulQnmQvdiJHx8k82PjGne2Lef6cpXO9LBjxI/ZB7lD0OFc4+M3ASi2fgU3stubOO9YY8tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783236839; c=relaxed/simple;
	bh=BAniLIxe5VehWiTjpLRK/YUK2Homp3nMMIKdtX834tM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mAxC3C/6pjs32b+nuGcKDTGAwc+cXQ9D5CTims0/5znlsNvHK7un6TP5VNuq2TJBrOEu7T728QOjIzK9K3gYDoplUMrxK8yJQB18s1VW42u7YgBFEuHzFduknu9ZJu++kW4zA9ht+j68UT42a8hp15flM1J2BF/R+wD8OM/9VLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UoTeBQH7; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UoTeBQH7"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-493bc8fda98so21131105e9.0
        for <linux-iio@vger.kernel.org>; Sun, 05 Jul 2026 00:33:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783236837; x=1783841637; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3EHEPZ3m60Kw/+tCMTS/4omv9ZRDOvhv32Eg+BM9Bww=;
        b=UoTeBQH7DIh/BWnvZRCncgg3Ro4B0hBr//7SL2VK2MMaUBTmJwlt939Rvqk6pQ0AGR
         QhqfbVsYjtQvkiYo/8+9A1Aq5BxJmeBQiv/CIv7QKhNKbaa8sXqZWmvnoQYAjyaQ6aOS
         cgmAE7ORwwEWluNKWPJbWEjBkjN/TiB2qRw6IBvK/RRe3QFWhXSaqNFWKZ9KCO20ovpH
         0Iv5NRwQ8fApDPdoCepkpZxPy1DQ6yupZcYQ2DLGIOKVF17+oE/JprMPzTjXhVilWS6T
         R1KwqIJNMASFAu2gCl53GiP5zFYnmmmBS8BLYsngL9aPG/TvT8pgqaLZdUq+wN6wjs2U
         zBxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783236837; x=1783841637;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3EHEPZ3m60Kw/+tCMTS/4omv9ZRDOvhv32Eg+BM9Bww=;
        b=j/WOgAiqWS2Fnsiq0/JoBBZ8bycihJeQbAhvvw/RVPT13pMk8VrLD1BOcOiiRPShVl
         deLEPvFJfbf+ZjxOqCneu4nVCoatBeIVSrEseKssYgbzQOyVhzfLsnc3E2YWUfVVTQzc
         UsMJauGh9B+goL2LYkENvXtVhLVokCX1KcXRA6PmsfX6xeKPOCQDy3npSbEqwRum7UhK
         Jqk/GXK4p1UkoGUB30NIedo9TttdVOFqsnxkitpf+KAzMPJGFXRW/TMbPRshlfAk0/w8
         oy6QwSjIgl799YiwM6EdBLt8zBWfj2yiLC5kF4g/GRuABsEiWoaQQ3HpHDnJPWajyFzP
         jcQQ==
X-Forwarded-Encrypted: i=1; AFNElJ8kSusn/zILfe79FsiDRrxbpcDa4dgdWuXmVgv28SfS4FR4ooJFW7FKQA8U07LiasEX2J34mDB0nMo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxF+J5NlprS8OnVxHG1q8NDVihTdv9m9900w/rV4wqA1O0TBrm6
	VrUOO9/Db6YVcrCKTUKdzPri4mp0YFUPsNno9ZZOseEzI5YR8OcERiXFrmpjgUX27wg=
X-Gm-Gg: AfdE7ckXfJ3gU30kYZIGbxyzEvHY8Gxht4Kcko0S6itOMClH3b1GTcSQtXAUqpc3Qpp
	mCz/wR+xfkZO53oFyqAfMeHOjOZnf6iaMYeldlfIINXkamhAldp439rnMfyI3nG7MY2HnUXx5cG
	n+CL4oP1YI8YEEw8YjDTCXvWGpTVyfoUMLBKlepaItsjRFkfJ8Up95feEkuGW2WvpoW4rTKe2tI
	b2C8IOg/GrYjDbP9WaKaq36AXfrRXVQzSGB5G3rWmCu0BKgkyikWkGAkCg7F9+V8fry276Sm8D+
	JISXv+LlL8oUWNu6J7T+4CgZCyCfp0vrFIRGY9FhWExpNzrZOX6r2DkMZZ0OrM7Zqck/Y20PRJe
	Rj8luEDmonVDNTgcLnbe95rJXWGCVZlkq8q3sMLWwoGlc0D+iS2amRyE55hSIfeqdyFOvfslIaI
	kpB4vWeS/st2uE02pxnpW4KxIegUOG6H/utLA+zikjqqAvWom9954se/ct810niZJkVQ7iib6ej
	ItlPhHLHr0UyT0BRnRTMMGnBAThhdjrNaLnrWeJruXFk/BeCb0=
X-Received: by 2002:a05:600c:3551:b0:493:bc4b:b8c with SMTP id 5b1f17b1804b1-493d11faf3amr67535995e9.38.1783236836820;
        Sun, 05 Jul 2026 00:33:56 -0700 (PDT)
Received: from [192.168.0.173] (108.228-30-62.static.virginmediabusiness.co.uk. [62.30.228.108])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493cce1a844sm174893715e9.15.2026.07.05.00.33.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Jul 2026 00:33:55 -0700 (PDT)
Message-ID: <8cba0a18-6cd7-48a9-9beb-83218148de6a@gmail.com>
Date: Sun, 5 Jul 2026 08:33:54 +0100
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: accel: bmc150: free irq before teardown
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, David Lechner <dlechner@baylibre.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, stable@vger.kernel.org
References: <20260705042731.388592-1-mlbnkm1@gmail.com>
 <akn_hlxkSDRG389t@ashevche-desk.local>
Content-Language: en-GB
From: Melbin K Mathew <mlbnkm1@gmail.com>
In-Reply-To: <akn_hlxkSDRG389t@ashevche-desk.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Thanks for the review.

I double checked the remove path.  The remaining hardware accesses after
freeing the IRQ are synchronous regmap accesses and do not rely on the 
IRQ being enabled.

In particular, iio_device_unregister() may disable the buffer path, 
which can call into the buffer predisable path and synchronously disable 
the FIFO interrupt, flush the FIFO and update the FIFO mode.  Later 
remove explicitly puts the device into deep suspend via 
bmc150_accel_set_mode().  These paths do not wait for an interrupt or 
use the threaded IRQ handler for completion.

The IRQ handler itself is only used for asynchronous trigger polling,
FIFO/event handling and interrupt latch acknowledgement, so freeing it 
before the rest of teardown should not remove anything that the remove 
path depends on.

On 05/07/2026 07:53, Andy Shevchenko wrote:
> On Sun, Jul 05, 2026 at 06:27:31AM +0200, Melbin K Mathew wrote:
>> bmc150_accel_core_probe() requests the interrupt with
>> devm_request_threaded_irq().  The managed IRQ is released only after the
>> driver remove callback has returned unless it is freed explicitly.
>>
>> bmc150_accel_core_remove() currently unregisters the IIO device and
>> triggers, cleans up the triggered buffer, suspends the chip and disables
>> the regulators while the IRQ action is still registered.  A late
>> interrupt can therefore run the hard or threaded handler while the IIO
>> trigger state is being torn down or after the device has been put into
>> deep suspend.
>>
>> Free the IRQ at the start of remove so that no handler is running while
>> the rest of the driver state and hardware resources are dismantled.
> 
> In general this is correct fix, but have you checked the rest of remove if it
> has any communication with HW and if that communication relies on IRQ to be on?
> 
> (*yes, this is very unlikely, but please double check as rarely we have some HW
>   that might need that, and in such a case the fix might be different)
> 
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> 

