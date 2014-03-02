Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-bn1lp0141.outbound.protection.outlook.com ([207.46.163.141]:19533
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753367AbaCBBgi convert rfc822-to-8bit (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 1 Mar 2014 20:36:38 -0500
From: "fugang.duan@freescale.com" <fugang.duan@freescale.com>
To: Jonathan Cameron <jic23@kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
CC: Dan Carpenter <dan.carpenter@oracle.com>
Subject: RE: [PATCH] iio:adc:vf610 ensure correct handing of interruption of
 wait for completion
Date: Sun, 2 Mar 2014 01:36:33 +0000
Message-ID: <14cec064ee944b29baf52f88cca1cf15@BLUPR03MB373.namprd03.prod.outlook.com>
References: <1393711367-2210-1-git-send-email-jic23@kernel.org>
In-Reply-To: <1393711367-2210-1-git-send-email-jic23@kernel.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

From: Jonathan Cameron <jic23@kernel.org>
Data: Sunday, March 02, 2014 6:03 AM

>To: linux-iio@vger.kernel.org
>Cc: Jonathan Cameron; Dan Carpenter; Duan Fugang-B38611
>Subject: [PATCH] iio:adc:vf610 ensure correct handing of interruption of wait
>for completion
>
>Issue highlighted by smatch warning:
>
>CHECK   drivers/iio/adc/vf610_adc.c
>drivers/iio/adc/vf610_adc.c:466 vf610_read_raw() warn: unsigned 'ret' is never
>less than zero.
>
>As wait_for_completion_interruptible_timeout can return -ERESTARTSTSYS, if
>interrupted, ret must be signed.
>
>Signed-off-by: Jonathan Cameron <jic23@kernel.org>
>Cc: Dan Carpenter <dan.carpenter@oracle.com>
>Cc: Fugang Duan <B38611@freescale.com>
>---
> drivers/iio/adc/vf610_adc.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/drivers/iio/adc/vf610_adc.c b/drivers/iio/adc/vf610_adc.c index
>37f542e..44799eb5 100644
>--- a/drivers/iio/adc/vf610_adc.c
>+++ b/drivers/iio/adc/vf610_adc.c
>@@ -447,7 +447,7 @@ static int vf610_read_raw(struct iio_dev *indio_dev,  {
> 	struct vf610_adc *info = iio_priv(indio_dev);
> 	unsigned int hc_cfg;
>-	unsigned long ret;
>+	long ret;
>
> 	switch (mask) {
> 	case IIO_CHAN_INFO_RAW:
>--
>1.9.0
>
>

Acked-by: Fugang Duan <B38611@freescale.com>
