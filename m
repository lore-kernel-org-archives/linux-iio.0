Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-32.csi.cam.ac.uk ([131.111.8.132]:53073 "EHLO
	ppsw-32.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755206Ab3LCVPj (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 3 Dec 2013 16:15:39 -0500
Message-ID: <529E43F1.207@cam.ac.uk>
Date: Tue, 03 Dec 2013 20:49:53 +0000
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: Greg KH <gregkh@linuxfoundation.org>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: [PULL] IIO fixes for 3.13 set 2
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The following changes since commit 930ba4a374b96560ef9fde2145cdc454a164ddcc:

  Staging: tidspbridge: disable driver (2013-11-27 09:32:49 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-fixes-for-3.13b

for you to fetch changes up to 419a4aaeb0f7a96359f7e937201b004f23e61976:

  Fix build failure for gp2ap020a00f.c (2013-12-02 21:11:30 +0000)

----------------------------------------------------------------
Second round of IIO fixes for the 3.13 cycle.

2 fixes here.

* The gp2ap020a00f is a simple missing kconfig dependency.

* The hid sensors hub fix is a work around for an issue introduced by hardware
changes due to a certain large software vendor having an 'interesting'
interpretation of the specification and hence indexing some arrays from 1
rather than 0.  The fix takes advantage of the logical min and max reading
facilities introduced by the precursor patch to figure out whether we have
a 0 indexed or 1 indexed device and to adjust appropriately.  It also
drops a previous kconfig option that allowed this issue to be worked around
at build time.

----------------------------------------------------------------
Russell King - ARM Linux (1):
      Fix build failure for gp2ap020a00f.c

Srinivas Pandruvada (2):
      HID: hid-sensor-hub: Add logical min and max
      iio: hid-sensors: Fix power and report state

 drivers/hid/hid-sensor-hub.c                        | 20 ++++++++------------
 drivers/iio/common/hid-sensors/Kconfig              |  9 ---------
 drivers/iio/common/hid-sensors/hid-sensor-trigger.c | 20 +++++++++++++++-----
 drivers/iio/light/Kconfig                           |  1 +
 include/linux/hid-sensor-hub.h                      |  2 ++
 include/linux/hid-sensor-ids.h                      | 12 ++++++++++++
 6 files changed, 38 insertions(+), 26 deletions(-)
