Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793024507;
	b=yeTH94bL1L1dj2jGfJ3tdIE1OJqjxM72VEsh3H4vSaJKs1A7xUylnCvocfFbfexZt8Da
	 L83TG4mivIKlWXVD7P0+Znr3ZgluIwAjGMo9+luNjEu2tJ6dfUaKSCJkZp7l/Oayu4aqU
	 coM0yFdMxZ/unQWvP7N7WZ/zw6wWjiIgkuKGQgrMN15iAxOqEebDLSxztiNuGFX8VqrzG
	 ryZgrgeATP3Z0pYvJpFKVZrnyqpA5mJ5/mtW6k6MTe7tb2k+TeTCzGsEoHLx+BjevQ8G6
	 yAbFzXz3AlEEMSqFmOCZGLua7OHXZxQH0BGrO53ITmcksLbiCT20l+8L4OkriHDt9RA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793024507;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=/FiQcDHgh/a9Z3vjpl46403izEP86pnHi8KIbA022QM=;
	b=0yROKDMOXcb4+X2Pjt1ecYLaDBoUjSHtn8n1hjj1jQiWa3ATFrT/tSOaCGso2jCnBCm/
	 pI/UReLuflq78z4WLNazi7Paza+5h2wHUQeuBknDm7/jBAlNSBXTpMAv3QoSn9fmgF72P
	 wuVXth7qFle9O3ul5RMCHq57HrrawVSHwlwpz2mkgK1awrOwH++NmP6wC3eQwixwH18BL
	 x6aAZW+PH4Ce8dXjbFjryypwYWRGDco279GuGvw8FwfOKfw43NMDzae7jBYjIkKmAEpjC
	 usmoS1vBe2dOUW1s5Y2N0lowXEaIS2rf11f387qO/e7wivFj6kCwTdPk8T5MPp+l+9Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=goX0ZSoo;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7CFD606A31B;
	Mon, 26 Oct 2026 14:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=goX0ZSoo
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E95E1F031E3;
	Mon, 26 Oct 2026 14:21:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793024506;
	bh=/FiQcDHgh/a9Z3vjpl46403izEP86pnHi8KIbA022QM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=goX0ZSooZSgGCvuM2Nt2WwPgwT7XvnfTAVHe+fmtHzW2cLyGSn+QAFLIzsvEce67j
	 vhTj6mXZ7yA/sfpahEP5SU+PbF+ChunnGyuEkcvZPEP88hlBoFu1l45BSETpNVwXVo
	 NKAF2FK7xpMr8rf9A0FgR6gWql4/ZWcuvhqOtDHdvWATjpJLn0Hu0T7cf0ZPynsPm7
	 4vLHZ95oWJ2msjx+RAPR5fCKRhDZuFV65VTl+TB7+u6pwprfXlfmO2TLXJGFxgx2Y3
	 6agdhzhnf61FTqK38zXyDV9mvuUVvOKaOTgrpRG3jxcptnSasZdWCnu0WjEkpTNWAz
	 IOoPzNyyskIog==
Message-ID: <4ec32f9c-5a35-4146-96b0-99e8c85e0ff0@kernel.org>
Date: Mon, 26 Oct 2026 15:21:37 +0100
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: adc: Add the Ingenic X1600 ADC
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: Olivier Louvignes <olivier@mgcrea.io>, Jonathan Cameron
 <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Paul Cercueil <paul@crapouillou.net>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261024041357.34346-1-olivier@mgcrea.io>
 <20261024083809.000026e5@gmail.com>
 <20261026-hungry-masked-anaconda-7fadb6@quoll>
 <20261026151811.00002233@gmail.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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
In-Reply-To: <20261026151811.00002233@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 26/10/2026 15:18, Joshua Crofts wrote:
> On Mon, 26 Oct 2026 11:50:44 +0100
> Krzysztof Kozlowski <krzk@kernel.org> wrote:
> 
>> On Sat, Oct 24, 2026 at 08:38:09AM +0200, Joshua Crofts wrote:
>>> On Sat, 24 Oct 2026 06:13:56 +0200
>>> Olivier Louvignes <olivier@mgcrea.io> wrote:
>>>   
>>>> The X1600's SAR ADC has four auxiliary channels and none of the
>>>> touchscreen or battery engines of the JZ47xx ADCs in
>>>> ingenic,adc.yaml, so it gets a binding of its own.
>>>>
>>>> Signed-off-by: Olivier Louvignes <olivier@mgcrea.io>
>>>> ---  
>>>
>>> Please use a cover letter when submitting a patch series.  
>>
>> It's fine for two patch series. Please do not make it more difficult,
>> than necessary.
> 
> I'm not trying to make it difficult. The cover is usually a good place

You are, because you are asking for something which is not a requirement
here.

> where to describe your motivations for a new driver, plus with a cover
> it's easier to pull via b4 and Sashiko will treat the two patches as

b4 works perfectly the same for this series as well.

If Sashiko cannot handle standard kernel workflow, then Sashiko needs to
improve, not contributors.

> part of one series, not separately.
> 


Best regards,
Krzysztof
