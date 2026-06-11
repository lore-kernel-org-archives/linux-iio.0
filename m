Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 109422D739C;
	Thu, 11 Jun 2026 16:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781194530; cv=none; b=e1Dtx/U37MHlxGammzo9wwGXjOak48VvFQlWIFvlN3jY334EuUGT8OC4/NpNkxrSXFyETvpjS4h9jT9yl4QmFlszBXau6oe5XrnV8XB9EGpNqtTB1O5Qw55v+sZ7rvad1nggcFm1oNZ8k2mNCBzrngYCXT+YeG3VioWf3sgvF3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781194530; c=relaxed/simple;
	bh=GzkMLOVGVfU5e/d/r0lVlmABkdCJ1H8QifQwXSQU02Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aCM7sqVfARU8faTcZzTERk0dKMWoNtemb5Xg8Os/Z8MOUfL2+V9Aw9USpK90jqhVGeqwiKMzkEM1wd4Kj6coM0vd9WZ4npLwdG6InJvN7+VA07MU3PrYN9r0bjhrDCnTS36hVXZAIcAs+2Boj3S8AXltsxru5NhXZBn210Oj2MI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Krci5kwN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Krci5kwN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5C311F00893;
	Thu, 11 Jun 2026 16:15:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781194528;
	bh=6wmtbsCr7ejFnlzM5tVGEOU70X2V3AM+TP+NKFtSlQI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Krci5kwN7SYrle7M4FUyQwrZerY2qAbcr+kND0cF8ALKb7cxzhx1HJ3JlM4Fb81mK
	 XwGJIIOIDYGMqal/ggMrUBIhyKmL3YUIAr8VRjrNQgYrDMcOiXE+Xesydkb3dHMlNz
	 2hJ+0LBo3FyvDGilmWCUlh8EEVLQetnFa+aeNVGkL6JRdraamDX4q4wO817JDLsLGN
	 jDlNHtIDBU8arPYli5Y9L0YDt/VU+jGAXML2uzxX7k+pODJ3BvSYsbMzQgo6cR+YKq
	 pPGnAv4Qk1ktBmMVj4w/6D15o5CwMmhbKugQxSlrx02yM9xPM+vxL+9b8zd4kQ7X0/
	 KXCr28h0VVuzQ==
Date: Thu, 11 Jun 2026 17:15:20 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Manuel Ebner <manuelebner@mailbox.org>
Cc: David Lechner <dlechner@baylibre.com>, Nuno Sa <nuno.sa@analog.com>,
 Andy Shevchenko  <andy@kernel.org>, open list
 <linux-kernel@vger.kernel.org>, linux-iio@vger.kernel.org
Subject: Re: [PATCH] Documentation: ABI: fix brackets and bracelets
Message-ID: <20260611171520.0a96ac83@jic23-huawei>
In-Reply-To: <54d15f70bd8ec76eea0a792ca701195b8472ee2a.camel@mailbox.org>
References: <20260611085620.127959-2-manuelebner@mailbox.org>
	<20260611104643.2a5ed6c2@jic23-huawei>
	<54d15f70bd8ec76eea0a792ca701195b8472ee2a.camel@mailbox.org>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 11 Jun 2026 13:54:04 +0200
Manuel Ebner <manuelebner@mailbox.org> wrote:

> On Thu, 2026-06-11 at 10:46 +0100, Jonathan Cameron wrote:
> > On Thu, 11 Jun 2026 10:56:21 +0200
> > Manuel Ebner <manuelebner@mailbox.org> wrote:
> >  =20
> > > Fix missing and needless brackets
> > > Fix missing bracelets
> > >=20
> > > Signed-off-by: Manuel Ebner <manuelebner@mailbox.org>
> > > ---
> > > =C2=A0Documentation/ABI/stable/sysfs-class-infiniband=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 | 4 ++--
> > > =C2=A0Documentation/ABI/testing/sysfs-bus-iio=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 4 ++--
> > > =C2=A0Documentation/ABI/testing/sysfs-bus-iio-adc-ad7192=C2=A0=C2=A0 =
| 2 +- =20
> >=20
> > Take a look at hos this stuff is routed into upstream.=C2=A0 Each=20
> > subsystem 'owns' their own documentation.=C2=A0 So this needs splitting=
 up
> > on a per subsystem basis.=C2=A0 I'll also note that you've only +CC IIO=
 folk
> > so you aren't going to get much review on the rest! =20
>=20
> I send it to the addresses get_maintainer returned, except the git blame
> ones. How can I find out who to send this to?

Some are easier to track down than others - look up related subsystems
in maintainers + look at anyone who has made significant changes to the fil=
es
in question.  However, some folk who work on Docs don't necessarily hang
around so also useful to use lore.kernel.org to see if they have been
on the list recently.  Also sometimes it is a bit fiddlier so look
at the original commits - that lets you find out what the files are associa=
ted
with.


INFINIBAND SUBSYSTEM
M:	Jason Gunthorpe <jgg@nvidia.com>
M:	Leon Romanovsky <leonro@nvidia.com>
L:	linux-rdma@vger.kernel.org

DMI/SMBIOS SUPPORT
M:	Jean Delvare <jdelvare@suse.com>
S:	Maintained

gsmi needed a bit of digging:
GOOGLE FIRMWARE DRIVERS
M:	Tzung-Bi Shih <tzungbi@kernel.org>
R:	Brian Norris <briannorris@chromium.org>
R:	Julius Werner <jwerner@chromium.org>
L:	chrome-platform@lists.linux.dev

