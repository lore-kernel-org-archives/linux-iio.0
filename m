Return-Path: <Michael.Hennerich@analog.com>
From: "Hennerich, Michael" <Michael.Hennerich@analog.com>
To: Jonathan Cameron <jic23@cam.ac.uk>, "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>
CC: "device-drivers-devel@blackfin.uclinux.org"
	<device-drivers-devel@blackfin.uclinux.org>, Drivers <Drivers@analog.com>
Date: Thu, 24 Feb 2011 20:26:33 +0000
Subject: RE: [PATCH] staging:iio:gyro: adis16080 cleanup, move to abi and
 bug fixes.
Message-ID: <544AC56F16B56944AEC3BD4E3D59177133FA5C01C9@LIMKCMBX1.ad.analog.com>
References: <1298578439-2080-1-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1298578439-2080-1-git-send-email-jic23@cam.ac.uk>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

Jonathan Cameron wrote on 2011-02-24:
> Much the same as teh adis16060 patch that preceeded it.
>
> Moved to standard sysfs naming and got rid of direct register writing
> from userspace.
>
> The rx and tx buffers are never used together so just have one and
> avoid the need to malloc it by using putting it in the state structure
> and using the ____cacheline_aligned trick.
>
> Couple of obvious bug fixes whilst I was here.
>
> I don't have one of these so can't test. This is done off datasheet.
> Note that as with the adis16060 driver there are parts that definitely
> wouldn't work before this patch.  Now it 'might' assuming I haven't
> messed up too badly.
>
> Would appreciate an Ack from someone at Analog.
>
> I've been a little lazy and not tracked down all the scale / offset
> values on the datasheet.  They can go in later.
>
> Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
Acked-by: Michael Hennerich <michael.hennerich@analog.com>

Greetings,
Michael

--
Analog Devices GmbH      Wilhelm-Wagenfeld-Str. 6      80807 Muenchen
Sitz der Gesellschaft: Muenchen; Registergericht: Muenchen HRB 40368; Gesch=
aeftsfuehrer:Dr.Carsten Suckrow, Thomas Wessel, William A. Martin, Margaret=
 Seif
