Return-Path: <Michael.Hennerich@analog.com>
From: "Hennerich, Michael" <Michael.Hennerich@analog.com>
To: Jonathan Cameron <jic23@cam.ac.uk>, "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>
Date: Tue, 8 Mar 2011 13:59:41 +0000
Subject: RE: Build iio as built in rather than module.
Message-ID: <544AC56F16B56944AEC3BD4E3D59177133FA8775EF@LIMKCMBX1.ad.analog.com>
References: <4D763507.2090003@cam.ac.uk>
In-Reply-To: <4D763507.2090003@cam.ac.uk>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

Jonathan Cameron wrote on 2011-03-08:
> Just a heads up.  Right now on a stargate 2 (pxa) I can't boot if IIO
> is built in rather than the module I normally use.
>
> Chasing down exactly why now.  Annoyingly this is occurring before any
> messages at all come out on the serial console so may take a while to
> track down.
>
> Jonathan

Works ok on Blackfin - however one thing I noticed a while ago.
In case IIO device drivers are build statically into the kernel,
udev/mdev and friends doesn't generate the device nodes on the fly.

Greetings,
Michael

--
Analog Devices GmbH      Wilhelm-Wagenfeld-Str. 6      80807 Muenchen
Sitz der Gesellschaft: Muenchen; Registergericht: Muenchen HRB 40368; Gesch=
aeftsfuehrer:Dr.Carsten Suckrow, Thomas Wessel, William A. Martin, Margaret=
 Seif
