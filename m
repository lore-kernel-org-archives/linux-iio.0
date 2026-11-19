Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795059167;
	b=NBVkwHK7VheqhMzHg4iKguqgp8B0rAJOdxdqEXWQI+ZEVp7hOdCGR6ee7LVIKBz34oOE
	 E6NGdGmCjC31slgwvIGYbLHaJjE6oCRXnUkn6YK4sm7CGPAj0N8wOYWeuV+Ot/HRTWgsF
	 A1kk1jAnvc8yuDT8/STBupTbLMNJa1ILHl0WAJmVo17XPzXW5cxe7hkyt9UIQ/XxmblDl
	 zQlmZWOSr33c1exvpqMVxjNmja1v+//QH2Fg7uy8Dg1htmBCAymGiokQdQKPl9A2Wu2Qn
	 s89Si9xHyMHHAp5h4RZyYgZDpRhSFCYbE4e56BvmlmXmM/41bbAMI5BC5rPRj7sgLlQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795059167;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=ePtiKlI4ZDgj9mw/721LgK0nSBL2vAT6x8ZIVWrD8iE=;
	b=CzOy3QYpteFQbjNCM+dvvxwdJGltXKrKTf4iwDtIYnSEY7/R5LTq6azRTQ9yPFdiNJwE
	 ggMYaARR9J/bYqVHWz5pAV6/z/mELs09c5+XPu28DGM7m07cG2dwkRxwfZoCQFXw02vFH
	 4rydU2CjHAp/PHsURP7nft65TEpsggIUMkm5HsKqmRlR6pAqwnS3Op/YYY14y6/BH4oW0
	 PMMXiSt3dcpxorkWH9hUJgbMh4V4vLdCYN+G4MEnUtKE6H2pnTlNJTi2Wp4sY4ZJw3gnP
	 60ky78FsoDe3Xftz9GknuN4ORqSylH648+B+kTCQuAZ+/2mf3wIrCrFF9Dslt+sfHVQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gvg4v9pV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EBDB606A320;
	Thu, 19 Nov 2026 03:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gvg4v9pV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A236F1F000C4;
	Thu, 19 Nov 2026 03:32:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795059167;
	bh=ePtiKlI4ZDgj9mw/721LgK0nSBL2vAT6x8ZIVWrD8iE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=gvg4v9pVfic3NMx5pYYVG3Ayk/7HITe4sSOS1bwbpJnpnOjby2AR9doQ0JHx85p4o
	 K8oIXENAahQ7UWZahlEsRypMfylgZQU+A141Ie0Le1lGJfgTaXmLxA3FdgJxCRZu8l
	 xKz9WAd9m7X387uSyYdhGswTPm+A3P6GQTSo5FuJhdH25vv6raPM+Z7+pyhDQid+u5
	 LVXNjHfR91CYwv+sqOo+MR7YdPAR+A2Mf2xFcf/+B+07phsMVShbxoAnnqJET/KZEn
	 L/g32bq0b6pCGHmThrj21mqJ5X3I5NvpzJ9tqhQfBGyhAsDGs5Vsn7tMb8FtCOynEg
	 lZaQq6grw4V4w==
Date: Thu, 19 Nov 2026 03:32:38 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Joshua Crofts <crofts@kernel.org>
Cc: Roman Vivchar via B4 Relay <devnull+rva333.protonmail.com@kernel.org>,
 rva333@protonmail.com, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/4] iio: light: stk3310: add vdd regulator support
Message-ID: <20261119033238.39bff7a7@jic23-hlaptop>
In-Reply-To: <20261118110138.000003ab@kernel.org>
References: <20261117-6768-stk3337-v2-0-92f4c7be3bc6@protonmail.com>
	<20261117-6768-stk3337-v2-3-92f4c7be3bc6@protonmail.com>
	<20261118110138.000003ab@kernel.org>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
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

On Wed, 18 Nov 2026 11:01:38 +0100
Joshua Crofts <crofts@kernel.org> wrote:

> On Tue, 17 Nov 2026 20:08:37 +0200
> Roman Vivchar via B4 Relay <devnull+rva333.protonmail.com@kernel.org> wrote:
> 
> > @@ -745,6 +746,10 @@ static int stk3310_probe(struct i2c_client *client)
> >  	device_property_read_u32(&client->dev, "proximity-near-level",
> >  				 &data->ps_near_level);
> >  
> > +	ret = devm_regulator_get_enable(dev, "vdd");
> > +	if (ret)
> > +		return dev_err_probe(dev, ret, "failed to get vdd supply\n");
> > +  
> 
> IMO this should work, but I don't like the mixing of devm_* and non-devm_*
> functions, this may cause issues down the road. Consider moving the driver
> to all devm_* functions?

In this particular case I agree with you because the conversion is very
simple.  Generally the rule of thumb is that devm from start of probe
until you decide to stop, then no more devm.  In that case the unwind
order should be correct.  This change doesn't break that, but the
driver already breaks this wrt to the interrupt, so if Roman
doesn't mind would be great to fix it whilst touching the driver.

Jonathan


