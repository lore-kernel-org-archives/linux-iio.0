Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0D503655F1
	for <linux-iio@vger.kernel.org>; Mon, 29 Jun 2026 06:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782714006; cv=none; b=OX5Bnvkldi5gQAMSqG5DgefCAP/YKXYyX+xNkun1j9FYABrKNh5ePTATs87CYd6by9gAp9+zlhgfOChOT9/agdjDJYKAYBLyp6OWEf0mvVB+VB+figjOb/5YewKVpqOUCy92w2RY5TYa1are9DFVEQs5H34d9Zi0fG4b+DZ289E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782714006; c=relaxed/simple;
	bh=+Oewf0zti4ZNl5WDki0vtNhFTQ5zzl+o5w0WuIwmOLI=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=lY9l1IszdWk5sc5YnwkZStTSSrHSsmPqVGD0G/wTeod5IhXDyOMAkFiULHHrDV2zGhgmV97LoYGQcXtqnJcI0IPnUXKvtZ/JEqOMcCClRUVPVnDmEPQVmd978pKrE2p2lJo2G5DbNHQfVFIo98QM4zMM2sQ2mv25AmNAF3H+PY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TPp7bvSU; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TPp7bvSU"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5aea4cbeb94so2082817e87.1
        for <linux-iio@vger.kernel.org>; Sun, 28 Jun 2026 23:20:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782714003; x=1783318803; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=628d7Vl1HoSb6L6sJz7pqGaATh0j3vfBdU40shBEREE=;
        b=TPp7bvSUahyN1sOyFZqk3O+ndH3Up+Vae8U0IQcTZ3i7AB60hvSG6Ubl2Dm0DJdvED
         DxKAIwzx5b/5ZfTqFgYWrLJm9YZ6CbhSLP+4awXaAC4E3PUToSsJSnWXIWZYi6zLHi0C
         MtV4OcNjWAeAosBu6APygsMi9A+FxYGvdRkeGU7IDUtLs08/5Pd/y3G2HpCOoalt9zYS
         VQqYYZRAdjjGFfbMTlJ3F1qSviYbkJWauI91gmwsrnShsQZs9AZBEOE8fK7Ag1JRXckm
         cVuHpSA4PPWIuKIW9GpG0EcnHWaC8P5Lu3ELDKDG8iynbcLF7Ba+JzJTa95BSdvaGTK2
         R2rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782714003; x=1783318803;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=628d7Vl1HoSb6L6sJz7pqGaATh0j3vfBdU40shBEREE=;
        b=YVrhCz24shWd7T+jCL32oo1lhI7dyeT0e8HEbUcxQTdpg/QI/0E1kJ4rS1DXwj1KTp
         pGgyXjxrfwWmczOJ01jmpquzxSV/YIN0fFEU4/vCKcB3ETZssJ0IEtnRkso+UpGxPA8O
         zcylqd4IvgvQT0cMKo1G5u9F6/i9vV5agdSxgRtBNRbLBCR3lZuqOGsm0IMbCnKRb0VK
         ZgGBdWwnC/rCMpDlpo4Qa5UCp5L1XMhKva2Z3sOqfk1nTgLVkvvbMsH840fUTO5AP5bS
         iqKylT4J07b9L898vOmtiSVT5r4oDE8y0EU/NnBip/EAU41eC5tCbRjPF3sH2/Nf0UyA
         yl3A==
X-Forwarded-Encrypted: i=1; AHgh+Rr7xsvQSHgjr3rqrpjEcmZ0To1CYxKXMyMGJ2p+XnqpzZUotzRUTyfQloYdMQbvttQ4vMjqruCYlrc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/HgS8KvW6j+rY/T0OeQPK7fVKVVJ+4MldzKdz0eJOkxobqA8H
	ae8+ZIlSC3G+OVfEqDhupHlir3f/SSAjn5ePOo04g/sOrOjAhz+Fpv9e
X-Gm-Gg: AfdE7ck0k9bifPL4JSpvDGv1nKE9WHAhudUeu60mwjTFP0f70JajFuoAhjhaASBxlKn
	/h/31FBXW/k/ZX1PO6Zewf6PMxEmZkiYhbybnBmVKQTQgHQhoNOgOu0i/oaWLhqn/Pj/FSm+hEx
	mJjC0anU6DhLeSIrPrxAejcJbKwI51p21ihimjlrQKy3gaHfBuBOMkh9dRilzSFls2PlZZAFcqu
	kohR6OqSlSRxEMP3cfjs8cNgaVq037P48VcwlIjaSgKaKirBhMNZU4xi2CBXm4wj66qf9PI8O2y
	RTz9CGm7vgO8s0naL71uiVrkfB/26GOU6HjkjB6wh3o9KibsQ7P+hBcvHSiAOqoHaTFRZHo2xTO
	MMjIKWuCs6VNiiEGrMNNtpsFVkmbFnwejH49AKS6PHsaoyf+no9vJij7QWWoM9nnrxCD4TQYy07
	RSGxSrATrLNJ5ZdS+WMt8XN+9c2Cl2hi+fTSHK194VLG3QhPLAtcUvdElGNZb5rAjuYpsTFCCHI
	MZG3z/q
X-Received: by 2002:a05:6512:8059:b0:5aa:7126:c645 with SMTP id 2adb3069b0e04-5aea1f41122mr2916271e87.2.1782714002091;
        Sun, 28 Jun 2026 23:20:02 -0700 (PDT)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5ad69579a76sm5681480e87.51.2026.06.28.23.20.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Jun 2026 23:20:01 -0700 (PDT)
Message-ID: <806c72a7-8c29-4308-b226-c347bcde7b0d@gmail.com>
Date: Mon, 29 Jun 2026 09:20:00 +0300
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
 Maxwell Doose <m32285159@gmail.com>, =?UTF-8?Q?Tomasz_Duszy=C5=84ski?=
 <tduszyns@gmail.com>
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
 <09dea87f-d2e2-4bbf-a948-3092a2dae29a@gmail.com>
Content-Language: en-US, en-AU, en-GB, en-BW
In-Reply-To: <09dea87f-d2e2-4bbf-a948-3092a2dae29a@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 25/06/2026 08:11, Matti Vaittinen wrote:
> On 10/06/2026 12:46, Matti Vaittinen wrote:
>> On 10/06/2026 11:36, Joshua Crofts wrote:
>>> On Tue, 9 Jun 2026 10:21:59 -0500
>>> Maxwell Doose <m32285159@gmail.com> wrote:
>>>> Alrighty then. I'll probably take his chemical/ drivers since I've
>>>> been spending some time in there. Regarding his light/ driver (ROHM
>>>> BH1750 AMBIENT LIGHT SENSOR DRIVER) I can take it but I want to see if
>>>> anyone else wants to first.
>>>>
>>>
>>> I believe that there are a few ROHM folk in IIO, perhaps they would take
>>> interest in maintaining the driver.
>>>
>>
>> Thanks for pinging me. I need to see if we have any of the:BH1710, 
>> BH1715, BH1721, BH1750 or BH1751 here - and if we don't, then I need 
>> to ask from the HQ.
> 
> The HQ promised to provide me BH1721 and BH1751 so I am fine maintaining 
> (S:) this driver.
> 

Oh, I noticed from another mail-chain that Tomasz was found :)

Tomasz, are you still actively maintaining the ROHM ND1750 driver? If 
yes, then I'm not jumping in. If not, then I'll send a MAINTAINERS patch.

Yours,
	-- Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~
