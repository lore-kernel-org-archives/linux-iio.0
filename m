Return-Path: <Michael.Hennerich@analog.com>
From: <michael.hennerich@analog.com>
To: jic23@cam.ac.uk
CC: linux-iio@vger.kernel.org, drivers@analog.com,
        device-drivers-devel@blackfin.uclinux.org,
        Michael Hennerich <michael.hennerich@analog.com>
Subject: [PATCH] IIO: Documentation: generic_buffer example: Avoid NULL pointer dereference
Date: Tue, 15 Feb 2011 15:46:17 +0100
Message-ID: <1297781180-5071-1-git-send-email-michael.hennerich@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

From: Michael Hennerich <michael.hennerich@analog.com>

In case optarg n is not given return/exit

Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
---
 drivers/staging/iio/Documentation/generic_buffer.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/drivers/staging/iio/Documentation/generic_buffer.c b/drivers/staging/iio/Documentation/generic_buffer.c
index df23aeb..131d9d0 100644
--- a/drivers/staging/iio/Documentation/generic_buffer.c
+++ b/drivers/staging/iio/Documentation/generic_buffer.c
@@ -151,6 +151,9 @@ int main(int argc, char **argv)
 		}
 	}
 
+	if (device_name == NULL)
+		return -1;
+
 	/* Find the device requested */
 	dev_num = find_type_by_name(device_name, "device");
 	if (dev_num < 0) {
-- 
1.6.0.2
