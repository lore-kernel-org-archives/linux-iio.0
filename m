Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=62.149.156.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793605033;
	b=oCRxEuroqeBHuan8b0oz97R8Ya/TOTvhqh2JeVN6sjgWlYAQQJNq8JUJArYKXkqqiN8o
	 dtAGuQfB6Z3sxNM/nclg/Os2CqeRFnvScGaEAHbAvRjWcn4m3fjUEfFj+f+zRPHuPcU45
	 svM+czqCmMbxBUWNddg1jSGk3kasqbt6MczIZkvEHDEBkqc4tqcFakjdCrtNwjLYlmg+W
	 fRpQW7gAqG1KqeI/yDViC7Bjm40ZQ1FEppb0wTQC4LsAPXsK4exOz65LLWtzw/hXD1GQP
	 6qPJLpXD7xEyi6lAkvPSPb7VNjtN/CB70TV0ASD56FUZD5Wl9XO6AWyp0HZsil2IDRA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793605033;
	h=DMARC-Filter:Received:DKIM-Signature:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:Content-Language:To:Cc:References:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-CMAE-Envelope;
	bh=xhcWkyQWUr5o7YPJr3rKBTz0NjHWa8qVQZWLF+KmEeE=;
	b=pCezCK+Uuk8NqUnYExal5SlU0Qhk2pvvoxwHtGYyDe1RNoryy9x6vc9clOnYtzuEnOni
	 SWEuyfMx4El68tzuN3Or15aKaI7yPohgcFcFPoX01QvWeHEscVQKuh3ETwxQBjlOAgj7U
	 /hFGGQQvjCWHLTAq46tefp7pXtt6DsJ9LKWGQ2nPZk9VO2i3ieBJ/pl+4qdFW05Rb7sAj
	 v+xFsOk9HDNjzoQMAN5JJjQFXoXoEiL90CCiAtYaooUrx17F85F8aQQwIJXSBQVkEDM50
	 Du9sGP7z+GBxUnmy6CCUR9oY95ndlLhDnbvDuf6EjaCwS+afh5qA8jgm6xXICQz9kqA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=enneenne.com;
	spf=pass smtp.mailfrom=enneenne.com;
	dkim=pass header.d=aruba.it header.i=@aruba.it header.a=rsa-sha256 header.s=a1 header.b=AnylbI18;
	arc=none smtp.remote-ip=62.149.156.131
