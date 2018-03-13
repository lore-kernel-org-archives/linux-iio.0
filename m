Return-Path: <SRS0=2i7U=GD=embeddedor.com=gustavo@kernel.org>
Date: Tue, 13 Mar 2018 10:23:43 -0500
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] iio: potentiometer: ds1803: remove VLA usage
Message-ID: <20180313152343.GA31789@embeddedgus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-ID: <linux-iio@vger.kernel.org>

In preparation to enabling -Wvla, remove VLA. In this particular
case use macro ARRAY_SIZE so the length of array _result_ can be
computed at preprocessing time.

The use of stack Variable Length Arrays needs to be avoided, as they
can be a vector for stack exhaustion, which can be both a runtime bug
or a security flaw. Also, in general, as code evolves it is easy to
lose track of how big a VLA can get. Thus, we can end up having runtime
failures that are hard to debug.

Also, fixed as part of the directive to remove all VLAs from
the kernel: https://lkml.org/lkml/2018/3/7/621

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/iio/potentiometer/ds1803.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/potentiometer/ds1803.c b/drivers/iio/potentiometer/ds1803.c
index 9b0ff4a..6bf12c9 100644
--- a/drivers/iio/potentiometer/ds1803.c
+++ b/drivers/iio/potentiometer/ds1803.c
@@ -64,7 +64,7 @@ static int ds1803_read_raw(struct iio_dev *indio_dev,
 	struct ds1803_data *data = iio_priv(indio_dev);
 	int pot = chan->channel;
 	int ret;
-	u8 result[indio_dev->num_channels];
+	u8 result[ARRAY_SIZE(ds1803_channels)];
 
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
-- 
2.7.4
