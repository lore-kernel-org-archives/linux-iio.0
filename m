Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: greg@kroah.com
Cc: jbrenner@taosinc.com,
	linux-iio@vger.kernel.org,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 8/8] staging:iio:documentation make read_size signed to allow for errors.
Date: Fri, 15 Apr 2011 18:56:00 +0100
Message-Id: <1302890160-8823-9-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1302890160-8823-1-git-send-email-jic23@cam.ac.uk>
References: <1302890160-8823-1-git-send-email-jic23@cam.ac.uk>
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
