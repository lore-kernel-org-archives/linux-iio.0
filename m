Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3710F7E105;
	Wed, 24 Jun 2026 06:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782282371; cv=none; b=u5SkxnvwDW7kiUqLGb7slgaxAsfoCjHJkAWOux6tMGESgo4SrAw2lbRyi6uUOCvm2c19i9FApdAFYB2sZ+wts/swKV2cCevZoMCscC4PSt7YQWHjW4OBhYFdyMRvn3kd4cS7fS0h6MAJ6Ym07iBKvNKEqYodTeezovzdyRdvfrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782282371; c=relaxed/simple;
	bh=KQQvs0dz3w/HdCW224GEcGez9fhF9xEyRoHtzqE4FBo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qSWdi19dV3MXv1Gze+PhoEGe2tSgFUBA2PP4UbqN4Z/uWHWFafQwZs6W0rEIYHGRcTGOdxA74bDw2sAJNFG2xr3r9O687S9cUXo4S+GVqBIbb5n9227sLlq8foYMuYokVhNockgdEmPMg5yS7UrX9EqCyv66sCBa67sFSbq/MTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=lukas.metz@gmx.net header.b=iv7PZkS3; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=lukas.metz@gmx.net header.b="iv7PZkS3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1782282362; x=1782887162; i=lukas.metz@gmx.net;
	bh=zC365oSTWaKv//GCcbyYx/XgeaQgqUEdUrmcGdfubGA=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:In-Reply-To:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=iv7PZkS3+YGufnfpP7wVr61CeMfSVy/8YTd/u+bz1UmK0Pdr88c58vvk3wEl4cFg
	 oJ30fUQMBRnq40Iox8EM1iua6Z9sOBViwcL1smhfLQaTQftb7yxms03nlX0o9a2W0
	 CI2P45tIvHGQh0us3nfyZE7FL6/nxYW4JWLDEx6TeIpXhQKJUDfd1+1BnEj7tC8t6
	 D6PT62LdjrGngNyewyA0uAf7znS8R19hxS6Vq0j1Fw7QHiGKhx5aS/SaIVUKzPy/9
	 sPZadrzJ09uchU6Xk0QDIoDnfk0Jj2UXXusF0rktqf3R/WvDlBtcuWF4K43Hi80+7
	 DBZrmz1z6VWJvf1nYQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MZTmY-1wh6qt33AM-00VTFZ; Wed, 24
 Jun 2026 08:26:02 +0200
Date: Wed, 24 Jun 2026 08:25:45 +0200
From: Lukas Metz <lukas.metz@gmx.net>
To: David Lechner <dlechner@baylibre.com>
Cc: Lukas Metz <lukas.metz@gmx.net>, Jonathan Cameron <jic23@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 2/2] dt-bindings: iio: dac: Add DAC8163
Message-ID: <ajt0vibLhh6Mmhoc@berta-MS-7693>
References: <20260623-dac8163-work-v1-0-5b508158faa0@gmx.net>
 <20260623-dac8163-work-v1-2-5b508158faa0@gmx.net>
 <5a19c272-e8fc-4fa9-b137-842b6ed6649b@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5a19c272-e8fc-4fa9-b137-842b6ed6649b@baylibre.com>
Mutt-References: <5a19c272-e8fc-4fa9-b137-842b6ed6649b@baylibre.com>
Mutt-Fcc: ~/sent
X-Provags-ID: V03:K1:0vLhg3ofF/uu3y3aSJsRVXIXDDHPD/EunxA11MlRjirS9hEEa/Q
 zbEYJf8uy0eRtp3ch0hhCTiVravcZ7QU0ls/NA0CQoSFTp+1Qs4QzukH+x0ptv4h5PWWFUc
 ZAObCRD0pID0zW7Uix+lCsZ9kolbZb4DkZ+oHaEE50UZT88/aCXLvLEnTfa/mcMjhQTWlOZ
 C2L+eGuW3h9JBEvlqBdNQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:zZ94Ce/kxsg=;n1tVdiJIuvQlDI51gn6PFr4Jiqn
 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
 pa
Content-Transfer-Encoding: quoted-printable

Thanks a lot for the review. This is my first time submitting a
patch so im grateful for the detailed comments and suggestions.

On Tue, Jun 23, 2026 at 02:17:04PM -0500, David Lechner wrote:
> It is more logical to put the dt-bindings patch first in the series
> before the driver that makes use of it.

I will reorder the commits in v2.

> There are a couple of more SPI properties needed since this is not a "no=
rmal"
> SPI device. We can only write and not read because there is no D_OUT pin=
. So
>=20
> spi-rx-bus-width:
>   items:
>     - const: 0
>=20
> will describe this.=20

I will the add the suggested changes to v2. Are there any other poperties=
=20
i have missed? Same for the other comments regarding vendor-prefix,=20
spi-max-frequency, avdd-supply and vref supply name.

> We also want the binding to be complete even if the driver doesn't all o=
f it, so
> `clear-gpios` and `sync-gpios` probably make sense too.

SYNC pin is the chip select pin of the device as described below. In
that case i dont need to add it here right?

> Usually, we don't bother with a property like this since it is redundant=
.
> If an external reference supply is given, then it gets used, otherwise
> the internal reference is used.

That sounds logical. I will remove the property completly.

> These chips don't appear to have a chip select pin, so this comment
> doesn't make sense to me. More logical would be to just use dac@0
> and reg =3D <0>; since it should just be ignored.

The SYNC pin on the device acts like a chip select pin.
According to the datasheet: when the pin goes low it enables the input shi=
ft
register. At least that was my understanding. On my board i have tested th=
e=20
driver with the chip select signal connected to the SYNC pin. The
example comes straight from my own device tree where i have two devices
on the bus. Thats why i used reg<1> here but i can change it to 0 and
remove the comment.
=20
> The pin is marked active low in the datasheet, so I would expect
> this to be GPIO_ACTIVE_LOW.

I wasnt sure about that. The pin needs to be held low continuously. I
thought when the pin is marked active low and i initialize the pin with
GPIOD_OUT_LOW the result will be that the pin is held high. To match the
datasheet description seems logical though.

