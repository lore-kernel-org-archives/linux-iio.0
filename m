Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D8213BFE2B;
	Thu, 11 Jun 2026 11:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781178854; cv=none; b=MhoJaO1RCqD6KkypE4eAUxh2LHNFAgeEj1AkzCStiPZ/RapkK6CluCeT6afxl0IOkp6GiTle8wVVYZno+nbl2mMCVGfHeaO44UcXj5fnn4gZ5UlMLD+O8sCwCHUffQLJdLuz0WP1GtmLuBF/ZuCGIQGc1H68U74ngKRuyBHKxOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781178854; c=relaxed/simple;
	bh=Xv80KS5yr+YUqGOVhsjsa8GDxfm6NL7abNWHyhvUI7k=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oHG7k3Kzz0AEqHwsDVNBSU67NydcqYcBzm/C1O6D8jDZ//vBWzCOOzDrj9T9C5krWHjXvsuonZ/gS9pCsGgt0YFPduP8MTfsiP8wzVdRnmHm2RMGbp4+aCKKGU2t2dnLhnQLRKQPlfwWgoEhKU4tmnaofUUdL8jo0STJxGWNpU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=mzE+kRha; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="mzE+kRha"
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4gbgzM72nPz9tCL;
	Thu, 11 Jun 2026 13:54:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1781178848;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j0Ub6DE0awfUIpTUoD04oxV6KYn50NAFddi9VzrQcrM=;
	b=mzE+kRhapg4go1H/N0eh0H+3Am7dhYU2rQCsjS9H1SOMqfv6S7S/RHlsOdpxvFvqHzVYjz
	iNO6Y5Y3JY+m3jK/pC23Ygq6CQFlogFn1jiIxONzgc9Cq39g+Xj9lTyVrPBO0HBq4UyOKj
	xIPBoPWQR6GtQaspA1dZoKATjxlrr3v9DOkNHQNsRTD6cMYBoPxQda8yJEoWqlRWc08JnE
	K0q8P7SOe2v3HU015rotg94+AMxTCQalWn9OCpSR89nGd31o8jhn3FVBU6IhMA6nRMgGqH
	VyIuw/xsZtS8FF8dfVL9NxXe/Mu2m877TfGJvPB/J1XJ3qbv4zIdSPNyyn3O+w==
Message-ID: <54d15f70bd8ec76eea0a792ca701195b8472ee2a.camel@mailbox.org>
Subject: Re: [PATCH] Documentation: ABI: fix brackets and bracelets
From: Manuel Ebner <manuelebner@mailbox.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>, Nuno Sa <nuno.sa@analog.com>, 
 Andy Shevchenko
	 <andy@kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	linux-iio@vger.kernel.org
Date: Thu, 11 Jun 2026 13:54:04 +0200
In-Reply-To: <20260611104643.2a5ed6c2@jic23-huawei>
References: <20260611085620.127959-2-manuelebner@mailbox.org>
	 <20260611104643.2a5ed6c2@jic23-huawei>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MBO-RS-ID: 90a807b5c3d1ec7bcd8
X-MBO-RS-META: xrjmgwqwx8y5u5dsabcds6hkd6m37gmu

On Thu, 2026-06-11 at 10:46 +0100, Jonathan Cameron wrote:
> On Thu, 11 Jun 2026 10:56:21 +0200
> Manuel Ebner <manuelebner@mailbox.org> wrote:
>=20
> > Fix missing and needless brackets
> > Fix missing bracelets
> >=20
> > Signed-off-by: Manuel Ebner <manuelebner@mailbox.org>
> > ---
> > =C2=A0Documentation/ABI/stable/sysfs-class-infiniband=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 | 4 ++--
> > =C2=A0Documentation/ABI/testing/sysfs-bus-iio=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 4 ++--
> > =C2=A0Documentation/ABI/testing/sysfs-bus-iio-adc-ad7192=C2=A0=C2=A0 | =
2 +-
>=20
> Take a look at hos this stuff is routed into upstream.=C2=A0 Each=20
> subsystem 'owns' their own documentation.=C2=A0 So this needs splitting u=
p
> on a per subsystem basis.=C2=A0 I'll also note that you've only +CC IIO f=
olk
> so you aren't going to get much review on the rest!

I send it to the addresses get_maintainer returned, except the git blame
ones. How can I find out who to send this to?

