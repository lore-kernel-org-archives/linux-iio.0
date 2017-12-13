Return-Path: <SRS0=ueJf=DJ=it-klinger.de=ak@kernel.org>
Date: Wed, 13 Dec 2017 18:09:05 +0100
From: Andreas Klinger <ak@it-klinger.de>
To: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
	singhalsimran0@gmail.com, linux-iio@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/2] iio: hx711: add buffered trigger support
Message-ID: <20171213170905.GA25179@arbeit>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-ID: <linux-iio@vger.kernel.org>

changes in v4:
thanks to the review of Jonathan, some issues were fixed:
- fixed error handling in hx711_probe()
- triggered-buffer cannot be allocated as managed device

changes in v3:
thanks to the review of Jonathan, some issues were fixed:
- locking in hx711_reset_read()
- data positioning in trigger handler

changes in v2:
- in Kconfig it's needed to select IIO_BUFFER and IIO_TRIGGERED_BUFFER to
  compile cleanly with buffered triggers

This small patch series adds:
- support for buffered triggers
- fixes a bug in the reset functionality


Andreas Klinger (2):
  iio: hx711: add triggered buffer support
  iio: hx711: fix bug in reset functionality

 drivers/iio/adc/Kconfig |   2 +
 drivers/iio/adc/hx711.c | 134 +++++++++++++++++++++++++++++++++++++-----------
 2 files changed, 106 insertions(+), 30 deletions(-)

-- 
2.1.4


-- 
