Return-Path: <jic23@kernel.org>
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 0/5] IIO: Refactor info_mask* handling and introduce info_mask_shared_[by_all/by_type]
Date: Sat, 17 Aug 2013 15:38:59 +0100
Message-Id: <1376750344-12817-1-git-send-email-jic23@kernel.org>
List-ID: <linux-iio@vger.kernel.org>

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
  iio: refactor info mask attribute creation.
  iio: add info_mask_[shared_by_dir/shared_by_all]
  staging:iio: dummy driver additions to show shared_by_dir infomask
    usage
  iio:temperature:tmp006 put sampling_frequency in
    info_mask_shared_by_all

 drivers/iio/iio_core.h                 |   7 +-
 drivers/iio/industrialio-buffer.c      |   2 +-
 drivers/iio/industrialio-core.c        | 179 ++++++++++++++++++++-------------
 drivers/iio/temperature/tmp006.c       |  57 +++++------
 drivers/staging/iio/iio_simple_dummy.c |  16 +++
 include/linux/iio/iio.h                |  14 ++-
 6 files changed, 169 insertions(+), 106 deletions(-)

-- 
1.8.3.4