Similar digging needed for sysfs-uevent, though I could probably have
guessed this one

DRIVER CORE, KOBJECTS, DEBUGFS AND SYSFS
M:	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
M:	"Rafael J. Wysocki" <rafael@kernel.org>
M:	Danilo Krummrich <dakr@kernel.org>
L:	driver-core@lists.linux.dev

IIO was the only one to have a specific match on these files.
It might be worth asking the other folk if they'd be happy to have
the MAINTAINERS entries updated to add one so that others find it easier
in future.

Jonathan

>=20
> > A few comments inline.
> >  =20
> > > =C2=A0Documentation/ABI/testing/sysfs-firmware-dmi-entries | 2 +-
> > > =C2=A0Documentation/ABI/testing/sysfs-firmware-gsmi=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 | 2 +-
> > > =C2=A0Documentation/ABI/testing/sysfs-uevent=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 2 +-
> > > =C2=A06 files changed, 8 insertions(+), 8 deletions(-)
> > >=20
> > > diff --git a/Documentation/ABI/stable/sysfs-class-infiniband
> > > b/Documentation/ABI/stable/sysfs-class-infiniband
> > > index 694f23a03a28..e48a0d2fb4e5 100644
> > > --- a/Documentation/ABI/stable/sysfs-class-infiniband
> > > +++ b/Documentation/ABI/stable/sysfs-class-infiniband
> > > @@ -157,8 +157,8 @@ Description:
> > > =C2=A0		all VLs from this port. This may include packets with errors.
> > > =C2=A0		This is 64 bit counter.
> > > =C2=A0
> > > -		port_rcv_packets: (RO) Total number of packets (this may include
> > > -		packets containing Errors. This is 64 bit counter.
> > > +		port_rcv_packets: (RO) Total number of packets, this may include
> > > +		packets containing Errors. This is a 64 bit counter. =20
> > Comma doesn't feel like the right choice here.=C2=A0 Perhaps,
> >=20
> > 		port_rc_packets: (RO) Total number of packets. May include
> > 		packets containing Errors. This is a 64 bit counter.
> >=20
> > Or just add the closing bracket. =20
>=20
> will do this.
>=20
> > > =C2=A0
> > > =C2=A0		link_downed: (RO) Total number of times the Port Training sta=
te
> > > =C2=A0		machine has failed the link error recovery process and downed
> > >=20
> > > diff --git a/Documentation/ABI/testing/sysfs-bus-iio-adc-ad7192
> > > b/Documentation/ABI/testing/sysfs-bus-iio-adc-ad7192
> > > index 28be1cabf112..108ea0abbdb6 100644
> > > --- a/Documentation/ABI/testing/sysfs-bus-iio-adc-ad7192
> > > +++ b/Documentation/ABI/testing/sysfs-bus-iio-adc-ad7192
> > > @@ -16,7 +16,7 @@ Description:
> > > =C2=A0		In bridge applications, such as strain gauges and load cells,
> > > =C2=A0		the bridge itself consumes the majority of the current in the
> > > =C2=A0		system. To minimize the current consumption of the system,
> > > -		the bridge can be disconnected (when it is not being used
> > > +		the bridge can be disconnected when it is not being used
> > > =C2=A0		using the bridge_switch_en attribute. =20
> >=20
> > I think intent would be better reflected here by adding the closing )
> > That last bit is kind of a 'by the way' rather than the dominant point =
of
> > the sentence. =20
>=20
> 		system. To minimize the current consumption of the system,
> -		the bridge can be disconnected (when it is not being used
> +		the bridge can be disconnected (when it is not being used)
>  		using the bridge_switch_en attribute.
> like this?

Looks good.

>=20
> >  =20
> > > =C2=A0
> > > =C2=A0What:		/sys/bus/iio/devices/iio:deviceX/in_voltage2-voltage2_sh=
orted_raw =20
> >  =20
> > > diff --git a/Documentation/ABI/testing/sysfs-firmware-gsmi
> > > b/Documentation/ABI/testing/sysfs-firmware-gsmi
> > > index 7a558354c1ee..88ca75d323d1 100644
> > > --- a/Documentation/ABI/testing/sysfs-firmware-gsmi
> > > +++ b/Documentation/ABI/testing/sysfs-firmware-gsmi
> > > @@ -18,7 +18,7 @@ Description:
> > > =C2=A0
> > > =C2=A0		/sys/firmware/gsmi/vars:
> > > =C2=A0
> > > -			This directory has the same layout (and
> > > +			This directory has the same layout and
> > > =C2=A0			underlying implementation as /sys/firmware/efi/vars.
> > > =C2=A0			See `Documentation/ABI/*/sysfs-firmware-efi-vars`
> > > =C2=A0			for more information on how to interact with =20
> > I think I'd add the bracket after implementation as this file is about =
ABI
> > so that's less important than the rest of the sentence. =20
>=20
> 			This directory has the same layout (and
> - 			underlying implementation as /sys/firmware/efi/vars.
> + 			underlying implementation) as /sys/firmware/efi/vars.
>  			See `Documentation/ABI/*/sysfs-firmware-efi-vars`
>  			for more information on how to interact with
>=20
> like this?

yes

Thanks,

Jonathan

>=20
> Thanks=20
>  manuel

