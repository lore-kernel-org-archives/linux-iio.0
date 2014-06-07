Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([87.118.82.44]:43408 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753022AbaFGPnE (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Sat, 7 Jun 2014 11:43:04 -0400
From: Peter Meerwald <pmeerw@pmeerw.net>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org, Peter Meerwald <pmeerw@pmeerw.net>
Subject: [PATCH 10/12] staging:iio: Fix error handling in generic_buffer example
Date: Sat,  7 Jun 2014 17:42:50 +0200
Message-Id: <1402155772-1373-11-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1402155772-1373-1-git-send-email-pmeerw@pmeerw.net>
References: <1402155772-1373-1-git-send-email-pmeerw@pmeerw.net>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

read() does not return -EAGAIN
read() returns -1 and the errno value needs to be checked for -EAGAIN

Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
---
 drivers/staging/iio/Documentation/generic_buffer.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/iio/Documentation/generic_buffer.c b/drivers/staging/iio/Documentation/generic_buffer.c
index 40d0eca..044ea19 100644
--- a/drivers/staging/iio/Documentation/generic_buffer.c
+++ b/drivers/staging/iio/Documentation/generic_buffer.c
@@ -305,9 +305,12 @@ int main(int argc, char **argv)
 		read_size = read(fp,
 				 data,
 				 toread*scan_size);
-		if (read_size == -EAGAIN) {
-			printf("nothing available\n");
-			continue;
+		if (read_size < 0) {
+			if (errno == -EAGAIN) {
+				printf("nothing available\n");
+				continue;
+			} else
+				break;
 		}
 		for (i = 0; i < read_size/scan_size; i++)
 			process_scan(data + scan_size*i,
-- 
1.9.1

