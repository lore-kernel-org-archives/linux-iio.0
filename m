Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AD37379C3C;
	Thu, 10 Sep 2026 03:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789011842; cv=none; b=Asq9tLU8KQVxAHsDdWRQnyLILxp+44Xk4fOEEFtpZE5HiJb/FmBfgsvTRcUh2Uyx7te1zLc5xVmcD9+Xwm0FQMdXFnEOt7g+4rE/ro8U+hKzMv1o17qxwyU2noQPhxM7jg9U5ChAAtoLsGdpxJNd+6VD9VeI4CAIpBjY63cGG6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789011842; c=relaxed/simple;
	bh=aHFXpjcIZQG9vX4kBkqYBeDw2g/hbR70cFKTn0d5m1I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Pmyj7FSd2f/SPCOQ4R9SXr7DUTgKtDe0oVQcGzrUUcSxlKzJn2UCmc2x83o+O1zxKkq9BOEM95jC5cmP1E8PQBLerhIu9L3Myy0srEnqo4aIq4OtIUFbwhRy7EUCldWvSayr2XXAOMPsCtiVbRKkJmKtmqULxeFy+3e/FfiJAJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IucH3r1E; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IucH3r1E"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C52B1F000FF;
	Thu, 10 Sep 2026 03:43:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789011840;
	bh=ANNG6DdUCxlYuWMbFzSeAUQzUyNQIbPodMwECaISSB4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=IucH3r1Ew0YlN89WQk+tOagjPY3acAnwOL3bFDIRIpdNtGQw2KR9pyHhwzq4hkPLj
	 tEfMzgCNrxRe/3v53B5YCaK/lfCX7/Nc5xLdPmohUr+IT+MxZnU9P59Z9hYD23OvCE
	 ounljH69wE6SrXwhESgwIlcn7Q7uScbxImgqm47RziwUYXFXTxbCp2j5qzVwPb2z1m
	 NL/OtgNE8wFVU7i7/7bljfc4fL1sjbSZoWiHrJDovqLFUBiaZb5ApxnwqJtf+tZ0PS
	 Z5g4fIDH0nw80p0eTXKbN3/omAZL+rOdnaQy4FowCooE/g6XENKGukeEBORrIkM5BW
	 Sr1RxE2KqYn5g==
Date: Thu, 10 Sep 2026 04:43:52 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Janani Sunil <jananisunil.dev@gmail.com>
Cc: Janani Sunil <janani.sunil@analog.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Michael Hennerich <Michael.Hennerich@analog.com>,
 David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Olivier Moysan
 <olivier.moysan@foss.st.com>, Philipp Zabel <p.zabel@pengutronix.de>, Linus
 Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Michael Walle <mwalle@kernel.org>, Randy Dunlap <rdunlap@infradead.org>,
 linux@analog.com, linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
 linux-doc@vger.kernel.org, Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?=
 <u.kleine-koenig@baylibre.com>
Subject: Re: [PATCH v6 05/17] iio: adc: Add AD7768 and AD7768-4 core support
Message-ID: <20260910044352.6241504b@jic23-hlaptop>
In-Reply-To: <21704002-3bc7-474a-9e27-dd9b7f01a4bb@gmail.com>
References: <20260904-ad7768-driver-v6-0-e4378f946bfb@analog.com>
	<20260904-ad7768-driver-v6-5-e4378f946bfb@analog.com>
	<178866660277.3402141.13365217395986099796.b4-review@b4>
	<21704002-3bc7-474a-9e27-dd9b7f01a4bb@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 7 Sep 2026 13:25:53 +0200
Janani Sunil <jananisunil.dev@gmail.com> wrote:

> On 9/6/26 05:50, Jonathan Cameron wrote:
> >> Add core support for the AD7768 and AD7768-4 simultaneous sampling ADCs.
> >> Configure supplies, clock and reset, use a custom regmap bus for the SPI
> >> protocol, and parse the enabled channels and input buffer settings from
> >> devicetree.
> >>
> >> Connect the converter to an IIO backend for buffered capture with CRC,
> >> provide a fixed safe wideband sampling configuration and add runtime
> >> power management.
> >>
> >> Signed-off-by: Janani Sunil <janani.sunil@analog.com>  
> > ...
> >  
> >> +
> >> +static int ad7768_get_enable_vref(struct device *dev, unsigned int index)
> >> +{
> >> +	const char * const *supply = ad7768_vref_supply_names[index];
> >> +	int refp_uV;
> >> +	int refn_uV;
> >> +
> >> +	refp_uV = devm_regulator_get_enable_read_voltage(dev, supply[0]);
> >> +	if (refp_uV < 0)
> >> +		return dev_err_probe(dev, refp_uV,
> >> +				     "Failed to get %s supply voltage\n", supply[0]);
> >> +
> >> +	refn_uV = devm_regulator_get_enable_read_voltage(dev, supply[1]);
> >> +	if (refn_uV == -ENODEV)
> >> +		refn_uV = 0;
> >> +	else if (refn_uV < 0)
> >> +		return dev_err_probe(dev, refn_uV,
> >> +				     "Failed to get %s supply voltage\n", supply[1]);
> >> +
> >> +	if (refp_uV <= refn_uV)
> >> +		return dev_err_probe(dev, -EINVAL,
> >> +				     "Invalid reference %u voltage\n", index + 1);
> >> +
> >> +	return refp_uV - refn_uV;  
> > Do we never care about the offset inherent in where the negative sits?  
> 
> The absolute REFx- voltage does not introduce an offset into the ADC transfer function. The datasheet defines VREF as REFx+ - REFx- and the LSB size as (2 * VREF)/2^24. Zero code remains at AINx+ - AINx- = 0.

Fair enough - I'm not sure what I had in mind.

Jonathan
> 
> Regards,
> Jan
> 

