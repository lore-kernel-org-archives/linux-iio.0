Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: "Maxin B. John" <maxin.john@gmail.com>,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 2/6] staging:iio:light:tsl2563 missing setting of id in get id function.
Date: Mon, 24 Oct 2011 10:43:31 +0100
Message-Id: <1319449415-23269-3-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1319449415-23269-1-git-send-email-jic23@cam.ac.uk>
References: <1319449415-23269-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

From: "Maxin B. John" <maxin.john@gmail.com>

Signed-off-by: Maxin B. John <maxin.john@gmail.com>
Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/light/tsl2563.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/staging/iio/light/tsl2563.c b/drivers/staging/iio/light/tsl2563.c
index be99925..6a17945 100644
--- a/drivers/staging/iio/light/tsl2563.c
+++ b/drivers/staging/iio/light/tsl2563.c
@@ -226,6 +226,8 @@ static int tsl2563_read_id(struct tsl2563_chip *chip, u8 *id)
 	if (ret < 0)
 		return ret;
 
+	*id = ret;
+
 	return 0;
 }
 
-- 
1.7.7
