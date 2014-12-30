Return-Path: <roberta.dobrescu@gmail.com>
From: Roberta Dobrescu <roberta.dobrescu@gmail.com>
To: jic23@kernel.org,
	linux-iio@vger.kernel.org
Cc: octavian.purdila@intel.com,
	daniel.baluta@intel.com,
	lars@metafoo.de,
	Michael.Hennerich@analog.com,
	knaack.h@gmx.de,
	pmeerw@pmeerw.net,
	Roberta Dobrescu <roberta.dobrescu@gmail.com>
Subject: [PATCH 2/3] iio: accel: mma8452: Remove trailing whitespace
Date: Tue, 30 Dec 2014 20:57:54 +0200
Message-Id: <1419965875-4298-3-git-send-email-roberta.dobrescu@gmail.com>
In-Reply-To: <1419965875-4298-1-git-send-email-roberta.dobrescu@gmail.com>
References: <1419965875-4298-1-git-send-email-roberta.dobrescu@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

This patch fixes the following checkpatch.pl error:
ERROR: trailing whitespace

Signed-off-by: Roberta Dobrescu <roberta.dobrescu@gmail.com>
---
 drivers/iio/accel/mma8452.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
index 3c12d49..5b80657 100644
--- a/drivers/iio/accel/mma8452.c
+++ b/drivers/iio/accel/mma8452.c
@@ -111,7 +111,7 @@ static const int mma8452_samp_freq[8][2] = {
 	{6, 250000}, {1, 560000}
 };
 
-/* 
+/*
  * Hardware has fullscale of -2G, -4G, -8G corresponding to raw value -2048
  * The userspace interface uses m/s^2 and we declare micro units
  * So scale factor is given by:
-- 
1.9.1
