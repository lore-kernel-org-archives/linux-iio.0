Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:57172 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750967AbcKFSFU (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 6 Nov 2016 13:05:20 -0500
To: Greg KH <gregkh@linuxfoundation.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: [PULL] Second set of IIO fixes for the 4.9 cycle.
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <5dd07645-0b93-a9d9-9f91-37382a43af4e@kernel.org>
Date: Sun, 6 Nov 2016 18:04:46 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The following changes since commit e866dd8aab76b6a0ee8428491e65fa5c83a6ae5a:

  greybus: fix a leak on error in gb_module_create() (2016-10-24 15:51:00 +0200)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-fixes-for-4.9b

for you to fetch changes up to 6f77199e9e4b84340c751c585691d7642a47d226:

  iio: hid-sensors: Increase the precision of scale to fix wrong reading interpretation. (2016-11-05 17:50:56 +0000)

----------------------------------------------------------------
Second set of IIO fixes for the 4.9 cycle.

Interestingly scale related fixes for accelerometers at both ends of
the range.  Obviously more varied devices turning up than we've seen before!

* ad5933
  - fix an uninitialized value in a return case that is winding up GCC.
* hid sensors
  - missing pm function prevents hid rotations sensors from working on newer
  ISH hubs (works by luck on older ones)
  - increase of scale precision needed to fix a case where on a yoga 260
  the reported scale is 0 (presumably a high precision but very low g sensor).
* st_sensors
  - fix an issue seen with the hs3lis331dl where the range is much greater
  than previous devices (100's of g) and hence the per bit scale is greater
  than 1.

----------------------------------------------------------------
Arnd Bergmann (1):
      staging: iio: ad5933: avoid uninitialized variable in error case

Lorenzo Bianconi (1):
      iio: st_sensors: fix scale configuration for h3lis331dl

Song Hongyan (2):
      iio: orientation: hid-sensor-rotation: Add PM function (fix non working driver)
      iio: hid-sensors: Increase the precision of scale to fix wrong reading interpretation.

 drivers/iio/accel/st_accel_core.c                  | 12 +++--
 .../iio/common/hid-sensors/hid-sensor-attributes.c | 56 +++++++++++-----------
 drivers/iio/common/st_sensors/st_sensors_core.c    |  8 ++--
 drivers/iio/orientation/hid-sensor-rotation.c      |  1 +
 drivers/staging/iio/impedance-analyzer/ad5933.c    | 17 ++++---
 5 files changed, 52 insertions(+), 42 deletions(-)
