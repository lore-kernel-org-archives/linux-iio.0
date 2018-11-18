Return-Path: <SRS0=LmQH=N5=usp.br=matheus.bernardino@kernel.org>
From: Matheus Tavares <matheus.bernardino@usp.br>
To: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>
Cc: linux-iio@vger.kernel.org,
	devel@driverdev.osuosl.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alexandru Ardelean <alexandru.ardelean@analog.com>,
	kernel-usp@googlegroups.com,
	victorcolombo@gmail.com
Subject: [PATCH v2 0/7] staging:iio:ad2s90: Add dt support and move out of staging
Date: Sun, 18 Nov 2018 02:25:33 -0200
Message-Id: <20181118042540.12697-1-matheus.bernardino@usp.br>
List-ID: <linux-iio@vger.kernel.org>

This series adds device tree support to ad2s90, adds the respective dt-binding  
documentation, solves all remaining codestyle problems in the driver code and
move it out of staging.                                                                 
                                                                                
This patch set completes all the remaining itens listed to be done before moving
the driver out of staging, enumerated in this mail thread:                      
https://marc.info/?l=linux-iio&m=154028966111330&w=2.

Alexandru Ardelean (1):
  staging:iio:ad2s90: Add max frequency check at probe

Matheus Tavares (5):
  staging:iio:ad2s90: Add device tree support
  staging:iio:ad2s90: Remove spi setup that should be done via dt
  dt-bindings:iio:resolver: Add docs for ad2s90
  staging:iio:ad2s90: Replace license text w/ SPDX identifier
  staging:iio:ad2s90: Move out of staging

Victor Colombo (1):
  staging:iio:ad2s90: Add comment to device state mutex

 .../bindings/iio/resolver/ad2s90.txt          |  28 ++++
 drivers/iio/resolver/Kconfig                  |  10 ++
 drivers/iio/resolver/Makefile                 |   1 +
 drivers/iio/resolver/ad2s90.c                 | 131 ++++++++++++++++++
 drivers/staging/iio/resolver/Kconfig          |  10 --
 drivers/staging/iio/resolver/Makefile         |   1 -
 drivers/staging/iio/resolver/ad2s90.c         | 127 -----------------
 7 files changed, 170 insertions(+), 138 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/resolver/ad2s90.txt
 create mode 100644 drivers/iio/resolver/ad2s90.c
 delete mode 100644 drivers/staging/iio/resolver/ad2s90.c

-- 
2.18.0
