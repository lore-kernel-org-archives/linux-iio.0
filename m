Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBDAA33E36A;
	Fri, 24 Apr 2026 16:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777049316; cv=none; b=kyIompuEv9PceXTHRW/sVKrKKsAYzQFCeoAPOWLROBBRiC1DFoilESfxzuK2Zhxx5ilMCFHL/hiZnPoX2DJqiGC8tvHYzJsn/MsWIzeOQrQKP4IFen6J/zmPP/Z3oTSVAiNc+NvObVRz7ZJWRaOJBu1zd/MIrYKVJ79OXFWYQAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777049316; c=relaxed/simple;
	bh=aYxO9NVY0EzrniJok7YG8oRF8dsAo+0G/cL+306ozF4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pv5rxM+fVNUfsleotzHGwN1igclhSF4+mJS+yeT6VaQU6FZ2ahFVWHJfElVstpZskJdAXxwiTzGydDZIrLN5BewXl2kfhctzktdrye5VvTtIHquWv9jL2B7+dRGlm33NeJyyDJDUE57fQFbK6QQpsj5tkz4XXyLftFENSD78C8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dGKaD+Az; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dGKaD+Az"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4546AC2BCB9;
	Fri, 24 Apr 2026 16:48:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777049316;
	bh=aYxO9NVY0EzrniJok7YG8oRF8dsAo+0G/cL+306ozF4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=dGKaD+Azc+MTzATbmEcfNRFbnKwKfQGiJSHL5/YwdnECjk9uHZqgzUyM7AlDqLRxS
	 6o6sjcUd7FiKKxeScMJxA7Tea1CQBjyMhFlzvCcfM/yjJYsbTsWfiEVLQKi7U/JDnw
	 FvmIjW52ZEwgjK97SRNKzV8hXc0cOz/qEzHDuL1xPx98BkcgwH7VtrxYPdwzN86Enk
	 IqVThpbo0xlSwY1Jgp4LM2EeKXxCzml56uXEGZtUuJzubw5Ekud3rSqMg2w5mjP6kP
	 YFhEFHbssHDBT4WNKPggAWN74eHTb22Z+BTfDWMtWkpsFBhAyzArUq7FsrEZHXYBDh
	 EfsIa2AexDDgw==
Date: Fri, 24 Apr 2026 17:48:27 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: <Ariana.Lazar@microchip.com>
Cc: <dlechner@baylibre.com>, <nuno.sa@analog.com>,
 <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <robh@kernel.org>, <linux-kernel@vger.kernel.org>, <andy@kernel.org>,
 <krzk+dt@kernel.org>, <conor+dt@kernel.org>
Subject: Re: [PATCH 2/2] iio: dac: add support for Microchip MCP48FEB02
Message-ID: <20260424174827.363f8b00@jic23-huawei>
In-Reply-To: <3ecc683135c742e097ec6ba91f275cbf5d8202ce.camel@microchip.com>
References: <20260212-mcp48feb02-v1-0-ce5843db65db@microchip.com>
	<20260212-mcp48feb02-v1-2-ce5843db65db@microchip.com>
	<20260215175857.4085bc2c@jic23-huawei>
	<f7f45b4327c9ce5c806cd878bd9b53e8fcbf7785.camel@microchip.com>
	<20260424111920.61765602@jic23-huawei>
	<3ecc683135c742e097ec6ba91f275cbf5d8202ce.camel@microchip.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 24 Apr 2026 13:30:59 +0000
<Ariana.Lazar@microchip.com> wrote:

> Hi Jonathan,
>=20
> >=20
> > The statement above about it not being possible to use the internal
> > band gap
> > if a vref is wired leaves me with more questions about this.
> >=20
> > I'm a bit concerned about cases like:
> >=20
> > Vref is wired and eeprom is set for internal reference.=C2=A0=C2=A0 Sho=
uld we
> > be very careful to not enable vref until that situation is resolved?
> > It might be on anyway but we can at least make sure we are reponsible
> > for turning it on.
> >=20
> > Maybe the chip has sufficient protective elements to cope with that
> > though obviously it won't give sensible output whilst this is true.
> >=20
> > If all those are fine, dev_info() makes sense to me.
> > I wonder if we should return -EBUSY for attempts to read the voltage
> > back whilst in this state as well?=C2=A0 Might provide some additional
> > indication something is mismatched and we don't expect the device to
> > work
> > correctly.
> >  =20
>=20
> There are 2 possible ways to handle this:
>=20
> - Keep the current approach, since restoring a mismatching
> configuration at power-up should not damage the device.
If it were just the device I'd agree, but the provision of vref
is an external thing.  Say some other OS was loaded in between
and didn't enable that regulator, + chose to use the internal
vref (maybe with resistor to pull up or down on that pin if no one
is driving it).=20

> - As you suggested, only read the external regulator voltage at probe
> to compute the related scale and enable the regulator when user space
> first selects that scale.
To me this seems slightly better. Though if the device is actually fine
(if non functioning correctly) with internal band gap on and vref at
max voltage then doesn't matter.

>=20
> In both cases, if you agree, I can return -EBUSY for RAW access until
> the correct scale is written from user space.

I think that probably makes sense if we are in a state that we
believe won't read a value that is correct.

>=20
> I will also improve the current messages in order to ensure the user
> sets the correct configuration before attempting to read voltage.
>=20
> Best regards,
> Ariana
>=20
>=20
>=20
>=20
>=20
>=20
>=20

