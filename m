Return-Path: <greg@kroah.com>
Subject: patch staging-iio-ring_sw-fix-incorrect-test-on-successful-read-of-last-value-causes-infinite-loop.patch added to gregkh-2.6 tree
To: jic23@cam.ac.uk,gregkh@suse.de,linux-iio@vger.kernel.org
From: <gregkh@suse.de>
Date: Thu, 22 Apr 2010 17:13:21 -0700
In-Reply-To: <4BB22A90.6070801@cam.ac.uk>
Message-ID: <1271981601503@kroah.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
List-ID: <linux-iio@vger.kernel.org>


This is a note to let you know that I've just added the patch titled

    Subject: staging: iio: ring_sw: Fix incorrect test on successful read=
 of last value, causes infinite loop

to my gregkh-2.6 tree.  Its filename is

    staging-iio-ring_sw-fix-incorrect-test-on-successful-read-of-last-val=
ue-causes-infinite-loop.patch

This tree can be found at=20
    http://www.kernel.org/pub/linux/kernel/people/gregkh/gregkh-2.6/patch=
es/


>>From jic23@cam.ac.uk  Thu Apr 22 16:41:09 2010
From: Jonathan Cameron <jic23@cam.ac.uk>
Date: Tue, 30 Mar 2010 17:45:04 +0100
Subject: staging: iio: ring_sw: Fix incorrect test on successful read of =
last value, causes infinite loop
To: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, Greg Kroah-H=
artman <gregkh@suse.de>
Message-ID: <4BB22A90.6070801@cam.ac.uk>


This is a bad one. The test means that almost no reads of the last
value ever succeed!  Result is an infinite loop.

Another one for the 'oops' category.

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 drivers/staging/iio/ring_sw.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/staging/iio/ring_sw.c
+++ b/drivers/staging/iio/ring_sw.c
@@ -293,7 +293,7 @@ again:
 		return -EAGAIN;
 	memcpy(data, last_written_p_copy, ring->buf.bpd);
=20
-	if (unlikely(ring->last_written_p >=3D last_written_p_copy))
+	if (unlikely(ring->last_written_p !=3D last_written_p_copy))
 		goto again;
=20
 	iio_unmark_sw_rb_in_use(&ring->buf);
