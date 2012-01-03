Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-41.csi.cam.ac.uk ([131.111.8.141]:49911 "EHLO
	ppsw-41.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754179Ab2ACRRE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 3 Jan 2012 12:17:04 -0500
References: <1325602497-7030-1-git-send-email-lars@metafoo.de> <1325602497-7030-2-git-send-email-lars@metafoo.de>
In-Reply-To: <1325602497-7030-2-git-send-email-lars@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Subject: Re: [PATCH 2/3] staging:iio: Add missing event code extract macros
From: Jonathan Cameron <jic23@cam.ac.uk>
Date: Tue, 03 Jan 2012 17:16:51 +0000
To: Lars-Peter Clausen <lars@metafoo.de>
CC: linux-iio@vger.kernel.org
Message-ID: <7bf32d13-da04-4ce0-a563-392972cfe25f@email.android.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org



Lars-Peter Clausen <lars@metafoo.de> wrote:

>Add macros for extracting whether the event is for a differential
>channel and
>the second channel number from the event code. These were the only two
>fields
>which did not have such an macro yet.
>
>Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
 Acked-by: Jonathan Cameron <jic23@kernel.org> 
>---
> drivers/staging/iio/events.h |    2 ++
> 1 files changed, 2 insertions(+), 0 deletions(-)
>
>diff --git a/drivers/staging/iio/events.h
>b/drivers/staging/iio/events.h
>index 416800e..c25f0e3 100644
>--- a/drivers/staging/iio/events.h
>+++ b/drivers/staging/iio/events.h
>@@ -97,7 +97,9 @@ enum iio_event_direction {
>/* Event code number extraction depends on which type of event we have.
>  * Perhaps review this function in the future*/
> #define IIO_EVENT_CODE_EXTRACT_CHAN(mask) ((__s16)(mask & 0xFFFF))
>+#define IIO_EVENT_CODE_EXTRACT_CHAN2(mask) ((__s16)(((mask) >> 16) &
>0xFFFF))
> 
> #define IIO_EVENT_CODE_EXTRACT_MODIFIER(mask) ((mask >> 40) & 0xFF)
>+#define IIO_EVENT_CODE_EXTRACT_DIFF(mask) (((mask) >> 55) & 0x1)
> 
> #endif
>-- 
>1.7.7.3

-- 
Sent from my Android phone with K-9 Mail. Please excuse my brevity.
