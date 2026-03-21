Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2950E56A;
	Sat, 21 Mar 2026 12:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774094520; cv=none; b=SJnOojecZzeZI0PoyFWTCtBBx8VKdVOynGFX0Fm0+FkatTwUys9EbqGKt3VfjqzZSN8OxzS9E0Y6iP5i6FNUJRECi0N8e50SotkscwDgUZWNm1hTgIbThocuZawWQ+o1FZqPA/zTouN0RRT9EUl9Muct5N+bCecOQuTwYs97jPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774094520; c=relaxed/simple;
	bh=kixSdQEKn6mGzzarBAS+1/1+sN1qYHCtmZ7olHEzqvQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oMCMRgchWgJFZnRKHzvv5WwcMs+yA8e54baN1S7A8msEqlr8nSOAtX6v01BaWHZEZeo+2q34ZgdW5IxjdupjQCk4zla6IjTTNve3i3mp6Xd1NbRUv3OQf+NY3sj2hCMlBlk4WS9rwovkcWpbe6tXtRSUPgbhdVyNF/YCpPaBZyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qC9UKTJv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qC9UKTJv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6A90C19421;
	Sat, 21 Mar 2026 12:01:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774094520;
	bh=kixSdQEKn6mGzzarBAS+1/1+sN1qYHCtmZ7olHEzqvQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qC9UKTJvGjnSptU/rgNNkXbap8ltUIxjdMKG6PYlyVwPfI20iaWev+mYmO6qA9bum
	 uK+AZ+o0w/BtEtNM5LxRV6T8RiPnGVnOAX5HGCLGhmmPPCzuDRN/3ZgYUdJ8DmhYrm
	 ysSTFYLyeSljt82XGYxd8EMvx6YAImGGmsYNKJhWq/+90AgOAccXT6k2HhcHRy5qbQ
	 2EZ1UTIe65iV7eQXSjWCSeuu75sDqivB1LyTSoK1XYQe7wauY0UKKybAPbZJtQtNwx
	 Vwrjl5XaG6f2aIXItbyctRMyLzXZG3G8jvj+fEThHOMpnbLSCfGyqN7iGTKbjBJPcM
	 LMFVipOv7is/g==
Date: Sat, 21 Mar 2026 12:01:49 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: "Miclaus, Antoniu" <Antoniu.Miclaus@analog.com>, Lars-Peter Clausen
 <lars@metafoo.de>, "Hennerich, Michael" <Michael.Hennerich@analog.com>,
 David Lechner <dlechner@baylibre.com>, "Sa, Nuno" <Nuno.Sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Olivier
 Moysan <olivier.moysan@foss.st.com>, "linux-iio@vger.kernel.org"
 <linux-iio@vger.kernel.org>, "devicetree@vger.kernel.org"
 <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 4/4] iio: adc: ad4080: add support for AD4880
 dual-channel ADC
Message-ID: <20260321120149.685524a5@jic23-huawei>
In-Reply-To: <abktanVPsFwIlIfH@ashevche-desk.local>
References: <20260313115856.87763-1-antoniu.miclaus@analog.com>
	<20260313115856.87763-5-antoniu.miclaus@analog.com>
	<abQdvXq9MtIZ0EpZ@ashevche-desk.local>
	<20260314120022.56265de3@jic23-huawei>
	<abfT3qbFaM6PIDKx@ashevche-desk.local>
	<SN6SPR01MB00908E6EDB8F4D20D391664B9B40A@SN6SPR01MB0090.namprd03.prod.outlook.com>
	<abgWpzT_fcMqRHzf@ashevche-desk.local>
	<SN6SPR01MB00904D9E9C5008D32066E2029B40A@SN6SPR01MB0090.namprd03.prod.outlook.com>
	<abgf3TZTib9UrjSB@ashevche-desk.local>
	<SN6SPR01MB00900C6A79A51852C73D6ECF9B41A@SN6SPR01MB0090.namprd03.prod.outlook.com>
	<abktanVPsFwIlIfH@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 17 Mar 2026 12:31:06 +0200
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Tue, Mar 17, 2026 at 09:54:13AM +0000, Miclaus, Antoniu wrote:
> > > On Mon, Mar 16, 2026 at 03:09:18PM +0000, Miclaus, Antoniu wrote: =20
> > > > > From: Andy Shevchenko <andriy.shevchenko@intel.com>
> > > > > Sent: Monday, March 16, 2026 4:42 PM
> > > > > On Mon, Mar 16, 2026 at 12:31:09PM +0000, Miclaus, Antoniu wrote:=
 =20
