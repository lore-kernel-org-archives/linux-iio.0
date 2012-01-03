Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-41.csi.cam.ac.uk ([131.111.8.141]:49393 "EHLO
	ppsw-41.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754185Ab2ACRP5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 3 Jan 2012 12:15:57 -0500
References: <1325602497-7030-1-git-send-email-lars@metafoo.de>
In-Reply-To: <1325602497-7030-1-git-send-email-lars@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Subject: Re: [PATCH 1/3] staging:iio: Rename IIO_EVENT_CODE_EXTRACT_NUM to IIO_EVENT_CODE_EXTRACT_CHAN
From: Jonathan Cameron <jic23@cam.ac.uk>
Date: Tue, 03 Jan 2012 17:15:54 +0000
To: Lars-Peter Clausen <lars@metafoo.de>
CC: linux-iio@vger.kernel.org
Message-ID: <f5fe7764-efbf-4487-816d-b3b6d1e264fb@email.android.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Sensible. 

Lars-Peter Clausen <lars@metafoo.de> wrote:

>We name this field "chan" throughout IIO with the exception of this one
>macro.
>Rename it to be more consistent.
>
>Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
 Acked-by: Jonathan Cameron <jic23@kernel.org> 
>---
> drivers/staging/iio/events.h |    2 +-
> 1 files changed, 1 insertions(+), 1 deletions(-)
>
>diff --git a/drivers/staging/iio/events.h
>b/drivers/staging/iio/events.h
>index bfb6340..416800e 100644
>--- a/drivers/staging/iio/events.h
>+++ b/drivers/staging/iio/events.h
>@@ -96,7 +96,7 @@ enum iio_event_direction {
> 
>/* Event code number extraction depends on which type of event we have.
>  * Perhaps review this function in the future*/
>-#define IIO_EVENT_CODE_EXTRACT_NUM(mask) ((__s16)(mask & 0xFFFF))
>+#define IIO_EVENT_CODE_EXTRACT_CHAN(mask) ((__s16)(mask & 0xFFFF))
> 
> #define IIO_EVENT_CODE_EXTRACT_MODIFIER(mask) ((mask >> 40) & 0xFF)
> 
>-- 
>1.7.7.3

-- 
Sent from my Android phone with K-9 Mail. Please excuse my brevity.
