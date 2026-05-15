Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D157466B58;
	Fri, 15 May 2026 10:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778842292; cv=none; b=okMAO68CGBewUcQSUJsJMG85ua0fNToRXOiQ89xaUhjVKsiVH1tnXOCG+3PTOgOUH1JVICSwkTnaoFH9eVQ0ETp3vHcIClZsqS/Yr5+KU3ovFoJ60ptO3/a4uBAuHgSf6agMlotixpwJ6ejutAGES4Xj+CVQTowD8oO8G5ahobs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778842292; c=relaxed/simple;
	bh=AD3TgwhHcVfzsD4xvDE++E4XugmkZ9j8786UL0vVLhg=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:Subject:Content-Type; b=iNaPeT9npkA/Gn+oRK3urJ58VMBgjH6HQd2FHLqqSFbRAxU7EVsWE3I4vbwIECElGTDaOrnm3NeHS5AcRuZRfaXRkaYwx//YMFoP2UhhoA74aX827+YgRgCxj9AHElWVv/VlzfGVQ5gtiB+ex4kttIt1dtoFgBMEj4oQwFo2NK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=RroRBmiQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XzD9zj3b; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="RroRBmiQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XzD9zj3b"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id BA7A81400016;
	Fri, 15 May 2026 06:51:29 -0400 (EDT)
Received: from phl-imap-16 ([10.202.2.88])
  by phl-compute-04.internal (MEProxy); Fri, 15 May 2026 06:51:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm3; t=1778842289; x=1778928689; bh=bv
	OFtffGWM6Ojp16cG/kgjG/NJsQkSioMbS31xGV9ms=; b=RroRBmiQQ1Y4TRzXAJ
	ikVNO8bGwjwTXNYzxsWwXYUREvmpFhsNx++N/XUoKrbdLCe67Snsum/ads+INgEf
	+iZBRDMx21HOIew+5S7+QQK/GDyU8lmQ+x/lw/RQwzXV2HG2KWAgjkaAjCj5IAHQ
	2hJSBhZ1Pk/s/OaDtzeHZ/+o5ZueUvlQBUf4yGv/l01GxuIjHoP7Gv5oJ5cxa+3M
	wrK7AYsE0/yc+dJZ0SNbheleCe2M818bJ/zoosHB3LdhoYAdqeh+DXDd4OiEws7m
	VEnj2n1MWiOyzwwSTSdstHeYbfJaCIba0a5mtBGkyC7wJchcJLGdsRGNG1rqdlvy
	E6Sg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1778842289; x=1778928689; bh=bvOFtffGWM6Ojp16cG/kgjG/NJsQ
	kSioMbS31xGV9ms=; b=XzD9zj3bW9YULGSxP3flOIK+IbWXQsGzBOfRuNeIbZmV
	/YCJyGXpnfrNYL3bQegr0Gxm6cFab62mmZ7uk5vMDs7ZioEOFilIVzEBjBxmS9/d
	puJPUcrJSoZdGe/L+iD2R6V0eionwuRUryxfG8BMNyGE4n9U3QX4WW6EnC3FADSo
	Z//QRNFtymAqTrvS7n6CR6c0tNewYK2Ey/3NNdbCTE2N55UZOnQOhos9J62wkSyv
	/ApA7FR/A5IlH4VTtu70cVGTVyxCtNXqivmkSao5jgOKtay7qVZvG0jInl/cha/o
	DYubLEd08uI80ytrnuzpW/tn1iKIkq2Kt5h1qfuU9A==
X-ME-Sender: <xms:sfoGan5C5DwySV4arBwOjcONy_1fYM28UwoHcWFDg_Mj5TGwmf-1Ug>
    <xme:sfoGantXpGy2sQ7-2J8Eb4HbBHEbnd7DyfMpcxQaRs-xh4TQpXdO_YaGS9o6atu3j
    Nrk-yGBV0S3HgMq3zGfVdpVhpZEYWQxu2EHYGS8KNyGdK8L_PQeFw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddufedtvddtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefoggffhffvvefkufgtgfesthhqredtre
    dtjeenucfhrhhomhepsghighdrsghlohgtkhdtvddtfeesfhgrshhtmhgrihhlrdgtohhm
    necuggftrfgrthhtvghrnhepiefgheeuieettdekudehveegfeeikeejiedvvdfgveeuve
    elgfetveeuueeutdeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghi
    lhhfrhhomhepsghighdrsghlohgtkhdtvddtfeesfhgrshhtmhgrihhlrdgtohhmpdhnsg
    gprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehjihgtvdef
    sehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdgrtghpihesvhhgvghrrd
    hkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhiihhosehvghgvrhdrkhgv
    rhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkh
    gvrhhnvghlrdhorhhgpdhrtghpthhtohepphhlrghtfhhorhhmqdgurhhivhgvrhdqgiek
    ieesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:sfoGavlvbzbB6Hwq8TWcGXbsKlE6E-duUFKRRacJnGavLWbW8Ef0cA>
    <xmx:sfoGasLShVdrYP50QvGrB2eopULW5Fu876ZW-eQqLydLPgRa90_MYg>
    <xmx:sfoGas7Xomx4H3HFiHHUEi5D6Wes_zRayFd9iVGgPEMGcqu_0a1IaA>
    <xmx:sfoGao0VUbQFM5A7QM3TUdu-XSGXw0UaqJMsRAgbsABnSxkenZYcmw>
    <xmx:sfoGaiyErGbB2zJ6o-INfirVk9I7--ylC8lokrr4H1pnY5SCcpTT1swR>
