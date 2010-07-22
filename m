Return-Path: <mensch0815@googlemail.com>
From: Matthias Brugger <mensch0815@googlemail.com>
To: jic23@cam.ac.uk
Cc: linux-iio@vger.kernel.org, Matthias Brugger <mensch0815@gmail.com>
Subject: [PATCH] IIO: typo in Documentation/overview.txt
Date: Fri, 23 Jul 2010 00:10:15 +0200
Message-Id: <1279836615-5043-1-git-send-email-mensch0815@gmail.com>
List-ID: <linux-iio@vger.kernel.org>


Signed-off-by: Matthias Brugger <mensch0815@gmail.com>
---
 drivers/staging/iio/Documentation/overview.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/staging/iio/Documentation/overview.txt b/drivers/staging/iio/Documentation/overview.txt
index e39dfc1..cc6ecad 100644
--- a/drivers/staging/iio/Documentation/overview.txt
+++ b/drivers/staging/iio/Documentation/overview.txt
@@ -44,7 +44,7 @@ which the raw data it self may be read back.
 applications it it useful to be able to capture data based on some
 external signal (trigger).  These triggers might be a data ready
 signal, a gpio line connected to some external system or an on
-processor periodic interrupt.  A single trigger many initialize data
+processor periodic interrupt.  A single trigger may initialize data
 capture or reading from a number of sensors.  These triggers are
 used in iio to fill software ring buffers acting in a very similar
 fashion to the hardware buffers described above.
-- 
1.7.2
