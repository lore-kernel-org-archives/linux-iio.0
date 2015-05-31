Return-Path: <knaack.h@gmx.de>
From: Hartmut Knaack <knaack.h@gmx.de>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Roberta Dobrescu <roberta.dobrescu@gmail.com>,
	Daniel Baluta <daniel.baluta@intel.com>,
	Irina Tirdea <irina.tirdea@intel.com>
Subject: [PATCH 19/32] tools:iio:iio_event_monitor: add error handling
Date: Sun, 31 May 2015 14:40:05 +0200
Message-Id: <71c628bf5ac132bca29fcbcc42dc8eaadf761675.1433072539.git.knaack.h@gmx.de>
In-Reply-To: <15952408423424396a4ace1522055e17da4afc80.1433072539.git.knaack.h@gmx.de>
References: <15952408423424396a4ace1522055e17da4afc80.1433072539.git.knaack.h@gmx.de>
In-Reply-To: <cover.1433072539.git.knaack.h@gmx.de>
References: <cover.1433072539.git.knaack.h@gmx.de>
List-ID: <linux-iio@vger.kernel.org>

Add error handling to calls which can indicate a major problem by
returning an error code.

Signed-off-by: Hartmut Knaack <knaack.h@gmx.de>
---
 tools/iio/iio_event_monitor.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/tools/iio/iio_event_monitor.c b/tools/iio/iio_event_monitor.c
index 1374374..1316527 100644
--- a/tools/iio/iio_event_monitor.c
+++ b/tools/iio/iio_event_monitor.c
@@ -286,7 +286,10 @@ int main(int argc, char **argv)
 		goto error_free_chrdev_name;
 	}
 
-	close(fd);
+	if (close(fd) == -1)  {
+		ret = -errno;
+		goto error_free_chrdev_name;
+	}
 
 	while (true) {
 		ret = read(event_fd, &event, sizeof(event));
@@ -304,7 +307,9 @@ int main(int argc, char **argv)
 		print_event(&event);
 	}
 
-	close(event_fd);
+	if (close(event_fd) == -1)
+		perror("Failed to close event file");
+
 error_free_chrdev_name:
 	free(chrdev_name);
 error_ret:
-- 
2.3.6
