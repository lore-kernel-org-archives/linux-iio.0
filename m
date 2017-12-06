Return-Path: <SRS0=0tfs=DC=it-klinger.de=ak@kernel.org>
Date: Wed, 6 Dec 2017 09:51:26 +0100
From: Andreas Klinger <ak@it-klinger.de>
To: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
	singhalsimran0@gmail.com, linux-iio@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/2] iio: hx711: add buffered trigger support
Message-ID: <20171206084709.GA14698@arbeit>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-ID: <linux-iio@vger.kernel.org>

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
 drivers/iio/adc/hx711.c | 117 +++++++++++++++++++++++++++++++++++++-----------
 2 files changed, 94 insertions(+), 25 deletions(-)

-- 
2.1.4


-- 
