Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FB9C24677B;
	Sun, 15 Feb 2026 19:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771183751; cv=none; b=A3hea2reaZgpEsOHNkzpIY6QXzlE3vEL7nw83+lnL9lQvnDEwg1TZxrQusPbetRi1alvJK/HkGDpnEbVC3d0f88azjqHQ0rltoWY6/7r/p1Rdqk8CgrpAsWGUnpsi2ZkI0r54LqdGpOgAGe/a+h8P3fpCCIl0LiKlsxq/EvONXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771183751; c=relaxed/simple;
	bh=zLaLcmSNawlbGGGAGMLWaP3Vsa9W85lOOL+d7+YYtJs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EV9MZtHALeD9eVpe4DVE3KWY7YqwcPF9gGxHgUl5HCPDjxw8VTuwccO9eMltY00xKxqa+om2ZNQHy1t1wtPJYui/iKJhsx2OPXsqMkGWwGFJLQ/qCTNMSqb4BPICj7JKrb4WYDMy16+bY1r3ZyTzlqj56MKHIEbUZA3rtM7AMDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FM0UmNY+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FM0UmNY+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D08EC4CEF7;
	Sun, 15 Feb 2026 19:29:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771183751;
	bh=zLaLcmSNawlbGGGAGMLWaP3Vsa9W85lOOL+d7+YYtJs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=FM0UmNY+OiJQR8mSiLgp3yCTghxX1wt5w7ZEBbWWiA6NLULw0pfXFeIBHJHNto/5c
	 2y/ykTHEUQChp94CKPXOXhT2vvxuUyCzQc4ek3RzJL0PvtDHN212AdrmhhMC+teJy0
	 BiKhhEvhoWe55cl51IciTSimU2Cs6L+swoSrtp9xMMEzVM/Wv67KxBHw+9xjQ0SsHj
	 XGIcXYGPJ/Xbnm3iHOTBX60QbdVE4gKwy8lAKxsXE4aPBKvkfVe/grJrOh/5N/Y6Kp
	 MY/vYZbsZXeOK40K+i4M4Chm0DzkU/LTz1eue5vzOv7HWd/WI0Z9saufQLBf13QSc+
	 30/6eqqnyalcQ==
Date: Sun, 15 Feb 2026 19:29:01 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Taha Ed-Dafili <0rayn.dev@gmail.com>, rdunlap@infradead.org,
 skhan@linuxfoundation.org,
 linux-kernel-mentees-archive@lists.linuxfoundation.org, nuno.sa@analog.com,
 andy@kernel.org, corbet@lwn.net, lars@metafoo.de,
 Michael.Hennerich@analog.com, linux-iio@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/4] docs: iio: adxl345: update math and examples for
 scaling
Message-ID: <20260215192901.0aa23e20@jic23-huawei>
In-Reply-To: <53cb71bb-4943-4e2f-bd26-9adeada84852@baylibre.com>
References: <20260208150515.14798-1-0rayn.dev@gmail.com>
	<20260208150515.14798-5-0rayn.dev@gmail.com>
	<53cb71bb-4943-4e2f-bd26-9adeada84852@baylibre.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sat, 14 Feb 2026 11:11:41 -0600
David Lechner <dlechner@baylibre.com> wrote:

> On 2/8/26 9:05 AM, Taha Ed-Dafili wrote:
> > Update the documentation to reflect the addition of event scaling
> > and correct existing technical errors in scale values.
> >=20
> > key changes:
> > - Fix the 62.5 g/LSB typo to 62.5 mg/LSB and add SI unit conversion.
> > - Correct decimal precision of in_accel_scale and
> > in_accel_scale_available to match actual SI unit (m/s^2)
> > values reported by the driver.
> > - Add sysfs example showing how to read and interpret the
> > newly implemented event scale factor.
> >=20
> > Suggested-by: Jonathan Cameron <jic23@kernel.org>
> > Signed-off-by: Taha Ed-Dafili <0rayn.dev@gmail.com>
> > ---
> >  Documentation/iio/adxl345.rst | 41 +++++++++++++++++++++++------------
> >  1 file changed, 27 insertions(+), 14 deletions(-)
> >=20
> > diff --git a/Documentation/iio/adxl345.rst b/Documentation/iio/adxl345.=
rst
> > index 3ca6a78feb5b..321565699817 100644
> > --- a/Documentation/iio/adxl345.rst
> > +++ b/Documentation/iio/adxl345.rst
> > @@ -13,7 +13,12 @@ This driver supports Analog Device's ADXL345/375 on =
SPI/I2C bus.
> >  * `ADXL375 <https://www.analog.com/ADXL375>`_
> > =20
> >  The ADXL345 is a general-purpose, low-power, 3-axis accelerometer with=
 selectable
