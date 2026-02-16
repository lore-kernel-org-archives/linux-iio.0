Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C6202F6922;
	Mon, 16 Feb 2026 10:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771236604; cv=none; b=eoXFjmgllc5do/vGQrCR/r+xdpe/roeaYqK9p6if43nuOxz/znXnGFSMGfrfYHpcYAnTRoTyTM45Y6jq/m8AwJRKbqiTJTPZh1/XokialZPInhO/PXwbG5Q6CanyeyinWqreg+mIGAG8KuP7+C0W4b1t1OJHyNy12oqC8kMnnwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771236604; c=relaxed/simple;
	bh=mzecU7QIehc96k6hTTchmWE7X6MIRsfEicPHBZ3pnxk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SbLnq5HREtD4xTWadRIQ1VoNxHkahZW9nCTuebnIBR+S31Lrrx29WSSdy80oG8XHpQg8QwAvu5N0dy8r0LbcfAjIye9aWmuM84YHBqnOsgfqPk4bU65zDDx5l1i8VnIMs8M9XnFq26svRdtEUbk4O0Zn3+2KKKdyTe9eSVPdt50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o3alX8Bd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o3alX8Bd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5944DC116C6;
	Mon, 16 Feb 2026 10:10:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771236604;
	bh=mzecU7QIehc96k6hTTchmWE7X6MIRsfEicPHBZ3pnxk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=o3alX8BdEIcAQCLPAAYnkxvPiYDxsPclOrKE4vgMZTsYUOUnCXhg59m8H+0od6/YG
	 PJsGLRF+r0IJvXMtSQXqTyJl/ZOKlLmy2dKlEBOfTj3SjoAvaRRhKsPEaGUOi4j7TF
	 UXcr3yhMa/UXsMFzTYNKE4PFQxQEtCCe0UpL2l02NSi2DgRqUmx1vaKWtHA257GBUl
	 PWLf0eSPIqQrlA5z0jjV/L9pjSsBEmctDEfPlyKDel5YlWjHLZZQlu/r2tkosU+uGP
	 PYpIdolThV5pLOQGO7/DuW6QtZp6XEL18AmLLN97iyvj6XlPoPGiF8NwGrtChZapyS
	 mnjlAUpSzGFgw==
Message-ID: <ddfda269-9eec-4e94-88eb-4eca31d4836e@kernel.org>
Date: Mon, 16 Feb 2026 11:09:59 +0100
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/6] dt-bindings: iio: adc: adi,ad4080: add support for
 AD4085
To: "Miclaus, Antoniu" <Antoniu.Miclaus@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
 "Hennerich, Michael" <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>,
 "Sa, Nuno" <Nuno.Sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <cover.1770382796.git.antoniu.miclaus@analog.com>
 <e1ef83150eea89864d4bad8d9b43e60503fc5f14.1770382796.git.antoniu.miclaus@analog.com>
 <20260207-hypnotic-passionate-crocodile-e5be30@quoll>
 <CY4PR03MB33991AA5BC33EF3786EB01A09B6CA@CY4PR03MB3399.namprd03.prod.outlook.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <CY4PR03MB33991AA5BC33EF3786EB01A09B6CA@CY4PR03MB3399.namprd03.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 16/02/2026 10:23, Miclaus, Antoniu wrote:
>> -----Original Message-----
>> From: Krzysztof Kozlowski <krzk@kernel.org>
>> Sent: Saturday, February 7, 2026 12:53 PM
>> To: Miclaus, Antoniu <Antoniu.Miclaus@analog.com>
>> Cc: Lars-Peter Clausen <lars@metafoo.de>; Hennerich, Michael
>> <Michael.Hennerich@analog.com>; Jonathan Cameron <jic23@kernel.org>;
>> David Lechner <dlechner@baylibre.com>; Sa, Nuno <Nuno.Sa@analog.com>;
>> Andy Shevchenko <andy@kernel.org>; Rob Herring <robh@kernel.org>;
>> Krzysztof Kozlowski <krzk+dt@kernel.org>; Conor Dooley
>> <conor+dt@kernel.org>; linux-iio@vger.kernel.org;
>> devicetree@vger.kernel.org; linux-kernel@vger.kernel.org
>> Subject: Re: [PATCH 3/6] dt-bindings: iio: adc: adi,ad4080: add support for
>> AD4085
>>
>> [External]
>>
>> On Fri, Feb 06, 2026 at 03:08:22PM +0200, Antoniu Miclaus wrote:
>>> Add device tree binding support for the AD4085 16-bit SAR ADC.
>>> Add adi,ad4085 to the compatible enum.
>>>
>>> A fallback compatible string to adi,ad4080 is not appropriate as the
>>> AD4085 has a different LVDS CNV clock count maximum (8 vs 7), requiring
>>> different driver configuration.
>>>
>>> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
>>> ---
>>>  Documentation/devicetree/bindings/iio/adc/adi,ad4080.yaml | 1 +
>>
>> Squash the patches. You just added one line, but commit msg is 5 lines.
>> Exactly copied from previous commit.
> 
> Sorry for missing your comments for v2.
> I wanted to keep the structure of the patch series similar to what was already accepted and integrated into the main branch:

And I want flying inflatable yellow duck. We do not use arguments that
we want, but we use arguments WHY we want something or why community
should want something.

> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=83185903b4eca86e0c7145d62e55de768eeb9e7b
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=6c3e7265734bbde7347d44fa8e5720bcc5ad5cea
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=d34ad6467200380c8f8337ceefee9f3d8cee5492
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=f11de95215311816595a1f2ee81cf8239d9b660a
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=4028cbcf3415f6e0810326d87c6e0b494814ae12
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=45e81d6ac0e1af349e5da050dc0be48a72fad9dd

>

No, because it does not make the code easier to handle.

Best regards,
Krzysztof
