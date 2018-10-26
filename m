Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-eopbgr30093.outbound.protection.outlook.com ([40.107.3.93]:50723
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726815AbeJ0Cwl (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 26 Oct 2018 22:52:41 -0400
From: Carlos Iglesias <carlos.iglesias@emutex.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>
CC: "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Dan O'Donovan <dan.odonovan@emutex.com>,
        Carlos Iglesias <carlos.iglesias@emutex.com>
Subject: [PATCH 0/2] iio: pressure: Add support for Honeywell HSC SPI sensors
Date: Fri, 26 Oct 2018 18:14:35 +0000
Message-ID: <20181026181406.14545-1-carlos.iglesias@emutex.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi all,

The Honeywell HSC is a series of pressure sensors that provide different
pressure ranges and measurement types (absolute, differential, gauge). The
available output types are analog, I2C or SPI (see [1]).

This driver provides support for a limited set of the HSC sensor models,
namely the absolute pressure sensors with SPI interface.

References:
[1] Datasheet https://sensing.honeywell.com/honeywell-sensing-trustability-=
hsc-series-high-accuracy-board-mount-pressure-sensors-50099148-a-en.pdf
[2] SPI Communications with Honeywell Digital Output Pressure Sensors https=
://sensing.honeywell.com/spi-comms-digital-ouptu-pressure-sensors-tn-008202=
-3-en-final-30may12.pdf

Carlos Iglesias (2):
  dt-bindings: iio: pressure: Add support for Honeywell HSC SPI sensors
  iio: pressure: Add support for Honeywell HSC SPI sensors

 .../bindings/iio/pressure/hsc_spi.txt         |  85 +++
 MAINTAINERS                                   |   6 +
 drivers/iio/pressure/Kconfig                  |  10 +
 drivers/iio/pressure/Makefile                 |   2 +
 drivers/iio/pressure/hsc_spi.c                | 543 ++++++++++++++++++
 5 files changed, 646 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/pressure/hsc_spi.=
txt
 create mode 100644 drivers/iio/pressure/hsc_spi.c

--=20
2.19.1
