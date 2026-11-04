Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.84.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793791725;
	b=gby5SkjYuJnEyoD+5SczVi+Twg4GudzO612jSSNBABk47V4QP/pQFVepKfW7v3luo41r
	 QPms+vw+2AkBKY80ov/n8zcEVjJBWO0ELUA5YsxIEmNG+z3aeOLLn9eE3J+xPleNFxxom
	 1xvhRrrwKtC9sQRvFz/LuWPpS7CZiRuyJmTZADXN6jN/KxZz1zOcP6rUfscOt9F8D/Kkx
	 uGGrB3K9tUoSLTczb4VMaJTBWBKjG4uQD04JZeY5W1yBM3eGIj2Rfju2DyRXJUqYJJ4Yk
	 NTuk91TEFOwNRkl7zJAuaqs+kjlJPOt6B6czLWPqtVluuuwevmdCc9HxPsGtVK6dxQA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793791725;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version;
	bh=spCiuAh3BQ8nXdC6c0i6ZhkNUB0OuA4C80t+dWzUXPU=;
	b=q9lSmrERjY0cnU27Yo61R7RLefnNBW+8cKaFpbBnkz+14bcrGh9osnWooxyVHtRvwhvh
	 HBhKaAOtc3iNoXlrDoOHBWzlz7fzqfl/YSl6D5nbDmGM3GhNrI8v4zkKTtpN49IbEtQlE
	 6d+rRQPxHyCNqDLGsYKN8Bninp0EJE1+e1tlbqcUn8bpJuZAZYo7AVvtKu8iY6WddLE8x
	 HGQKhUV8jkKwzWGIfonT2ZWEJGMMos76NPX2258nhK1pr1qu46SCm7T1n8l0tXpmJfEwx
	 BDvk2JjxPY4KyT2Jy3d0Zq7IolE4j7NdZMJazV8dWHjHCimbZUZKhiijMaADF4jz4Gw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=yJPMA1XF;
	arc=none smtp.remote-ip=185.246.84.56
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25553606A328;
	Wed,  4 Nov 2026 11:28:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 25553606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=yJPMA1XF
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 84D3C1A1451;
	Wed,  4 Nov 2026 11:28:40 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 47FCD60770;
	Wed,  4 Nov 2026 11:28:40 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E0FC1103291D1;
	Wed,  4 Nov 2026 12:28:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1793791714; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=spCiuAh3BQ8nXdC6c0i6ZhkNUB0OuA4C80t+dWzUXPU=;
	b=yJPMA1XFx4bUB0CaN4PHH/frMh5h5ylQggTVajK7+Gw0WjyU6+jGBt8rkPgeY7R7Pb0mfq
	l2diMYv6krooVzUOOv/lFb2UiLnhB5RfsdrK75D/EYQKNujofSLSd3bFhBu1Gq5bnX6Gbl
	DMZsK+hRTnbIKWgglkyQnByBkBQHZ4Sooqzpd3/D/BQWfSWbBF8hRNX/lgiKr1hw4lgrYD
	t0wzyg5VzKji3e1rGeCTYYLa6Z+doe6c8TzCkMeodPCSy78B7E6iAnaQWO8RnAxmWYyR+r
	xB2036/6DXXrF2eTw5s9U66yMpmILvdYwTWt7fbvpltlZIsDMjilS6EaYiMR1w==
Message-ID: <3ec7364a-3373-489e-99aa-38723a0f7b17@bootlin.com>
Date: Wed, 4 Nov 2026 12:28:26 +0100
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
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Matti Vaittinen <mazziesaccount@gmail.com>,
 Rodolfo Giometti <giometti@enneenne.com>,
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
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <20261031234848.00248ddd@jic23-hlaptop>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Jonathan,

On 11/1/26 00:48, Jonathan Cameron wrote:
> On Fri, 30 Oct 2026 17:47:04 +0100
> Maxime Chevallier <maxime.chevallier@bootlin.com> wrote:
> 
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
> Hi Maxime
> 
> A couple of minor things inline.  At least one due to cleanup
> that happened tree wide in the last year.
> 

Thanks a lot for your reviews, I'll address those in V3, I don't have
any objections on them, it's all clear and straightforward :)

Same goes for Matti, Victor and Rodolfo's comments, I'll just keep the
Kconfig help message consistent with other drivers.

Thanks,

Maxime

