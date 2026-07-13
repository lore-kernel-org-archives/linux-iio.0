Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B16843A75A4;
	Mon, 13 Jul 2026 08:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783930306; cv=none; b=hspjHPb+bBf7NN4ZATUUtcGshmM4uLr+aC910eLNQqJqTBuBvKNqlZzZay4iR/wPoOQEqpYVe6ChSilZBxt67oGtE91iknHH9k8dnJTFsgaP3grbfazXs5q74d6AgkSu8AK7tscvIWEW2m6WdHdDeQ2UvnX3dxg4T/YmN+307uU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783930306; c=relaxed/simple;
	bh=nekH3c8fOVjXzri9HMJDZCZ+Cs7MULnXoNr/TShtOno=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SExLm3yF7SL6nEbCSj+PBHDUlEiMxwt/JYGQLJorcOsq7B6BzdErBmQNiwITWiPWiAvRSvIpAasnp5bvdOh5DBYviA8PAYmjvV8CedEin2emlrucgYnr9wTWaRmBkHqIwcQOXOYTMV1Bc4vuNrgRWRcUUiVL9c7bw4TDB/AaEFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Zons0NaZ; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Zons0NaZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1783930302;
	bh=nekH3c8fOVjXzri9HMJDZCZ+Cs7MULnXoNr/TShtOno=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Zons0NaZRFePVu2AFie0jHRJDaSl8nVZRnppWW3K5rXuujeJq89RNEwiLr+W4Ez1n
	 XqNQ9w7ETzBiN4jiaaKGFgK2J05DcFbj1EsTEnklxVGNSnDxjIwODNoCiu5eeib+eP
	 iBEnixp/SEl43F90hI/BEJoKIiKEk2YrZjiPEKZMHcH9c/Ts2Rv5AQD6hIbA1vRRDY
	 AKeCIlt+n9ubbCUY9L1rCtwStMnkfmU8+2OsMTAqcG+ZZIY6mebedYjlWgaDwHygf1
	 1rrT+Qq0g2UhQleHWRQI7hCZT8ZruH9g6YS35nhGmJuV99XAluti273G0joQA26vBQ
	 XbymhUnq3Ec7g==
Received: from [100.64.1.21] (unknown [100.64.1.21])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 3C6B317E07AA;
	Mon, 13 Jul 2026 10:11:42 +0200 (CEST)
Message-ID: <c11705b1-fc46-440b-a27e-0cc38f3b2d69@collabora.com>
Date: Mon, 13 Jul 2026 10:11:41 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/4] AUXADC driver for the MediaTek mt6323 PMIC
To: Jonathan Cameron <jic23@kernel.org>
Cc: rva333@protonmail.com, David Lechner <dlechner@baylibre.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 Lee Jones <lee@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 Ben Grisdale <bengris32@protonmail.ch>,
 Conor Dooley <conor.dooley@microchip.com>,
 Andy Shevchenko <andriy.shevchenko@intel.com>
References: <20260709-mt6323-adc-v5-0-d11b8332a735@protonmail.com>
 <f2d5801c-1d12-4a61-ac23-aa24dfd0ee5c@collabora.com>
 <20260710005424.5c559b5a@jic23-huawei>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20260710005424.5c559b5a@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/10/26 01:54, Jonathan Cameron wrote:
> On Thu, 9 Jul 2026 13:33:46 +0200
> AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com> wrote:
> 
>> On 7/9/26 12:52, Roman Vivchar via B4 Relay wrote:
>>> This series adds support for the 15-bit AUXADC hardware block found on
>>> the MediaTek mt6323 PMIC.
>>>
>>> The previous version of the series for all AUXADC, EFUSE and thermal
>>> drivers was split after Krzysztof's comment [1].
>>>
>>> Tested on the MediaTek mt6572 and mt8163 SoCs (Ben), both paired with a
>>> mt6323.
>>>
>>> [1]: https://lore.kernel.org/linux-mediatek/20260504-mt6323-v1-0-799b58b355ff@protonmail.com/T/#med30fad67a090be35f549231336b2dec295233f6
>>>
>>> Tested-by: Ben Grisdale <bengris32@protonmail.ch> # Amazon Echo Dot (2nd Generation)
>>> Signed-off-by: Roman Vivchar <rva333@protonmail.com>
>>
>> Whole series is
>>
>> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>>
>> Cheers,
>> Angelo
> 
> As noted on discussion of previous version. I picked up the IIO side of things already
> so I'm assuming nothing else for me to do here.  Shout if not!
> 

You're assuming right. I should've replied with R-b only to the last two patches as
it's too late for this on IIO - it's fine! :-)

Cheers,
Angelo

> Thanks,
> 
> Jonathan
> 
