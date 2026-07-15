Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 843C0443E58;
	Wed, 15 Jul 2026 18:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784140201; cv=none; b=sf0Rd1dcXNvIMOeYNkSYfGtXsXTanies31Na95rkAqHsQc2Xmk5+rIdEtqWlqAs/XXYk29tU077u0uz3OgxYOrmF6dBSaW9oeMLJdtrDmQkPlaBPgYda815IZB+UpcQQYazudhcMflk/0jfcK2w0f8G1tBT7j9iEVDJz1+eDAHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784140201; c=relaxed/simple;
	bh=5Hhx9hTXzBl+KHHAd5y7bDT1L9mwziJVwN8QQ/88Kh0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q/7n39ozpbXU6FbPx1lJbABXZ/lyDQBVZKSGf5kf3OdI5hBebLE0E9ZXR7cLZB4IkFfwBmkQBh5kpx8SdCD7rbxmDXDIYUUVTnmSXKiUdwv1+imuxBWn/ZJKtICCpe/o+3IZ1XK7v2JjiKVu03xWhQUVtWIxwykR9niZtJMkfHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R64NRlwi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R64NRlwi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79C5C1F000E9;
	Wed, 15 Jul 2026 18:29:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784140192;
	bh=m9EZ6WFfHR8NNH32nm0Pzpwwjx7Gv9Yhtrd4QxA+b3s=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=R64NRlwikpnHsASIVAmwGzClZigFwJigpZK3WDg3jA9VCD89dFQs/biSoRUQw/lCf
	 qrz++5bVgjdyakvtZhY7SwPezMaAKyZObFUetBmYG68xyPuBXL1CdY//pzDzul44Wk
	 TPA73kN2mus50saPFngLCaU6yykWTgPk3njybphvmFdKoVr5XCNYqpH5dO7CYk/Tls
	 BYVO9AZKdDkFYHDSj6Vjw3Me0d7GIVe7fibPCuWyOJV5FkjUbp6vb/WaCBks/0VZgS
	 eHzgsHRIi1X71Qh7rK1rljUuly8pt/2l5audMOZE70S7qUiIPusd/N36NeJjstvYI1
	 I6yYIp/bfkKXw==
Message-ID: <82e3c736-f06f-484a-887c-9e156cb7cb44@kernel.org>
Date: Wed, 15 Jul 2026 20:29:44 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v16 02/10] dt-bindings: iio: imu: icm42600: Remove
 interrupts from required
To: Chris Morgan <macromorgan@hotmail.com>
Cc: Chris Morgan <macroalpha82@gmail.com>, linux-iio@vger.kernel.org,
 andy@kernel.org, nuno.sa@analog.com, dlechner@baylibre.com,
 jic23@kernel.org, jean-baptiste.maneyrol@tdk.com,
 linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
 heiko@sntech.de, conor+dt@kernel.org, krzk+dt@kernel.org, robh@kernel.org,
 andriy.shevchenko@intel.com
References: <20260713215842.69097-1-macroalpha82@gmail.com>
 <20260713215842.69097-3-macroalpha82@gmail.com>
 <20260715-mottled-uncovered-mastodon-6c08be@quoll>
 <PH0PR19MB997338D80EB8ABB7C623850A23A5F82@PH0PR19MB997338.namprd19.prod.outlook.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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
In-Reply-To: <PH0PR19MB997338D80EB8ABB7C623850A23A5F82@PH0PR19MB997338.namprd19.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 15/07/2026 16:52, Chris Morgan wrote:
> On Wed, Jul 15, 2026 at 07:52:52AM +0200, Krzysztof Kozlowski wrote:
>> On Mon, Jul 13, 2026 at 04:58:32PM -0500, Chris Morgan wrote:
>>> From: Chris Morgan <macromorgan@hotmail.com>
>>>
>>> Interrupts are almost never required for IIO devices per upstream
>>> maintainers. Remove interrupt as a required parameter for the
>>> devicetree binding.
>>
>> That's an odd statement. We do require interrupts when the hardware
>> requires them. We do not require interrupts, not because we have such
>> policy, but because hardware does not require them.
>>
>> Plus, we do require interrupts when software implementing ABI requires
>> them.
>>
>> Above commit msg is simply inaccurate and misleading. Instead, please
>> use actual hardware arguments or how ABI is actually used. You must not
>> introduce changes to ABI just "because" while for example making that
>> ABI conflicting with existing implementation.
> 
> I will defer then to Jonathan on the specifics of this, but from what I
> can tell:
> 
> 1) The icm42600 devices don't need an interrupt for operation other
> than for buffered mode or wake on movement. One-shot should work
> without it.
> 
> 2) The existing icm42600 driver does require an interrupt however, and
> refuses to bind without it. The driver could in theory be modified to
> not require an interrupt though and skip using buffered mode and WoM
> when no interrupt is present; however I don't plan on making these
> changes at this time.
> 
> 3) The new icm42607 driver I'm trying to upstream does not use an
> interrupt, because on my current test device it's not even wired up.
> On future devices that I have with this chip I may pursue using an
> interrupt, but it will never be required.
> 
> So should I go back to requiring the interrupt for all devices except
> for the new driver then?

You mentioned two drivers, I don't know how does this relate to them. In
any case your commit msg is inaccurate and not a correct reason to make
a change.

Best regards,
Krzysztof
