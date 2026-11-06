Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793953421;
	b=crYWYUtksIIjYAhOW7IYpN/4dK212HIFj0WJ26RHSpbqi7aM5DTMYBzkNMY4crX8lX+t
	 KYDOenwxAUp3F193RmAqKoDJtJxckbEWe5hvRvk5es8UtKX6jZWr9LFyEthn6jPnTj2UC
	 cqc527aOTpXz5/oTX4iBUYumt2vY0Cxszq5Gcx88UPEV9po3zmnecpSI14TlvlxhE0pO1
	 K1OxV7TI2/fO9TqalbD5W8wjtCRdQobtLYytyzuM90P8x5NRUE7IEcyhn/w64G/pzjfJc
	 qi5mg9iJyveoxCXKr7UOAmRsQp5J41LmEkAK/5nES5Rrc0UhrawmxtBbU5zd+tjaMlA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793953421;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=ymrZpA8Fy9JtHf0tOEjbIKru6WLcYWV1jdxeTqeYIWQ=;
	b=IvSizdQVGZk0e/aWI84H2/rlNGc0R+ljFkXnaZJRSzGbX/509OvG6CRkZNEwTWambSJm
	 9BLFvAMq/jZz+yUPGWBcCJL4Jd7+G3R1XuJKtfpzkvsS6/S9BjCGxyX1hWtHerPBBrKDp
	 cwIV9NaZf0Sp5ddCHhwk37ODAO8haHsCXezRIJ7OJJY/YcLGgDsHmX0/d+gr+XAsHJaha
	 X8dyMeSaV3iQzgZMOHMAVc7n+CsbDlFvVE6Rd6V7p4iOAl0l0cwnTlDBw0yU8Uo4LnMBB
	 EMxZHitzT4vpeuLXsaEGDH+eFAyu5lBUgIQbW0ZZLo0w5vKZXgcaM575zrBsYPLSEEA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mCof7OFh;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7B4D606A326;
	Fri,  6 Nov 2026 08:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mCof7OFh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACE021F0089F;
	Fri,  6 Nov 2026 08:23:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793953420;
	bh=ymrZpA8Fy9JtHf0tOEjbIKru6WLcYWV1jdxeTqeYIWQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=mCof7OFhh6WPdXc6ZOc1oB2YKq4sWYk/6d6hqdFst7do13U6MfLOD5VErszqR7qYB
	 eQux1XTChgxk19c50Ns6jkSaVrRygZEs5WMKxpLfOUupTJvst5gG7WHhmeglpgpodo
	 7AX8zhnK/1Fotitw7NklhGl/OiILSSf9KBoYEmKvPaUDcgNTDm6BksoQyDrAPH/1HG
	 4mTBdPtcGEJdL38/1yTmjmD9ZYOWEjYXp/OUDr6BlXyQA2Yd+5oQIs2uZcIi6Tjfko
	 TIXhwStX8+Ln24+ATdAMfZrjjJVaM8wCl4cqsbsemqlJAtpKbzxF9iosGLd/ZtP6Re
	 jaeMUegpgL3lQ==
Message-ID: <eeec310a-a271-4e56-8958-a03318f07e82@kernel.org>
Date: Fri, 6 Nov 2026 09:23:32 +0100
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
 <f74bf2cc-c459-4b9c-ad94-c60afcaed3cf@kernel.org>
 <05798D24-C5A7-41BD-8FDF-F7075F2F0D01@goldelico.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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
In-Reply-To: <05798D24-C5A7-41BD-8FDF-F7075F2F0D01@goldelico.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 06/11/2026 09:18, H. Nikolaus Schaller wrote:
>>
>> Again, please drop inaccurate tag from this patch.
> 
> Ah, on third thought I start to understand...
> 
> Because you look at *this* patch in isolation while I looked at the whole
> series.

I did not comment under the driver patch, nor under the cover letter. I
placed my comment in specific context - this patch touching the
bindings, because you cannot test bindings on a device.


> 
> Yes, you are right - the dt-bindings is not directly tested (indirectly it 
> was because I copied the example from this patch into my device tree and
> it worked). Then, the ADC driver was tested (but not the hardware).
> 
> So this tag should not simply be dropped but moved to the driver code.
Yes, please. Thank you for testing, it is important and should be
credited, just accordingly.


Best regards,
Krzysztof
