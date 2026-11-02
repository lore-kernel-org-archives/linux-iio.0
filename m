Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793615112;
	b=2yEHQxWPSYtZ/ro64lG/aevJoNtXjw4QfD0lQIGvG1xKj6VZ+FjoLf23/guydkGX/wUU
	 G6WiNzADFFNjEszFPPFMZXcTO9OnS1YgFoAhJh/01EAfimsRvaNRsOdy43QTmjb7aEbKP
	 RyS5MeDgYNCK3Scz4JGtsijUHQD5KFxikFKzUsTV6ZvzsuloEOe7E1ORusHBkpPJHe/aL
	 Lks5iiq0xgik6JiDVOx+X19OoTyKQhYdGbdK89GicYR3RDHuulrtvTzPzZa9IBTQFIyp3
	 s124lHBTZMPenL37KM1KUVz1tR0vjrVXis2BMBd3uYlfwtaCQjfXbI5yCiB1hdQkv4A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793615112;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=5or754KcT3/otpjX2Fvbrx34Bn91ddEOXVq/C0WH8VQ=;
	b=PKdfNLqnJSAMeY0dECwmnz45OnMn5lnYyKnYEqcckC5+s4ZSWET9SVAGq8kxAsgYkH4O
	 AIZ8NAhh08LmWssarMjO3YKYufBcboJEJXZHVqq3LjOWeqgyav244zasr0/cBBW4D8kth
	 MeP405QKg/jIrCcQXe9zbjP7qUqLPEJ/uxKNTLlJM3IBhQSdqtcIloidmARIXSbq9JLC9
	 bo8aSwUhMkmzU6BeCgqEhJsUGUBJVhtmEFXUX4VRuRZbjV5IZefPuAEtfXCT9J/1maVYI
	 182kA+U7uDuA+jLyKxTwoE1jnTWsrEjImSSKRKgZW8yID559SqEMBr8LeYaqBW8f2Mg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G+F6OucH;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2FE8606A327;
	Mon,  2 Nov 2026 10:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G+F6OucH
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=90.182.112.124
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793615111;
	b=ZLRJU9JP4xVRelCq+U7W3iE6YCK6yB9GU19aiXUQtLLS+oOA1/SgVVIRPK+lHLGE1VWL
	 8nTQZ1AZNjJHbKvF2u8pGRfwcQRNnenQTpN5IuZuqmxFJHxSInk33MpF5RS2F8hM1btnF
	 Pr4b0r7vrODNCP+5eA2j670KXxHknF+oGynlSo9yLnghk6Ihy1N9snBDQVYlx2AmCmbY8
	 0w2A/O+/8/h8lUHlQH13VvsVK1oMND1ZK6qJ0fmEEaW51aFf8cFiSexwWmxgDR32dqEqp
	 XQA9RgNy+Z3bmPSXkXlXDgm5dsqd7Hon/PPeatr6EJ8ih321/9T5V4qyz0M7Mdgvc0w==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793615111;
	h=DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:In-Reply-To:
	 References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=5or754KcT3/otpjX2Fvbrx34Bn91ddEOXVq/C0WH8VQ=;
	b=OXfHkn4Or1H2wtPiqWnbF9Enfd0FMI07iFHGgQopDXiOh5EbFxazpQEYZT1EwoOIwUDv
	 JWEEjDYOdFUKGPcj89MYUeKi/d5P9YSOmmbAHt8WoahlO7ou02fF8/vazWMrwYmAxdhTr
	 uOzDc2rJkcoUHujx7KsNsjNPM6NP+I9xilGIf6GgXDSsgJxmi66LdHzsZwwAJvXxW8zMk
	 R0ehAtDPUsBBcGlk5PW++aRPB2ZObS10ofmXJMrzptASHhbuJmyF/BLGQE7f2T4pc82AB
	 eAXt8gSlBoyn5ebIJDW1kFRtJNUm9z9K85g4sBQZdENLBSfyjBWNwLdzudC94JID7NQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=90.182.112.124
Received: from localhost (90-182-112-124.rcp.o2.cz [90.182.112.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPSA id 595501F00919;
	Mon,  2 Nov 2026 10:25:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793615111;
	bh=5or754KcT3/otpjX2Fvbrx34Bn91ddEOXVq/C0WH8VQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=G+F6OucH7Gj1XAiqa5Dd2ngzExKIQPBHNBynO/DBjrCEb50F7TOaxZokYMtrXhYzn
	 z613BKT+mLJ3Iob6jwLWoyJ42JzRybD2p4oU1dJMnhMFRBoryFCmIiEHg9J0a5JAD1
	 YyrPd2c6J/+BwyW8Lr2Hqd8w25Fz1UVqKJhAsVwmBPYdqfszAO0ez4C3P2LGYMO0hx
	 yaS4iYAoa2FJGF7jpEaA1kZ50hTKF15oesGu0x+rUN02jolQuIN0sP439LntJ6g5D+
	 jXOKr6kDnFcFaAJjSyC3QKptLcvUKj7t2vxw9R5irK3SK31BfX22y7Lpw0PaUO0iHG
	 DMuldCTt6qJEQ==
Date: Mon, 2 Nov 2026 11:24:59 +0100
From: Joshua Crofts <crofts@kernel.org>
To: Jaakko Koivisto <jmatko@utu.fi>
Cc: Andreas Klinger <ak@it-klinger.de>, Jonathan Cameron <jic23@kernel.org>,
 David Lechner <dlechner@baylibre.com>, Nuno =?ISO-8859-1?Q?S=E1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 5/5] iio: chemical: sgp40: Implement
 turn_heater_off-command
Message-ID: <20261102112459.00001dc7@kernel.org>
In-Reply-To: <20261102095602.333752-1-jmatko@utu.fi>
References: <20261102091258.247402-1-jmatko@utu.fi>
	<20261102095602.333752-1-jmatko@utu.fi>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 2 Nov 2026 11:56:02 +0200
Jaakko Koivisto <jmatko@utu.fi> wrote:

...

> +static int sgp40_turn_heater_off(struct sgp40_data *data)
> +{
> +	int ret;
> +	struct i2c_client *client = data->client;
> +	struct sgp40_tg_measure turn_off = { .command = {0x36, 0x15} };

Reverse xmas tree.

> +
> +	guard(mutex)(&data->lock);
> +
> +	ret = i2c_master_send(client, (char *)&turn_off, sizeof(turn_off.command));
> +	if (ret < 0)
> +		return ret;
> +	if (ret != sizeof(turn_off.command))
> +		return dev_err_probe(data->dev, -EIO,
> +		       "i2c_master_send ret: %d, expected %zu", ret, sizeof(turn_off.command));

Again, this function isn't called from probe(), yet it uses
dev_err_probe().

-- 
Kind regards,
Joshua Crofts