> > > > > > > From: Andy Shevchenko <andriy.shevchenko@intel.com>
> > > > > > > Sent: Monday, March 16, 2026 11:57 AM
> > > > > > > On Sat, Mar 14, 2026 at 12:00:22PM +0000, Jonathan Cameron =20
> > > wrote: =20
> > > > > > > > On Fri, 13 Mar 2026 16:22:53 +0200
> > > > > > > > Andy Shevchenko <andriy.shevchenko@intel.com> wrote: =20
> > > > > > > > > On Fri, Mar 13, 2026 at 01:58:53PM +0200, Antoniu Miclaus=
 =20
> > > wrote: =20
>=20
> ...
>=20
> > > > > > > > Nope. You are talking to different devices (more or less). =
=20
> > > > > > >
> > > > > > > If it's a twins in the package, why do we have a special hand=
ling and not =20
> > > > > just =20
> > > > > > > describing two independent devices in the DT/fw? =20
> > > > > >
> > > > > > Because they are not fully independent - they share:
> > > > > > - Power supplies and voltage reference
> > > > > > - The CNV clock (conversion trigger) =20
> > > > >
> > > > > Okay, then why not having a core part and a glue driver that regi=
sters as =20
> > > many =20
> > > > > devices as you wish and provides just a common stuff? =20
> > >  =20
> > > > Because the AD4880 is not two independent ADCs sharing a package - =
it is
> > > > a single device with a single interleaved data output. Splitting in=
to
> > > > separate IIO devices would make synchronized dual-channel capture
> > > > impossible from userspace, which is the primary use case for this p=
art. =20
> > >=20
> > > Sounds to me like you need, probably, a virtual device for that.
> > > Maybe even on IIO level. Do we expect more devices like this to
> > > be enabled in the future (or maybe already in tree, but lacking this
> > > feature)? =20
> >=20
> >  The AD4880 is a fairly unique part - having separate SPI config
> >  interfaces per channel with a shared interleaved data output is not
> >  a common pattern, and the chances of another device like this being
> >  upstreamed are low. Given that Jonathan has already reviewed and
> >  approved a previous version of this series, and the patch has
> >  collected multiple Reviewed-by tags, I'd prefer to keep the current
> >  approach. =20
>=20
> This...
>=20
> > > > The shared resources (supplies, CNV clock, interleaved data stream)=
 are
> > > > not just "glue" - they define the device's operating model. =20
> > >=20
> > > Sure, like any other resource for MFD (HW speaking). =20
> >=20
> > MFD models a single device exposing multiple functionally distinct
> > sub-devices. The AD4880 channels are not distinct sub-devices - they sh=
are a
> > single interleaved data stream, and splitting them would break
> > synchronized capture. =20
>=20
> ...and this are important pieces of information. Can you add a summary
> to v7 commit message explaining on the chosen approach?
>=20
> > > > The per-channel SPI interfaces exist only for register configuratio=
n; the
> > > > actual data path is a single stream handled entirely by the backend.
> > > > =20
> > > > > We have similar (to some extend) cases with SPI/I=C2=B2C where
> > > > > drivers/platform/x86/serial-multi-instantiate.c services as "MFD"=
 for that
