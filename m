Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 240382472AA;
	Sun, 12 Jul 2026 01:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783820498; cv=none; b=pqxy76/VZ24a/vmmDYSEDQPGVMoTkVoujC9AI5QqhhMpr414My9bowLznFpbpm2VMvM6mmFLpt7j/6XE+l0psa5feP/5Z0zKYkcA792JmkMZ3LsxgkBT1/zcuGvdHqM+TCqXaVgRbGKqmLIXJUQ3qUqBqJ4IOID7wlOCk+EV45E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783820498; c=relaxed/simple;
	bh=hX/JVgtYdXPmAqU55kxDoibH+8hJiar5fu+xmtHvrfA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fZNNaneXMFE4i1/VTNq1zaviFLT5vt30IXn8tmzKEyMPCrnvk+ovbJJuhIrvNem0Mr8LjVLrHXA7fJnTRcb3jKDonh08doYsPGwdd2OTsvQBsqXmVHpfhbU6a4/SJ2sMSt5dkD0gLcdH5MsB2cc6DDpdp6OtsUJCpOmeYeWAPtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jxgYtHZq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jxgYtHZq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE4261F00A3E;
	Sun, 12 Jul 2026 01:41:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783820496;
	bh=2WRc5d7D7WzeJTab5qtDY3JXeaqsh7qoDA26O08VMAY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=jxgYtHZqNyIRqvp8Azf5ZzQ/j85EvfVRxpfCT9gHYCyvD6EqicsLtqllsbMSy1tXY
	 rpm7WgMUji4Ffjrmz642e21b1r7+yeQKwcsyj6NN79oYqy+lqo+qF/BA+J6E83HBwV
	 +0tT7mkuaoJ6R73ew8hj4zR5ayt5fo5TXWTO/0Em0RVzs83DJ8ITt8569KH4PsFwT4
	 s60EzCaVlOdiLS/D7UOD8ZFKHe6wICiWLYrwJSRyVdk9ssPn22mUPW9vyLKiVS4Zra
	 F4cmwulAKwNIKaGl+DyoT6nbaEFUJ7gSF+oBfsCH0chWCu7Xpez/Wjnr/NILTMIvgx
	 6He8SSpQAnmxw==
Date: Sun, 12 Jul 2026 02:41:30 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Roman Vivchar <rva333@protonmail.com>
Cc: Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <u.kleine-koenig@baylibre.com>,
 David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Lee
 Jones <lee@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 Ben Grisdale <bengris32@protonmail.ch>, Andy Shevchenko
 <andriy.shevchenko@intel.com>
Subject: Re: [PATCH v5 2/4] iio: adc: mt6323-auxadc: add mt6323 PMIC AUXADC
 driver
Message-ID: <20260712024130.7a087d35@jic23-huawei>
In-Reply-To: <KnchjScV7RNnhDi3rI7qqdZSgivkk8WJiQEGWYifNJJjMzzJrEFfZGEuPWSrQisnh_JDj15_CLSLtO2HEjUFe6Jr4wgramAhYwmJjHy6aiw=@protonmail.com>
References: <20260709-mt6323-adc-v5-0-d11b8332a735@protonmail.com>
	<20260709-mt6323-adc-v5-2-d11b8332a735@protonmail.com>
	<alChi9oG0-2XUFXK@monoceros>
	<KnchjScV7RNnhDi3rI7qqdZSgivkk8WJiQEGWYifNJJjMzzJrEFfZGEuPWSrQisnh_JDj15_CLSLtO2HEjUFe6Jr4wgramAhYwmJjHy6aiw=@protonmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 10 Jul 2026 10:06:05 +0000
Roman Vivchar <rva333@protonmail.com> wrote:

> Hi Uwe,
>=20
> On Friday, July 10th, 2026 at 10:39 AM, Uwe Kleine-K=C3=B6nig <u.kleine-k=
oenig@baylibre.com> wrote:
>=20
> > Hello,
> >
> > On Thu, Jul 09, 2026 at 01:52:48PM +0300, Roman Vivchar via B4 Relay wr=
ote: =20
> > > +#include <linux/mod_devicetable.h> =20
> >
> > Please don't add new users for this header file. Only use those
> > <linux/device-id/*.h> that you actually need (if any).
> > =20
>=20
> Jonathan, since you've already picked up the driver to the iio testing
> tree, would you prefer v6 or a separate patch on top of iio tree?
Yes please.  That will be one less for Uwe or me to do.

J
>=20
> In any case, I will drop the header since it's not needed.
>=20
> Best regards,
> Roman

