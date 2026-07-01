Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77AFC17736;
	Wed,  1 Jul 2026 00:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782864803; cv=none; b=rvyxd5d2pijsjHJoo7DO5nid2Z+gODI3EvQATp38EYBN5exD1Z7xH8WEFri6/eJGkU4aLPcVkuQHCnbEJ9mwxU9KC0BY2/eMRcYXpf542KbSIwpKRSbP7lpdcUOATQtx9qhwk8MC2qkbvqGaqZWlQN2+Eiw/iV8DwnCIvnYtGXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782864803; c=relaxed/simple;
	bh=xlRsoySwmtKcnxv6OFIt2H56qw8lNTnI6qyJT3sKTVA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UjntiPHf+hJ0Y2LLbRsh27n6UD/mI96U9iCw5DU3Ej4vRazo7bk1wLVjcmyTgpy4pMxWs7xEpbNSIz678WfwwFRmBLp6A/RfO2xNI3UQoE0zBHxRjfvCRvwzrvtHttuv6iYe0Vhmg9HAVXFYh55EMT+j6F5GvjcsioVWyFTzUcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LyJu1wcK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LyJu1wcK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 358B11F000E9;
	Wed,  1 Jul 2026 00:13:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782864802;
	bh=5e/PLzqrcTAEl4YEODzsKqyRAhDwaFeBGekCR184Fek=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=LyJu1wcKr1DSRH/Sh/BRIWCx/bDwbT8/YdZNEYkE07lrUUWUQExL3wxNNlY//2Y79
	 pqsTx5JYT/W2GVsKEA7Icdx44Uu2FHkABlZ9HN27d/0E9B6a0IzmAkeNBFNZHGeJGJ
	 B1LRYGcuQzRS1ArosWXwbKo4al+UQQLY/YvJXop7WoWthZZHl4B+F603a8mmbIHefS
	 AHgF0vH8euCASvfNPY9sIojQSrD5eqzQUf8Pt3fJCL7jNt2Nel9xhdYsgEskU42qx2
	 EMZkwBI7Xr1TCHcy6drquGA7pmg7+WnxNDY4Y0Pe4dYvB52zBXge1fSkceShjUCbBi
	 Q1jM0CR/CoA/g==
Date: Wed, 1 Jul 2026 01:13:15 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Kim Jinseob <kimjinseob88@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, David Lechner <dlechner@baylibre.com>,
 Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan
 <skhan@linuxfoundation.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC v6 2/5] Documentation: iio: add Open Sensor Fusion
 driver overview
Message-ID: <20260701011315.2a7c56af@jic23-huawei>
In-Reply-To: <CALMSew+=8P851Wdc=zDLsU5T9YC_ZeTHRotCzYiFP=LNznZhDQ@mail.gmail.com>
References: <20260628191337.937-1-kimjinseob88@gmail.com>
	<20260628191337.937-3-kimjinseob88@gmail.com>
	<20260630000254.1d1cf422@jic23-huawei>
	<CALMSew+=8P851Wdc=zDLsU5T9YC_ZeTHRotCzYiFP=LNznZhDQ@mail.gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 30 Jun 2026 14:04:43 +0900
Kim Jinseob <kimjinseob88@gmail.com> wrote:

> I will remove "initial" there in the next revision.
>=20
Hi Jinseob

A small process thing that a lot of people get 'wrong' is to reply when only
saying you are making the suggested change. That adds a lot of noise to the
mailing list. The correct place for this information is in the change log
for the next version.

Thanks,

Jonathan

> Thanks
>=20
> Jinseob
>=20
> 2026=EB=85=84 6=EC=9B=94 30=EC=9D=BC (=ED=99=94) =EC=98=A4=EC=A0=84 8:03,=
 Jonathan Cameron <jic23@kernel.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
> >
> > On Mon, 29 Jun 2026 04:13:34 +0900
> > Jinseob Kim <kimjinseob88@gmail.com> wrote:
> > =20
> > > Document the Linux IIO mapping for Open Sensor Fusion devices.
> > >
> > > The overview explains that sensor channels are discovered at runtime
> > > from mandatory capability reports. It also documents that OSF0 is a
> > > wire-format detail and that protocol_major and protocol_minor carry
> > > protocol compatibility information.
> > >
> > > Signed-off-by: Jinseob Kim <kimjinseob88@gmail.com> =20
> >
> > One small thing inline.  Otherwise looks good to me!
> >
> > Jonathan
> > =20
> > > diff --git a/Documentation/iio/open-sensor-fusion.rst b/Documentation=
/iio/open-sensor-fusion.rst
> > > new file mode 100644
> > > index 000000000..832901f5e
> > > --- /dev/null
> > > +++ b/Documentation/iio/open-sensor-fusion.rst =20
> > =20
> > > +Timestamps
> > > +----------
> > > +
> > > +OSF frames include a device-side ``timestamp_us`` field. Buffered II=
O samples use
> > > +an IIO timestamp captured on the host when samples are pushed to IIO=
 buffers.
> > > +The initial driver does not correlate the device timestamp with the =
host IIO
> > > +clock. =20
> >
> > Really small thing but I would avoid talking about 'initial' driver.
> > It can cause confusion about when something is true and when it is not
> > as we may have multiple non 'initial' drivers before you get to changing
> > this handling. So just remove that word.
> > =20

