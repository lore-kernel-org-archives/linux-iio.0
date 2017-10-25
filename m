Return-Path: <SRS0=aVu3=BY=users.sourceforge.net=elfring@kernel.org>
To: linux-iio@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
 Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
 Tiberiu Breana <tiberiu.a.breana@intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 0/2] iio/accel/stk8ba50: Fine-tuning for two function
 implementations
Message-ID: <5ab7e200-2dea-63e2-06db-0e185f563d16@users.sourceforge.net>
Date: Wed, 25 Oct 2017 22:15:02 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-ID: <linux-iio@vger.kernel.org>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Wed, 25 Oct 2017 22:10:12 +0200

Two update suggestions were taken into account
from static source code analysis.

Markus Elfring (2):
  Use common error handling code in stk8ba50_probe()
  Improve unlocking of a mutex in stk8ba50_read_raw()

 drivers/iio/accel/stk8ba50.c | 37 +++++++++++++++++++++----------------
 1 file changed, 21 insertions(+), 16 deletions(-)

-- 
2.14.3
