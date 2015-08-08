Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:60202 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2992525AbbHHTH2 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 8 Aug 2015 15:07:28 -0400
To: Greg KH <gregkh@linuxfoundation.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: [PULL] 4th set of IIO fixes for the 4.2 cycle
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <55C6536E.3030300@kernel.org>
Date: Sat, 8 Aug 2015 20:07:26 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The following changes since commit 40c3ef9d2f14cce91dbd6ae9c9ccf6210d8c5df7:

  staging: comedi: das1800: add missing break in switch (2015-07-31 16:59:47 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-fixes-for-4.2d

for you to fetch changes up to 2e8ea3cded44a8fe0ba4d4d14b290a458f969b1f:

  iio: event: Remove negative error code from iio_event_poll (2015-08-08 17:18:16 +0100)

----------------------------------------------------------------
Fourth set of IIO fixes for the 4.2 cycle.

* Poll functions for both event chardev and the buffer one were returning
  negative error codes (via a positive value).
* A recent change to lsiio adding some error handling that was wrong and
  stopped the tool working.
* bmg160 was missing some dependencies in Kconfig
* berlin2-adc had a misshandled register (wrote a value rather than a bitmap)

----------------------------------------------------------------
Cristina Opriceana (2):
      iio: industrialio-buffer: Fix iio_buffer_poll return value
      iio: event: Remove negative error code from iio_event_poll

Hartmut Knaack (1):
      iio:adc:berlin2-adc: Fix register definition

Linus Walleij (1):
      iio: lsiio: fix error code handling error

Markus Pargmann (1):
      iio: bmg160: IIO_BUFFER and IIO_TRIGGERED_BUFFER are required

 drivers/iio/adc/berlin2-adc.c     | 8 ++++----
 drivers/iio/gyro/Kconfig          | 3 ++-
 drivers/iio/industrialio-buffer.c | 2 +-
 drivers/iio/industrialio-event.c  | 2 +-
 tools/iio/lsiio.c                 | 4 ++--
 5 files changed, 10 insertions(+), 9 deletions(-)
