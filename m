Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAFC9405C33;
	Sat, 16 May 2026 10:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778926868; cv=none; b=LCY6FYfbnYfPF6LjNFSo4U3AEzdhHNZFiXppGvW6DQ33Of1+ppdS7C6LGB5bL4gqp+uI6T2lXspTBfvIVPr1/Jg+xX1QEZHgCpit9i0IT6tH/dwKfg3XRKqTS31FDYsp05xSyIIAlRbCDjONcScorpLdrt+VqaUhNK49kBY53pM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778926868; c=relaxed/simple;
	bh=ayP8RTZV4aYS2r9BLo6oxyb7aJ6ZybkcMp13vh+CxOg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LI5LqAD0qv46/8C53f0IHPWS8tLyuoVU6vP3oaEowYaW26uhv0HF6CujU4uUC087assNRT8aADnUFnmb5AQjnAlqmXLK8r8L/EjBMYV6BsSytROuWcNc+UBfq39lKk1gds+TDxIf4d097KSquVBbEdphtJYVngH/Y31XeS41nEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FHKM1Mzy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FHKM1Mzy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56A43C19425;
	Sat, 16 May 2026 10:21:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778926867;
	bh=ayP8RTZV4aYS2r9BLo6oxyb7aJ6ZybkcMp13vh+CxOg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=FHKM1MzySVT5ClMJdbvU9+3HIucfIV84zqtCridmzIpVNr6txWMjNKrVDXiZB7yYM
	 QiMfZ4ZirCWuF+PswB/oatMb+mGk4vEyCE6AAEo+VNojg24hZDRH3xyyN3SXbDskfi
	 frMstlyG7Gr/Oy/G9LuzAuF3PwL4+tZY2+M7p5iP4GeekeWTExhGvOOzXfxKkFA+eV
	 Gwvob6B/QvoT6oqQPDnWiAYPRYkqt+1toeV0+/l0vb3L7qiCaVcq5rDRLNfx7XMxZb
	 ycOrSA3wHozRsedE9dFcaR9AcCzXhLm065Xqh/MmBoIdwUVriVW5iQaeuUuLTO/Vb3
	 g1nlS0NXujZfw==
Date: Sat, 16 May 2026 11:20:57 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Salih Erim <salih.erim@amd.com>
Cc: Guenter Roeck <linux@roeck-us.net>, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, git@amd.com, nuno.sa@analog.com, andy@kernel.org,
 dlechner@baylibre.com, michal.simek@amd.com, conall.ogriofa@amd.com,
 erimsalih@gmail.com, linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org
Subject: Re: [PATCH v2 2/5] iio: adc: add Versal SysMon driver
Message-ID: <20260516112057.381dc19c@jic23-huawei>
In-Reply-To: <ec5634b3-2f17-42b6-8bfb-124ac0c7cde8@amd.com>
References: <20260502111951.538488-1-salih.erim@amd.com>
	<20260502111951.538488-3-salih.erim@amd.com>
	<20260504183215.37c8ae65@jic23-huawei>
	<66268e35-4897-4c40-b358-1c973b70426b@roeck-us.net>
	<ec5634b3-2f17-42b6-8bfb-124ac0c7cde8@amd.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 12 May 2026 12:35:21 +0100
Salih Erim <salih.erim@amd.com> wrote:

