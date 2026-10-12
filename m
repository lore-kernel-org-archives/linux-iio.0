Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DE953E7BAD;
	Mon, 12 Oct 2026 10:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791802012; cv=none; b=ngLCsdwY/+9lJiZe0hok1YX+XUrZ90HXeQAY/WEbZJ/mnfJkgqq0+lSXGpCNflWNNjBpzSKWCaW2zZle5UmzxeJw8kywkgvLAmdwzYIA9Bki/5Gz593kkOdY/CEOzUhObreRPsRN3a2ynfYJyJUXFKCTQ9erQQBKJKbtW+zYJjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791802012; c=relaxed/simple;
	bh=D0djbKAJ260yOansJhWoZJsuS0GOznHYMAEu/P+XDFc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GPiOPmdF85IpZQqNylCIC4UH/kEjjTiat9R1RHCJRZ506dsxBh6BF7KO7Z3sVbkS2kmRMuQg4QR6YUSC3qqFrBYveKaVZrOGhDjampkk/cUd6rtI45FE5tyY8ap/GUfpLk71RgNdIWDQFWHVzAuUQwb8MKS4wVxqNZlQOd4Q3F8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PL6gpJEl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PL6gpJEl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0AC01F0089B;
	Mon, 12 Oct 2026 10:46:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791802010;
	bh=Om8qGMDL7nqZdjsVE3iC7vtB7DrWJ+Nip+e2yrwUBM4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=PL6gpJElYBga3a4/0opbidcVqlkkCXxatLqYBbb6ZKgm5eFfrVZezHvt8sP0O1L6a
	 uvLVlGTRFeyKdm0U3oqhrFJH+xgNBV+n8Bt4nWpYQQI7JYfjc2kWvg8XPxd/CwjkPb
	 i+hPf8XVOgO5FaXDRqkZ8oqBLEOYR6rY1peVjnj9x6apVsDDIQkDdKS/6T4aPtPdoE
	 MOXzsgE7Ww5YSocWLPjkQGukfDtQAGEF/b1b/5AFoEfFp1QdNHVvytnHxksLikrSc/
	 M2SWJS/mGYKuiO4x7p2UoVF3a/gPGZul4znARwM7yI78EoVF8vUqb8e5gzUVkqeCZM
	 3cfnfu6iv9Q9A==
Message-ID: <da8b6047-419b-4c3d-8416-e5c871ea4dec@kernel.org>
Date: Mon, 12 Oct 2026 12:46:41 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/6] dt-bindings: iio: imu: icm42600: Add ICM-42670-P
To: Kanak Shilledar <Kanak.Shilledar@axis.com>
Cc: "andy@kernel.org" <andy@kernel.org>, "robh@kernel.org" <robh@kernel.org>,
 Kernel <Kernel@axis.com>, "macromorgan@hotmail.com"
 <macromorgan@hotmail.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "conor+dt@kernel.org" <conor+dt@kernel.org>,
 "joshua.crofts1@gmail.com" <joshua.crofts1@gmail.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "jean-baptiste.maneyrol@tdk.com" <jean-baptiste.maneyrol@tdk.com>,
 "dlechner@baylibre.com" <dlechner@baylibre.com>,
 "nuno.sa@analog.com" <nuno.sa@analog.com>,
 "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
 "jic23@kernel.org" <jic23@kernel.org>,
 "marcelo.schmitt1@gmail.com" <marcelo.schmitt1@gmail.com>,
 Henrik Grimler <Henrik.Grimler@axis.com>,
 "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
References: <20261009-b4-inv_icm42370p-v6-0-e53884f185ff@axis.com>
 <20261009-b4-inv_icm42370p-v6-1-e53884f185ff@axis.com>
 <20261012-adventurous-corgi-of-fury-01219b@quoll>
 <fd4181c7e2f48e3c64530340ae1a02adde1f342e.camel@axis.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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
In-Reply-To: <fd4181c7e2f48e3c64530340ae1a02adde1f342e.camel@axis.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 12/10/2026 12:43, Kanak Shilledar wrote:
> Hi Krzystztof,
> 
> On Mon, 2026-10-12 at 10:58 +0200, Krzysztof Kozlowski wrote:
>> On Fri, Oct 09, 2026 at 04:12:06PM +0200, Kanak Shilledar wrote:
>>>    It has a configurable host interface that supports I3C, I2C and
>>> SPI serial
>>> -  communication, features a 2kB FIFO and 2 programmable interrupts
>>> with
>>> +  communication, features up to 2.25kB FIFO and 2 programmable
>>> interrupts with
>>>    ultra-low-power wake-on-motion support to minimize system power
>>> consumption.
>>>  
>>>    Other industry-leading features include InvenSense on-chip APEX
>>> Motion
>>> @@ -28,6 +29,7 @@ properties:
>>>    compatible:
>>>      oneOf:
>>>        - enum:
>>> +          - invensense,icm42370p
>>>            - invensense,icm42600
>>>            - invensense,icm42602
>>>            - invensense,icm42605
>>
>> Why aren't the interrupts required?
> 
> The interrupts are only required if using the device is used in
> buffered mode. Which will be added later and the dt-binding will be
> updated when the buffer support is added. Currently, the device works
> without any interrupts.
> 

That's misleading or confusing. Either the device works or does not
without interrupt hooked up. Consult hardware datasheet if in doubts.

Driver support is different thing here and you cannot make it required
later, because that would be unjustified ABI break.

Best regards,
Krzysztof
