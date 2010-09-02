Return-Path: <manuel.stahl9ab33xy531iis.fraunhofer.de@bounce.antispameurope.com>
Message-ID: <4C7F52EC.3000006@iis.fraunhofer.de>
Date: Thu, 02 Sep 2010 09:31:56 +0200
From: Manuel Stahl <manuel.stahl@iis.fraunhofer.de>
MIME-Version: 1.0
To: Rhyland Klein <rklein@nvidia.com>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "jic23@cam.ac.uk" <jic23@cam.ac.uk>
Subject: Re: question about hwo to fit in an ALS driver
References: <E88A1D35AF5437468E5B14C7C4BA61C702CF4B627B@HQMAIL01.nvidia.com>
In-Reply-To: <E88A1D35AF5437468E5B14C7C4BA61C702CF4B627B@HQMAIL01.nvidia.com>
Content-Type: multipart/mixed;
 boundary="------------070805060006020007050007"
List-ID: <linux-iio@vger.kernel.org>

This is a multi-part message in MIME format.
--------------070805060006020007050007
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by iis.fhg.de id JAA01464

Am 02.09.2010 00:52, schrieb Rhyland Klein:
> I am looking into submitting a sensor driver for the isl29018 ambient
> light sensor (als). I noticed there is an old isl als driver for a
> different part (isl29003) in drivers/misc but I also see the light
> sensor driver for tsl2653 in the drivers/staging/iio/light directory
> which seems much more like the correct place for this type of sensor
> driver to reside.
>
> Is this subsystem designed for ALS drivers or a different type of
> light sensor?

It's designed for all kind of sensors. Of course not all are supported=20
properly yet.

> If it should support ALS drivers, I don't know how the
> IIO_DEV* attributes should map for this. I suppose it would just use
> the IIO_DEV_ATTR_LIGHT_VISIBLE for the lux, which could work, except
> that the isl29018 also functions as a proximity sensor, and the
> driver will support both modes.  What is the proper way to fit a
> driver like this into the iio subsystem?

 > One thing to note is that there are additional properties other than
 > just reporting the lux that will need to be supported including
 > changing the mode and setting the range, and I am not sure how these
 > should fit into the device attribute framework exposed via light.h.

When you have attributes that fit into the current scheme, use these.
When you have additional attributes that might be useful for other=20
sensors, make a name proposal.
When you have attributes, like mode, that are device specific, use=20
IIO_DEVICE_ATTR(_name, _mode, _show, _store, _addr) and put in a proper=20
name.


Regards,
--=20
Dipl.-Inf. Manuel Stahl
Fraunhofer-Institut f=FCr Integrierte Schaltungen IIS
- Leistungsoptimierte Systeme -
Nordostpark 93                Telefon  +49 (0)911/58061-6419
90411 N=FCrnberg                Fax      +49 (0)911/58061-6398
http://www.iis.fraunhofer.de  manuel.stahl@iis.fraunhofer.de

--------------070805060006020007050007
Content-Type: text/x-vcard; charset=utf-8;
 name="manuel_stahl.vcf"
Content-Disposition: attachment;
 filename="manuel_stahl.vcf"
Content-Transfer-Encoding: quoted-printable

begin:vcard
fn:Manuel Stahl
n:Stahl;Manuel
email;internet:manuel.stahl@iis.fraunhofer.de
tel;work:+49 911 58061-6419
x-mozilla-html:FALSE
version:2.1
end:vcard


--------------070805060006020007050007--
