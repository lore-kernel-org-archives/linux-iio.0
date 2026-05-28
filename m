Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B14A43CF02B;
	Thu, 28 May 2026 12:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779969745; cv=none; b=tfoDFGz0TxG847tgubdgP/IBSUHNZ0unDlOfSRqCbzHudSXpW2tdJrTcdWUTRF9IqEHiRJMNMRQByMZvlNvHVekMZV6nmCR2qhTnqHo7SNtvVaMbqgljBMBdGNHciyIcTkVb43gCErUecax1yvrCOd0M0jVTDsYUpgFLnEdUcfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779969745; c=relaxed/simple;
	bh=2uY4ZI7usT1H7+lrAfujorYr9nqqsk5TvMq2DZK/CLg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VIhq/t39xF54T9DLF2drfr14aVHNQJfnURxFbUi4D5/FbwaelqL146yR/ONeG1pTVF1qhS69thLIWvyN+rlrxlIZgBwg1+9dvoQ+1xF/n2RwRRK+ZmUhisynUX5W+Atob7CVA3+tm7ygSMepBPMIUF06iuKJbiwIt4d1ScwD9x0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F4IRyAH1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F4IRyAH1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A84851F000E9;
	Thu, 28 May 2026 12:02:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779969744;
	bh=Pp3GhjbscioS3+95lLwvO/20+iWbgK2Y5aPIyvB2zvM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=F4IRyAH1piOWL3UDeMMoZ9fzmPWlWr6qkwJA/6OqKyDTj2iGLfZbneJiEzwS2+lv0
	 6R4YcLBcvAhQ8Ejq3txgqlsjmfvSwlsCcaDkPdLVWgOOKUqBhMMezg30ILx+NFjiLe
	 qh4k4yZrEkkJ1B7q+a8ewQP+IeebJoC5MJhGg28M+Kvp+cUPp9LH61SEmTUkPMfBDN
	 UDLECAL+YtIl9o0iVjx3qDN8/5U94oU0FuNh1zD7cFJAh9CDVdboPnkkxExupf4hUT
	 +BalC9j2KISUrlf7qkIhEO+FJeBr8wu5D94lC8BtD+Z6zZQD0zlBxwBTPAxiTfa+dx
	 etkyl5iwUUFIw==
Date: Thu, 28 May 2026 13:02:12 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: "Erim, Salih" <salih.erim@amd.com>
Cc: Guenter Roeck <linux@roeck-us.net>, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, git@amd.com, nuno.sa@analog.com, andy@kernel.org,
 dlechner@baylibre.com, michal.simek@amd.com, conall.ogriofa@amd.com,
 erimsalih@gmail.com, linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org
Subject: Re: [PATCH v2 2/5] iio: adc: add Versal SysMon driver
Message-ID: <20260528130212.409c5b60@jic23-huawei>
In-Reply-To: <0c51ed6b-1abb-45c7-ad5c-65605076dff3@amd.com>
References: <20260502111951.538488-1-salih.erim@amd.com>
	<20260502111951.538488-3-salih.erim@amd.com>
	<20260504183215.37c8ae65@jic23-huawei>
	<66268e35-4897-4c40-b358-1c973b70426b@roeck-us.net>
	<ec5634b3-2f17-42b6-8bfb-124ac0c7cde8@amd.com>
	<20260516112057.381dc19c@jic23-huawei>
	<d5fe3740-bd49-4835-acf1-b8cc56543318@roeck-us.net>
	<0c51ed6b-1abb-45c7-ad5c-65605076dff3@amd.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 18 May 2026 00:11:36 +0100
"Erim, Salih" <salih.erim@amd.com> wrote:

