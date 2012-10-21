Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail4-relais-sop.national.inria.fr ([192.134.164.105]:61600
	"EHLO mail4-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752745Ab2JUKwP (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 21 Oct 2012 06:52:15 -0400
From: Julia Lawall <Julia.Lawall@lip6.fr>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: kernel-janitors@vger.kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] drivers/iio/industrialio-event.c: eliminate possible double free
Date: Sun, 21 Oct 2012 12:52:07 +0200
Message-Id: <1350816727-1381-6-git-send-email-Julia.Lawall@lip6.fr>
In-Reply-To: <1350816727-1381-1-git-send-email-Julia.Lawall@lip6.fr>
References: <1350816727-1381-1-git-send-email-Julia.Lawall@lip6.fr>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

From: Julia Lawall <Julia.Lawall@lip6.fr>

The function __iio_add_event_config_attrs is only called once, by the
function iio_device_register_eventset.  If the call fails,
iio_device_register_eventset calls __iio_remove_event_config_attrs.  There
is thus no need for __iio_add_event_config_attrs to also call
__iio_remove_event_config_attrs on failure.

A simplified version of the semantic match that finds this problem is as
follows: (http://coccinelle.lip6.fr/)

// <smpl>
@r@
identifier f,free,a;
parameter list[n] ps;
type T;
expression e;
@@

f(ps,T a,...) {
  ... when any
      when != a = e
  if(...) { ... free(a); ... return ...; }
  ... when any
}

@@
identifier r.f,r.free;
expression x,a;
expression list[r.n] xs;
@@

* x = f(xs,a,...);
  if (...) { ... free(a); ... return ...; }
// </smpl>

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
__iio_remove_event_config_attrs kfrees the elements of a list, but doesn't
actually remove them from the list.  Perhaps for safety this should be
cleaned up as well.  Not tested.

 drivers/iio/industrialio-event.c |    7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/iio/industrialio-event.c b/drivers/iio/industrialio-event.c
index fa6543b..78570c7 100644
--- a/drivers/iio/industrialio-event.c
+++ b/drivers/iio/industrialio-event.c
@@ -350,15 +350,10 @@ static inline int __iio_add_event_config_attrs(struct iio_dev *indio_dev)
 		ret = iio_device_add_event_sysfs(indio_dev,
 						 &indio_dev->channels[j]);
 		if (ret < 0)
-			goto error_clear_attrs;
+			return ret;
 		attrcount += ret;
 	}
 	return attrcount;
-
-error_clear_attrs:
-	__iio_remove_event_config_attrs(indio_dev);
-
-	return ret;
 }
 
 static bool iio_check_for_dynamic_events(struct iio_dev *indio_dev)