> > -measurement ranges. The ADXL345 supports the =C2=B12 g, =C2=B14 g, =C2=
=B18 g, and =C2=B116 g ranges.
> > +measurement ranges. The ADXL345 supports the following ranges:
> > +
> > +- =C2=B12g  (approx. =C2=B119.61 m/s^2)
> > +- =C2=B14g  (approx. =C2=B139.23 m/s^2)
> > +- =C2=B18g  (approx. =C2=B178.45 m/s^2)
> > +- =C2=B116g (approx. =C2=B1156.91 m/s^2)
> > =20
> >  2. Device Attributes
> >  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > @@ -98,23 +103,23 @@ listed.
> >  +---------------------------------------------+-----------------------=
----------------------+
> >  | in_accel_gesture_singletap_timeout          | Single tap duration in=
 [us]                 |
> >  +---------------------------------------------+-----------------------=
----------------------+
> > -| in_accel_gesture_singletap_value            | Single tap threshold v=
alue in 62.5/LSB      |
> > +| in_accel_gesture_singletap_value            | Single tap threshold v=
alue                  |
> >  +---------------------------------------------+-----------------------=
----------------------+
> >  | in_accel_mag_falling_period                 | Inactivity time in sec=
onds                  |
> >  +---------------------------------------------+-----------------------=
----------------------+
> > -| in_accel_mag_falling_value                  | Inactivity threshold v=
alue in 62.5/LSB      |
> > +| in_accel_mag_falling_value                  | Inactivity threshold v=
alue                  |
> >  +---------------------------------------------+-----------------------=
----------------------+
> >  | in_accel_mag_adaptive_rising_en             | Enable AC coupled acti=
vity on X axis        |
> >  +---------------------------------------------+-----------------------=
----------------------+
> >  | in_accel_mag_adaptive_falling_period        | AC coupled inactivity =
time in seconds       |
> >  +---------------------------------------------+-----------------------=
----------------------+
> > -| in_accel_mag_adaptive_falling_value         | AC coupled inactivity =
threshold in 62.5/LSB |
> > +| in_accel_mag_adaptive_falling_value         | AC coupled inactivity =
threshold             |
> >  +---------------------------------------------+-----------------------=
----------------------+
> > -| in_accel_mag_adaptive_rising_value          | AC coupled activity th=
reshold in 62.5/LSB   |
> > +| in_accel_mag_adaptive_rising_value          | AC coupled activity th=
reshold               |
> >  +---------------------------------------------+-----------------------=
----------------------+
> >  | in_accel_mag_rising_en                      | Enable activity detect=
ion on X axis         |
> >  +---------------------------------------------+-----------------------=
----------------------+
> > -| in_accel_mag_rising_value                   | Activity threshold val=
ue in 62.5/LSB        |
> > +| in_accel_mag_rising_value                   | Activity threshold val=
ue                    |
> >  +---------------------------------------------+-----------------------=
----------------------+
> >  | in_accel_x_gesture_singletap_en             | Enable single tap dete=
ction on X axis       |
> >  +---------------------------------------------+-----------------------=
----------------------+
> > @@ -126,6 +131,10 @@ listed.
> >  +---------------------------------------------+-----------------------=
----------------------+
> >  | in_accel_z_gesture_singletap_en             | Enable single tap dete=
ction on Z axis       |
> >  +---------------------------------------------+-----------------------=
----------------------+
> > +| in_accel_gesture_scale                      | Tap threshold scale (0=
.612915 m/s^2).       |
> > ++---------------------------------------------+-----------------------=
----------------------+
> > +| in_accel_mag_scale                          | Activity threshold sca=
le (0.612915 m/s^2).  |
> > ++---------------------------------------------+-----------------------=
----------------------+ =20

Does it?  See below,

>=20
> It looks like the others are in alphabetical order (or , so would
> be nice to insert the new ones in the appropriate order.
>=20
> (in_accel_mag_falling is also out of order, so that could be part
> of the precursor cleanup patch)
>=20
> Also, missing in_accel_mag_adaptive_scale (it was added in
> the driver changes.)

That missing is particularly interesting as I think Claude code + Chris's p=
rompts found an issue
(took a while as I ran out of tokens yesterday!)

Issue: IIO_EV_INFO_SCALE is added to mask_shared_by_type for MAG and
  MAG_ADAPTIVE event types (both rising and falling), but
  adxl345_read_mag_value() doesn't handle IIO_EV_INFO_SCALE =E2=80=94 it fa=
lls
  through to default: return -EINVAL. The sysfs attributes
  in_accel_mag_scale and in_accel_mag_adaptive_scale will be created
  by the IIO core but reading them returns -EINVAL. The scale case
  is only handled for IIO_EV_TYPE_GESTURE events.

Which i think is right:
The code is only added in patch 3 for the TYPE_GESTURE, but the relevant
bit is set to create the interface you call out as missing... + indeed
in_accel_mag_scale.

Taha assuming this bug report is correct, please up your testing game.
This stuff is much easier for an author to find by actually looking at
what new files are created and checking they respond as expected than
it is for reviewers to figure out from patches.

Jonathan




>=20

