Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:48901 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752383AbbLVTEI (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 22 Dec 2015 14:04:08 -0500
To: Greg KH <gregkh@linuxfoundation.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: [PULL] Third set of IIO new stuff for the 4.5 cycle.
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <56799EA6.1010909@kernel.org>
Date: Tue, 22 Dec 2015 19:04:06 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The following changes since commit c34c18195d30aa3b95f5ae1b4349875c45fdb8e4:

  iio/inkern.c Use list_for_each_entry_safe (2015-12-12 17:23:37 +0000)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-for-4.5c

for you to fetch changes up to e8aab48b34d3bd069dfcf4ccb8f13ba8c98f7845:

  iio: adc: ina2xx: Fix incorrect report of data endianness to userspace. (2015-12-22 18:51:27 +0000)

----------------------------------------------------------------
Third set of new stuff for IIO in the 4.5 cycle.

New driver features
- us5182
  * Add interrupt support and rising / falling threshold events.

Cleanups / fixes to new stuff / minor additions
* Expose the IIO value formatting function for drivers to
  make use of internally.
- ina2xx
   * Fix wrong channel order
   * Fix incorrect reporting of endianness
   * Adding documentation of ABI unique to this device
- mma8452
  * Drop an unused register description
  * Use an enum for the channel index to aid readability
- sca3000
  * Use standard NULL comparison style
- us5182
  * fix an inconsistency in status of enable (a bug with no real effect until
    above patches are applied)
  * refactor the read_raw function to improve maintainability / readability.

----------------------------------------------------------------
Adriana Reus (3):
      iio: light: us5182d: Fix enable status inconcistency
      iio: light: us5182d: Add interrupt support and events
      iio: light: us5182d: Refactor read_raw function

Andrew F. Davis (1):
      iio: Make IIO value formating function globally available.

Bhaktipriya Shridhar (1):
      Staging: iio: accel: sca3000: Fixed NULL comparison style

Jonathan Cameron (1):
      iio: adc: ina2xx: Fix incorrect report of data endianness to userspace.

Marc Titinger (2):
      iio: ina2xx: fix channel order in software buffer
      iio: ina2xx: add ABI documentation entry sysfs-bus-iio-ina2xx-adc

Martin Kepplinger (2):
      iio: mma8452: remove unused register description
      iio: mma8452: use enum for channel index

 Documentation/ABI/testing/sysfs-bus-iio-ina2xx-adc |  24 ++
 drivers/iio/accel/mma8452.c                        |  40 +-
 drivers/iio/adc/ina2xx-adc.c                       |   6 +-
 drivers/iio/industrialio-core.c                    |   1 +
 drivers/iio/light/us5182d.c                        | 442 +++++++++++++++++----
 drivers/staging/iio/accel/sca3000_ring.c           |   2 +-
 include/linux/iio/iio.h                            |   2 +
 7 files changed, 414 insertions(+), 103 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-ina2xx-adc
