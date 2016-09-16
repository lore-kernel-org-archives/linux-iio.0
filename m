Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:45357 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1759216AbcIPLNo (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 16 Sep 2016 07:13:44 -0400
From: Julia Lawall <Julia.Lawall@lip6.fr>
To: Jonathan Cameron <jic23@kernel.org>
Cc: kernel-janitors@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] iio: adc: men_z188_adc: constify iio_info structures
Date: Fri, 16 Sep 2016 12:55:25 +0200
Message-Id: <1474023326-24645-3-git-send-email-Julia.Lawall@lip6.fr>
In-Reply-To: <1474023326-24645-1-git-send-email-Julia.Lawall@lip6.fr>
References: <1474023326-24645-1-git-send-email-Julia.Lawall@lip6.fr>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Check for iio_info structures that are only stored in the info field of a
iio_dev structure.  This field is declared const, so iio_info structures
that have this property can be declared as const also.

The semantic patch that makes this change is as follows:
(http://coccinelle.lip6.fr/)

// <smpl>
@r disable optional_qualifier@
identifier i;
position p;
@@
static struct iio_info i@p = { ... };

@ok@
identifier r.i;
struct iio_dev e;
position p;
@@
e.info = &i@p;

@bad@
position p != {r.p,ok.p};
identifier r.i;
struct iio_info e;
@@
e@i@p

@depends on !bad disable optional_qualifier@
identifier r.i;
@@
static
+const
 struct iio_info i = { ... };
// </smpl>

The result of size on this file before the change is:
   text	      data     bss     dec         hex	  filename
   1529	       312       0    1841         731
   drivers/iio/adc/men_z188_adc.o

and after the change it is:
   text	     data        bss	    dec	    hex	filename
   1689       168          0       1857     741
   drivers/iio/adc/men_z188_adc.o

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
 drivers/iio/adc/men_z188_adc.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/men_z188_adc.c b/drivers/iio/adc/men_z188_adc.c
index d095efe..8f3606d 100644
--- a/drivers/iio/adc/men_z188_adc.c
+++ b/drivers/iio/adc/men_z188_adc.c
@@ -78,7 +78,7 @@ static int z188_iio_read_raw(struct iio_dev *iio_dev,
 	return ret;
 }
 
-static struct iio_info z188_adc_info = {
+static const struct iio_info z188_adc_info = {
 	.read_raw = &z188_iio_read_raw,
 	.driver_module = THIS_MODULE,
 };

