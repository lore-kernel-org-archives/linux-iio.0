Return-Path: <jic23@hermes.cam.ac.uk>
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: greg@kroah.com,
	guenter.roeck@ericsson.com,
	khali@linux-fr.org,
	dmitry.torokhov@gmail.com,
	broonie@opensource.wolfsonmicro.com,
	alan@lxorguk.ukuu.org.uk,
	arnd@arndb.de,
	linus.walleij@linaro.org,
	maxime.ripard@free-electrons.com,
	thomas.petazzoni@free-electrons.com,
	zdevai@gmail.com,
	w.sang@pengutronix.de,
	marek.vasut@gmail.com,
	Jonathan Cameron <jic23@kernel.org>
Subject: [RFC PATCH 0/5 V5] IIO: in kernel pull interfaces.
Date: Sun, 29 Jan 2012 11:46:49 +0000
Message-Id: <1327837614-24176-1-git-send-email-jic23@kernel.org>
Sender: "J.I. Cameron" <jic23@hermes.cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

Hi All,

Firstly this is an RFC rather than a final proposal because I know there is
an issue with the provider being removed before the consumer.  It will be easy
to make this less likely to happen, but I am not entirely sure how to avoid
any possible race (suggestion welcome).

Greg KH raised significant issues with how I originally proposed doing this
map registration (consumer - provider association).  Hence this version is
a lot more conventional (you may well notice that even the header naming is
lifted from the regulator framework).  The original proposal registered this
mapping completely independent of the iio drivers, thus requiring no in driver
changes.  This version requires passing the mapping through them.  There are
advantages to both approaches and we can always bolt the driver independent
version back in if there is sufficient justification for it at a later date.

Note that this series is against the full IIO tree in staging.

All comments welcome.

Jonathan

Jonathan Cameron (5):
  staging:iio:core add in kernel interface mapping and getting IIO
    channels.
  staging:iio: move iio data return types into types.h for use by
    inkern
  staging:iio::hwmon interface client driver.
  staging:iio:Documentation in kernel pull description.
  stargate2: example of map configuration for iio to hwmon example.

 arch/arm/mach-pxa/stargate2.c                  |   22 ++
 drivers/staging/iio/Documentation/inkernel.txt |   59 ++++++
 drivers/staging/iio/Kconfig                    |   16 ++-
 drivers/staging/iio/Makefile                   |    4 +-
 drivers/staging/iio/consumer.h                 |  103 ++++++++++
 drivers/staging/iio/driver.h                   |   34 +++
 drivers/staging/iio/iio.h                      |    6 -
 drivers/staging/iio/iio_core.h                 |    3 +
 drivers/staging/iio/iio_hwmon.c                |  226 +++++++++++++++++++++
 drivers/staging/iio/industrialio-core.c        |    2 +-
 drivers/staging/iio/inkern.c                   |  256 ++++++++++++++++++++++++
 drivers/staging/iio/machine.h                  |   30 +++
 drivers/staging/iio/types.h                    |    4 +
 13 files changed, 756 insertions(+), 9 deletions(-)
 create mode 100644 drivers/staging/iio/Documentation/inkernel.txt
 create mode 100644 drivers/staging/iio/consumer.h
 create mode 100644 drivers/staging/iio/driver.h
 create mode 100644 drivers/staging/iio/iio_hwmon.c
 create mode 100644 drivers/staging/iio/inkern.c
 create mode 100644 drivers/staging/iio/machine.h

-- 
1.7.8.4
