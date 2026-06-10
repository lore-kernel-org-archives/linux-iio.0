Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FD303E317B
	for <linux-iio@vger.kernel.org>; Wed, 10 Jun 2026 09:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781084801; cv=none; b=ee756KJbAG1UV/Om2/IxcHtU0omUv7TBodsj2yGgyR5dvsikD0dKAG95Uxgd3dAs3d1PLM6AKZ6yVYaNvtmIB/lWrOSSyeLjNmHoBTFqA9VQMy6cg6Z7bIlzlQNNt4DbHYpY+fD1dM48ZoiXEnvpr4Fh4W+uGXkG/FgLeLqsUkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781084801; c=relaxed/simple;
	bh=CjqpUwgcdmZGGnClxIAgMEUFzDmGEog+0mTyc8+EBl0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bnHVJ3YgJ5xJZsth3X29y5X0GijwWaD21FJ8BiTikX/jeDCmPzEVMwTm4B/wQRv5R6/hnbr5DeZy1s2xdOcwldmeYDAqMID41yKhgqrEd0NSAGXxgbEjVUgOsJGOwoMxNKthxRuXqWetugO/I9JjLDaO3ndkHTasVHsXg2lmx5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ksyZvItZ; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ksyZvItZ"
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5aa7a7ad475so6832014e87.1
        for <linux-iio@vger.kernel.org>; Wed, 10 Jun 2026 02:46:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781084798; x=1781689598; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hD0v8SnZ7X7UJ3KpditBZ6pdY3I6wfeV6+vKhTqrGG8=;
        b=ksyZvItZsXgLM9PEPsZNAS34Ql8P+mxJhgeyomIQveBD7eVX0vNguSqQ9Jvr1C+FOo
         zzhxUEa90ERuO6ZXuHEj1rW2H0+IKdCFv7rJntJbXdbCpr0vtukUPeYH6qOfph50K8n8
         pW2ZfhXidn9EKbg2zMq5cqADuMG7mC9LI6dj2Cqr1igxVu35RNmyO2P7sESj0mS26R9H
         LOx6QF9xAQ34is0SbBTWCiuqWlO5hP4EUO1+18a35+Qm7WhifkNbDrDfxwlqdrRuR1ed
         rfMQOhZTsc/uKreGn1VYWgu0iZrTmn6VqGIewoQmao6N2RqMPQsJ2i4g3PM4LN8gDt0c
         HoTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781084798; x=1781689598;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hD0v8SnZ7X7UJ3KpditBZ6pdY3I6wfeV6+vKhTqrGG8=;
        b=j3CnVT8vZYodFMhOUt4DUKyWCeNVQkh9wtK4myUitzNn+40b10osqjUjBjlR99wUR/
         lfYSMCFyZQkcZJvEO5D8kTYLk2Ra0eRQTKKXNQoZsXs+A8TebSViEMxNlzyaMKWrxxC9
         ydi/li+uSPvY8uRFAet14VOcC9qoqcskIzUC9NgVPjVEgTiaziT4t8vCyDL/jJiNayTi
         GLCVTDgqkyJuVRIYU3jfS4jw9wCby/KHpunw7Umi56vbipw9+ryXv6/bYxH+bA0JybzQ
         Mh1olk2/4m8871z2NpGxd8N8QRmDnSdcHyhJj9N6mSnl7aIsuOmgDNbaxJPqLzpzFayo
         YY1A==
X-Forwarded-Encrypted: i=1; AFNElJ//eCVuIVio9/ksYfO53MpJ45VuKCuCFISAhQc/V2lnnn1b/3TYeo0DWsM5IYZ5l5ARReXk34+RNJA=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywyv1a0G5vO93JzTZ6v4LfqOiKiBu4HaNYOD9M5wZ/zUJeSFAm2
	yFjddMsNNf7e14c03JXM2MbHUI97Wq8YOb7q2lM34rbXwdRm07ktt/KD
X-Gm-Gg: Acq92OFCAuWENTfkaZRms0dWz9JAMcJMnvne6lycN1jOdLYkvtTWyE7B9JLnqCJ+27F
	R3KVbuzI9DpjOC+s1k1IVrQxeQkI/X3rkhhDBiCxYONFg63kcGTbpe7QwwrH/6+zvzRimCNbFAE
	g/mY329E2VPYFHnsHClGfCVbviojTj7TG2LN2EUZNkh1FM4Lmpych47XA5X3A1jILjodkyPy56X
	CUijbnhfHeogxMc05rD3upHEqVKueduQs+IpQnsfgjv4tUP1dzk7FAZemg5w5Q3wiPHHGzJm4tF
	nSX6aqlp3PLKgJ0sz6KpRc+ToVhCkfJwP7VzBzyx9XTuiAI5DBEVhdDwBsqLBfgNh/3aha+W5pJ
	9u/gV8T5XHpbMb2ojaiyVaVlU9kG76VBK35lVaFqtydu9bpT+1EW0ZVD+CBPIZyVqSUsdU6hMO/
	vuhw++3abmCqyois9nsrQDqaEVu0f5m/6ZJYXi0CaQW7o=
X-Received: by 2002:a05:6512:110d:b0:5ad:229e:385e with SMTP id 2adb3069b0e04-5ad229e3a98mr302697e87.44.1781084798015;
        Wed, 10 Jun 2026 02:46:38 -0700 (PDT)
Received: from [10.38.18.54] ([213.255.186.37])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-396ac2ed9e1sm61685631fa.38.2026.06.10.02.46.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jun 2026 02:46:37 -0700 (PDT)
Message-ID: <a2b1acbb-f8f2-4d6f-9681-986f42feddfa@gmail.com>
Date: Wed, 10 Jun 2026 12:46:36 +0300
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] Maintenance status of SPS30 driver and related Tomasz
 Duszynski entries
To: Joshua Crofts <joshua.crofts1@gmail.com>,
 Maxwell Doose <m32285159@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
 Andy Shevchenko <andriy.shevchenko@intel.com>,
 open list <linux-iio@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>, tduszyns@gmail.com,
 heikki.haikola@fi.rohmeurope.com, antti.sakkinen@fi.rohmeurope.com
References: <CAKqfh0GxasvVEMVySviw5vB1QmbNF-RKBjuoMD9ffEtnQjDkJQ@mail.gmail.com>
 <agAvydze87mMLaVC@ashevche-desk.local> <20260608085754.32def4cd@linuxescape>
 <20260609140712.2e5d1640@jic23-huawei> <20260609102159.14c68a8e@linuxescape>
 <20260610103651.00007a64@gmail.com>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20260610103651.00007a64@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/06/2026 11:36, Joshua Crofts wrote:
> On Tue, 9 Jun 2026 10:21:59 -0500
> Maxwell Doose <m32285159@gmail.com> wrote:
>> Alrighty then. I'll probably take his chemical/ drivers since I've
>> been spending some time in there. Regarding his light/ driver (ROHM
>> BH1750 AMBIENT LIGHT SENSOR DRIVER) I can take it but I want to see if
>> anyone else wants to first.
>>
> 
> I believe that there are a few ROHM folk in IIO, perhaps they would take
> interest in maintaining the driver.
> 

Thanks for pinging me. I need to see if we have any of the:BH1710, 
BH1715, BH1721, BH1750 or BH1751 here - and if we don't, then I need to 
ask from the HQ.

It is Ok for me to maintain the driver, if I have at least some hardware 
available. If I can't get the HW, then I think it is better to "offload" 
this to someone having a board with the sensor.

Please, give me couple of days.

Yours,
	-- Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~
