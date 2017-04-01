Return-Path: <SRS0=bHRo=3J=gmail.com=singhalsimran0@kernel.org>
Date: Sat, 1 Apr 2017 19:44:15 +0530
From: simran singhal <singhalsimran0@gmail.com>
To: jic23@kernel.org
Cc: Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] iio: humidity: hts221_buffer: Remove unnecessary cast on
 void pointer
Message-ID: <20170401141415.GA29239@singhal-Inspiron-5558>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-ID: <linux-iio@vger.kernel.org>

The following Coccinelle script was used to detect this:
@r@
expression x;
void* e;
type T;
identifier f;
@@
(
  *((T *)e)
|
  ((T *)x)[...]
|
  ((T*)x)->f
|
- (T*)
  e
)

Signed-off-by: simran singhal <singhalsimran0@gmail.com>
---
 drivers/iio/humidity/hts221_buffer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/humidity/hts221_buffer.c b/drivers/iio/humidity/hts221_buffer.c
index 72ddcda..7d19a3d 100644
--- a/drivers/iio/humidity/hts221_buffer.c
+++ b/drivers/iio/humidity/hts221_buffer.c
@@ -41,7 +41,7 @@ static const struct iio_trigger_ops hts221_trigger_ops = {
 
 static irqreturn_t hts221_trigger_handler_thread(int irq, void *private)
 {
-	struct hts221_hw *hw = (struct hts221_hw *)private;
+	struct hts221_hw *hw = private;
 	u8 status;
 	int err;
 
-- 
2.7.4
