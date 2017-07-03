Return-Path: <SRS0=D67Y=6G=kapsi.fi=mikkoz@kernel.org>
From: Mikko Koivunen <mikko.koivunen@fi.rohmeurope.com>
To: jic23@kernel.org
Cc: pmeerw@pmeerw.net,
	knaack.h@gmx.de,
	lars@metafoo.de,
	Daniel Baluta <daniel.baluta@nxp.com>,
	linux-iio@vger.kernel.org,
	Mikko Koivunen <mikko.koivunen@fi.rohmeurope.com>
Subject: [PATCH v7 00/10] iio: light: rpr0521
Date: Mon,  3 Jul 2017 15:50:12 +0300
Message-Id: <1499086214-1811-1-git-send-email-mikko.koivunen@fi.rohmeurope.com>
List-ID: <linux-iio@vger.kernel.org>

Patchset v6->v7 changes:
  0001-0008 not reposted as they went upstream already
  0009 Shared irq support fixed, whitespace fixed

Patchset v5->v6 changes:
  0001-0008 not reposted as they went upstream already
  0009 Shared irq support, default trigger removed, devm_
  0010 patch added: Changed iio_device_register to devm_

Patchset v4->v5 changes:
  cover letter added
  0002 (void) removed

Patchset v3->v4 changes:
  0006 indent fix
  0009 on/off to preenable/postdisable

Patchset v2->v3 changes:
  More commits, numbers change, order change
  Changes listed in individual commits

Mikko Koivunen (10):
  iio: light: rpr0521 disable sensor -bugfix
  iio: light: rpr0521 poweroff for probe fails
  iio: light: rpr0521 on-off sequence change for CONFIG_PM
  iio: light: rpr0521 magic number to sizeof() on value read
  iio: light: rpr0521 whitespace fixes
  iio: light: rpr0521 sample_frequency read/write
  iio: light: rpr0521 proximity offset read/write
  iio: light: rpr0521 channel numbers reordered
  iio: light: rpr0521 triggered buffer
  iio: light: rpr0521 iio_device_register to devm_

 drivers/iio/light/rpr0521.c |  643 +++++++++++++++++++++++++++++++++++++++----
 1 file changed, 588 insertions(+), 55 deletions(-)

-- 
1.7.9.5