Received: from smtpcmd12131.aruba.it (smtpcmd12131.aruba.it [62.149.156.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F262D606A327
	for <linux-iio@vger.kernel.org>; Mon,  2 Nov 2026 07:37:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F262D606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enneenne.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=enneenne.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=aruba.it header.i=@aruba.it header.a=rsa-sha256 header.s=a1 header.b=AnylbI18
Received: from [192.168.0.186] ([101.57.122.26])
	by Aruba SMTP with ESMTPSA
	id NmbHxkfRaV5J9NmbHxJSzH; Mon, 02 Nov 2026 08:37:04 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
	t=1793605024; bh=saVY7wfWjYqhW6bPBGHo/DEe3cjEs9f8BoRfe+c4DAs=;
	h=Date:MIME-Version:Subject:To:From:Content-Type;
	b=AnylbI18PEyfQBh1G4nG42CzN5Q/eHvSIDHP7sHKmuTf08UtHGv3O5/RZp1fEsQYb
	 wircYXtMCJpIUlOPBRYinkZD6HbriBpDahkM1PxB1PC/zspqI+egxAnKUqZcbyzN10
	 LkGOfz30VcoxtKHSUmsmCQitIDZvmNCtJujmpL6MYSt6I/LjxbZHWWAW/FpKKx0HdF
	 DXa9i46c4WwU4UB4FeksFNyzw5X5+MWIOp5MCurihv2xBLrLyjC11TwrECQGkus/vV
	 iFW3HClAt847UU19NvmIEqawCyAfEef6iYM585aGKhuTQDj9P8pmgKoDUmTZXrULEi
	 xeiUsQ5UWN8vw==
Message-ID: <e858ddf4-4710-4908-b2e7-d26a68d06fbb@enneenne.com>
Date: Mon, 2 Nov 2026 08:37:02 +0100
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
Subject: Re: [PATCH v2 2/2] iio: adc: add driver for Texas Instruments TLA2528
 adc
Content-Language: en-US, it, it-IT
To: Jonathan Cameron <jic23@kernel.org>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: David Lechner <dlechner@baylibre.com>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Matti Vaittinen <mazziesaccount@gmail.com>,
 Marcelo Schmitt <marcelo.schmitt@analog.com>,
 Antoniu Miclaus <antoniu.miclaus@analog.com>,
 Angelo Dureghello <adureghello@baylibre.com>,
 Tobias Sperling <tobias.sperling@softing.com>,
 Eason Yang <j2anfernee@gmail.com>,
 Marilene Andrade Garcia <marilene.agarcia@gmail.com>,
 Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>,
 duje@dujemihanovic.xyz, herve.codina@bootlin.com,
 thomas.petazzoni@bootlin.com, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261030164705.297354-1-maxime.chevallier@bootlin.com>
 <20261030164705.297354-3-maxime.chevallier@bootlin.com>
 <20261031234848.00248ddd@jic23-hlaptop>
From: Rodolfo Giometti <giometti@enneenne.com>
In-Reply-To: <20261031234848.00248ddd@jic23-hlaptop>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfCHbwW499DCRrn78XsmTi21/wd2BGqm+Vq/lCd1YFZH1tK5d4fTKjVrtFW3ZyX7hk379owkLKK5isgmB0qKkuQoJUJz6A28x5gAWarp02MF9HOq67B/B
 cJWCdwmcOx7R8yjFFM8bOdOK5lx3rV/4PqeOtkiUTOsAndhMcFJgnmB3nbZkoVUyNIlW7TXJ7wns4yyB2gT3jbvKLh//5CXWftv1URmlv7KQ+rXOesAECWEp
 /D4UgiOwZ2Z+kKSdaeAyahsuTuS8buL5rahbE1JGTFsriUjbfcZ+FchfmtXX3osll8QlXCwEQAyGQvFl9bSV2uaebWpIvyRRKqMYNdIQY6tUucQpz2IQ/OI0
 k0RF8slHcQGA/UtinpVVb5bBCf2rd5zWfI4DNS20pWkWl0JSQUsiTZ+3wdVmqjD5juD+jVJ1Ca81gu4GMANeq1NJJwXU5rpR1C4s3tG/bbzTzdODET+G7v64
 GKGMgNFLdTJ3bcMQB5nRm0Eak+6I5uoDR1GfJKQ/6Xudmz4UHC6LtuXs8HWxKdSnmrHTJfjzJGozJt6HmqFvf5OTVHA2lY2iuVIH2/UgpLoRdBSOQ0zHoF4Q
 PSKdWeh6/y848DaleDR5H911o5ssviYVgmW83cE6oOljoUNTMvUT8nN9RZPBRRg+dkqcWRe+QA6v38Cv/9LfdchtqAoALMjLMinVZvbloYHH29FAlz8WR0h6
 dmEMPpd59qvOJQ54UDezUUJQN2gpsdhHaboUVMOFP7MKfaKfN703o7OMAlWWVSbnNWMT5Oj9QtrAGKztbK3jBSrJswxBKLljDNV1ZSKPAosDJM3s9b9/Pi4E
 +5lRJd32LERW+y0ZT6Y8Wv1gYrIbDV5zZt+XOaJQFL3Z0YPk8rVyuLXTAkMAQMlfVyoC+KaUx4Aa/pQNbAs8EMKkyk+YiQ3Jo8L2Hsn1ki39xBh86tVL1XBG
 6zLrxlmikdrTUeabnbr5QgXo5SU=

On 01/11/2026 00:48, Jonathan Cameron wrote:
> I'd also like to avoid propagating the fallback to all channels
> if none are specified. In this particular case it is problematic
> because if you add the GPIO mode, for chips like this, we tend
> to expose all pins that aren't in use for anything else as GPIOs.
> With the fallback scheme you have no way to tell if you want all
> pins as GPIOs.

Agreed. With only 8 pins, listing the channels explicitly in the DT
costs little, and it keeps the door open for the GPIO support.

Maxime, if you drop the fallback, I think the commit message of patch
1/2 should lose its last sentence too ("If no ADC chan description is
represented, all channels will be exposed as analog inputs."), since
it would no longer describe what the driver does.

Thanks,

Rodolfo

-- 
GNU/Linux Solutions                  e-mail: giometti@enneenne.com
Linux Device Driver                          giometti@linux.it
Embedded Systems                     phone:  +39 349 2432127
UNIX programming
