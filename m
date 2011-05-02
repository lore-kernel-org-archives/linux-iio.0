Return-Path: <Michael.Hennerich@analog.com>
From: "Hennerich, Michael" <Michael.Hennerich@analog.com>
To: Jonathan Cameron <jic23@cam.ac.uk>, "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>
CC: "device-drivers-devel@blackfin.uclinux.org"
	<device-drivers-devel@blackfin.uclinux.org>, Drivers <Drivers@analog.com>
Date: Mon, 2 May 2011 14:05:14 +0100
Subject: RE: [RFC PATCH 0/2] staging:iio: add name_extend to allow for named
 channels
Message-ID: <544AC56F16B56944AEC3BD4E3D5917713AAF07290B@LIMKCMBX1.ad.analog.com>
References: <1304000663-5176-1-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1304000663-5176-1-git-send-email-jic23@cam.ac.uk>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

Jonathan Cameron wrote on 2011-04-28:
> This is needed for the light sensors where we indicate what a given
> sensor is measuring. It also came up in Michael's questions in the the
> thread Oddities and how to handle them.  Also for that matter allows
> us to put back the in0_supply_raw convention that got squashed in
> moving to iio_chan_spec registration.
>
> What do people think?

Looks good to me... And actually needed for the ADE7758 driver cleanup.
So it would be good if you could get this into your iio-onwards tree.

> (this is rather rough and ready, but then it is an RFC ;)
>
> Jonathan Cameron (2):
>   RFC add naming to channels
>   Example of naming usage
>  drivers/staging/iio/iio.h               |   26 +++-
>  drivers/staging/iio/industrialio-core.c |   34 +++-
>  drivers/staging/iio/light/tsl2563.c     |  323 +++++++++++------------
>  -------- 3 files changed, 165 insertions(+), 218 deletions(-)

Greetings,
Michael

--
Analog Devices GmbH      Wilhelm-Wagenfeld-Str. 6      80807 Muenchen
Sitz der Gesellschaft: Muenchen; Registergericht: Muenchen HRB 40368; Gesch=
aeftsfuehrer:Dr.Carsten Suckrow, Thomas Wessel, William A. Martin, Margaret=
 Seif
