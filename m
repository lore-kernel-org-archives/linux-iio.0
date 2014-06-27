Return-Path: <srinivas.pandruvada@linux.intel.com>
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [RFC PATCH 0/2] raw read performance improvement
Date: Thu, 26 Jun 2014 17:40:24 -0700
Message-Id: <1403829626-17660-1-git-send-email-srinivas.pandruvada@linux.intel.com>
List-ID: <linux-iio@vger.kernel.org>

We see several performance issues reading individual axis, when
raw read is the only option. Since most of the time user space reads x, y
and z, one after other, this results in three sysfs reads, and based on
chipset we have to power up or set up measurement mode and wait for
response.
For example reading x,y and z takes 160ms for ak8975, it is true for
other too. But reading together takes only 80ms.

IIO types already defined a modifier for X_AND_Y_AND_Z, which is used
by one driver to send event code. This modifier has no value assigned
so (null) appears in sysfs. If this is not correct then we may need 
another modifier. 

Since we have now raw_read with capability to read multiple values,
we can use this callback to return values to iio core.

Srinivas Pandruvada (2):
  iio: core: add xyz modifier value
  iio: magnetometer: ak8975: Improve performance of raw reads

 drivers/iio/industrialio-core.c   |  1 +
 drivers/iio/magnetometer/ak8975.c | 58 ++++++++++++++++++++++++++-------------
 2 files changed, 40 insertions(+), 19 deletions(-)

-- 
1.8.3.2
