Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795658460;
	b=MVcQbwHyYglbsF0ww77+Ei2q+Pg3H88mDIrkqsbuWO9ySQklaDkBKHNtOBsky1DMr+qH
	 go2cueFJiAvYy+NZJfMzlxX+8l8qGyKHq5hZJAVMUez9JcN/oftUdFdod+1KKa51Bpvn/
	 h7DohZ6SLfrr3hXaVWlkhyRUWMqJKS5dzq22wi0aJOOqVHjMTi8n5hpjPY69Fx7gFlhCV
	 byKuUre3b9HFFPG6XdJPyJ3QPM1uzN05XhDKDacVD8vvD0r7fZGmaCo4tpoEAHU19+S+z
	 GKUh1ASxSqR5y3heKXUGkUy1VhzjfkgGr8bPYzLWPc0lBkCXU/zFFPdZsfIOeNzqQLA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795658460;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=rHntN9D8WHAwh0API+RNbmZQZWgXaLW45ts29PF0xrk=;
	b=HeqF/5mnHH+3mNrCWeYxFcDBPHt9K+b5cF8qSuu/7Nq+f6RH71viskofMCAueOC4mmd9
	 y7k0VpK7DAvydWZ3RA2Cb12/20ephOO7gbUKoy0lmd6UbOjBKCaIjXS6xeBCCa+jmfSXg
	 Olml8T/aMZeTyMNt4n1eEfHSM8JFoH545d4MJLvqF9qVj+a5uqtMZfP+OKDY9JgW/XlO8
	 itGK4KuT8QNez3y8fpJd8W2ZtnphXPen83ThDa6weNckjsN/o1l0z42nbYCoeMS1+6tiw
	 O66UvZ1/Gd7dAz/rZvzcWoM45oQQZLMWnD6FxwmB2Id7dCs0fME89nSRPwG/otVaLKw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="V7/QU7ym";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F076606A321;
	Thu, 26 Nov 2026 02:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V7/QU7ym
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB2981F000C0;
	Thu, 26 Nov 2026 02:00:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795658460;
	bh=rHntN9D8WHAwh0API+RNbmZQZWgXaLW45ts29PF0xrk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=V7/QU7ymvi/jtvL8+xukEiCQR3yVqeOoPMrxCLukjRyZk6hQ6dH9kabo8kXg/lJbE
	 GeC04d3FGjCWXq9rqXs9eLwSCV1iWIKK6L9JQm41juX5jnVoC/WIlV/itz7tfvXbTS
	 mlmJlvxXNEBusXmJ9CgZEgHMUK9OtjxwSPZMAryQhKYgvmvzisM6cjtR8id7zYEpyU
	 bj92+JzM29M3ReLVzFVRUP0vKwnSsNBW0Hp1H5g1QlMOLJK7267bIGKEogeFaz76/Z
	 MMy/mberaUu+6R+u0zSk4d0/liSZD+0EHJ+mwKIWMLPOqoHdjfBrw/zAzyxcImnnWd
	 1S15XgOyGMwWw==
Date: Thu, 26 Nov 2026 02:00:51 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux@analog.com, Michael Hennerich
 <Michael.Hennerich@analog.com>, David Lechner <dlechner@baylibre.com>, Andy
 Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Arnd
 Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 6/6] iio: adc: ad7793: add firmware support and drop
 platform data
Message-ID: <20261126020051.670fd7bd@jic23-hlaptop>
In-Reply-To: <awbA11Ps-v16BKxP@nsa>
References: <20261125-iio-adi-legacy-platdata-v1-0-54e4c8830b57@analog.com>
	<20261125-iio-adi-legacy-platdata-v1-6-54e4c8830b57@analog.com>
	<awa728YWKMfpwe8c@ashevche-desk.local>
	<awbA11Ps-v16BKxP@nsa>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 25 Nov 2026 11:11:48 +0000
Nuno S=C3=A1 <nuno.sa@analog.com> wrote:

> On Wed, Nov 25, 2026 at 12:43:39PM +0200, Andy Shevchenko wrote:
> > On Wed, Nov 25, 2026 at 10:19:22AM +0000, Nuno S=C3=A1 wrote: =20
> > > The driver refuses to probe without struct ad7793_platform_data, and
> > > there are no in-tree users of it. That means the driver can not be us=
ed
> > > at all on a modern system.
> > >=20
> > > Get the configuration from firmware properties instead, following the
> > > new binding, and drop the platform data header:
> > >=20
> > > - The reference is REFIN (REFIN1) if refin-supply is present, REFIN2 =
if
> > >   refin2-supply is present, and the internal 1.17 V reference otherwi=
se.
> > >   Parts without an internal reference need refin-supply.
> > > - An external clock on the CLK pin is used if given. A 128 kHz clock
> > >   is divided by 2 internally.
> > > - The input buffer stays enabled (as it is at power-up) unless
> > >   adi,buffer-disable is set, and unipolar coding is used unless bipol=
ar
> > >   is set.
> > > - The bias voltage generator, the burnout currents and the excitation
> > >   current sources get their own properties.
> > >=20
> > > While at it, also enable the AVDD and DVDD supplies, add an OF match
> > > table and fold the platform data checks into the property parsing. =20
> >=20
> > First of all, can this be split to a few smaller changes?
> > I will look at the rest later on. =20
>=20
> I could but is it worth it? In theory this is all actually resulting of
> the same change which is dropping platdata which means supporting FW and
> of_id_table (the extra supplies could another patch but it comes
> down to the regulator bulk reg). I'll double check if something can be sp=
itted
> but I do prefer to keep s/platdata/of_id as one single patch.
One churn reducing thing we've done before with these is to squash the head=
er
into the c file as a precursor. That gets you all the enums + lots of docs.

The we get to see the switch to a firmware filled structure slightly more
easily.   Another thing I think we did once or twice is just leave
the platform_data naming alone.  That can also reduce the churn somewhat.
I'm less keen on that one but you could do:

1. Code move for platform data into the c file.
2. Simple renames of platform data to cfg.
3. The new handling.



>=20
> - Nuno S=C3=A1
>=20
> >=20
> > --=20
> > With Best Regards,
> > Andy Shevchenko
> >=20
> >  =20

