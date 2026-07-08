Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 159FE2D12ED;
	Wed,  8 Jul 2026 17:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783532046; cv=none; b=Bu2C/YrdyC2ijkl2cANO/mtNQcPTcJWWrJy3oniye6BlyZGihmmUOQRLOT8+7POusJZjkW7TJ6YMi/a4uuV/moJtZI0MjaJdNEHHIFdHfLm62ReNGAwiyuOZlOM6TMSN7IXujh7egXE3sH4Iqxc+Me3149nyH0lZP61TckZ41V0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783532046; c=relaxed/simple;
	bh=7N8onrXdRueWOF5R2aqm/8APanqJ22aQiR2sdGazQn0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uUVL7tTnSbNP4sZxYfUtwQg0fzUV9UWqppXUuWUS4p8Xj6eJtW0ya7mJV+UzVSaQ55nrM8+w8xwMLbzuRNjd1tic+wXpdmp9GCjKugUoIk8Su+FZ7Hpyhszu9Qj7utgmIEqbkgz7njLtbwP2ZWtSukNKJ6ue8hH17Cbm1smu2kU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D4a7nTWy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D4a7nTWy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 338F51F000E9;
	Wed,  8 Jul 2026 17:34:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783532044;
	bh=ZzrvFNdSN4W/iiPIWPPTXG7gd4SZNNMqCRl0tSiJ7Ik=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=D4a7nTWycrH4CeKGbcTX+s1aUzLu9QnFlw5/vzK0JXq/jm8pWe+JlLGbYD8ogLjhV
	 YAlA2AV4TSDZzg1eldmFiQp7UkyfNb0e+PCNuNhCrSsqr8IJmEa06ra8riH0WEllu4
	 8xqK77sLoebVGU8LHdYH9GhdRlIABnUFNaHbovNqL0FengIaTsaxuFa0RH6KPNwAOU
	 U5TFgNqDAvRWza586HD/uGlaL6UyGFbtJIotlisxVVsSUrdBZX/hytyFWgFolu3b6N
	 5ZsMR0ujHSiWhYZOLSvYU6M2D+F29YL4+0Kb26SzGQj/CpgH3pbJvNxbQTR11Sh3rz
	 Gs34PUU58/jcw==
Date: Wed, 8 Jul 2026 18:33:59 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Siratul Islam <siratul.islam@linux.dev>
Cc: Lukas Metz <lukas.metz@gmx.net>, David Lechner <dlechner@baylibre.com>,
 Nuno =?UTF-8?B?U8Oh?=	 <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, Rob Herring	 <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley	 <conor+dt@kernel.org>,
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org
Subject: Re: [PATCH v2 2/2] iio: dac: dac8163: Add driver for DAC8163
Message-ID: <20260708183359.495c4b65@jic23-huawei>
In-Reply-To: <e84c4e047e104cca9b88dda791997ceecba1204c.camel@linux.dev>
References: <20260708-dac8163-work-v2-0-3acd1bf20182@gmx.net>
	<20260708-dac8163-work-v2-2-3acd1bf20182@gmx.net>
	<e84c4e047e104cca9b88dda791997ceecba1204c.camel@linux.dev>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable


> > +
> > +#include <linux/array_size.h>
> > +#include <linux/bitfield.h>
> > +#include <linux/bits.h>
> > +#include <linux/err.h>
> > +#include <linux/errno.h>
> > +#include <linux/gpio/consumer.h>
> > +#include <linux/mod_devicetable.h> =20
> I asked you to add this "mod_devicetable.h" header previously. But I noti=
ced some reviews by Uwe=C2=A0
> to use more specific headers.=C2=A0
> In your case these should be=C2=A0
>=20
>=20
> #include <linux/device-id/spi.h>
> #include <linux/device-id/of.h>
>=20
Not necessary given they are guaranteed to be include by the bus headers.

Take a look at what Uwe did in his series.  The actual device-id headers
are added to very few drivers - mostly the bus ones are enough.

Jonathan
