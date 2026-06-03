Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D94D3C4577
	for <linux-iio@vger.kernel.org>; Wed,  3 Jun 2026 12:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780491004; cv=none; b=i74fHQSQBKlGJodb+GSOf7y4rFOezb+fszClkPdKYlIp9wuAZaLRWGOUdab5XCDlVr+4/ztlUG0OoQ4fPf23zLzjnAIvQ5kyRX38eD5q4BfKKi9B013h6ZvT36rFwhYcC8dYvvZv6SGwnfS5jDfxcaS1B3C09CbK+BFgOQbMqu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780491004; c=relaxed/simple;
	bh=nrpKqG35VvaKSATLpa2MeeXN29Z1G1amie1rZa8WeKM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lBk9uwxkKN70SA6/X7Yks4cZNwzNuEcejWfXS69YPbdLg4P7swbMKUVy2oadArQjCBOzwM+HXHblVn/CK1vLVEJih8jcRbxzIXue9UQwWKKgnm6NsQkohAlsyEaISZ8xLNDPO4VQjlZgveT2XS+JQ7rd/x1uAwK8VrRr/WurdZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SccOX6aw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SccOX6aw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9432C1F00893;
	Wed,  3 Jun 2026 12:49:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780491002;
	bh=maD4sWTZBSiq40bI6ZCzud5HpqHdSjRb1I5VG4VHOcg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=SccOX6awBeB5PQKZseGMmcel3ozf1D4x1eeMN59Olvnjim0tToyCdrOavA0Q31pCX
	 GIHXQK25JhH9qkgt7tgajE+BYUyifIfmYxiUs3MIj9UZmdSqPKxmJUH/UDZTheqnHK
	 6JPWIzbPhBa89xJTaUPQk9hWHUD/9KAXpQQBAlZ8XIVnD2Gq8Ke7TqV+RdQs52XOE1
	 +u4lrH3yo4t01bVal8YogmNGVFRvV7rkvRR6mBXO7rVX8QoI3jpQ2qLZEH+hlR9atE
	 zCzMJ8vW2QoRNEPHlw7xlq+QIOlSrXl0OI83p4b/woVR9aXD4LPXAwV1zCcrGFm/t3
	 URr52u1GibFkg==
Date: Wed, 3 Jun 2026 13:49:55 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Samuel Moelius <sam.moelius@trailofbits.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Marcelo Schmitt <marcelo.schmitt@analog.com>,
 Jonathan Santos <Jonathan.Santos@analog.com>, Jorge Marques
 <jorge.marques@analog.com>, Antoniu Miclaus <antoniu.miclaus@analog.com>,
 Matti Vaittinen <mazziesaccount@gmail.com>, Jishnu Prakash
 <jishnu.prakash@oss.qualcomm.com>, Duje =?UTF-8?B?TWloYW5vdmnEhw==?=
 <duje@dujemihanovic.xyz>, Stefan Popa <stefan.popa@analog.com>, Julien
 Stephan <jstephan@baylibre.com>, "open list:IIO SUBSYSTEM AND DRIVERS"
 <linux-iio@vger.kernel.org>, Samuel Moelius
 <samuel.moelius@trailofbits.com>
Subject: Re: [PATCH v2] iio: adc: ad7380: select REGMAP
Message-ID: <20260603134955.2f1d5ede@jic23-huawei>
In-Reply-To: <CAE+C+DYE-8nNouH_Ec6vB0Z1tgyxznbbMvoQJ9S0iKqb1oj2Hg@mail.gmail.com>
References: <20260602164539.1541685-1-sam.moelius@trailofbits.com>
	<ah-ADnSU_VhacXqI@ashevche-desk.local>
	<20260603120127.03f9172c@jic23-huawei>
	<CAE+C+DYE-8nNouH_Ec6vB0Z1tgyxznbbMvoQJ9S0iKqb1oj2Hg@mail.gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 3 Jun 2026 07:53:09 -0400
Samuel Moelius <sam.moelius@trailofbits.com> wrote:

> On Wed, Jun 3, 2026 at 7:01=E2=80=AFAM Jonathan Cameron <jic23@kernel.org=
> wrote:
> >
> > On Wed, 3 Jun 2026 04:14:54 +0300
> > Andy Shevchenko <andriy.shevchenko@intel.com> wrote:
> > =20
> > > On Tue, Jun 02, 2026 at 04:45:39PM +0000, Sam Moelius wrote:
> > > =20
> > > > The AD7380 driver uses generic regmap types and APIs. However, its
> > > > Kconfig entry does not select REGMAP.
> > > >
> > > > As a result, AD7380 can be enabled from an allnoconfig-derived conf=
ig
> > > > with SPI_MASTER=3Dy while REGMAP remains unset, causing ad7380.o to=
 fail
> > > > to build. =20
> > >
> > > Okay,
> > > Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> > > =20
> > I replied late to v1.  Unless I'm missing something makes more sense
> > to select REGMAP_SPI =20
>=20
> REGMAP_SPI also builds drivers/base/regmap/regmap-spi.o, which AD7380
> does not use.
>=20
> So, to merely fix the ad7380.o build failure, REGMAP seems to be the
> right choice.

Good point.  I failed to notice it uses a custom regmap.

Applied to the fixes-togreg branch of iio.git and marked for stable.

Given timing I may well drag that into the queue for the merge window
rather than ending a separate pull request for fixes.
