Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-208.synserver.de ([212.40.185.208]:1056 "EHLO
	smtp-out-208.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755197AbbHNOzD (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 14 Aug 2015 10:55:03 -0400
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 0/2] iio: One more buffer cleanup
Date: Fri, 14 Aug 2015 16:54:53 +0200
Message-Id: <1439564095-7352-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi,

One more buffer cleanup moving the generic buffer implementations to a
common sub-directory before we start adding new generic buffer
implementations in form of the DMA buffer.

- Lars

Lars-Peter Clausen (2):
  iio: Move callback buffer to its own module
  iio: Move generic buffer implementations to sub-directory

 drivers/iio/Kconfig                                | 22 +-------------------
 drivers/iio/Makefile                               |  5 +----
 drivers/iio/buffer/Kconfig                         | 24 ++++++++++++++++++++++
 drivers/iio/buffer/Makefile                        |  8 ++++++++
 .../industrialio-buffer-cb.c}                      | 12 +++++++++++
 .../{ => buffer}/industrialio-triggered-buffer.c   |  0
 drivers/iio/{ => buffer}/kfifo_buf.c               |  0
 7 files changed, 46 insertions(+), 25 deletions(-)
 create mode 100644 drivers/iio/buffer/Kconfig
 create mode 100644 drivers/iio/buffer/Makefile
 rename drivers/iio/{buffer_cb.c => buffer/industrialio-buffer-cb.c} (89%)
 rename drivers/iio/{ => buffer}/industrialio-triggered-buffer.c (100%)
 rename drivers/iio/{ => buffer}/kfifo_buf.c (100%)

-- 
2.1.4

