Received: from mail-06.mail-europe.com (mail-06.mail-europe.com [85.9.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25148341062
	for <linux-iio@vger.kernel.org>; Thu, 13 Aug 2026 03:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.9.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786591538; cv=none; b=DuBW5NKgFY+z/wkH1gF9MfaXEcIEDA+63E4kbd5zY+SK65ZH4RxTaSx1scxycQfarcpDMI/9cNxuvN01KZTBGuj4eqF1DdPSUI3r74oAEPB5gscSlP65GFHtbPfwOk2B+cCRZCYUpL1vhPLK+1oz1Y14OaI+qQhczuqTOphgLog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786591538; c=relaxed/simple;
	bh=jAKSlg8XPD6jZTuYNbxnZiQ8D605E2mw5Sq2rr8obDk=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T4SOlIS3a84VH9pgWJ62TMxanb/ivY05lcNXuUrLPGUVkdBf0uRLEpyXvZxRukXhhZGfQqjOwJrsgbWDm+JX3L2RPz+tVZZNsUkqFlXxUotM/QHTVt7NkXUCCUOAmsjJALfo2QAN0QpPlXleU2GNbUk/Oi+NZqXl8sVRN6jLqWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ranostay.sg; spf=pass smtp.mailfrom=ranostay.sg; dkim=pass (2048-bit key) header.d=ranostay.sg header.i=@ranostay.sg header.b=1zzDW9l9; arc=none smtp.client-ip=85.9.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ranostay.sg
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ranostay.sg
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ranostay.sg header.i=@ranostay.sg header.b="1zzDW9l9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ranostay.sg;
	s=protonmail3; t=1786591525; x=1786850725;
	bh=swtaVwfi/0t61uvACDpQkQTcnrGpGE1uy8RSGqVXwMc=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=1zzDW9l9GyFpJBtjABgcYssOQ0lbDGLYz+Qgnjj3Ac13/AUcBvOBDuLleQJ4p010D
	 wULFuCAJDogTVJm/wLKvlhIBvGAWWH4uMW1MwWD/vqFGqcLZ00ktG/tfDWKd6vPSpe
	 KaA7uczMK5euQjFYCxoWdII2bNLzhIZF6NskU2mLj4zRYHf95X97rTPhXtWz5n780N
	 0+JH6jblXYQnh91CYBvXxPNYNU1e6bU/+NF6nxOvaayDUFD+6fi6Iai3a0AhLUQgL0
	 K+EQ9/LlZLWyEZMiaQHNfVh0YojXXKD2F7QPz+H0WrZzxArUiodCkvRiNJW4ZuRkVC
	 VEYNO4kzrm23A==
Date: Thu, 13 Aug 2026 03:25:20 +0000
To: Marco Chen <marcochen.dev@gmail.com>
From: Matt Ranostay <matt@ranostay.sg>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, skhan@linuxfoundation.org, linux-kernel-mentees@lists.linux.dev, pmeerw@pmeerw.net
Subject: Re: [RFC] iio: health: max30102: proximity power saving TODO and datasheet history
Message-ID: <aKjPzpTxFtOOSb5I3IU9e-JHMyOPlI2HKNFuNLIxdtinaIYkAeMLLy4PKFmSYr811ioZiVflEFjVYwAqdRX3jJy271WGUgM1GSLU_Byw5fs=@ranostay.sg>
In-Reply-To: <any69uXah07eA8lR@xiaolong>
References: <any69uXah07eA8lR@xiaolong>
Feedback-ID: 87502384:user:proton
X-Pm-Message-ID: 9502b9064953691956fd13ce3ecf5a62bc6936f4
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


On Thursday, 13 August 2026 at 02:27, Marco Chen <marcochen.dev@gmail.com> =
wrote:

> The proximity power saving TODO in max30102.c was added in the original
> driver commit b3c590ce14b1 ("iio: health: add MAX30102 oximeter driver
> support") in Feb 2017. At that time, the MAX30102 datasheet documented a
> Proximity Function and Proximity Mode Interrupt Threshold register. Both
> were removed in revision 1 of that datasheet on October 2018. The MAX3010=
1
> datasheet did the same in its revision 1 on June 2018.

If I had to guess the power-saving was such a minor amount that I didn't bo=
ther
with implementing it, and it being dropped from the datasheet probably back=
s that
up.

Thanks,

Matt

>=20
> That also explains the PROX_INT defines in max30102.c, as they were
> correct in revision 0 of the datasheet when the commit was made.
>=20
> Since there is no current documentation for the proximity function on
> the MAX30102 or MAX30101, I don't think this TODO should be implemented
> for those parts. Does this seem like the right decision?
>=20
> However, the feature is still well-documented on the MAX30105. Is
> proximity power saving worth implementing there? I don't have a MAX30105
> but I am more than willing to purchase one and develop and test on it,
> and I have access to a logic analyzer to verify the I2C transactions.
>=20
> For the implementation, I would add MAX30105-gated defines for the
> PILOT_PA (0x10) and PROX_INT_THRESH (0x30) registers and handle PROX_INT
> in the interrupt handler. The MAX30105 transitions out of proximity mode
> automatically once the ADC count exceeds the threshold, so PROX_INT is a
> notification to start getting data, rather than a mode switch.
>=20
> For the ABI, I was thinking of using an IIO_PROXIMITY channel with an
> iio_event_spec for the threshold and enable, similar to what was done in
> cm36651.c. Is this the right approach?
>=20
> This feature would then be enabled through the event enable, so with the
> event disabled, the driver would behave the same as it does today. This
> is important because with proximity active, enabling the buffer would
> not produce data until an object is detected.
>=20
> One interaction with a patch that was applied recently [1]: enabling
> PROX_INT falsifies the assumption that FIFO_RDY is the only enabled
> interrupt source. So the handler would need to distinguish between
> causes, likely meaning that max30102_fifo_count() will need to be
> refactored a little.
>=20
> Thank you.
>=20
> [1] https://lore.kernel.org/linux-iio/20260808195450.25420-1-marcochen.de=
v@gmail.com/
>=20
>=20
> 
