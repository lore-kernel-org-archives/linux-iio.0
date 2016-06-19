Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:39799 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751364AbcFSUAS (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 19 Jun 2016 16:00:18 -0400
To: Greg KH <gregkh@linuxfoundation.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: [PULL] Second round of IIO fixes for the 4.7 cycle
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <eed3303a-b04b-f1f0-9615-c9cf6fa9c3a2@kernel.org>
Date: Sun, 19 Jun 2016 20:59:24 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The following changes since commit a9cc4006155a68dd0940728f4f222dd035180904:

  staging: lustre: lnet: Don't access NULL NI on failure path (2016-06-09 18:33:27 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-fixes-for-4.7b

for you to fetch changes up to f4070a19142d5ee06f0da0cef56a0e78995f172c:

  staging: iio: ad5933: fix order of cycle conditions (2016-06-11 18:37:13 +0100)

----------------------------------------------------------------
Second set of IIO fixes for the 4.7 cycle.

This includes one tracked regression (Arnd's patch for the ad7606).
The other two have I think always been broken.

* inv_mpu6050
  - Fix a use after free in the ACPI code.
* ad5933
  - The code for setting the cycles had a bug that meant it was simply wrong.
* ad7606_spi
  - Fix a regression that got introduced in a buggy cleanup of a sparse
    warning.

----------------------------------------------------------------
Arnd Bergmann (1):
      staging: iio: fix ad7606_spi regression

Crestez Dan Leonard (1):
      iio: inv_mpu6050: Fix use-after-free in ACPI code

Luis de Bethencourt (1):
      staging: iio: ad5933: fix order of cycle conditions

 drivers/iio/imu/inv_mpu6050/inv_mpu_acpi.c      | 5 +++--
 drivers/staging/iio/adc/ad7606_spi.c            | 2 +-
 drivers/staging/iio/impedance-analyzer/ad5933.c | 6 +++---
 3 files changed, 7 insertions(+), 6 deletions(-)
