Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: arnd@arndb.de,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 8/8] staging:iio:documentation make read_size signed to allow for errors.
Date: Thu, 17 Mar 2011 21:00:27 +0000
Message-Id: <1300395627-18547-9-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1300395627-18547-1-git-send-email-jic23@cam.ac.uk>
References: <1300395627-18547-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

Without this all hell breaks loose if you have no data.

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/Documentation/generic_buffer.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/staging/iio/Documentation/generic_buffer.c b/drivers/staging/iio/Documentation/generic_buffer.c
index 3cc18ab..eb72e95 100644
--- a/drivers/staging/iio/Documentation/generic_buffer.c
+++ b/drivers/staging/iio/Documentation/generic_buffer.c
@@ -132,7 +132,7 @@ int main(int argc, char **argv)
 
 	int datardytrigger = 1;
 	char *data;
-	size_t read_size;
+	ssize_t read_size;
 	struct iio_event_data dat;
 	int dev_num, trig_num;
 	char *buffer_access, *buffer_event;
-- 
1.7.3.4
