Return-Path: <SRS0=licw=EB=lxorguk.ukuu.org.uk=gnomes@kernel.org>
Date: Sat, 6 Jan 2018 00:20:24 +0000
From: Alan Cox <gnomes@lxorguk.ukuu.org.uk>
To: "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>,
        linux-input@vger.kernel.org
Subject: Re: [RFP] iio: Support of gesture sensor as a standard IIO sensor
Message-ID: <20180106002024.012f44c0@alans-desktop>
In-Reply-To: <1515197240.26317.65.camel@intel.com>
References: <1515197240.26317.65.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

> >From an IIO sensor point of view A Gesture sensor: =20
> Outputs
> 	A pre defined activity type
> 		WAKE
> 		TILT
> 		GLANCE
> 		PICK_UP
> 		=C2=A0&
> 		=C2=A0more
>=20
> 	A user defined activity type as "string"
>=20
> Inputs
> 	A raw binary cdev interface to download templates/patterns
>=20
>=20
> I want to gather more opinions before submitting a RFC patch.

The only question I have is should it appear under IIO or should it be an
input event interface. It feels to me more like an input device in that in
this case while it's not keys or joystick it is still 'please do X'. That
might also make it much easier (in the non-Android space in particular)
to bind these activities to actions in things like web browsers.

(+ linux-input)

Alan
