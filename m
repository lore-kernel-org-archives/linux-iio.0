Return-Path: <stefan.wahren@i2se.com>
From: Stefan Wahren <stefan.wahren@i2se.com>
To: jic23@kernel.org
Cc: festevam@gmail.com,
	kristina.martsenko@gmail.com,
	knaack.h@gmx.de,
	marex@denx.de,
	kernel@pengutronix.de,
	pawel.moll@arm.com,
	ijc+devicetree@hellion.org.uk,
	robh+dt@kernel.org,
	galak@codeaurora.org,
	mark.rutland@arm.com,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	Stefan Wahren <stefan.wahren@i2se.com>
Subject: [PATCH V2 0/2] iio: mxs-lradc: check ranges of ts properties
Date: Mon, 29 Dec 2014 10:27:19 +0000
Message-Id: <1419848841-12749-1-git-send-email-stefan.wahren@i2se.com>
List-ID: <linux-iio@vger.kernel.org>

These patch series fixes off-by-one issues of the touchscreen DT properties
and finally adds a range check during probe.

Only the range check has been tested by myself, because i don't have a
touchscreen. So a functional test is very welcome.

Changes since V1:
- fix format specifier in error message
- fix minor style issues

Changes since RFC:
- add fix for off-by-one issues
- first check DT properties and then assign a value
- adapt range check to better represent DT binding
- add important note from the reference manual as comment

Stefan Wahren (2):
  DT: mxs-lradc: fix ranges of ts properties
  iio: mxs-lradc: check ranges of ts properties

 .../bindings/staging/iio/adc/mxs-lradc.txt         |    4 +-
 drivers/staging/iio/adc/mxs-lradc.c                |   45 +++++++++++++++-----
 2 files changed, 37 insertions(+), 12 deletions(-)

-- 
1.7.9.5
