Return-Path: <knaack.h@gmx.de>
From: Hartmut Knaack <knaack.h@gmx.de>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Roberta Dobrescu <roberta.dobrescu@gmail.com>,
	Daniel Baluta <daniel.baluta@intel.com>,
	Irina Tirdea <irina.tirdea@intel.com>
Subject: [PATCH 09/32] tools:iio:iio_event_monitor: save right errno
Date: Sun, 31 May 2015 14:39:49 +0200
Message-Id: <ebe100b3d8062b6e408551e7fd1bc5183467ed3d.1433072539.git.knaack.h@gmx.de>
In-Reply-To: <cover.1433072539.git.knaack.h@gmx.de>
References: <cover.1433072539.git.knaack.h@gmx.de>
In-Reply-To: <cover.1433072539.git.knaack.h@gmx.de>
References: <cover.1433072539.git.knaack.h@gmx.de>
List-ID: <linux-iio@vger.kernel.org>

Move up error handling code to preserve the errno coming from ioctl(),
before it may be changed by close().

Signed-off-by: Hartmut Knaack <knaack.h@gmx.de>
---
 tools/iio/iio_event_monitor.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/tools/iio/iio_event_monitor.c b/tools/iio/iio_event_monitor.c
index f6fdab4..578390d 100644
--- a/tools/iio/iio_event_monitor.c
+++ b/tools/iio/iio_event_monitor.c
@@ -275,15 +275,17 @@ int main(int argc, char **argv)
 	}
 
 	ret = ioctl(fd, IIO_GET_EVENT_FD_IOCTL, &event_fd);
-
-	close(fd);
-
 	if (ret == -1 || event_fd == -1) {
 		ret = -errno;
 		fprintf(stdout, "Failed to retrieve event fd\n");
+		if (close(fd) == -1)
+			perror("Failed to close character device file");
+
 		goto error_free_chrdev_name;
 	}
 
+	close(fd);
+
 	while (true) {
 		ret = read(event_fd, &event, sizeof(event));
 		if (ret == -1) {
-- 
2.3.6
