Return-Path: <gregor.boirie@parrot.com>
From: Gregor Boirie <gregor.boirie@parrot.com>
To: <linux-iio@vger.kernel.org>
CC: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald-Stadler
	<pmeerw@pmeerw.net>, Gregor Boirie <gregor.boirie@parrot.com>
Subject: [PATCH v1 2/2] iio:buffer: document iio_buffer_poll() return value
Date: Wed, 7 Sep 2016 19:26:05 +0200
Message-ID: <631831ba76071da263e7579c20a62ea674e9d092.1473269007.git.gregor.boirie@parrot.com>
In-Reply-To: <cover.1473269007.git.gregor.boirie@parrot.com>
References: <cover.1473269007.git.gregor.boirie@parrot.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

Add documentation for iio_buffer_poll() POLLERR return value.

Signed-off-by: Gregor Boirie <gregor.boirie@parrot.com>
---
 drivers/iio/industrialio-buffer.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
index b15b3386..aad5159 100644
--- a/drivers/iio/industrialio-buffer.c
+++ b/drivers/iio/industrialio-buffer.c
@@ -155,6 +155,7 @@ ssize_t iio_buffer_read_first_n_outer(struct file *filp, char __user *buf,
  *		a wait queue
  *
  * Return: (POLLIN | POLLRDNORM) if data is available for reading
+ *	   POLLERR if device was unregistered in our back
  *	   or 0 for other cases
  */
 unsigned int iio_buffer_poll(struct file *filp,
-- 
2.1.4
