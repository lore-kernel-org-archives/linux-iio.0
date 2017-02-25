Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:47146 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751571AbdBYSc1 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 25 Feb 2017 13:32:27 -0500
To: Greg KH <gregkh@linuxfoundation.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
From: Jonathan Cameron <jic23@kernel.org>
Subject: [PULL] Second set of fixes for IIO in the 4.11 cycle
Message-ID: <fce8d54d-9b02-283e-34ca-d6c4297cc125@kernel.org>
Date: Sat, 25 Feb 2017 18:31:55 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The following changes since commit 0f06feba91580df799c48bed753a7400a43d05f7:

  staging: bcm2835: cleanup: remove deprecated <asm/uaccess.h> include (2017-02-03 13:01:39 +0100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-fixes-for-4.11b

for you to fetch changes up to ca1c39ef76376b67303d01f94fe98bb68bb3861a:

  iio: adc: xilinx: Fix error handling (2017-02-25 16:39:32 +0000)

----------------------------------------------------------------
Second set of IIO fixes for IIO in the 4.11 cycle.

This series consists of fixes that either came in after the merge window
had opened or are fixes for work that merged during the merge window so had
to wait for that to hit mainline.

* 104-quad-8
  - Fix an off by one error in the register address for the flag register.
* rcar-gyroadc
  - protect against possible issues in future by dealing with childmode not
    being in a valid state.  This also deals with some build warnings.
* xilinx
  - fix some error handling paths to ensure resources are released in
    reverse order of being acquired.

----------------------------------------------------------------
Arnd Bergmann (1):
      iio: adc: handle unknow of_device_id data

Christophe JAILLET (1):
      iio: adc: xilinx: Fix error handling

William Breathitt Gray (1):
      iio: 104-quad-8: Fix off-by-one error when addressing flag register

 drivers/iio/adc/rcar-gyroadc.c     | 4 +++-
 drivers/iio/adc/xilinx-xadc-core.c | 6 +++---
 drivers/iio/counter/104-quad-8.c   | 2 +-
 3 files changed, 7 insertions(+), 5 deletions(-)
