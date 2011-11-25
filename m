Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-51.csi.cam.ac.uk ([131.111.8.151]:43028 "EHLO
	ppsw-51.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751684Ab1KYHcd convert rfc822-to-8bit (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 25 Nov 2011 02:32:33 -0500
References: <1322169950-21630-1-git-send-email-arnd@arndnet.de>
In-Reply-To: <1322169950-21630-1-git-send-email-arnd@arndnet.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Subject: Re: [PATCH] staging: iio: fix compile error
From: Jonathan Cameron <jic23@cam.ac.uk>
Date: Fri, 25 Nov 2011 07:28:13 +0000
To: Arnd Hannemann <arnd@arndnet.de>, linux-iio@vger.kernel.org
CC: linux-kernel@vger.kernel.org
Message-ID: <44fd139f-a08f-4f1d-83ea-085b9a852287@email.android.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Thanks though this is fix number 4 I think. One will hit Linux next today and Greg has one to push out to Linus. 

Arnd Hannemann <arnd@arndnet.de> wrote:

>Commit b46413367961c2e8bd827e067a231be982aaeee2 introduced the
>following compile error:
>
>  CC      drivers/staging/iio/industrialio-core.o
>linux-2.6/drivers/staging/iio/industrialio-core.c: In function
>'iio_event_getfd':
>linux-2.6/drivers/staging/iio/industrialio-core.c:262:32: error:
>'ev_int' undeclared (first use in this function)
>linux-2.6/drivers/staging/iio/industrialio-core.c:262:32: note: each
>undeclared identifier is reported only once for each function it
>appears in
>
>This patch fixes that.
>
>Signed-off-by: Arnd Hannemann <arnd@arndnet.de>
>---
> drivers/staging/iio/industrialio-core.c |    1 +
> 1 files changed, 1 insertions(+), 0 deletions(-)
>
>diff --git a/drivers/staging/iio/industrialio-core.c
>b/drivers/staging/iio/industrialio-core.c
>index 2656409..a5b4a1f 100644
>--- a/drivers/staging/iio/industrialio-core.c
>+++ b/drivers/staging/iio/industrialio-core.c
>@@ -243,6 +243,7 @@ static const struct file_operations
>iio_event_chrdev_fileops = {
> static int iio_event_getfd(struct iio_dev *indio_dev)
> {
> 	int fd;
>+	struct iio_event_interface *ev_int = indio_dev->event_interface;
> 
> 	if (indio_dev->event_interface == NULL)
> 		return -ENODEV;
>-- 
>1.7.5.4
>
>--
>To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Sent from my Android phone 
with K-9 Mail. Please excuse my brevity.
