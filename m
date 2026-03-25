Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D21A939B971;
	Wed, 25 Mar 2026 13:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774446257; cv=none; b=QIxe0doP55mRADx9Te4mLdxrw26nV46juN4Tyv+R3B3HEeHEzetmx4JTOcwnOzkYUhx3y/BkpCrFyMkrEfmzC5yOwG7GFA9nLsByULhSLxfWkWKOFfUNiwu5VYKHh+Ykk9OA5w61nlP/CJHRvqOKkAHSqyCrYvntcnqHFbF0x1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774446257; c=relaxed/simple;
	bh=aVeXl96fDbGRyWT9TuYudXskoTKKztaf86ZZMUJH2uY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WLI4L4zZ50YTw4BQvuosdRb3PKD9YqglamTX7VGFrKS6/gC7VrlgvnpGFOzzeNWPrUIqx49pyjiR5DdoAcBPlViWccEKXsgcx0l0F0HjMS736AzllHBVeO96dqbvEeRHVj/eRLfPB3hDp6ryl0HLdQrBUU2chQMoNbLiDcf2XnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p4AihPRo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p4AihPRo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD68BC2BCB2;
	Wed, 25 Mar 2026 13:44:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774446257;
	bh=aVeXl96fDbGRyWT9TuYudXskoTKKztaf86ZZMUJH2uY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=p4AihPRowNRLIXM9svfzj3qzeKVnNy5WH65pGvsiAxcbQeXP0oQGRXwiI+aCheJTz
	 wDXHlIeARdHnYZrA9nAtz/3RbZxsNrAXhLCCVBtwl+xx9stzvo8D2M8H9w++fDGREv
	 e9lg/m8rOwKgVLbSHFGmqC+XsOTj/xzCpTtZAMqkuGlO8fA5H9YugXKEEiZ2mKHJuc
	 bBWciyOpVs2o0w4WtwqAy38tM/Ik96po/+IDRo5ONUiSnhERevFyVcBpBA9pdmPeK1
	 HYmdNeP29gvJ8nrZs8WqfmLx7Q2dl9ImlvRzbHUWO/DBKW9fLWRmaG24s8PD5dekbc
	 jywatYRKKItIw==
Message-ID: <f27bfbe4-aa90-4631-b96b-efb8465b05d4@kernel.org>
Date: Wed, 25 Mar 2026 14:44:13 +0100
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/2] dt-bindings: iio: proximity: add ST VL53L1X ToF
 sensor
To: Jonathan Cameron <jonathan.cameron@huawei.com>, Sirat <email@sirat.me>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, jic23@kernel.org,
 dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, linux-kernel@vger.kernel.org
References: <20260325063254.18062-1-email@sirat.me>
 <20260325063254.18062-2-email@sirat.me>
 <20260325-gentle-earthworm-of-progress-1f9f46@quoll>
 <CANn+LW+Y6j0xk2x02-BUL9qNq2gf-PXspi4wP_KGd7Abz3hOYw@mail.gmail.com>
 <4d10b6c0-d599-4fc5-b9ed-ce669ac46e84@kernel.org>
 <CANn+LWJQM45rAT+mzS9ZEGBgmqChbxUtStdzhbzthXUPJ=2csg@mail.gmail.com>
 <20260325133806.00007b68@huawei.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <20260325133806.00007b68@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 25/03/2026 14:38, Jonathan Cameron wrote:
> On Wed, 25 Mar 2026 15:18:05 +0600
> Sirat <email@sirat.me> wrote:
> 
>> On Wed, Mar 25, 2026 at 2:58 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
>>>
>>> On 25/03/2026 09:48, Sirat wrote:  
>>>> On Wed, Mar 25, 2026 at 2:05 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:  
>>>>>
>>>>> On Wed, Mar 25, 2026 at 12:32:22PM +0600, Siratul Islam wrote:  
>>>>>> Add device tree binding documentation for the STMicroelectronics
>>>>>> VL53L1X Time-of-Flight ranging sensor connected via I2C.
>>>>>>
>>>>>> Make vdd-supply required. The device requires power to operate
>>>>>> and the property should have been required from the start.  
>>>>>
>>>>> That's ABI break and device for many years was working fine, so this
>>>>> should not be changed.
>>>>>  
>>>> Jonathan and David asked that vdd-supply be made required. I feel like
>>>> there is a conflict here that I am not able to resolve myself.
>>>>
>>>> What I think about it is the binding does not correctly describe the
>>>> hardware and we should consider this a bug and fix it.
>>>> The driver worked because of a fallback mechanism (dummy/fake
>>>> regulator) and not because power was optional.
>>>>  
>>>
>>>
>>> I looked at v6 and v5 and I do not see such comment for binding that
>>> existing device should change ABI. Can you point me to it?
>>>  
>> "Make it required and add a note to the commit message to say why the
>> requirement should always have been there. Devices tend not to work
>> with no power." - Jonathan (v3:
>> https://lore.kernel.org/linux-iio/20260322115704.10b2e0d4@jic23-huawei)
>>
>> "No, bindings should not depend on driver implementation." - David
>> (When I asked if I should  drop the hard requirement in the binding,
>> v6: https://lore.kernel.org/linux-iio/55e92148-b5de-4fb8-af0b-9476235341bc@baylibre.com/)
>>
>> "From the point of view of the devicetree, it doesn't matter what the
>> driver does. It matters that the chip can't work without power. ;-)" -
>> David (v1: https://lore.kernel.org/linux-iio/d0ec6a2f-6d30-4774-8950-15dd3c4b020b@baylibre.com)
>>
>> I'm not sure if this is the correct way to quote. But I have added the links.
> 
> This came up a few years back - though I doubt I can track down the
> exact discussion however.
> 
> From a Linux point of view we are breaking binding checks only if the
> supply (that should always have been there as chips tend not to work
> well without power) is not present.  We absolutely have to
> keep the driver running whether or not the supply is specified.
> Do other DT users provide such a constraint? I've no idea.
> 
> If the DT maintainer preference is leave it not required (perhaps
> with a comment saying new users of the binding should supply it)
> then that's fine by me. I'll keep it in mind for future similar changes.

If this was other ABI, e.g. clock, then answer would be - do not require
it, because that's ABI break. Therefore I would stick to that also to
regulators. Once Rob also expressed such thoughts, although noting that
it is not that big deal.

New device in this binding of course should require the supply.

Best regards,
Krzysztof
