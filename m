Return-Path: <Michael.Hennerich@analog.com>
From: "Hennerich, Michael" <Michael.Hennerich@analog.com>
To: Jonathan Cameron <jic23@cam.ac.uk>, "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>
CC: "device-drivers-devel@blackfin.uclinux.org"
	<device-drivers-devel@blackfin.uclinux.org>, Drivers <Drivers@analog.com>
Date: Mon, 18 Apr 2011 08:52:30 +0100
Subject: RE: [PATCH 48/70] staging:iio:ad7606 conversion to irq_chip based
 polling.
Message-ID: <544AC56F16B56944AEC3BD4E3D591771375475E5BC@LIMKCMBX1.ad.analog.com>
References: <1303067203-4894-1-git-send-email-jic23@cam.ac.uk>
 <1303067203-4894-49-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1303067203-4894-49-git-send-email-jic23@cam.ac.uk>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

Jonathan Cameron wrote on 2011-04-17:
> I'm far from sure what the best way to handle this particular part is,
> so have (I think) done the absolute minimum to change it to the new
> interface.

Typo below "adis16203_consumer%d"

Acked-by: Michael Hennerich <michael.hennerich@analog.com>

>
> Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
> ---
>  drivers/staging/iio/adc/ad7606_ring.c |   27 +++++++++++++++++++++----

Greetings,
Michael

--
Analog Devices GmbH      Wilhelm-Wagenfeld-Str. 6      80807 Muenchen
Sitz der Gesellschaft: Muenchen; Registergericht: Muenchen HRB 40368; Gesch=
aeftsfuehrer:Dr.Carsten Suckrow, Thomas Wessel, William A. Martin, Margaret=
 Seif
