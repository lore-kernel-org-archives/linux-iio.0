Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F1FB33A9CF
	for <linux-iio@vger.kernel.org>; Wed,  6 May 2026 19:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778096699; cv=none; b=l6Mg5VXPj7ADU+GMjomLUteyOCkpi+FJ4CY0nKPT3YM2uR0ingARczmuUuHNcoEFdq6i+/FXLi9QcJsNxTjP2zoi9Jt+mPOIipnkJOSAjBfnRFG7GEahFxbjreRDgpsngLdO/evocZudYrBeime/j+PhmZaGB7reVOcYPqQLlmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778096699; c=relaxed/simple;
	bh=JqGLpdLb1snUOwfA8YpmEoiA3kJOIkemImw8Vx+HEYI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V4gHF/9BfYYYP4GxKi00JUQ2WyF0Fzndz9AahCak7xhTY9bRo3Pwnjx5Qnc3vqCb7zB2HMKje5LW/+wmp6fx3VoNVlGPr8rKt2V6GFf1i5IGCkXkr8M+eIyPbkOYyP5jC7vQH0zdIVNzdiCUQbivshEyI8uLXRuKJbiHoAWzm6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TPcrVRgr; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TPcrVRgr"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-48909558b3aso768665e9.0
        for <linux-iio@vger.kernel.org>; Wed, 06 May 2026 12:44:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778096697; x=1778701497; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JqGLpdLb1snUOwfA8YpmEoiA3kJOIkemImw8Vx+HEYI=;
        b=TPcrVRgrQMVeUMCwOBfBsqipaLdXeSwBqVF+Yn50WCStqGRCd++wYEed6t8Lkx5aLK
         MBj8pQ2zK6lGizkdP8aI7HYklEyyZrgwKf7nTATr/ScKh0zdpjHSZgLOYjxBMhDz8rrF
         W3n8TVmqzKhg13HxTltxestQ3/LVYEZ204uofb1ooGgaa8+ZUe5w9JNUssQ/7zrixikX
         JKMm2QbCAg1CDRbidhiMdIJBdZEmdTWcIYcFEfquKB2bhvGB+dy7gzKnafGQey0HPBxN
         bZt+6TBlkg0SP7zLn0cUICFwcViH9g7soI2NN7RKfksgARI0B00l81TJw8zaz4JwDnPF
         Xl9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778096697; x=1778701497;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JqGLpdLb1snUOwfA8YpmEoiA3kJOIkemImw8Vx+HEYI=;
        b=dRYrBf34yFd9Vf8/IVNnO9GbMPsuCYSXFLWhyghZpBEHQuVcRwo35lYIWZZv+4Ib1Z
         2d+bzIZlLLuyVzoUCLQeoy8zLwBYKbrBZ5FEIXn98mgx/BdVXSN3ve3ntZRPuE5IeupB
         PEtF00OfJ8ennNgWOy5vkqNZrGvfPoFCqSLtph5/h5ttjZqIFe/0hGXACAbt8yOXyKlu
         5Z/aecbkr1qbJex65aOY44m+M1YDyKkEXtPJpEQ/BTSstzjOTPdW4Ltdx3citkoRp67B
         CZnZcM3UNH+zaVCCLnaudWl2IraJyrtrWzyBgYeZujIe52fqY7z8pO1Ji7rkou2SDR1/
         IhWA==
X-Forwarded-Encrypted: i=1; AFNElJ+WYFHTTUO5ABepa9wj2VTx7bgutk/gIovt3DW74umGv8OHz8voEbVL6N4KGfGrXMSrx8PlIv7fb2M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcLFm5DrWLkmUKcKclFjm+hK4EFW0VjIaE5t3ZVm07vZXX+uAt
	I7EAhjRMpXrt+tq+/msUywwRemCdXGJPaJvijNWNrG1TckDKTp40Py7+
X-Gm-Gg: AeBDieuvPa5+9uzg5ZijbxOukMBDvSmd8fAwmtYSpW2e1tJurS1cywoIjAwHaLdtWh3
	+sjXRBWJohqX6WZwY+nrjaX+YmmiuSRw96pf5iL8PFffEjBH2FMMQmwj1D40ROEOYax9etJWoOL
	tJyxP34oxRdObdodGebosXx3tEkM746OL9zfqfhnkJNq+hloXfDEi18Yv4FIBv+etPSfJm0WrJf
	Dt96gL++CVXIY+7ngPPJzL+u0ko4MGJao6KRW4WV3iDqdUVpZSKfuWNUzLAtIrFaleh9zdkUi2Y
	k51Wona1OpzPqn1qqIFOOEDATZ/vFck4NiWSNotrACFqUuFjv+pg4ZVKuwA0TBppwqARvZcHVyl
	xVzpzDkCWSbGCGTevQIjMOX5QSO7I1MJHCNr+gVFYWSdDDQ+oPM/9L//E+v47GwLLPFY9x6bpiT
	4Sss/9OAarI/urifZ7Nf00+DxD8ui2QPGreHXqWESdrDpa2COfWMQAnOcKULaIHeXIfPIYXFhZk
	U8hPf8TA3o4c/9t8yGv6YsSbivM+97l+LXI+AA=
X-Received: by 2002:a05:6000:454b:b0:452:6aaf:76cb with SMTP id ffacd0b85a97d-4526aaf7700mr2060260f8f.1.1778096696657;
        Wed, 06 May 2026 12:44:56 -0700 (PDT)
Received: from ?IPV6:2a06:5906:2639:e200:6958:e55d:575e:c24c? ([2a06:5906:2639:e200:6958:e55d:575e:c24c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45054b03d4csm15073323f8f.22.2026.05.06.12.44.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 May 2026 12:44:56 -0700 (PDT)
Message-ID: <ae4df358-4f61-429d-b8be-2f63823f05b3@gmail.com>
Date: Wed, 6 May 2026 20:44:57 +0100
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 1/4] i2c: rust: add smbus_read_byte_data and
 smbus_read_word_data
To: Muchamad Coirul Anwar <muchamadcoirulanwar@gmail.com>,
 Igor Korotin <igor.korotin@linux.dev>
Cc: jic23@kernel.org, linux-iio@vger.kernel.org,
 rust-for-linux@vger.kernel.org, devicetree@vger.kernel.org,
 branstj@gmail.com, lars@metafoo.de, ojeda@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, linux-kernel@vger.kernel.org
References: <20260429132234.30514-1-muchamadcoirulanwar@gmail.com>
 <20260429132234.30514-2-muchamadcoirulanwar@gmail.com>
 <5f126a59-9f03-44e3-b4cd-27f70bd9840b@linux.dev>
 <CAO26r3R_TxwMwLoJMqjAG0pd2P__V-WmGkTcrZFt6CQwa2y1cA@mail.gmail.com>
Content-Language: en-US
From: Igor Korotin <igor.korotin.linux@gmail.com>
In-Reply-To: <CAO26r3R_TxwMwLoJMqjAG0pd2P__V-WmGkTcrZFt6CQwa2y1cA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/6/2026 8:46 AM, Muchamad Coirul Anwar wrote:
> Quick question on logistics: would you prefer the Io trait patches as
> a separate series, or bundled as prerequisites in my v3 for the AS5600
> driver?

Bundled patch is pretty fine by me

Thanks
Igor