> Hi Guenter,
>=20
> On 16/05/2026 16:04, Guenter Roeck wrote:
> > Caution: This message originated from an External Source. Use proper=20
> > caution when opening attachments, clicking links, or responding.
> >=20
> >=20
> > On 5/16/26 03:20, Jonathan Cameron wrote: =20
> >> On Tue, 12 May 2026 12:35:21 +0100
> >> Salih Erim <salih.erim@amd.com> wrote:
> >> =20
> >>> Hi Guenter and Jonathan,
> >>>
> >>> On 5/4/2026 8:26 PM, Guenter Roeck wrote: =20
> >>>>
> >>>>
> >>>> On 5/4/26 10:32, Jonathan Cameron wrote: =20
> >>>>> On Sat, 2 May 2026 12:19:48 +0100
> >>>>> Salih Erim <salih.erim@amd.com> wrote:
> >>>>> =20
> >>>>>> Add the AMD/Xilinx Versal System Monitor (SysMon) IIO driver.
> >>>>>>
> >>>>>> The driver is split into a bus-agnostic core module
> >>>>>> (versal-sysmon-core) and a memory-mapped I/O platform driver
> >>>>>> (versal-sysmon). The core uses the regmap API so that different
> >>>>>> bus implementations can share the same IIO logic.
> >>>>>>
> >>>>>> The core provides:
> >>>>>> =C2=A0=C2=A0=C2=A0 - Static temperature channels (current max/min,=
 peak max/min)
> >>>>>> =C2=A0=C2=A0=C2=A0 - Supply voltage channels parsed from DT contai=
ner nodes
> >>>>>> =C2=A0=C2=A0=C2=A0 - Temperature satellite channels parsed from DT=
 container nodes
> >>>>>> =C2=A0=C2=A0=C2=A0 - read_raw for IIO_CHAN_INFO_RAW and IIO_CHAN_I=
NFO_PROCESSED
> >>>>>> =C2=A0=C2=A0=C2=A0 - read_label using the DT label property =20
> >>>>>
> >>>>> Various comments inline.=C2=A0 One thing to check.
> >>>>> Is this one strictly a hardware monitoring device? Or does it
> >>>>> get used for more general ADC purposes?=C2=A0 Did you consider an H=
WMON=20
> >>>>> driver
> >>>>> for it? The above sounds a lot like hwmon. So why IIO for this one?
> >>>>>
> >>>>> I wasn't awake enough on v1 to raise this!=C2=A0 Sorry about that.
> >>>>> +CC Guenter and linux-hwmon for that discussion.
> >>>>> =20
> >>>>
> >>>> This very much sounds like a hardware monitoring device to me. =20
> >>>
> >>> The device is indeed used for hardware monitoring, but the hardware
> >>> characteristics push it towards IIO:
> >>>
> >>> - The predecessor (Zynq UltraScale+ AMS, xilinx-ams.c) is already
> >>> =C2=A0=C2=A0=C2=A0 in drivers/iio/adc/ upstream. This driver is the d=
irect successor
> >>> =C2=A0=C2=A0=C2=A0 for the Versal generation. =20
> >>
> >> Was a long time back but at the time I think it was argued that some
> >> usecases for that device were general purpose external ADC channels
> >> rather than just hardware monitoring. Is that true for the new IP?
> >> (might not have been true for the old one!)
> >> =20
> >>>
> >>> - The supply voltage encoding is a modified floating-point format
> >>> =C2=A0=C2=A0=C2=A0 with per-register exponent and format bits. This n=
on-linear
> >>> =C2=A0=C2=A0=C2=A0 encoding doesn't map well to hwmon's linear in*_in=
put model. =20
> >>
> >> Given IIO doesn't really do floating point either I assume that is
> >> getting converted to something fixed point which ever subsystem
> >> is used.
> >> =20
> >>>
> >>> - The device has configurable threshold events with per-channel
> >>> =C2=A0=C2=A0=C2=A0 alarm registers, hysteresis bits, and level-sensit=
ive interrupt
> >>> =C2=A0=C2=A0=C2=A0 masking/unmasking -- which maps directly to the II=
O event
> >>> =C2=A0=C2=A0=C2=A0 infrastructure. =20
> >>
> >> What in that list doesn't map to hwmon events?
> >> =20
> >>>
> >>> - Oversampling is hardware-configurable per channel type with
> >>> =C2=A0=C2=A0=C2=A0 per-channel averaging enable registers. =20
> >>
> >> I think this is not present in hwmon (could be wrong!) but is there
> >> a 'right' configuration for a typical usecase?=C2=A0 I.e. would sensib=
le
> >> defaults work?
> >> =20
> >=20
> > There is a per sensor type "samples" attribute. I don't recall a request
> > or even a chip supporting per-channel oversampling, though such an=20
> > attribute
> > could easily be added if there is a use case. =20
>=20
> Good to know, thanks.
>=20
> >  =20
> >>>
> >>> - Up to 160 voltage and 64 temperature channels are dynamically
> >>> =C2=A0=C2=A0=C2=A0 configured from DT, which fits IIO's dynamic chann=
el model
> >>> =C2=A0=C2=A0=C2=A0 better than hwmon's compile-time attribute groups.=
 =20
