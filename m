Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 069E8125A0;
	Sat,  7 Feb 2026 16:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770481099; cv=none; b=VaPE4+5A3KyMdeOXbH3tz4U3JFNRCEqmNS0ppoMCILVmmfrzvFEqCdXJo+NeJ6nBZQY5xTuaRyPOgRmGYH4/IGzm3uuh+pi6q8outz1yDKv42rtL9gu8xlbtJBuphsZX0gf8mbmQc2Fd8eoOSmAMeg1H/KqJq2vPIMjbtWtr2TU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770481099; c=relaxed/simple;
	bh=Q6ceXdrIArpLVGClzYXR3vLOkttPjE6YPnbXEG1ovEc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QLS3iyiPDsjbLuNThFE5J0lPX01FVrZXRDLfSqP8Ys1BPCrqn2ZsIIoUdGLAPYh+9o2PlWwgJmgDmWn/tvMs4h77d77HbbuS+g1XHTnAZPdNn4nIiOF+BSkZ3cr/Vm+K43iAwH+UsI7Y85rHJVyxAHGkDDsrlTTjbNB2zgI1OaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m2Hikhzy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m2Hikhzy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FC0AC116D0;
	Sat,  7 Feb 2026 16:18:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770481098;
	bh=Q6ceXdrIArpLVGClzYXR3vLOkttPjE6YPnbXEG1ovEc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=m2Hikhzy69wg8N1P4EIFMo/Y1e5mMRz89B1LWyACWtmkPLSAXOIJxd0wuHvzsF3J4
	 TOrun8Xo/64vvCGpFtujZOAYokTJUpHs+R/wo5zpx2jpAQJAQlUkVsChQjy5toMbbM
	 axjvrA0EGKNDQGRRIkUqUGKZRSNLzZisX2BV2CpXkP4hkLGrQJnf6KhTgMtQR+wAQr
	 hGOraAhmwk536ShFhHfmSyLjgFLFFys0J5UhOVQ/SYHqCxpMcT9IFVD7CMlqEU9Frb
	 +JMB/nS28VOa07+rl+R8YodTO1F1rVuv5o7NltNFPhQJEXDBKwN8nInemzd+/svUkl
	 QeZVX+zUn/uwg==
Date: Sat, 7 Feb 2026 16:18:08 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Taha Ed-Dafili <0rayn.dev@gmail.com>, Michael.Hennerich@analog.com,
 andy@kernel.org, corbet@lwn.net, lars@metafoo.de,
 linux-doc@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-kernel-mentees-archive@lists.linuxfoundation.org,
 linux-kernel@vger.kernel.org, me@brighamcampbell.com, nuno.sa@analog.com,
 rdunlap@infradead.org, skhan@linuxfoundation.org
Subject: Re: [PATCH v2 2/4] iio: core: Add IIO_EV_INFO_SCALE to event info
Message-ID: <20260207161808.6e5cf265@jic23-huawei>
In-Reply-To: <745218f5-fe09-4a20-9cff-ee2ca28143e3@baylibre.com>
References: <afa85a59-07c7-46c9-990a-b0b34599cdc3@baylibre.com>
	<20260202151939.15893-1-0rayn.dev@gmail.com>
	<745218f5-fe09-4a20-9cff-ee2ca28143e3@baylibre.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 2 Feb 2026 09:31:45 -0600
David Lechner <dlechner@baylibre.com> wrote:

> On 2/2/26 9:19 AM, Taha Ed-Dafili wrote:
> > Hi David,
> >=20
> > Thanks for the feedback. You're right=E2=80=94"missing" was poor wordin=
g; I=E2=80=99ll
> > rephrase to "implement support in the core" for v3 to reflect that this
> > is an infrastructure addition.
> >=20
> > Regarding existing users, the current lack of IIO_EV_INFO_SCALE in the =
core
> > forces developers into manual workarounds to stay ABI-compliant. For
> > instance, in drivers/iio/accel/mma8452.c, the developer used
> > IIO_CONST_ATTR_NAMED to create a manual in_accel_scale and linked it via
> > .event_attrs. This approach is static and bypasses the standard event_s=
pec
> > infrastructure. =20
>=20
> OK, so it looks like there is just one existing user of any events/*_scale
> attribute then. That would explain why there isn't a IIO_EV_INFO_SCALE.
> It just isn't very common.
>=20
> >=20
> > My goal with adding IIO_EV_INFO_SCALE is to provide a standard path to
> > report these scales dynamically through read_event_value(), ensuring ABI
> > compliance without manual sysfs boilerplate.
> >=20
> > Does this core infrastructure approach seem like the right architectural
> > path, or would you prefer I stick to a driver-level attribute for the
> > ADXL345? Regardless of the path chosen, I will address your other comme=
nts
> > in the next version: I'll fix the "in scale" typo and add the new scale
> > entries to the adxl345 documentation table. =20
>=20
> If we think there will be more users of this and we want to make it more
> discoverable, then adding IIO_EV_INFO_SCALE seems useful.
>=20
> I would wait until Jonathan weighs in with his opinion before taking acti=
on
> though.

I agree. Makes sense to add this.=20

Jonathan

>=20
> >=20
> > Thanks,
> > Taha =20
>=20

