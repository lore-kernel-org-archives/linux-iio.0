Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4F893EEACB;
	Fri, 15 May 2026 18:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778870000; cv=none; b=fIi23J8IPGh/EoS3TJqFJGD15NG4+/OV95Rha13xUrOzKNJRi8IsaEg9mC58HzraQb/LXpAlYe4T9kEF6duo57P7f4KF48I4b1Cosn9tK7rotL4xTNgivtMXvxyKXZukeKtZR5MQDngwOBHKwPQ19KGTKMDPOByLUSpUiRzlimE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778870000; c=relaxed/simple;
	bh=xfZSxIoJK19gwrE9E7SGifWh9eoEO3UHtHjk6DVDYBI=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=A/mK17njU+NSngfktirTNq9pFmVQu5zPTyVEerJhJP2HjkmRlJ6O+rHwI/b4tcxt4FJIXFUQoBQllYmdKFHG8YvOutRyczYaXB59+wZBSGtkcF0xGVpYkL6SrqydCTmeSd9S66STBrQe1zDBqRFS6GyOGnmOkn9hXpzHqr258l0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=BJeUiZlh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=o7OXka5e; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="BJeUiZlh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="o7OXka5e"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 2A2671D00061;
	Fri, 15 May 2026 14:33:18 -0400 (EDT)
Received: from phl-imap-16 ([10.202.2.88])
  by phl-compute-04.internal (MEProxy); Fri, 15 May 2026 14:33:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1778869997;
	 x=1778956397; bh=ilS9yHfUk0M+1nOJH4mmR6H8ZDbliMMuc3QgNvTZS/U=; b=
	BJeUiZlhIpQd6yjL5xw9BjIuCcIlyA/kMGeGJWr1QTXRG/tIorpjY2AOCALrzl4F
	TPoCv9+3lADxAwnvASKkR2pW4ZTlDNg9bfN6XmNwdf4k2sxJe72wI3RjZOodiNok
	PRMRgJaRLQsPX6EYZPxeAAr7BK24d/otXz4OKnzKbYU4SDmyYiGbRum/ABKUhzJT
	MXPYsn1rTpZcG4VBc9J2jOfrDDMBwwGAOWJ2tCevgnQDvegLwNPwlI5i0gND1PTy
	1DPvG+0oVCeLlrKuQSiPBF2NlUWIFi27zFRFDHOo6GAiBtEBYKK+/S2zJrXyUbaj
	uQGAZvFqMfCqtBuCgUHXiw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1778869997; x=
	1778956397; bh=ilS9yHfUk0M+1nOJH4mmR6H8ZDbliMMuc3QgNvTZS/U=; b=o
	7OXka5eMJadY7reqfK5caOEEyt0q1nOcRuij4WJsMoQgbEG+6wA8k4XbW4emcInb
	92actggAh2SloVr8qUkZOYAeOMY1Wu+/DFkTZoiqm6S5vB9sicMUtBXXei6r1CGb
	r+vyZVa/pGzDL0z5lPMJ/7gCJe/QqzZvUIukZllMHqsOVweYugCWX2clXMKVU33K
	xd68+s2nRUbktN10zY5hSwaDyuO9cnosxuqiK88G6E1FmfavpMPRuQNVVSy1E5IP
	2yg5LRafXgMmkOdERt3A4s+LoTOb2Cd6AN3cHcwZcDrvwtFfAX7drF/N2Vbpwlny
	6SKN6qcJF3wUUPtfv1ECg==
X-ME-Sender: <xms:7WYHarFl3gwhlQ_PolvIi5RfwsKLt3mBPtQqo6Jiz0rmw6klHLTjbA>
    <xme:7WYHajImyWLjrzdb5AFCZxPO0XHiL6YXYSnRrHvLZBgrdiJ58fFTVI1f50OLwfZb9
    PGN4UIq9HeeaB0uUCrufJAchZzZLz7_BPvwL31hJ3kUILxRmxFbqYXo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddufeduudefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefoggffhffvvefkjghfufgtgfesthhqre
    dtredtjeenucfhrhhomhepsghighdrsghlohgtkhdtvddtfeesfhgrshhtmhgrihhlrdgt
    ohhmnecuggftrfgrthhtvghrnhepleeuleelgeffheekteegheevtdduffelveektdevgf
    ehtdfhgeeflefgfeffheefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehm
    rghilhhfrhhomhepsghighdrsghlohgtkhdtvddtfeesfhgrshhtmhgrihhlrdgtohhmpd
    hnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehjihgt
    vdefsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdgrtghpihesvhhgvg
    hrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhiihhosehvghgvrhdr
    khgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrh
    drkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphhlrghtfhhorhhmqdgurhhivhgvrhdq
    giekieesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:7WYHagxsX3I_b-zUWTu_DRDP3ey55wK4X3xMTrRhHWAqumpS5vBnZQ>
    <xmx:7WYHatk4sVQNKTjhnftpFnafAlIDt0eKhn3vq_8x5mjvvQgCqFfVIw>
    <xmx:7WYHapn5CUUEZMg9vsaPH5vv3O-aDCnWy7XiLndxtGrVz4VqKZWzAw>
    <xmx:7WYHavzaurE2Z59xBIgt37kNFRdjzSfJRidFucS3of7nsVrzMBad4g>
    <xmx:7WYHaidxIokX-HrrL2IhCOMWJD3T2_AAe-rEjlrCPY3XftPlTPkC1Nl0>
