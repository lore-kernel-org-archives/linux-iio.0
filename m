Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-lf0-f65.google.com ([209.85.215.65]:33230 "EHLO
	mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753877AbcGUUcm (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 21 Jul 2016 16:32:42 -0400
From: Aleksei Mamlin <mamlinav@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	Aleksei Mamlin <mamlinav@gmail.com>
Subject: [PATCH 0/2] Add driver for Domintech DMARD06 accelerometer
Date: Thu, 21 Jul 2016 23:32:20 +0300
Message-Id: <1469133140-14722-1-git-send-email-mamlinav@gmail.com>
In-Reply-To: <1468846092-18914-1-git-send-email-mamlinav@gmail.com>
References: <1468846092-18914-1-git-send-email-mamlinav@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This patch series adds driver for Domintech DMARD06 low-g tri-axial
digital accelerometer and vendor prefix for Domintech Co., Ltd.

Changes since v1:
 - Rewrite driver to iio subsystem

Aleksei Mamlin (2):
  devicetree: bindings: Add vendor prefix for Domintech Co., Ltd.
  iio: accel: Add support for Domintech DMARD06 accelerometer

 .../devicetree/bindings/iio/accel/dmard06.txt      |  17 ++
 .../devicetree/bindings/vendor-prefixes.txt        |   1 +
 drivers/iio/accel/Kconfig                          |  11 ++
 drivers/iio/accel/Makefile                         |   1 +
 drivers/iio/accel/dmard06.c                        | 219 +++++++++++++++++++++
 5 files changed, 249 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/accel/dmard06.txt
 create mode 100644 drivers/iio/accel/dmard06.c

-- 
2.7.3

