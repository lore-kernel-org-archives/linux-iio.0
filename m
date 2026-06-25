Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C23D2F6188
	for <linux-iio@vger.kernel.org>; Thu, 25 Jun 2026 05:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782364284; cv=none; b=eJf/gn6ghKVqOHj+1rug/6Xgkx8Kf6VZUKYfPjQQ7S03TMRUosIfpwLTqZNtD19Pom+qp8j60W/rnAuXO7AbfoXwgExxw7oJm4CM0pAnRJuGghhTmHdvf7jEa2buy6yo83dh+8cebO6H8kORywN0rM+HFOXYnWR11krls8oOiiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782364284; c=relaxed/simple;
	bh=U3Rc5fZjGrvml8RCr/4CaZxmiB/vs9JOKuwFgszVHOI=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=WdTNktK8VUHtdqzlx6ly+GcOz8gX/7ZdTxc7j2Tc8Pxn0vQ4ZSt7RdxX+XNlu8oOK1W2pLLYRkMDCC23bvNDAwiOU8ybtvttETG248UbHU4DbOayyhCh/uNY1UpWDHnUzA3rfRzZsztbde166zHJn5EBwsjhG5SAzdz/oqO+Jb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kdZAg1mP; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kdZAg1mP"
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-39979f72d0cso11523331fa.2
        for <linux-iio@vger.kernel.org>; Wed, 24 Jun 2026 22:11:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782364281; x=1782969081; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Tk28JSw05X5+0Vmc/X5fV/Pz/S1GM2gZJrQf/Lxfzhs=;
        b=kdZAg1mPwbjxx8qJrjWF+Q6LGm9+MP9zal16lHwUty2nk6uZEOBenwlXHo/k87ZOmP
         Y/gUEiATJ2HIZ/Hz+X+A/iBpKWh1YEmwHlWshH/nyYZ88aOMCcheaW3w54qh6RPl2RBo
         GJzxnUW/EJOL7eVThf6VoMe1JL4W9F2f0TzQ6U5S+6aAKJJmpEus/rIHyRb8Kz04doNt
         /XBqH3MKrmLJyja6VaoKibmdBiueni4peAuksQtop0qgXThNm1PE0SsG+sDC0WRUE/el
         Tt/+a4qsEhyr09Z7iZCHmDOIHGjRI8LuRtneVi2a1VVBCngDjhsMDmOiVTmLV9M+uixz
         eCTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782364281; x=1782969081;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Tk28JSw05X5+0Vmc/X5fV/Pz/S1GM2gZJrQf/Lxfzhs=;
        b=Gqyzc7Vve1s5H2OSb2+gbc71YY91vEi2kxTKPcJZGPkl7PpYUBD7Uikq+qxsIEt4wP
         WV/2+KZeL46yI2Lg/4QLHTOCuWcqdFJs1jtHwa5znGdrhgP7vKuZ76zsMbbWsvjAhGAw
         THbUD/MmPsXMCsV6gih5xPK2R1Y1YVVcXddeU3uoq/H3qZmnkwRSUN7eItXCiAjQW7T8
         iEELlokga7icltSBWTp/p4Ea/lUsj8LnGw0yT+p2LEAUOtXmUdn1UEh0Kvk4s5i/kgVT
         ZVWMsjukmeuq/9PS9II0MEsORm6BS7A8/f4ERgV/X7XZX+hkQp66eXA2wCx6JEIcTczW
         3C/w==
X-Forwarded-Encrypted: i=1; AHgh+Row1/d81J21wUbu3DZwh7XJ2Fwv1m1a8lHPtFS4UMcxE9fWHuzo1c7kOBwtbSCyUNeW4ChUFShINg0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+OGosDFdp7ajSE4eGOPSUNL42YoIv5u7tqRukRWUr2FEFwDEI
	GC+v6rRa11zV/nRUM/zwLZy8utZmYvxmcpyFZUJHaZ6KR3D9FwWIav+F
X-Gm-Gg: AfdE7ckSO6U8iDhR4U0iRKLI5yDbVNTtg7QS4zLzhixSKsz5gitZF/JaJRYpT+U0SME
	2OPrFKcT5Q0ZweGiwEZH9GmTu3Z/no4QhfPfxllryJK8k5xS2rc15f3WrMLhdFj99/Wvp2v5DgA
	6K2euoS2EpII3D6a/kn8uctqMi2ntb3NOpRREKTjRCHM+j5lexg3jbCsOX4MGwPMdkykLXTlNLr
	Ia3VrjdfQabm3C0HTIq3C0WX5sZJXeRLzo1E17MeQOmrSGfzDYaxMf86oeMy6vj8TXovU/0NtWf
	+6HHgQsJXtVj5IFUkoZtpWm8DrNit7eh7zE5m5zSNs5Ly7jhiJ+TXP6mZDiL3+bVEufAbZDTSou
	adGr05v9nSPnZraeDgh+nk2R2Ff+PVRjFR+Xp3lsPRMMJErz++KJj+RAEq0WqDufJW0n0UuicIS
	DXyvByPTe9T8duSrCwVUDodX6sBjzIXFJz19ecHW1ILw7v3ZJy13Hdf7fmOYFZUP8cRXlibdlnh
	xvdZsxf
X-Received: by 2002:a2e:bea2:0:b0:396:78b8:27df with SMTP id 38308e7fff4ca-39acb695b94mr1583131fa.8.1782364280931;
        Wed, 24 Jun 2026 22:11:20 -0700 (PDT)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3999af9f3b4sm43008041fa.8.2026.06.24.22.11.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jun 2026 22:11:18 -0700 (PDT)
Message-ID: <09dea87f-d2e2-4bbf-a948-3092a2dae29a@gmail.com>
Date: Thu, 25 Jun 2026 08:11:17 +0300
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] Maintenance status of SPS30 driver and related Tomasz
 Duszynski entries
From: Matti Vaittinen <mazziesaccount@gmail.com>
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
 <a2b1acbb-f8f2-4d6f-9681-986f42feddfa@gmail.com>
Content-Language: en-US, en-AU, en-GB, en-BW
In-Reply-To: <a2b1acbb-f8f2-4d6f-9681-986f42feddfa@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/06/2026 12:46, Matti Vaittinen wrote:
> On 10/06/2026 11:36, Joshua Crofts wrote:
>> On Tue, 9 Jun 2026 10:21:59 -0500
>> Maxwell Doose <m32285159@gmail.com> wrote:
>>> Alrighty then. I'll probably take his chemical/ drivers since I've
>>> been spending some time in there. Regarding his light/ driver (ROHM
>>> BH1750 AMBIENT LIGHT SENSOR DRIVER) I can take it but I want to see if
>>> anyone else wants to first.
>>>
>>
>> I believe that there are a few ROHM folk in IIO, perhaps they would take
>> interest in maintaining the driver.
>>
> 
> Thanks for pinging me. I need to see if we have any of the:BH1710, 
> BH1715, BH1721, BH1750 or BH1751 here - and if we don't, then I need to 
> ask from the HQ.

The HQ promised to provide me BH1721 and BH1751 so I am fine maintaining 
(S:) this driver.

Yours,
	-- Matti


-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~