Feedback-ID: i35d941ae:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id CB9922CC0083; Fri, 15 May 2026 14:33:17 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 15 May 2026 22:32:57 +0400
From: big.block0203@fastmail.com
To: "Jonathan Cameron" <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, platform-driver-x86@vger.kernel.org,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <32f3063c-16cf-42a1-b122-118c291b3217@app.fastmail.com>
In-Reply-To: <20260515124718.6481e2c3@jic23-huawei>
References: <7915f7f0-d5fa-48a8-9aa6-fa2f8e621837@app.fastmail.com>
 <20260515124718.6481e2c3@jic23-huawei>
Subject: Re: [BUG] ACPI INT33D3 ambient light sensor not bound on Intel Lunar Lake
 (ThinkPad X1 Carbon Gen 13)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Jonathan,

Following up: PNP0C60 is not what I read it as initially. Per Microsoft's
ACPI/GPIO button documentation, _CID PNP0C60 is the laptop/slate mode
state indicator (the soc_button_array binding you mentioned). The
matching ACPI ID for an ALS is ACPI0008, and that device is not present
anywhere in this machine's namespace.

The laptop has a small unidentified optical element in the top bezel
beside the camera assembly that may be an ALS =E2=80=94 but the ACPI side
doesn't expose anything named like one. A walk of the LEN* and INT33D3
devices on this system:

    LEN0071:00  status=3D?   driver=3Di8042 kbd    (TrackPoint keyboard)
    LEN009F:00  status=3D0   driver=3DNONE         (disabled by firmware)
    LEN0100:00  status=3D15  driver=3DNONE
    LEN0111:00  status=3D15  driver=3DNONE
    LEN0112:00  status=3D15  driver=3DNONE
    LEN0130:00  status=3D15  driver=3DNONE         (Fn / Function Keys p=
er Lenovo Windows driver naming)
    LEN0140:00  status=3D0   driver=3DNONE         (disabled by firmware)
    LEN0268:00  status=3D15  driver=3DNONE         (ThinkPad HKEY; think=
pad_acpi matches this HID)
    LEN0310:00  status=3D?   driver=3Di8042 aux    (TrackPoint pointing =
device)
    INT33D3:00  status=3D15  driver=3DNONE

(driver=3D taken from physical_node/driver. thinkpad_acpi registers via
the ACPI bus rather than creating a platform-bus binding, so it doesn't
appear here even though it uses LEN0268.)

LEN0100, LEN0111, LEN0112 are the genuine unknowns. No IPU6 / INT3472
stack is present either =E2=80=94 this SKU's camera is a UVC device on U=
SB
(Chicony 04f2:b7e0, uvcvideo), so the ALS, if there is one, isn't
behind that path.

This looks like a thinkpad_acpi / platform-driver-x86 question rather
than an IIO one. I'll continue the discussion there. Thanks for the
help narrowing it down =E2=80=94 pointing at the cid field is what got u=
s here.

Regards,
big.block