> A few comments inline.
>=20
> > =C2=A0Documentation/ABI/testing/sysfs-firmware-dmi-entries | 2 +-
> > =C2=A0Documentation/ABI/testing/sysfs-firmware-gsmi=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 | 2 +-
> > =C2=A0Documentation/ABI/testing/sysfs-uevent=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 2 +-
> > =C2=A06 files changed, 8 insertions(+), 8 deletions(-)
> >=20
> > diff --git a/Documentation/ABI/stable/sysfs-class-infiniband
> > b/Documentation/ABI/stable/sysfs-class-infiniband
> > index 694f23a03a28..e48a0d2fb4e5 100644
> > --- a/Documentation/ABI/stable/sysfs-class-infiniband
> > +++ b/Documentation/ABI/stable/sysfs-class-infiniband
> > @@ -157,8 +157,8 @@ Description:
> > =C2=A0		all VLs from this port. This may include packets with errors.
> > =C2=A0		This is 64 bit counter.
> > =C2=A0
> > -		port_rcv_packets: (RO) Total number of packets (this may include
> > -		packets containing Errors. This is 64 bit counter.
> > +		port_rcv_packets: (RO) Total number of packets, this may include
> > +		packets containing Errors. This is a 64 bit counter.
> Comma doesn't feel like the right choice here.=C2=A0 Perhaps,
>=20
> 		port_rc_packets: (RO) Total number of packets. May include
> 		packets containing Errors. This is a 64 bit counter.
>=20
> Or just add the closing bracket.

will do this.

> > =C2=A0
> > =C2=A0		link_downed: (RO) Total number of times the Port Training state
> > =C2=A0		machine has failed the link error recovery process and downed
> >=20
> > diff --git a/Documentation/ABI/testing/sysfs-bus-iio-adc-ad7192
> > b/Documentation/ABI/testing/sysfs-bus-iio-adc-ad7192
> > index 28be1cabf112..108ea0abbdb6 100644
> > --- a/Documentation/ABI/testing/sysfs-bus-iio-adc-ad7192
> > +++ b/Documentation/ABI/testing/sysfs-bus-iio-adc-ad7192
> > @@ -16,7 +16,7 @@ Description:
> > =C2=A0		In bridge applications, such as strain gauges and load cells,
> > =C2=A0		the bridge itself consumes the majority of the current in the
> > =C2=A0		system. To minimize the current consumption of the system,
> > -		the bridge can be disconnected (when it is not being used
> > +		the bridge can be disconnected when it is not being used
> > =C2=A0		using the bridge_switch_en attribute.
>=20
> I think intent would be better reflected here by adding the closing )
> That last bit is kind of a 'by the way' rather than the dominant point of
> the sentence.

		system. To minimize the current consumption of the system,
-		the bridge can be disconnected (when it is not being used
+		the bridge can be disconnected (when it is not being used)
 		using the bridge_switch_en attribute.
like this?

>=20
> > =C2=A0
> > =C2=A0What:		/sys/bus/iio/devices/iio:deviceX/in_voltage2-voltage2_shor=
ted_raw
>=20
> > diff --git a/Documentation/ABI/testing/sysfs-firmware-gsmi
> > b/Documentation/ABI/testing/sysfs-firmware-gsmi
> > index 7a558354c1ee..88ca75d323d1 100644
> > --- a/Documentation/ABI/testing/sysfs-firmware-gsmi
> > +++ b/Documentation/ABI/testing/sysfs-firmware-gsmi
> > @@ -18,7 +18,7 @@ Description:
> > =C2=A0
> > =C2=A0		/sys/firmware/gsmi/vars:
> > =C2=A0
> > -			This directory has the same layout (and
> > +			This directory has the same layout and
> > =C2=A0			underlying implementation as /sys/firmware/efi/vars.
> > =C2=A0			See `Documentation/ABI/*/sysfs-firmware-efi-vars`
> > =C2=A0			for more information on how to interact with
> I think I'd add the bracket after implementation as this file is about AB=
I
> so that's less important than the rest of the sentence.

			This directory has the same layout (and
- 			underlying implementation as /sys/firmware/efi/vars.
+ 			underlying implementation) as /sys/firmware/efi/vars.
 			See `Documentation/ABI/*/sysfs-firmware-efi-vars`
 			for more information on how to interact with

like this?

Thanks=20
 manuel