Feedback-ID: i35d941ae:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 977B52CC0086; Fri, 15 May 2026 06:51:29 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 15 May 2026 14:51:09 +0400
From: big.block0203@fastmail.com
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org, platform-driver-x86@vger.kernel.org,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <7915f7f0-d5fa-48a8-9aa6-fa2f8e621837@app.fastmail.com>
Subject: [BUG] ACPI INT33D3 ambient light sensor not bound on Intel Lunar Lake
 (ThinkPad X1 Carbon Gen 13)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

On a Lenovo ThinkPad X1 Carbon Gen 13 (Intel Lunar Lake), the ACPI
firmware declares an INT33D3 ambient light sensor as present, enabled,
and functional, but no Linux driver binds to it. As a result, no IIO
device is created and no ambient light data is available to userspace
(KDE/GNOME auto-brightness, iio-sensor-proxy, etc.).

I did not find an existing report covering this on Lunar Lake. Apologies
if this duplicates one I missed; pointers welcome.

Hardware
=3D=3D=3D=3D=3D=3D=3D=3D
- Lenovo ThinkPad X1 Carbon Gen 13
- Intel Core Ultra 7 258V (Lunar Lake, Xe2)
- iGPU: PCI 8086:64a0 (rev 04), subsystem 17aa:2339
- Panel: Samsung Display ATNA40YK20-0 (2.8K OLED)

Software
=3D=3D=3D=3D=3D=3D=3D=3D
- Fedora Kinoite 44
- kernel 7.0.6-200.fc44.x86_64
- KDE Plasma 6 on Wayland

Symptom
=3D=3D=3D=3D=3D=3D=3D
No IIO devices are exposed at all:

    $ ls /sys/bus/iio/devices/
    (empty)
    $ ls /sys/class/iio/
    (empty)

But the ALS is declared in ACPI:

    $ cat /sys/bus/acpi/devices/INT33D3:00/hid
    INT33D3

    $ cat /sys/bus/acpi/devices/INT33D3:00/status
    15

    $ ls /sys/bus/acpi/devices/INT33D3:00/
    cid  hid  modalias  path  physical_node  power  status  subsystem  u=
event
    # No `driver` symlink under physical_node =E2=80=94 nothing bound.

    $ readlink /sys/bus/acpi/devices/INT33D3:00/physical_node
    ../../../../../../pci0000:00/0000:00:1f.0/PNP0C09:00/INT33D3:00

    $ sudo dmesg | grep -i INT33D3
    (no output =E2=80=94 no driver even attempted to probe)

Status 0xf per ACPI spec means: present (bit 0), enabled (bit 1), shown
in UI (bit 2), functional (bit 3). The firmware unambiguously declares
the device as available. dmesg shows no probe attempt and no error.

Other unclaimed firmware-declared devices on this platform (for context)
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
    INTC1025:00     status=3D?    driver=3DNONE
    INTC105D:00     status=3D15   driver=3Dintel-pinctrl
    INTC105D:01     status=3D15   driver=3Dintel-pinctrl
    INTC105D:02     status=3D15   driver=3Dintel-pinctrl
    INTC105D:03     status=3D15   driver=3Dintel-pinctrl
    INTC105D:04     status=3D15   driver=3Dintel-pinctrl
    INTC1068:00     status=3D15   driver=3Dint3400 thermal
    INTC1069:00     status=3D15   driver=3Dint3403 thermal
    INTC1069:01     status=3D15   driver=3Dint3403 thermal
    INTC1069:02     status=3D15   driver=3Dint3403 thermal
    INTC1069:03     status=3D15   driver=3Dint3403 thermal
    INTC1069:04     status=3D15   driver=3Dint3403 thermal
    INTC107B:00     status=3D15   driver=3Dintel-hid
    INTC1092:00     status=3D0    driver=3DNONE
    INTC109D:00     status=3D15   driver=3DNONE

INTC109D:00 is also present-and-enabled but has no driver bound. Its
function is unknown to me; including it for awareness in case it is
sensor-hub-related and a prerequisite for INT33D3.

INT3519:00 is also present in ACPI but with status=3D0 (disabled by
firmware), so likely not relevant here.

Expected behavior
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
An IIO device of class `in_illuminance*` should appear under
/sys/bus/iio/devices/, allowing iio-sensor-proxy and desktop
environments to consume ambient light data for auto-brightness.

Thanks,
big.block
