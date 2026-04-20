Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DDC4288C08;
	Mon, 20 Apr 2026 12:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776687576; cv=none; b=fNWxR+kwDh+d8S+n7yPezWpjuB78RaIJgfDLmOfGQ/8NIgOilC0eKzv/V2BFJPfUAq4eVPWL8k9DuYN+hTkJKo9FlhiK74c8H3TuPDXNGtO3yoj8nIdh19YiwQoWFgI5r5yw4tVR3Fdl0qX/HcXpHuLmNzwQN7e6fCgaIyv/gJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776687576; c=relaxed/simple;
	bh=MHIHzUv03e8rq48nZVbldDWJGUQRpzJ2S24vKjHjQPM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CaN3yBtTC0FDWxxNaHGRmQb10wxIpa1uEdtMYrKQRimxrScSSFjdliqzxW13tI/QI9mhLcY0vsdYlyG6/1ZJsi4hxPtlEUn1OtkJCFN+rf3PuWOI/OFNCJ7c/fOkEFYR4bc2iMAULPbQqf4uuddViVQa6kIX4XmhuLFy2JXeSIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jV4JoivI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jV4JoivI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F1A3C19425;
	Mon, 20 Apr 2026 12:19:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776687576;
	bh=MHIHzUv03e8rq48nZVbldDWJGUQRpzJ2S24vKjHjQPM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jV4JoivI2zjXeRrdNWRyrxquDElhlo1pZdw7YSwRbsQcq9B8lUVRGoWa9lSCRyUyX
	 TPepfn4vPbXl0o/PyOxgFriYwmtJw+pesxL7DjMk6u1nQyyWa2+jJxR6zSGsZWmNB3
	 2ooJo+Icj8a+okMuS7oTU2vLRZM4bckkjpqs9t3Be6a7Y+0GE+d26udm80WDwnleml
	 D+RnabdaGIIe5x7T1OMPGLyFZiHyQsB8XXr+PZZVYs2586Ie6+BqxlKqbugsJiiUxv
	 fCJobkw4WjMYQTqg47KTcYBeTViif0FMXILfonENuwJYTzKHMz3H2t25+J7zSsGViM
	 dqyitB74W7zzg==
Date: Mon, 20 Apr 2026 13:19:27 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Ariana.Lazar@microchip.com, dlechner@baylibre.com, nuno.sa@analog.com,
 linux-iio@vger.kernel.org, Jonathan.Cameron@huawei.com,
 linux-kernel@vger.kernel.org, andy@kernel.org, error27@gmail.com
Subject: Re: [PATCH] iio: dac: Fix passing uninitialized vref1_uV for no
 Vref1 case
Message-ID: <20260420131927.24c97451@jic23-huawei>
In-Reply-To: <ad5qsFP_7l3FATMA@ashevche-desk.local>
References: <20260414-mcp47feb02-fix4-v1-1-9d71badfd25e@microchip.com>
	<ad43ofFZwzEkYifY@ashevche-desk.local>
	<30022c5e780b2312e764c9e25399d67b2eed165c.camel@microchip.com>
	<ad5qsFP_7l3FATMA@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 14 Apr 2026 19:26:24 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Tue, Apr 14, 2026 at 02:26:45PM +0000, Ariana.Lazar@microchip.com wrot=
e:
> > On Tue, 2026-04-14 at 15:48 +0300, Andy Shevchenko wrote: =20
> > > EXTERNAL EMAIL: Do not click links or open attachments unless you
> > > know the content is safe =20
>=20
> You should get rid of this message. It's incompatible with OSS development
> process.
>=20
> > > On Tue, Apr 14, 2026 at 03:33:38PM +0300, Ariana Lazar wrote: =20
>=20
> ...
>=20
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0 vref1_uV =3D 0;
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (chip_features->have_ext_vref1) {=
 =20
> > >=20
> > > I'm wondering what will happen if we do the below unconditionally?
> > >  =20
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 ret =3D devm_regulator_get_enable_read_voltage(dev,
> > > > "vref1"); =20
> > >=20
> > > If we have no regulator, we get a dummy one, right? What is the
> > > voltage will
> > > be? 0?
> > >  =20
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 if (ret > 0) {
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 vref1_uV =3D r=
et;
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 data->use_vref=
1 =3D true;
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 } else {
> > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 vref1_uV =3D 0;
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dev_dbg(dev, "=
using internal band gap as
> > > > voltage reference 1.\n");
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dev_dbg(dev, "=
Vref1 is unavailable.\n");
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 } =20
> >=20
> > Thank you for the review.
> >=20
> > This is a safety check to ensure the devicetree matches the available
> > hardware. If Vref1 was selected in devicetree but unavailable in
> > hardware, the scales MCP47FEB02_SCALE_GAIN_X1 and
> > MCP47FEB02_SCALE_GAIN_X2 and also voltage readings would be incorrect
> > for the channels that use Vref1. =20
>=20
> I didn't get how. What I recommend is to do regulator request uncondition=
ally.
>=20
> > I did something similiar to what you have suggested in the first patch
> > I have submitted for this driver and checking first was recommended.
> >=20
> > https://lore.kernel.org/all/20250927185324.2f9e8061@jic23-huawei/ =20
>=20
> I briefly read that. The check was there, Jonathan just asked to modify
> the check itself IIUC, i.o.w. the semantics of the check was commented
> and not the check presence in the first place.
>=20
> Did I get it wrong? Jonathan, can we get rid of the check and ask for
> regulator unconditionally? (Maybe it would be good to print an error
> code in the debug message to be sure why it failed to get the regulator
> or its voltage.)
>=20
Whilst it might be harmless I'm not keen to get a regulator at all if it
doesn't exist.  Sure we'll see an error and the code will work (assuming
the non existent regulator isn't in the DT!) but we'll also get a debug
message that is at best misleading.  Vref1 would indeed be unavailable
because the specific device doesn't have a pin to connect it to!

So I think the outer guard still makes sense.=20

There is a reasonable question of why anything is using the value that
isn't initialized, and hence why the original bug exists?
I'm thinking it probably doesn't in practice, but that the
relationship between the flag and channel count etc is sufficiently complex
the compiler can't tell that.  So my assumption is this 'bug' is
a false positive.  We still want to tidy it up anyway on basis
it's not unreasonable that we are triggering static analysis warnings
on it!

J

