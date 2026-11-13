Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.84.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794587144;
	b=WZ9eMgX/tFYXi9mlQyZnaIgXrJCMXQ0EoqnPmCF0KytvTTZXq/tPSgPp3GDNvWPBC7WR
	 lzRS5N275kX9rBkC023LeQ7hH9fNbmTG0JxaXYgdqOVE2BLF6SEHZyLkcRH/Nu/d60UOQ
	 dbTJTc+/RHzbNj48UzDI0p5e5v34wFcBCHy2bPVNTtrVHTqR+ivmcMYRrX1hybfGdP6hQ
	 ipc8JS9Md3FqmtiLf8vo+jWfe6shzBDmTX2dNCew6/dAiPGACNDOjLBdoxjSBkTxZ2Cuc
	 UcIhV745Ve5ocPNfxx0SvvSnB6mS0ieKcNZ7a6lRheY7X3IwQIrpoIAHSrDSmg8dkxA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794587144;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-Last-TLS-Session-Version;
	bh=b7NmDtV0PqprOLTs1md4OfGCm51DCX09C9kORwNtvtM=;
	b=Q8GSZfmkIzjw0FGCwxjbX2oNy9fgTqFwblt79RzNj6ptDUxW74B9hwiwQRaqPzkAWkKo
	 vDjPSiZaITbObiYVr2R/wlGT3c9vnOW4NYTcziSnF5oxjNFKmfUZ3ZXACa8JrS+svVq/7
	 Dxf2mUGd6OnQzlTdZYQlYgFlZKFDvzuxM2qbfr0JeIndaWNOSGGec0LfPo9EYHtQYF8Um
	 V1x6bntiE97mgDYI2Z5sda1XwEdkwWtFgsYBwRWUuk1hI0d9MbSPoXTaq+2nO4YeMTFUY
	 xArSjxvgf0pyNbnCmudr6I8/6OwAAucL1r9YD0jfuCWy+stzz+gdvHVS4LwQBhdiIiQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=OCOuyuwG;
	arc=none smtp.remote-ip=185.246.84.56
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3023606A327;
	Fri, 13 Nov 2026 16:25:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B3023606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=OCOuyuwG
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 2D7F11A1646;
	Fri, 13 Nov 2026 16:25:42 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id EB1B860015;
	Fri, 13 Nov 2026 16:25:41 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 48E1211BC0069;
	Fri, 13 Nov 2026 17:25:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1794587140; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=b7NmDtV0PqprOLTs1md4OfGCm51DCX09C9kORwNtvtM=;
	b=OCOuyuwG5KLMpusWNquL6+4C1/rhbuepLLTbLuKdTKfFdo8RJUl5Ty1HLBbGeDFdl97gEc
	fRxAcfGGQNfPY1udAvHunXuGOt04vOBNX/NPHF2/x1srIul/rjHWPMs3a4wdfvCFzl6yQv
	+6XtvPBdDsHYdGf/1BvKgtuY+iLq6e36qLCoACosoUhmFtGxwLGhHmIEa0dyNtxyF9igBZ
	nusr0CjAo0kOoLWx8dY8I3D6/TiSY0w1w8cJ1OGAtPWHll/FZK2r5t2g3Pbi7bnETN3fDm
	V8EW3DvM8yL3FVcG7G5sHoCHmyvTkeUiXHOjWuG0VlvxM73eMylglAnjOFLRtw==
Message-ID: <1be528e6-9189-42d5-afe5-298be5af6b39@bootlin.com>
Date: Fri, 13 Nov 2026 17:25:32 +0100
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
Subject: Re: [PATCH v4 2/2] iio: adc: add driver for Texas Instruments TLA2528
 adc
To: Matti Vaittinen <mazziesaccount@gmail.com>,
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: Rodolfo Giometti <giometti@enneenne.com>,
 Marcelo Schmitt <marcelo.schmitt@analog.com>,
 Antoniu Miclaus <antoniu.miclaus@analog.com>,
 Angelo Dureghello <adureghello@baylibre.com>,
 Tobias Sperling <tobias.sperling@softing.com>,
 Eason Yang <j2anfernee@gmail.com>,
 Marilene Andrade Garcia <marilene.agarcia@gmail.com>,
 Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>,
 duje@dujemihanovic.xyz, Joshua Crofts <crofts@kernel.org>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 Victor Chernyakin <chernyakin.victor.j@outlook.com>,
 herve.codina@bootlin.com, thomas.petazzoni@bootlin.com,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20261113151543.2241604-1-maxime.chevallier@bootlin.com>
 <20261113151543.2241604-3-maxime.chevallier@bootlin.com>
 <ef47542e-308c-4211-9b42-ba2de13f5f82@gmail.com>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <ef47542e-308c-4211-9b42-ba2de13f5f82@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Matti,

On 11/13/26 16:36, Matti Vaittinen wrote:
> On 13/11/2026 17:15, Maxime Chevallier wrote:
>> Add a new driver for the TI TLA2528 ADC chip. It has 8 12-bit
>> channels, that can also be configured as 16-bit averaging channels.
>>
>> This is a very simple driver, allowing reading raw values for each
>> channel. GPIO mode isn't supported for now, as well as buffered mode and
>> the 16-bit averaging mode.
>>
>> Co-developed-by: Rodolfo Giometti <giometti@enneenne.com>
>> Signed-off-by: Rodolfo Giometti <giometti@enneenne.com>
>> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
> This looks very familiar to me. I am pretty sure I've reviewed this. Is there a reason the RB-tag wasn't carried over? (Sorry if I've missed some change(s))!
> 
> Yours,
>   -- Matti

You did add a Rb tag on V2, but I dropped it for V3 as the delta between V2
and V3 was quite substantial and included changes requested by other people
than you :)

I mentionned your tag being dropped on the V3 cover, but I didn't carry that info
for V4, sorry about that...

Anyways thanks a lot for the help,

Maxime