On Fri, May 15, 2026, at 15:47, Jonathan Cameron wrote:
> On Fri, 15 May 2026 14:51:09 +0400
> big.block0203@fastmail.com wrote:
>=20
> > Hi,
> >=20
> > On a Lenovo ThinkPad X1 Carbon Gen 13 (Intel Lunar Lake), the ACPI
> > firmware declares an INT33D3 ambient light sensor as present, enable=
d,
> > and functional, but no Linux driver binds to it. As a result, no IIO
> > device is created and no ambient light data is available to userspace
> > (KDE/GNOME auto-brightness, iio-sensor-proxy, etc.).
>=20
> So INT33D3 is a new ID to IIO at least but looks like it
> binds to drivers/input/misc/soc_button_array.c=20
>=20
> So I'm guessing not an ALS unless that's a multipurpose chip - seems
> unlikely though as that combination isn't common.
>=20
> So if there is an ambient light sensor here that is exposed to
> the OS we need to find it amongst the other IDs..
>=20
> >=20
> > I did not find an existing report covering this on Lunar Lake. Apolo=
gies
> > if this duplicates one I missed; pointers welcome.
> >=20
> > Hardware
> > =3D=3D=3D=3D=3D=3D=3D=3D
> > - Lenovo ThinkPad X1 Carbon Gen 13
> > - Intel Core Ultra 7 258V (Lunar Lake, Xe2)
> > - iGPU: PCI 8086:64a0 (rev 04), subsystem 17aa:2339
> > - Panel: Samsung Display ATNA40YK20-0 (2.8K OLED)
> >=20
> > Software
> > =3D=3D=3D=3D=3D=3D=3D=3D
> > - Fedora Kinoite 44
> > - kernel 7.0.6-200.fc44.x86_64
> > - KDE Plasma 6 on Wayland
> >=20
> > Symptom
> > =3D=3D=3D=3D=3D=3D=3D
> > No IIO devices are exposed at all:
> >=20
> >     $ ls /sys/bus/iio/devices/
> >     (empty)
> >     $ ls /sys/class/iio/
> >     (empty)
> >=20
> > But the ALS is declared in ACPI:
> >=20
> >     $ cat /sys/bus/acpi/devices/INT33D3:00/hid
> >     INT33D3
> >=20
> >     $ cat /sys/bus/acpi/devices/INT33D3:00/status
> >     15
> >=20
> >     $ ls /sys/bus/acpi/devices/INT33D3:00/
> >     cid  hid  modalias  path  physical_node  power  status  subsyste=
m  uevent
> >     # No `driver` symlink under physical_node =E2=80=94 nothing boun=
d.
> >=20
> >     $ readlink /sys/bus/acpi/devices/INT33D3:00/physical_node
> >     ../../../../../../pci0000:00/0000:00:1f.0/PNP0C09:00/INT33D3:00
> >=20
> >     $ sudo dmesg | grep -i INT33D3
> >     (no output =E2=80=94 no driver even attempted to probe)
> >=20
> > Status 0xf per ACPI spec means: present (bit 0), enabled (bit 1), sh=
own
> > in UI (bit 2), functional (bit 3). The firmware unambiguously declar=
es
> > the device as available. dmesg shows no probe attempt and no error.
> >=20
> > Other unclaimed firmware-declared devices on this platform (for cont=
ext)
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >     INTC1025:00     status=3D?    driver=3DNONE
> >     INTC105D:00     status=3D15   driver=3Dintel-pinctrl
> >     INTC105D:01     status=3D15   driver=3Dintel-pinctrl
> >     INTC105D:02     status=3D15   driver=3Dintel-pinctrl
> >     INTC105D:03     status=3D15   driver=3Dintel-pinctrl
> >     INTC105D:04     status=3D15   driver=3Dintel-pinctrl
> >     INTC1068:00     status=3D15   driver=3Dint3400 thermal
> >     INTC1069:00     status=3D15   driver=3Dint3403 thermal
> >     INTC1069:01     status=3D15   driver=3Dint3403 thermal
> >     INTC1069:02     status=3D15   driver=3Dint3403 thermal
> >     INTC1069:03     status=3D15   driver=3Dint3403 thermal
> >     INTC1069:04     status=3D15   driver=3Dint3403 thermal
> >     INTC107B:00     status=3D15   driver=3Dintel-hid
>=20
> It's more than possible that the ALS is presented as part of the HID.
>=20
> >     INTC1092:00     status=3D0    driver=3DNONE
> not 100% sure but there are some references to a wireless modem related
> thing associated with this ID.
>=20
> >     INTC109D:00     status=3D15   driver=3DNONE
> Might be the watchdog.  Maybe see if it has a cid entry.
>=20
>=20
> Other alternatives would be it's on a discoverable bus...
>=20
> So without figuring out where it is, not much we can do here.
>=20
> Good luck on finding more info!
>=20
> Jonathan
>=20
>=20
> >=20
> > INTC109D:00 is also present-and-enabled but has no driver bound. Its
> > function is unknown to me; including it for awareness in case it is
> > sensor-hub-related and a prerequisite for INT33D3.
> >=20
> > INT3519:00 is also present in ACPI but with status=3D0 (disabled by
> > firmware), so likely not relevant here.
> >=20
> > Expected behavior
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > An IIO device of class `in_illuminance*` should appear under
> > /sys/bus/iio/devices/, allowing iio-sensor-proxy and desktop
> > environments to consume ambient light data for auto-brightness.
> >=20
> > Thanks,
> > big.block
>=20
>=20
