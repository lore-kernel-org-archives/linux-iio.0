Return-Path: <SRS0=Bg67=67=linux.intel.com=andriy.shevchenko@kernel.org>
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	linux-iio@vger.kernel.org,
	David Lechner <david@lechnology.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 0/2] iio: ti-ads7950: Make it working on ACPI platforms
Date: Sat, 29 Jul 2017 01:20:13 +0300
Message-Id: <20170728222015.43574-1-andriy.shevchenko@linux.intel.com>
List-ID: <linux-iio@vger.kernel.org>

ACPI has no regulators, thus we need to provide a reference voltage
value for ACPI platforms for now. I leave regulator request in place
because for ACPI we will get dummy regulator. This is done in patch 1.

Since we have no dedicated ACPI ID we may use compatible string, so,
patch 2 adds them.

In v2:
- correct subject in patch 1
- add tag for patch 2
- change patch 1 to leave a regulator request in place
- do not add tag for patch 1 because of above

Andy Shevchenko (2):
  iio: adc: ti-ads7950: Allow to use on ACPI platforms
  iio: adc: ti-ads7950: Add OF device ID table

 drivers/iio/adc/ti-ads7950.c | 42 ++++++++++++++++++++++++++++++++++++++----
 1 file changed, 38 insertions(+), 4 deletions(-)

-- 
2.13.2
