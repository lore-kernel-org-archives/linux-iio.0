Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:37530 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752302Ab3IHM5T (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 8 Sep 2013 08:57:19 -0400
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: lars@metafoo.de, Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH V3 0/5] IIO: Refactor info_mask* and ext_info handling and introduce info_mask_shared_[by_all/by_type]
Date: Sun,  8 Sep 2013 14:57:16 +0100
Message-Id: <1378648641-28280-1-git-send-email-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Changes since V2.
1) Fixed formatting in the iio_shared_by enum definition as pointed out
   by Lars.

Changes since V1.
1) Deal with ext_info as well as the info_mask.
   In the previous set things sort of worked by coincidence of the ordering
   in the enum.  This version handles this cleanly.
2) Dropped the bonus const in tmp006.

Original message :

This series first performs a bit of refactoring of the core handling
of info_mask_separate and info_mask_shared_by_type.

Next we introduce info_mask_shared_by_dir and info_mask_shared_by_all
to allow for attributes of the form

in_sampling_frequency or sampling_frequency as appropriate.

Most existing drivers will make no use of the shared_by_dir
case, but it is there to handle devices with both and input and
output channels.

There are two main reasons for adding these two cases.
1) Should result in shorter code, particularly for complex drivers.
2) Allows for in kernel consumers accessing this functionality.

The intent is to follow this series with one providing a standard
way of providing 'available' attributes.  The combination of the
two should mean that very few things are still handled via direct
registration of attributes.

Thanks,

Jonathan

Jonathan Cameron (5):
  iio: drop info_mask from struct iio_dev
  iio: refactor info mask and ext_info attribute creation.
  iio: add info_mask_[shared_by_dir/shared_by_all]
  staging:iio: dummy driver additions to show shared_by_dir infomask
    usage
  iio:temperature:tmp006 put sampling_frequency in
    info_mask_shared_by_all

 drivers/iio/dac/ad5064.c               |   3 +-
 drivers/iio/dac/ad5380.c               |   4 +-
 drivers/iio/dac/ad5446.c               |   3 +-
 drivers/iio/dac/ad5504.c               |   4 +-
 drivers/iio/dac/ad5624r_spi.c          |   4 +-
 drivers/iio/dac/ad5686.c               |   3 +-
 drivers/iio/dac/ad5755.c               |   1 +
 drivers/iio/dac/ad5791.c               |   5 +-
 drivers/iio/dac/ad7303.c               |   1 +
 drivers/iio/dac/mcp4725.c              |   3 +-
 drivers/iio/frequency/adf4350.c        |   1 +
 drivers/iio/iio_core.h                 |   2 +-
 drivers/iio/industrialio-buffer.c      |   2 +-
 drivers/iio/industrialio-core.c        | 179 ++++++++++++++++++++-------------
 drivers/iio/temperature/tmp006.c       |  57 +++++------
 drivers/staging/iio/iio_simple_dummy.c |  16 +++
 include/linux/iio/iio.h                |  26 +++--
 17 files changed, 197 insertions(+), 117 deletions(-)

-- 
1.8.4