> >>
> >> This used to be true, but hwmon has for some years supported a similar
> >> model for channel creation to that of IIO + you even for traditional
> >> attributes it is easy enough to create them dynamically (that's aftera=
ll
> >> what the IIO core does under the hood!)
> >>
> >> Anyhow, take a look at struct hwmon_chip_info and the=20
> >> HWMON_CHANNEL_INFO()
> >> macro.=C2=A0 I couldn't immediately spot a dynamic user but maybe Guen=
ter can
> >> point to one.
> >> =20
> >=20
> > There are several hardware monitoring drivers with dynamic sensor=20
> > allocation. =20
>=20
> Acknowledged, dynamic channels are not differentiator.
>=20
> >  =20
> >>>
> >>> - The follow-up thermal driver uses the IIO consumer API
> >>> =C2=A0=C2=A0=C2=A0 (iio_channel_read) to aggregate temperature data a=
cross
> >>> =C2=A0=C2=A0=C2=A0 multiple satellites into thermal zones. The iio-hw=
mon bridge
> >>> =C2=A0=C2=A0=C2=A0 then exposes the same data to hwmon userspace. =20
> >>
> >> This might be a good reason for IIO. However what stops you just=20
> >> embedding
> >> all that in a single hwmon driver that also registers the thermal zone=
s?
> >> =20
> > The hardware monitoring subsystem supports registering thermal sensors =
as
> > thermal zones. It would be up to the thermal subsystem to aggregate the=
m. =20
>=20
> Understood.
>=20
> To add some context from Jonathan's question about general-purpose
> ADC use: the Versal SysMon has 17 external analog channels (1 dedicated=20
> VP/VN differential pair + 16 auxiliary inputs on MIO/HDIO pins) that=20
> support unipolar and bipolar modes for measuring arbitrary external=20
> voltages, in addition to the internal supply and temperature monitoring.

Ok. I think this is the one item that has shown up in the discussion that
makes an argument this is a lot more general purpose than the name would
suggest and so possibly should be an IIO driver.

It is a fairly slow ADC though at only 8ksps so not sure how general
purpose these actually are but the potential is there.

Jonathan




>=20
> Thanks,
> Salih.
>=20
> >=20
> > Guenter
> >  =20
> >>>
> >>> So the architecture is: IIO driver (provider) -> iio-hwmon bridge
> >>> (hwmon exposure) + IIO consumer (thermal zones). This gives both
> >>> hwmon and thermal framework access through a single IIO provider. =20
> >>
> >> So overall there are some possible reasons in here for using IIO but
> >> I think a little more in depth analysis is needed.
> >>
> >> Thanks,
> >>
> >> Jonathan
> >> =20
> >>>>
> >>>> Guenter
> >>>> =20
> >>>
> >>> Salih.
> >>> =20
> >> =20
> >  =20
>=20
>=20

