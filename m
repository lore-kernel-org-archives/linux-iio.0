Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 629C747D933;
	Fri, 15 May 2026 11:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778845644; cv=none; b=cEoo5ehPaqEgbTfU0nm08po5m++NhOSxfd86sdZxxV2sFd02qEUvVhR0I3ICw2IAj96ek/2u0106cPLFTOmkaKDFb3TMm+PfHGyrT3BV02KtJiKwWBRqQ/tvcupdfDkWGvDRZY7fECLXrhubAmS8e4UDjZ+FiZ4jdx6GDb/bCQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778845644; c=relaxed/simple;
	bh=izu3Yv8C0HpytL1nX8WW6ktwrKLP2bk22wNZ1K2u+JA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VSng5NT15kN9Zlbn3X4vZbg0BEPHUd8SGhpRBeZdwn0iyelJlNykZxBnNlI9DvdvYQyTN9R8LXtcZIdPI05ui2cSaBuRHRTQ805jpVDXW+Q8TPLFTYvVnJi+gQa45ZYBr0p/z68mBOPsOKmEbhB5cvbIa77feemjVE3UMhKb1bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LvIC/fP0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LvIC/fP0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC7C0C2BCF5;
	Fri, 15 May 2026 11:47:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778845643;
	bh=izu3Yv8C0HpytL1nX8WW6ktwrKLP2bk22wNZ1K2u+JA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LvIC/fP0DzdjseVvlkV3EoUVKWnugHxTrYBwZJGSPupLpomtZy+SyTRKWjq/NAweq
	 80IpXbCzMX86AmbZUvFQBkSfoFpQ5mgfuciwx5OTLyfsGyvplxiYRttJzroN1Xn5iF
	 AwiZl/rvglEIHx+FbFw+73dPvRqM5msDn1ZDGRivdsfvjCNIX+0nzSnJpuDdbXPrpa
	 4wBA7dnHbUymCjS98TF/tzbajhiCWWaEWE4AXq7bof9sCS1sAhgmbajzEDO48HzefF
	 KxEp6DOEqiQQuDRLC0qX0MfolZ7wL5RaQd3FHOFLf6yowHd9WvyLIygn5uZyx5qJdE
	 ii/1WNeEOaF4w==
Date: Fri, 15 May 2026 12:47:18 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: big.block0203@fastmail.com
Cc: linux-iio@vger.kernel.org, platform-driver-x86@vger.kernel.org,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [BUG] ACPI INT33D3 ambient light sensor not bound on Intel
 Lunar Lake (ThinkPad X1 Carbon Gen 13)
Message-ID: <20260515124718.6481e2c3@jic23-huawei>
In-Reply-To: <7915f7f0-d5fa-48a8-9aa6-fa2f8e621837@app.fastmail.com>
References: <7915f7f0-d5fa-48a8-9aa6-fa2f8e621837@app.fastmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 15 May 2026 14:51:09 +0400
big.block0203@fastmail.com wrote:

> Hi,
>=20
> On a Lenovo ThinkPad X1 Carbon Gen 13 (Intel Lunar Lake), the ACPI
> firmware declares an INT33D3 ambient light sensor as present, enabled,
> and functional, but no Linux driver binds to it. As a result, no IIO
> device is created and no ambient light data is available to userspace
> (KDE/GNOME auto-brightness, iio-sensor-proxy, etc.).

So INT33D3 is a new ID to IIO at least but looks like it
binds to drivers/input/misc/soc_button_array.c=20

So I'm guessing not an ALS unless that's a multipurpose chip - seems
unlikely though as that combination isn't common.

So if there is an ambient light sensor here that is exposed to
the OS we need to find it amongst the other IDs..

