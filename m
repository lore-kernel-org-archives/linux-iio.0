Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:45672 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751646AbbKVOYH (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 22 Nov 2015 09:24:07 -0500
To: Greg KH <gregkh@linuxfoundation.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: [PULL] IIO - Second set of fixes for the 4.4 cycle.
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <5651D004.2030600@kernel.org>
Date: Sun, 22 Nov 2015 14:24:04 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

he following changes since commit b57f9f34e27bf81c97b10d6725d71824e448c37e:

  Revert "Staging: wilc1000: coreconfigurator: Drop unneeded wrapper functions" (2015-11-18 13:22:44 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-fixes-for-4.4b

for you to fetch changes up to d4c65fe4ed69a62a30a680789322ed677e3438af:

  iio: adc: spmi-vadc: add missing of_node_put (2015-11-21 18:24:44 +0000)

----------------------------------------------------------------
Second set of IIO fixes for the 4.4 cycle.

Some of these were waiting for various code to hit during the merge
window - others have simply shown up recently.

* Dummy - fix a bug introduced recently that stops events actually
  reaching userspace.
* Lidar - return -EINVAL on getting a report of an invalid reading from
  the device.  This could mean that nothing is in range, or something
  else has gone wrong.  Basically it tells us nothing useful beyond the
  reading is bogus and should be ignored.
* apds9660 - make sure to call pm_runtime_mark_last_busy when reading
  from the device to avoid a premature disabling of the power.
* core - fix up a few missues of the WARN macro.
* spmi-vadc - fix a missing of_node_put when breaking out of
  a for_each_available_child_of_node loop.

The dummy driver is going to result in a slightly interesting
merge when this meets the togreg branch as that driver has graduated
from staging in the meantime.  I'll send an email in reply to that
pull request highlighting this as well.

----------------------------------------------------------------
Dan Carpenter (1):
      iio: fix some warning messages

Ioana Ciornei (1):
      staging: iio: dummy: complete IIO events delivery to userspace

Julia Lawall (1):
      iio: adc: spmi-vadc: add missing of_node_put

Matt Ranostay (2):
      iio: lidar: return -EINVAL on invalid signal
      iio: light: apds9960: correct ->last_busy count

 drivers/iio/adc/qcom-spmi-vadc.c                  | 4 +++-
 drivers/iio/industrialio-buffer.c                 | 2 +-
 drivers/iio/industrialio-core.c                   | 2 +-
 drivers/iio/light/apds9960.c                      | 1 +
 drivers/iio/proximity/pulsedlight-lidar-lite-v2.c | 6 +++---
 drivers/staging/iio/iio_simple_dummy_events.c     | 2 +-
 6 files changed, 10 insertions(+), 7 deletions(-)
