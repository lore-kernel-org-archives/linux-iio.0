Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-43.csi.cam.ac.uk ([131.111.8.143]:42730 "EHLO
	ppsw-43.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751295Ab0EDKee (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 4 May 2010 06:34:34 -0400
Message-ID: <4BDFF8EE.2000201@cam.ac.uk>
Date: Tue, 04 May 2010 11:37:34 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: "Hennerich, Michael" <Michael.Hennerich@analog.com>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"uclinux-dist-devel@blackfin.uclinux.org"
	<uclinux-dist-devel@blackfin.uclinux.org>,
	"Getz, Robin" <Robin.Getz@analog.com>
Subject: Re: IIO:ADC Scan Modes
References: <544AC56F16B56944AEC3BD4E3D5917712E568A02D0@LIMKCMBX1.ad.analog.com>
In-Reply-To: <544AC56F16B56944AEC3BD4E3D5917712E568A02D0@LIMKCMBX1.ad.analog.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Michael
> The way available scan modes are handled in the max1363 driver doesn'=
t
> nicely equate to the AD7997, AD7997 or AD7991 series of ADCs.
> These devices feature up to 8 Channels while each channel can be inde=
pendently
> included into the scan sequence.
> (this would require up to 256 'named' modes)
I agree entirely.  The approach originally used in max1363 has gone in =
the latest
patch set posted the other day (indeed the set you reference below)
>=20
> A while ago we talked about this - and you said you would abandon the
> 'named' scan mode selection - and come up with something like a scan_=
elements
> directory with channel control files (enable/disable), and some sort =
of mechanism
> that rejects invalid combinations.
>=20
> I noticed some additions ...
> [PATCH 04/19] staging:iio: Support functions for scan mask matching
Yup.  That's what max1363 now does. In the same series, see
[PATCH 08/19] staging:iio:max1363 move to new abi.

(as the new abi didn't allow the 'named' scan mode approach!)

Other than some renaming, the lis3l20dq for example has done the scan_e=
lements
approach from the start (as have some of the others.)

Jonathan


>=20
> But the sysfs interface is not in place.
> Is this something you're still planning to put into place?
>=20
> Best regards,
> Michael
>=20
>=20
> ------------------------------------------------------------------
> ********* Analog Devices GmbH              Open Platform Solutions
> **  *****
> **     ** Wilhelm-Wagenfeld-Strasse 6
> **  ***** D-80807 Munich
> ********* Germany
> Registergericht M=FCnchen HRB 40368,  Gesch=E4ftsf=FChrer: Thomas Wes=
sel, William A. Martin, Margaret K. Seif
>=20
>=20

