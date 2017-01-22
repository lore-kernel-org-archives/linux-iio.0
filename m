Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:41018 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750741AbdAVQTU (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 22 Jan 2017 11:19:20 -0500
To: Greg KH <gregkh@linuxfoundation.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: [PULL] Second set of IIO fixes for the 4.10 cycle.
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <907faf53-6c5a-39bd-e87c-a3ab8d2cf915@kernel.org>
Date: Sun, 22 Jan 2017 16:12:13 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The following changes since commit a121103c922847ba5010819a3f250f1f7fc84ab8:

  Linux 4.10-rc3 (2017-01-08 14:18:17 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-fixes-for-4.10b

for you to fetch changes up to 5c113b5e0082e90d2e1c7b12e96a7b8cf0623e27:

  iio: dht11: Use usleep_range instead of msleep for start signal (2017-01-22 13:35:40 +0000)

----------------------------------------------------------------
Second set of IIO fixes for the 4.10 cycle.
* afe4403
  - retrieve valid iio_dev in suspend / resume. Previously using the wrong
    dev for a call to dev_to_iio_dev.
* afe4404
  - retrieve valid iio_dev in suspend / resume. Previously using the wrong
    dev for a call to dev_to_iio_dev.
* dht11
  - Something seems to have caused a regression in timing on the raspberry pi
    2B.  However, the bug that it threw up was real. msleep was occasionally
    resulting in very long sleeps, over the limit possible to read from this
    chip. Switch to usleep_range to avoid this.  The timing needed by this
    part is very fiddly.
* max30100
  - wrong parenthesis around fifo count check meant it always read after the
    almost_full state had been reached. I've tagged this with a fixes tag which
    covers the last patch that it will not need precursor patches.  The bug
    predates that but will need backporting.
* palmas_gpadc.
  - retrieve valid iio_dev in suspend / resume. Previously using the wrong
    dev for a call to dev_to_iio_dev.

----------------------------------------------------------------
Alison Schofield (3):
      iio: health: afe4403: retrieve a valid iio_dev in suspend/resume
      iio: health: afe4404: retrieve a valid iio_dev in suspend/resume
      iio: adc: palmas_gpadc: retrieve a valid iio_dev in suspend/resume

John Brooks (1):
      iio: dht11: Use usleep_range instead of msleep for start signal

Matt Ranostay (1):
      iio: health: max30100: fixed parenthesis around FIFO count check

 drivers/iio/adc/palmas_gpadc.c | 4 ++--
 drivers/iio/health/afe4403.c   | 4 ++--
 drivers/iio/health/afe4404.c   | 4 ++--
 drivers/iio/health/max30100.c  | 2 +-
 drivers/iio/humidity/dht11.c   | 6 ++++--
 5 files changed, 11 insertions(+), 9 deletions(-)
