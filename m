Return-Path: <SRS0=axIo=C4=gmail.com=arvind.yadav.cs@kernel.org>
From: Arvind Yadav <arvind.yadav.cs@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org,
	knaack.h@gmx.de,
	pmeerw@pmeerw.net,
	gregkh@linuxfoundation.org,
	samuel@sortiz.org
Cc: linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org,
	devel@driverdev.osuosl.org,
	netdev@vger.kernel.org
Subject: [PATCH 0/3] Handle return value of platform_get_irq
Date: Thu, 30 Nov 2017 21:13:33 +0530
Message-Id: <1512056616-21065-1-git-send-email-arvind.yadav.cs@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

The platform_get_irq() function returns negative if an error occurs.
zero or positive number on success. platform_get_irq() error checking
for zero is not correct.

Remove unnecessary 'err' initialization for irda driver.

Arvind Yadav (3):
  [PATCH 1/3] iio: trigger: Fix platform_get_irq's error checking
  [PATCH 2/3] staging: irda: Handle return value of platform_get_irq
  [PATCH 3/3] staging: irda: Remove unnecessary 'err' initialization.

 drivers/staging/iio/trigger/iio-trig-bfin-timer.c |  4 ++--
 drivers/staging/irda/drivers/pxaficp_ir.c         | 11 ++++++++++-
 2 files changed, 12 insertions(+), 3 deletions(-)

-- 
2.7.4
