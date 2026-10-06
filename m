Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7814A530E14
	for <linux-iio@vger.kernel.org>; Tue, 13 Oct 2026 17:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791914139; cv=none; b=nZXCX07D388zIZXmYWQigFtYxnMED0AfpZUCKSydeKC/IdJdgsxpCYgfVSiml99+f+xLPtT9PfZgccRT9jJkJnAW3djnq5PmuTt9+q6i+MLvOVotO6Po8mxakxFrG/Ij4lqGgQcQNU1As3Co4oEZUZUMLai9RePtSwzmQiE28R4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791914139; c=relaxed/simple;
	bh=N9QDoNjH7SQ2a6fTr+DM4BznMS1QQy9nCHm80PlOj4I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YlWcaFuWuWotanTAElKWv7c9Orff0+tWz6gHY7X5JISaYMRoJqwDez531P6sB7HvThsgZogdYWfMyrDAxW2ZsBsd8+HhTxvpc69Q0wW3AJd0pyHvsSkBbHUpwyMQhNbVRVzg7Lcypg3fklYDVe9NUfEZssQsUW9MvQKZu077JmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=cy48IUzn; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="cy48IUzn"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 734E7C653FA
	for <linux-iio@vger.kernel.org>; Tue, 13 Oct 2026 17:56:31 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id D064260362
	for <linux-iio@vger.kernel.org>; Tue, 13 Oct 2026 17:55:35 +0000 (UTC)
Received: by mail.galae.net (Postcow, from userid 0)
	id 7C70111D71892; Tue, 13 Oct 2026 19:49:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1791914135; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=AKYKWw8yRJADG0ZqwchQesW4ZpXy14oTpfFHmw5LWn4=;
	b=cy48IUzniLllL3YScDFy6LNEREjzAQAt92LWyyAP96Rk/wFebaMIWkjL+SIa5VVhpWdBZi
	4IYjbvSag2xUX9oOYiJ4HNm3a9c5uLweGhcDgDr7QW/b9/HImeeNLCPow9d+5F2iGlaHfg
	Qieg0b6ZqCAl2lCewRHzcIoJRVnG8Pct3EthfNhivTPUQT5+2xlnMbsIkG9nQLzMhCqQGZ
	Eiy3AXRigaivPUBDUYnfEeAfzBKio4qhh1gDstLgsMv/TXAk1/Dg9uU92eM+6QM0t4CZpg
	hyHtk7FO4VAJxnJy6iqOzBfhDe8U0FVNMcfPQHwsMTDeVstPL3fDneVLhjzWGg==
Authentication-Results: mail.galae.net;
	none
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Thomas Bonnefille <thomas.bonnefille@bootlin.com>
Cc: Puranjay Mohan <puranjay@kernel.org>,  Jonathan Cameron
 <jic23@kernel.org>,  David Lechner <dlechner@baylibre.com>,  Nuno
 =?utf-8?Q?S=C3=A1?=
 <nuno.sa@analog.com>,  Andy Shevchenko <andy@kernel.org>,  Rob Herring
 <robh@kernel.org>,  Krzysztof Kozlowski <krzk+dt@kernel.org>,  Conor
 Dooley <conor+dt@kernel.org>,  Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>,  linux-iio@vger.kernel.org,
  devicetree@vger.kernel.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: temperature: tmp117: add support for HIGH and
 LOW alerts
In-Reply-To: <20261005-add-tmp117-notif-v1-2-c6cef6fad64c@bootlin.com> (Thomas
	Bonnefille's message of "Mon, 05 Oct 2026 16:44:20 +0200")
References: <20261005-add-tmp117-notif-v1-0-c6cef6fad64c@bootlin.com>
	<20261005-add-tmp117-notif-v1-2-c6cef6fad64c@bootlin.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Tue, 06 Oct 2026 16:09:16 +0200
Message-ID: <87se2ihqer.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-TUID: Qka5b1aiBGbP
X-Last-TLS-Session-Version: None
X-Rspamd-Queue-Id: 7C70111D71892
X-Spamd-Result: default: False [1.78 / 30.00];
	SUSPICIOUS_RECIPS(1.50)[];
	DATE_IN_PAST(1.00)[171];
	BAYES_HAM(-0.62)[76.19%];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_COUNT_ZERO(0.00)[0];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	BCC(0.00)[];
	TAGGED_RCPT(0.00)[dt];
	DKIM_SIGNED(0.00)[bootlin.com:s=dkim];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	MAILCOW_DOMAIN_HEADER_FROM(0.00)[bootlin.com];
	URIBL_BLOCKED(0.00)[bootlin.com:mid,localhost:rdns,localhost:helo];
	TO_DN_SOME(0.00)[]

Hi Thomas,

The code overall looks fine but I have a couple of style improvement
proposals.

> +
> +	/*
> +	 * The threshold is passed in millidegrees Celsius as
> +	 * value =3D val + val2 / 1000000 (val2 holds the fractional part, with
> +	 * the sign taken from val). Convert it back with the same LSB ratio:
> +	 * raw =3D value / (TMP117_LIMIT_LSB_NUM / TMP117_LIMIT_LSB_DEN).
> +	 */
> +	tmp =3D (val < 0) ? (s64)val * 1000000 - val2
> +			: (s64)val * 1000000 + val2;

                        ^
Usually operators stay at the end of the previous line

> +	tmp =3D DIV_ROUND_CLOSEST(tmp * TMP117_LIMIT_LSB_DEN,
> +				(s64)TMP117_LIMIT_LSB_NUM * 1000000);
> +	tmp =3D clamp_t(s64, tmp, S16_MIN, S16_MAX);
> +
> +	return i2c_smbus_write_word_swapped(data->client,
> +					    reg, tmp);

Overall the wrapping looks too aggressive in several places

> +}

...

>  static int tmp117_probe(struct i2c_client *client)
> @@ -208,6 +343,16 @@ static int tmp117_probe(struct i2c_client *client)
>  	indio_dev->num_channels =3D match_data->num_channels;
>  	indio_dev->name =3D match_data->name;
>=20=20
> +	if (client->irq) {

Since you're adding the binding for it, I'm surprised the irq already
exists?

> +		ret =3D devm_request_threaded_irq(&client->dev, client->irq,
> +						NULL, tmp117_interrupt_handler,
> +						IRQF_ONESHOT, match_data->name,
> +						indio_dev);
> +		if (ret) {
> +			dev_err_probe(&client->dev, ret, "irq request error\n");
> +			return ret;

Isn't dev_err_probe() return ret already? so return `dev_err_probe()`?

> +		}
> +	}
>=20=20
>  	return devm_iio_device_register(&client->dev, indio_dev);
>  }

Thanks,
Miqu=C3=A8l
