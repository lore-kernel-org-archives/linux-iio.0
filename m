Return-Path: <SRS0=jEZM=KF=lechnology.com=david@kernel.org>
From: David Lechner <david@lechnology.com>
To: linux-iio@vger.kernel.org
Cc: David Lechner <david@lechnology.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] iio: adc: ti-ads7950: allow simultaneous use of buffer and direct mode
Date: Sat, 21 Jul 2018 14:37:32 -0500
Message-Id: <20180721193734.6427-1-david@lechnology.com>
List-ID: <linux-iio@vger.kernel.org>

v2 changes:
- add new patch to use SPDX-License-Identifier (since we are touching this file
  anyway)
- don't add struct iio_device *indio_dev as field to private data
- fix indent on return statement

David Lechner (2):
  iio: adc: ti-ads7950: use SPDX-License-Identifier
  iio: adc: ti-ads7950: allow simultaneous use of buffer and direct mode

 drivers/iio/adc/ti-ads7950.c | 42 ++++++++++++++++--------------------
 1 file changed, 19 insertions(+), 23 deletions(-)

-- 
2.17.1