>=20
> I did not find an existing report covering this on Lunar Lake. Apologies
> if this duplicates one I missed; pointers welcome.
>=20
> Hardware
> =3D=3D=3D=3D=3D=3D=3D=3D
> - Lenovo ThinkPad X1 Carbon Gen 13
> - Intel Core Ultra 7 258V (Lunar Lake, Xe2)
> - iGPU: PCI 8086:64a0 (rev 04), subsystem 17aa:2339
> - Panel: Samsung Display ATNA40YK20-0 (2.8K OLED)
>=20
> Software
> =3D=3D=3D=3D=3D=3D=3D=3D
> - Fedora Kinoite 44
> - kernel 7.0.6-200.fc44.x86_64
> - KDE Plasma 6 on Wayland
>=20
> Symptom
> =3D=3D=3D=3D=3D=3D=3D
> No IIO devices are exposed at all:
>=20
>     $ ls /sys/bus/iio/devices/
>     (empty)
>     $ ls /sys/class/iio/
>     (empty)
>=20
> But the ALS is declared in ACPI:
>=20
>     $ cat /sys/bus/acpi/devices/INT33D3:00/hid
>     INT33D3
>=20
>     $ cat /sys/bus/acpi/devices/INT33D3:00/status
>     15
>=20
>     $ ls /sys/bus/acpi/devices/INT33D3:00/
>     cid  hid  modalias  path  physical_node  power  status  subsystem  ue=
vent
>     # No `driver` symlink under physical_node =E2=80=94 nothing bound.
>=20
>     $ readlink /sys/bus/acpi/devices/INT33D3:00/physical_node
>     ../../../../../../pci0000:00/0000:00:1f.0/PNP0C09:00/INT33D3:00
>=20
>     $ sudo dmesg | grep -i INT33D3
>     (no output =E2=80=94 no driver even attempted to probe)
>=20
> Status 0xf per ACPI spec means: present (bit 0), enabled (bit 1), shown
> in UI (bit 2), functional (bit 3). The firmware unambiguously declares
> the device as available. dmesg shows no probe attempt and no error.
>=20
> Other unclaimed firmware-declared devices on this platform (for context)
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>     INTC1025:00     status=3D?    driver=3DNONE
>     INTC105D:00     status=3D15   driver=3Dintel-pinctrl
>     INTC105D:01     status=3D15   driver=3Dintel-pinctrl
>     INTC105D:02     status=3D15   driver=3Dintel-pinctrl
>     INTC105D:03     status=3D15   driver=3Dintel-pinctrl
>     INTC105D:04     status=3D15   driver=3Dintel-pinctrl
>     INTC1068:00     status=3D15   driver=3Dint3400 thermal
>     INTC1069:00     status=3D15   driver=3Dint3403 thermal
>     INTC1069:01     status=3D15   driver=3Dint3403 thermal
>     INTC1069:02     status=3D15   driver=3Dint3403 thermal
>     INTC1069:03     status=3D15   driver=3Dint3403 thermal
>     INTC1069:04     status=3D15   driver=3Dint3403 thermal
>     INTC107B:00     status=3D15   driver=3Dintel-hid

It's more than possible that the ALS is presented as part of the HID.

>     INTC1092:00     status=3D0    driver=3DNONE
not 100% sure but there are some references to a wireless modem related
thing associated with this ID.

>     INTC109D:00     status=3D15   driver=3DNONE
Might be the watchdog.  Maybe see if it has a cid entry.


Other alternatives would be it's on a discoverable bus...

So without figuring out where it is, not much we can do here.

Good luck on finding more info!

Jonathan


>=20
> INTC109D:00 is also present-and-enabled but has no driver bound. Its
> function is unknown to me; including it for awareness in case it is
> sensor-hub-related and a prerequisite for INT33D3.
>=20
> INT3519:00 is also present in ACPI but with status=3D0 (disabled by
> firmware), so likely not relevant here.
>=20
> Expected behavior
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> An IIO device of class `in_illuminance*` should appear under
> /sys/bus/iio/devices/, allowing iio-sensor-proxy and desktop
> environments to consume ambient light data for auto-brightness.
>=20
> Thanks,
> big.block

