Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([87.118.82.44]:55316 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756160Ab2FYVN1 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Mon, 25 Jun 2012 17:13:27 -0400
From: Peter Meerwald <pmeerw@pmeerw.net>
To: linux-iio@vger.kernel.org
Cc: jic23@cam.ac.uk, Peter Meerwald <pmeerw@pmeerw.net>
Subject: [PATCH 2/3] iio staging: fix potential memory/resource leaks in find_type_by_name()
Date: Mon, 25 Jun 2012 23:13:25 +0200
Message-Id: <1340658806-5609-2-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1340658806-5609-1-git-send-email-pmeerw@pmeerw.net>
References: <1340658806-5609-1-git-send-email-pmeerw@pmeerw.net>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
---
 drivers/staging/iio/Documentation/iio_utils.h |   15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/iio/Documentation/iio_utils.h b/drivers/staging/iio/Documentation/iio_utils.h
index 9241288..8869c55 100644
--- a/drivers/staging/iio/Documentation/iio_utils.h
+++ b/drivers/staging/iio/Documentation/iio_utils.h
@@ -473,23 +473,30 @@ inline int find_type_by_name(const char *name, const char *type)
 						+ strlen(type)
 						+ numstrlen
 						+ 6);
-				if (filename == NULL)
+				if (filename == NULL) {
+					closedir(dp);
 					return -ENOMEM;
+				}
 				sprintf(filename, "%s%s%d/name",
 					iio_dir,
 					type,
 					number);
 				nameFile = fopen(filename, "r");
-				if (!nameFile)
+				if (!nameFile) {
+					free(filename);
 					continue;
+				}
 				free(filename);
 				fscanf(nameFile, "%s", thisname);
-				if (strcmp(name, thisname) == 0)
-					return number;
 				fclose(nameFile);
+				if (strcmp(name, thisname) == 0) {
+					closedir(dp);
+					return number;
+				}
 			}
 		}
 	}
+	closedir(dp);
 	return -ENODEV;
 }
 
-- 
1.7.9.5

