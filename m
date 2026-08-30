Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A414276041;
	Sun, 30 Aug 2026 01:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788055070; cv=none; b=jgFdXoe3GyW9MshbgQESqbw7o5fCXXS9/mFjn6aTU581ArLkZZ9Hz/WRI3qvx4syJ68R4EyNCnCnBpQ/Hvny29jjGQPCrMnBqZKVnRW+YAlH9LX0ueI7bB29bDR34qHAAotn8OiyN/q+69gTmrBjkcVdyadgtZVfTqbrjgwTBcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788055070; c=relaxed/simple;
	bh=u3E41Z+YKjXyLtxHlZDjpEOydnQ4rtNWatB8xFHkFZk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eTqjhnTvgzgqpLCt6rcHIqrc6G6cDt+nPbzwXBN60OpxKS1379Pk2WrbeRC17Tz9VXJ7IKHToe07csMjbjgnNwvwWq/sX5ek47N1Qgf3j+qq2XmdOLcn+VwKXyc92goHCu4dzMpq6nm4YGjywzSJDygHR2Aa0wsikU5Da56Qby4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oQJW1YO7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oQJW1YO7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 414091F000E9;
	Sun, 30 Aug 2026 01:57:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788055069;
	bh=e0JhEpC2MchROPqnxxS3ZC7QejhZgB0QtqKA3dM7w1o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=oQJW1YO7flgMwxqLGk4V8v79foQVQ/aVN6jnW+W7DDOfqJi1hL74UIPBZ2onnbsXw
	 ec6F/+/8F9EjoK7YoRgvbXQ6zH1bYRZjzlg6H0jr9XPXbMVQ6Dnn0qHzSnxo2ggKdh
	 2DGTiQICavq1Ve+3S+gKQUuvg8J3wkAEmhQ5kR1Ue8X+/991Un0rY0maDENZ50Wbps
	 ZyrZ7qY4GMxg0sz6WShgzqBFRhUfRs7ZIocVnPNWpuBclf4e5MhaTPtgu3GoRk4cHB
	 TteBwXL1wwBwgsAKmoniomKfeG7uZjnlUihL+ACyDWDKRt27Es8lZEOT/1WDzNmSEu
	 GLf0pLSOpd4BA==
Date: Sun, 30 Aug 2026 02:57:43 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Conor Dooley <conor@kernel.org>
Cc: Kurt Borja <kuurtb@gmail.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, David
 Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 02/10] dt-bindings: iio: adc: support the TI ADS126x
 ADC family
Message-ID: <20260830025743.70dc65e4@jic23-huawei>
In-Reply-To: <20260828-cartel-willow-9592e4e8b912@spud>
References: <20260828-ads126x-v4-0-1dc27e9c0260@gmail.com>
	<20260828-ads126x-v4-2-1dc27e9c0260@gmail.com>
	<20260828-cartel-willow-9592e4e8b912@spud>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

> > +
> > +  clocks:
> > +    maxItems: 1  
> 
> clock doesn't appear mandatory, what does it do?
> 
> > +
> > +  '#io-channel-cells':
> > +    minimum: 1
> > +    maximum: 2  
> 
> What's the use case for actually setting this as a single cell? Kinda
> confused by it.

Part dependent, but I think we should just make them both take the two
parameters and have the value of one of those fixed to 0 for some parts.
Probably easier to understand that way at least.

> 
> Otherwise, quite frankly, the binding is too complicated for me! I'll
> have to leave it up to the IIO folks to cover whether what's being done
> is sane.

I'm rely on David to take a look :)

To me it looks mostly fine but a few odd corners where I'm not sure
how things are supposed to work.

Jonathan

> 
> Cheers,
> Conor.
> 