> > > > > type of busses.
> > > > > =20
> > > > > > - A single interleaved data output stream =20
> > > > >
> > > > > How does it work in non-racy way? =20
> > > >
> > > > The data path has no software involvement at runtime. The CNV clock
> > > >  triggers both channels to sample simultaneously, and the device ou=
tputs
> > > >  the conversion results as a single interleaved bitstream on the da=
ta
> > > >  lane(s). The FPGA backend captures this stream directly - no SPI
> > > >  register reads are involved in the data path. The only SPI traffic=
 is
> > > >  for configuration, and each channel has its own independent SPI
> > > >  interface and regmap, so there is no shared bus contention. =20

In this whole discussion this is the one element that I think maybe needs
some additional clarification.

=46rom the datasheet it looks to me like there are actually separate data pat=
hs
per channel. There are separate SPI / LVDS data lines.

Its a decision in the backend design / FPGA to fuse them. That is logical
because as you've noted the cnv clock is shared. Or is it?  In the initial
diagram on the datasheet first page it is shown as shared, but there are ac=
tually
separate CNV_chA+- and CNV_chB+. It's a draft datasheet, so if you can feed=
back
to the author it would be good to make it more consistent!

It would be possible to build a similar setup with multiple discrete
ADCs connected to a single backend - I just don't think we've seen that done
yet.=20

Have I understood the above correctly?

My initial thoughts if we did would be a virtual / multiplexer
IIO device front end that was a consumer of the two separate IIO ADC device
instances (and probably had a path to their shared backend) + those two
instances would use the same backend. Thus the front end device could
provide the buffer interfaces. Without some prototyping I'm not sure how
we'd pull that together.

Note that I'm not suggesting this is the time to work out how to solve
that setup!

To my mind, this driver is effectively performing role of that front end and
the individual ADC instance drivers all in one. I think it's reasonable
to assume no one is going to buy this chip to use the channels independently
and if they do we can later work out how to make that work without this
initial path getting much in the way.


> > >=20
> > > Okay, so it's in a way more complex (like a camera sensor in terms of
> > > data/configuration paths) device. It's now even more looking that the
> > > current approach is a quick hack rather than a solution to make this
> > > properly fit Linux device model. =20
> >=20
> > The driver uses spi_new_ancillary_device() for the config path and
> >  the IIO backend for the data path - both existing kernel
> >  infrastructure used as intended. No custom abstractions are added. =20
>=20
> Also would be nice to have something from this.
>=20
> So, I think for v7 we need transform this discussion to a summary that co=
vers
> all aspects:
>=20
> - why MFD box can't be applied here
> - why regmaps are independent
> - how does it look with data and configuration paths
> - the device is unique and we do not expect more to come (or very little =
chances)
> - et cetera (or what I forgot to mention)

Agreed on this list.

thanks,

Jonathan


>=20
> > > > > > Describing them as two independent DT nodes would mean duplicat=
ing
> > > > > > all the shared resources, and more importantly, the data interf=
ace
> > > > > > is a single interleaved stream feeding into one IIO buffer. Hav=
ing
> > > > > > two separate IIO devices would make synchronized capture imposs=
ible
> > > > > > from userspace. =20
> > >  =20
> > > > > > This is exactly the use case spi_new_ancillary_device() was des=
igned
> > > > > > for - a multi-die device sharing a bus with separate chip selec=
ts for
> > > > > > configuration but common data/clock/power infrastructure. =20
> > >=20
> > > This... It doesn't fit the data path as far as I read from the above.=
 =20
> >=20
> > Right, spi_new_ancillary_device() covers only the config path.
> > The data path is handled entirely by the IIO backend with no SPI
> > involvement at runtime.
> >  =20
> > > > > See above.
> > > > > =20
> > > > > > > TO me is either something special about channel 0, then we ha=
ve to
> > > > > > > synchronise
> > > > > > > accesses, or there is no point to have this patch at all, jus=
t make devices =20
> > > to =20
> > > > > > > be the same under the hood and describe as independent pair. =
=20
>=20

