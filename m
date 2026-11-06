Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793952721;
	b=o2Oa1XNJcBdGX+Ibb86sysHRAudYlhk/h6plUSTBBlBZVSPuK8sZLrQz2AorcbAaQXhm
	 vl5NBUTY0Jv+W/TAlHb3nsPTBC8zEaL0yKmz8owsa8eBBNA3B9pCb3k5A+Njnk9YzI/+a
	 UGDj2duG2LV4lTp3Ur2R0apM2As53EcDSdGa459xV+kv0qdfeYtnV9uAs0koSi0TgGED0
	 oe6SxbJQDrM+JZD+xC+1WBe2sKfelNMwQZc+kho6xdZ6mUp0KnXwMbm4nHD7CwCj/Bt4m
	 wNbRM7/IEuOS5zNYV62CX0OaDPT9FTmcPbGTVGM5Uqe6OsDcOzqTtJkFt2Sh5+Wp0oQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793952721;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=bngU0TAJdIHhGjLUX69NcYJp2YPnX3lHd5Xcv4+sk30=;
	b=CU7ar3aNVr6WBBjOrZfkVUeIeH5v3cmmU2QR6ja87mDFS5DFCt88GaT2kOreUnXySEEQ
	 UOPisEV1I/qXkdiG/ubiFT3LTRo/YvvnUhZTDxbLy9k7SQuS5idxEdX/m7iGW2RV4PlQp
	 bFoUZ/+Bux7QO2dgVCnybPUEhSofTcy8qHtEs/oPWpKV7vaBPlrWqVKu4Mv3QoXOmmACS
	 fB5kTv7So8eWnpdll8XKchUnkIGcGdlrmdbDIEYQwHeaT4fV57zVQ+Y9TFdf9Fjf6tZzg
	 NHNeMNuLEqeYePUKQaMB0iFuK79f3aBZ3UhlfZpWu/fSGH+s5QiTatXpXpEEbYg/OYQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d0bi7yEU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DFC8606A328;
	Fri,  6 Nov 2026 08:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d0bi7yEU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC0101F008A1;
	Fri,  6 Nov 2026 08:11:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793952721;
	bh=bngU0TAJdIHhGjLUX69NcYJp2YPnX3lHd5Xcv4+sk30=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=d0bi7yEUfktCgqR0Cz3lbB4Nxxvfj6T7uZfM6PJr2rItUrQgtMBpI/26Ex9cJMGAS
	 dp7UiTF9m6fYgivA+9DiBobsnT0rUvQPz4qCRVVYPljy+s8Gmul8WTqJsG6LYOreHa
	 FyrMJfPXh2poS9kmn3SVsE5gmWTv9LZrxX/g6tF7ZGXcY/foRJZ9Y/XtSViw4fl6rA
	 Q4vYfl6rGMidBOkmt5TNQcxM1yKvarGX8tLURc82tTQDgA5YlDKEFmDAulyhuInDcM
	 nq/ot6hZT9EMSEy4+F0ghPIi2wO5jptTgKfLY4e9vIBXQ9nGGlJHJVOzOYgFr2fyMs
	 SBx8yDK4OUssA==
Message-ID: <f74bf2cc-c459-4b9c-ad94-c60afcaed3cf@kernel.org>
Date: Fri, 6 Nov 2026 09:11:53 +0100
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
Subject: Re: [PATCH v5 1/2] dt-bindings: iio: adc: Add the Ingenic X1600 ADC
To: "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: Olivier Louvignes <olivier@mgcrea.io>, Jonathan Cameron
 <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Paul Cercueil <paul@crapouillou.net>,
 Joshua Crofts <crofts@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-mips@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20261105213210.87457-1-olivier@mgcrea.io>
 <20261105213210.87457-2-olivier@mgcrea.io>
 <49e69d9c-6cb1-453f-bbf5-e2202f97e4ef@kernel.org>
 <30B040B3-D371-443C-A66D-11EF89FC7C63@goldelico.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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
In-Reply-To: <30B040B3-D371-443C-A66D-11EF89FC7C63@goldelico.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 06/11/2026 09:05, H. Nikolaus Schaller wrote:
> 
> 
>> Am 06.11.2026 um 08:05 schrieb Krzysztof Kozlowski <krzk@kernel.org>:
>>
>> On 05/11/2026 22:32, Olivier Louvignes wrote:
>>> The X1600's SAR ADC has four auxiliary channels and none of the
>>> touchscreen or battery engines of the JZ47xx ADCs in ingenic,adc.yaml,
>>> so it gets a binding of its own.
>>>
>>> Signed-off-by: Olivier Louvignes <olivier@mgcrea.io>
>>> Tested-by: H. Nikolaus Schaller <hns@goldelico.com> # LX16 - driver only, no real world test
>>
>> Drop, did not happen. Even comment says it did not happen!
> 
> What did not happen? Are you expecting a software test or a full hardware test?

Testing of this patch did not happen.

> 
>>
>> Otherwise please explain me how this code was executed on a device.
> 
> 1. add decive tree entries, 2. compile, 3. install, 4. boot and load module, 5. check sysfs

And none of above is in this patch, so you just confirmed this patch was
not tested.

Again, please drop inaccurate tag from this patch.


Best regards,
Krzysztof