> Hi Guenter and Jonathan,
>=20
> On 5/4/2026 8:26 PM, Guenter Roeck wrote:
> >=20
> >=20
> > On 5/4/26 10:32, Jonathan Cameron wrote: =20
> >> On Sat, 2 May 2026 12:19:48 +0100
> >> Salih Erim <salih.erim@amd.com> wrote:
> >> =20
> >>> Add the AMD/Xilinx Versal System Monitor (SysMon) IIO driver.
> >>>
> >>> The driver is split into a bus-agnostic core module
> >>> (versal-sysmon-core) and a memory-mapped I/O platform driver
> >>> (versal-sysmon). The core uses the regmap API so that different
> >>> bus implementations can share the same IIO logic.
> >>>
> >>> The core provides:
> >>> =C2=A0=C2=A0 - Static temperature channels (current max/min, peak max=
/min)
> >>> =C2=A0=C2=A0 - Supply voltage channels parsed from DT container nodes
> >>> =C2=A0=C2=A0 - Temperature satellite channels parsed from DT containe=
r nodes
> >>> =C2=A0=C2=A0 - read_raw for IIO_CHAN_INFO_RAW and IIO_CHAN_INFO_PROCE=
SSED
> >>> =C2=A0=C2=A0 - read_label using the DT label property =20
> >>
> >> Various comments inline.=C2=A0 One thing to check.
> >> Is this one strictly a hardware monitoring device? Or does it
> >> get used for more general ADC purposes?=C2=A0 Did you consider an HWMO=
N driver
> >> for it? The above sounds a lot like hwmon. So why IIO for this one?
> >>
> >> I wasn't awake enough on v1 to raise this!=C2=A0 Sorry about that.
> >> +CC Guenter and linux-hwmon for that discussion.
> >> =20
> >=20
> > This very much sounds like a hardware monitoring device to me. =20
>=20
> The device is indeed used for hardware monitoring, but the hardware
> characteristics push it towards IIO:
>=20
> - The predecessor (Zynq UltraScale+ AMS, xilinx-ams.c) is already
>    in drivers/iio/adc/ upstream. This driver is the direct successor
>    for the Versal generation.

Was a long time back but at the time I think it was argued that some
usecases for that device were general purpose external ADC channels
rather than just hardware monitoring. Is that true for the new IP?
(might not have been true for the old one!)

>=20
> - The supply voltage encoding is a modified floating-point format
>    with per-register exponent and format bits. This non-linear
>    encoding doesn't map well to hwmon's linear in*_input model.

Given IIO doesn't really do floating point either I assume that is
getting converted to something fixed point which ever subsystem
is used.

>=20
> - The device has configurable threshold events with per-channel
>    alarm registers, hysteresis bits, and level-sensitive interrupt
>    masking/unmasking -- which maps directly to the IIO event
>    infrastructure.

What in that list doesn't map to hwmon events?

>=20
> - Oversampling is hardware-configurable per channel type with
>    per-channel averaging enable registers.

I think this is not present in hwmon (could be wrong!) but is there
a 'right' configuration for a typical usecase?  I.e. would sensible
defaults work?

>=20
> - Up to 160 voltage and 64 temperature channels are dynamically
>    configured from DT, which fits IIO's dynamic channel model
>    better than hwmon's compile-time attribute groups.

This used to be true, but hwmon has for some years supported a similar
model for channel creation to that of IIO + you even for traditional
attributes it is easy enough to create them dynamically (that's afterall
what the IIO core does under the hood!)

Anyhow, take a look at struct hwmon_chip_info and the HWMON_CHANNEL_INFO()
macro.  I couldn't immediately spot a dynamic user but maybe Guenter can
point to one.

>=20
> - The follow-up thermal driver uses the IIO consumer API
>    (iio_channel_read) to aggregate temperature data across
>    multiple satellites into thermal zones. The iio-hwmon bridge
>    then exposes the same data to hwmon userspace.

This might be a good reason for IIO. However what stops you just embedding
all that in a single hwmon driver that also registers the thermal zones?

>=20
> So the architecture is: IIO driver (provider) -> iio-hwmon bridge
> (hwmon exposure) + IIO consumer (thermal zones). This gives both
> hwmon and thermal framework access through a single IIO provider.

So overall there are some possible reasons in here for using IIO but
I think a little more in depth analysis is needed.

Thanks,

Jonathan

> >=20
> > Guenter
> >  =20
>=20
> Salih.
>=20

