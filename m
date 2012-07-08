Return-Path: <marxin.liska@gmail.com>
MIME-Version: 1.0
Date: Sun, 8 Jul 2012 22:03:42 +0200
Message-ID: <CAObPJ3PctmLP56NvmLvJd+4w9e4xeOGSyz24FyBDXBQQVhDhxQ@mail.gmail.com>
Subject: ACPI ambient light sensor
From: =?UTF-8?Q?Martin_Li=C5=A1ka?= <marxin.liska@gmail.com>
To: platform-driver-x86@vger.kernel.org, linux-iio@vger.kernel.org
Cc: Zhang Rui <rui.zhang@intel.com>, Corentin Chary <corentin.chary@gmail.com>,
	joeyli <jlee@suse.com>, Len Brown <len.brown@intel.com>, pavel@denx.de, marex@denx.de,
	Jonathan Cameron <jic23@jic23.retrosnub.co.uk>, Jonathan Cameron <jic23@kernel.org>
Content-Type: multipart/alternative; boundary=bcaec54a32527aa03f04c456fe6c
List-ID: <linux-iio@vger.kernel.org>

--bcaec54a32527aa03f04c456fe6c
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hello,
   Iconia Tab W500 contains Ambient Light Sensor (hid 0008), I started
implementing IIO device drive having following questions:

   - chip could offer following variables: illuminance, color chromaticity
   and color temperature, how should I connect last 2 vars to any of IIO
   CHANNEL types?
   - I'm not sure how to connect an illuminance mapping to IIO
   infrastructure?

Thank you,
Martin Li=C5=A1ka

--bcaec54a32527aa03f04c456fe6c
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hello,<div>=C2=A0 =C2=A0Iconia Tab W500 contains Ambient Light Sensor (hid =
0008), I started implementing IIO device drive having following questions:<=
/div><div><ul><li>chip could offer following variables: illuminance, color =
chromaticity and color temperature, how should I connect last 2 vars to any=
 of IIO CHANNEL types?</li>
<li>I&#39;m not sure how to connect an illuminance mapping to IIO infrastru=
cture?</li></ul><div>Thank you,</div></div><div>Martin Li=C5=A1ka</div>

--bcaec54a32527aa03f04c456fe6c--
