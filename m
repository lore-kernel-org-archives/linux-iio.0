Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A247A18AE2;
	Thu, 11 Jun 2026 06:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781161133; cv=none; b=GqlfDQFF8SBLWrUajIzpEfO714cVHRd2q3KOs2xCYI/KIRCk2o4RNZXG8BYFxVbGVZ7tCANLQ4AVodfLs4x6c97eqRklnz1jj46lIKvCgu9KmnXnt12lsBJPQF8A5/6v1VgC9XYrsWArhz5DMFJVjJoyUdOkY5B8ohA6pp1kTdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781161133; c=relaxed/simple;
	bh=ILTCwe8+NklxpHWZXmThZMyoTYeL08vv8RZPOuPMLzk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j7Y7Xb/ARbYnBTPx+XgL0x467IxED/wAXI+PakXE7d70mHr/8wSKBMhe9PcRoXz4x97d72whPe1HAbPRoW3be+HuiJ7Utugj9rAmBO73htR8ZbMuNq+45z/w4SZCqE5JMKcdku6/+6bYWM/bXEp8mA89ZNW/VTDXe82h17WM0hQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cfJYYsYI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cfJYYsYI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53E2E1F00893;
	Thu, 11 Jun 2026 06:58:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781161132;
	bh=8Jc+3exJOLpmHaPJpAfMqA01reA6uTgwo8bkThST0Zs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=cfJYYsYIwRxiR5piYTADVzdLF1X/H9iGbCPN0xk4nlWHv3QpEsGcUe8i60ViuBC3z
	 +NimtPtf0Rl+qslS+F8J9FWWeLrBNx0tuPBUmwphgYmPj6dx2fceqqHgVwiwEPfM9t
	 NIsHz0vwpfuqYa7qIv3ad3Au7LljoAfQIhJgAR7HfPowUDvSRXZBMNFL95uh1MidNc
	 KJGxlT+GyScBD2wB6LKyXBZf5S1GXQNQqR8Vhk3QpsulcR3vtxlloifzPpN67tPv4F
	 DqKNGrTiF0frRIjlzoWNdy/aZoNXasUh6jbFxENzc+B2rtP+VQinhQwIDHjh8JewO7
	 DFRSZA/NKptkg==
Message-ID: <6c5a657b-f316-4982-8cb8-8c09f1b1669a@kernel.org>
Date: Thu, 11 Jun 2026 08:58:47 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] MAINTAINERS: Add myself as maintainer for PMS7003
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Maxwell Doose <m32285159@gmail.com>, Jonathan Cameron <jic23@kernel.org>,
 David Lechner <dlechner@baylibre.com>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>,
 Tomasz Duszynski <tduszyns@gmail.com>
References: <20260609160326.45123-1-m32285159@gmail.com>
 <20260609160326.45123-3-m32285159@gmail.com>
 <20260610-pastoral-dark-ostrich-5ca3f6@quoll>
 <CAKqfh0Hi8EkShh3s4dUqAJRDExQLR0NVOvd4An+bY5hat4-Lhw@mail.gmail.com>
 <e00caff5-55e4-428f-bc57-3885699b221c@kernel.org>
 <aipatjyVcltbspRJ@ashevche-desk.local>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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
In-Reply-To: <aipatjyVcltbspRJ@ashevche-desk.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 11/06/2026 08:50, Andy Shevchenko wrote:
> On Thu, Jun 11, 2026 at 08:37:33AM +0200, Krzysztof Kozlowski wrote:
>> On 11/06/2026 00:24, Maxwell Doose wrote:
>>> On Wed, Jun 10, 2026 at 4:09 AM Krzysztof Kozlowski <krzk@kernel.org> wrote:
>>>> On Tue, Jun 09, 2026 at 11:03:26AM -0500, Maxwell Doose wrote:
>>>>> Tomasz's entry is no longer valid, as he is not active anymore. Add
>>>>
>>>> Why is not longer valid? I see activity in Feb...
>>>
>>> Strange. According to git log --author="Tomasz Duszynski" last commit
>>> I have from him is 2023. We also did have an RFC open for a month on
>>> linux-iio with Tomasz Cced with no response.
>>
>> So you did not check enough... and no one needs to read RFC :/
> 
> Hmm... lore.kernel.org shows last activity November last year (07-11-2025).
> What other sources do you suggest to check?

No, only lore. As I said, February this year.

https://lore.kernel.org/all/CAObtm8zKUAWNS23nRMhc9ZR-zn7xeVOFPiV4ai_x7Bkd5puiyA@mail.gmail.com/

Best regards,
Krzysztof
