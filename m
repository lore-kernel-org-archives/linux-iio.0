Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:59678 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933644AbaLLQcv (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Fri, 12 Dec 2014 11:32:51 -0500
Date: Sat, 13 Dec 2014 00:28:52 +0800
From: kbuild test robot <fengguang.wu@intel.com>
To: Daniel Baluta <daniel.baluta@intel.com>
Cc: kbuild-all@01.org, Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [iio:testing 44/44] drivers/iio/imu/kmx61.c:422:5: sparse: symbol
 'kmx61_set_wake_up_odr' was not declared. Should it be static?
Message-ID: <201412130004.58sFmPKu%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git testing
head:   fd3ae7a9f21c2a51a1d220bc7a7c3b45ab5e6ad1
commit: fd3ae7a9f21c2a51a1d220bc7a7c3b45ab5e6ad1 [44/44] iio: imu: kmx61: Add support for any motion trigger
reproduce:
  # apt-get install sparse
  git checkout fd3ae7a9f21c2a51a1d220bc7a7c3b45ab5e6ad1
  make ARCH=x86_64 allmodconfig
  make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

>> drivers/iio/imu/kmx61.c:422:5: sparse: symbol 'kmx61_set_wake_up_odr' was not declared. Should it be static?

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
http://lists.01.org/mailman/listinfo/kbuild                 Intel Corporation
