Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C3B1451054;
	Tue, 28 Apr 2026 17:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777399082; cv=none; b=o2fkoO4SttKMX6GitGwEY/hqVrR/vLH5j35zTsibs0e2weUO9W4iNk49pIB6Jfp9043Xmixcj7+bM3ZPg4vALjaQgjsdxVxqYf9AERUzvktZHogx+d21HnDU0kv8N62vhZVYNVJYK+QYs+Ei4+oE1xJl8s3gU4QnR6gqSZF8ecA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777399082; c=relaxed/simple;
	bh=/VRnkAP9lVS13dsgEnXcS+bu4997VeoYMwp75yD+UtM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mDryzL/32PV5NTFGOKKM6zV9IBwAxk87O76DpIapBEKKLmwAr9vXcUpME9gzVPlstvSpr2KQazjNQuQ7lubdKLVt9iDDA27sg8be5whvwkVtl2agvIBT0wIEz4IIjuD/N4fPgGERZyZOy9ci9XzOmUEiUDQbM5ZVKOoiCPiduio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TnRErpvB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TnRErpvB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8235C2BCAF;
	Tue, 28 Apr 2026 17:57:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777399082;
	bh=/VRnkAP9lVS13dsgEnXcS+bu4997VeoYMwp75yD+UtM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=TnRErpvBPvib/z/fK0pHN3hg9VpzAsi1u0wigngLgSjOBtR7wIXZxUk/4pKbsP1TH
	 IA7DJUs8Q+raymqcK++x1iMgLn7L93YcK5mLBmk9ePnBDDa3S7wQ/s8PzeEG9vDXTF
	 LjZZRUJ+ifQBvNdGzkAEy6F8sz6ro5D/Zc/S5+dV92U0QGAP2yU8fZbincgMvVWX7R
	 r0/0hoVI941TgE6uwQi8zkXJaqViDXQsf+tOB5hwJnU5yIGf5utzhM7o8NuXW4IFMw
	 URIG77pnlDkx4Jj8Ji6ExYookDHpfjva/bEzJtHj2cWIN3xKjs4R7XVYNuHnQ8367Z
	 Vzu6JpPvOjlgw==
Date: Tue, 28 Apr 2026 18:57:50 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Piyush Patle <piyushpatle228@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, ak@it-klinger.de,
 dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 4/7] iio: adc: hx711: introduce hx711_chip_info
 per-variant structure
Message-ID: <20260428185750.48618814@jic23-huawei>
In-Reply-To: <CAMB+xkZ6bw1y2Awhka9Hw8WU94=NW=n8A256aez-14YC-oj_Lw@mail.gmail.com>
References: <20260427100950.33936-1-piyushpatle228@gmail.com>
	<20260427100950.33936-5-piyushpatle228@gmail.com>
	<ae9t0WuhKgcPkfIt@ashevche-desk.local>
	<ae9vKxTrqe90OsCN@ashevche-desk.local>
	<CAMB+xkZ6bw1y2Awhka9Hw8WU94=NW=n8A256aez-14YC-oj_Lw@mail.gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 28 Apr 2026 04:17:20 +0530
Piyush Patle <piyushpatle228@gmail.com> wrote:

> On Mon, Apr 27, 2026 at 7:44=E2=80=AFPM Andy Shevchenko
> <andriy.shevchenko@intel.com> wrote:
> >
> > On Mon, Apr 27, 2026 at 05:08:17PM +0300, Andy Shevchenko wrote: =20
> > > On Mon, Apr 27, 2026 at 03:39:35PM +0530, Piyush Patle wrote: =20
> >
> > ...
> > =20
> > > > +   chip_info =3D device_get_match_data(dev);
> > > > +   if (!chip_info)
> > > > +           return dev_err_probe(dev, -ENODEV, "missing match data\=
n"); =20
> > >
> > > Since we are here, it's not match data, it's driver data. "missing dr=
iver data". =20
> >
> > And does it need property.h to be included?
> > =20
> property.h is already present in the driver
>=20
> > Also check if dev_printk.h and errno.h are there (it may be that driver=
 already
> > uses device.h and err.h that cover these two). =20
> platform_device.h pulls in device.h which covers dev_err_probe().

That's generally not something we'd count as guaranteed for all time so
I'd expect to see dev_printk.h in here.  Never include device.h directly
in new code unless you really need to. It's an historical artefact - if
it was already included though because we actually need it then it would
have been fine to assume dev_printk.h was included via device.h

> err.h covers the errno values. No new includes are needed for this patch.
>=20
> >
> > --
> > With Best Regards,
> > Andy Shevchenko
> >
> > =20

