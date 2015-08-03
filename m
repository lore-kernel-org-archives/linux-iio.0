Return-Path: <mporter@konsulko.com>
From: Matt Porter <mporter@konsulko.com>
To: Linux IIO List <linux-iio@vger.kernel.org>,
	Devicetree List <devicetree@vger.kernel.org>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/3] MAX6675 IIO temperature driver
Date: Mon,  3 Aug 2015 16:56:47 -0400
Message-Id: <1438635410-3757-1-git-send-email-mporter@konsulko.com>
List-ID: <linux-iio@vger.kernel.org>

This series adds a driver for the MAX6675 SPI thermocouple converter.
The device supports temperature measurements via type-K thermocouples
and implements cold-junction compensation within the part. The datasheet
can be found at http://datasheets.maximintegrated.com/en/ds/MAX6675.pdf

Matt Porter (3):
  iio: temperature: add max6675 dt binding
  iio: temperature: add max6675 thermocouple converter driver
  MAINTAINERS: add max6675 driver

 .../bindings/iio/temperature/max6675.txt           |  19 +++
 MAINTAINERS                                        |   7 +
 drivers/iio/temperature/Kconfig                    |  11 ++
 drivers/iio/temperature/Makefile                   |   1 +
 drivers/iio/temperature/max6675.c                  | 155 +++++++++++++++++++++
 5 files changed, 193 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/temperature/max6675.txt
 create mode 100644 drivers/iio/temperature/max6675.c

-- 
2.1.4
