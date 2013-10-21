Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:49467 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751287Ab3JUVfp (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 21 Oct 2013 17:35:45 -0400
In-Reply-To: <1382389277-7932-1-git-send-email-srinivas.pandruvada@linux.intel.com>
References: <1382389277-7932-1-git-send-email-srinivas.pandruvada@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Subject: Re: [PATCH 1/9] iio: Fix crash in trigger unregister
From: Jonathan Cameron <jic23@kernel.org>
Date: Mon, 21 Oct 2013 22:35:40 +0100
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
CC: linux-iio@vger.kernel.org
Message-ID: <997f9af3-4265-483e-960e-9ee08051ba3c@email.android.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org



Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com> wrote:
>User space can write a triger name via trigger/current_trigger.
>But it is possible that it can't find this name. In this case
>iio_trigger_find_by_name will return NULL. Even if it is NULL,
>it sets indio_dev->trig to this NULL value. But when iio drivers
>calls iio_trigger_unregister, it will crash because it will try
>to dereference NULL pointer. So either every driver checks for
>NULL before calling iio_trigger_unregister or make sure that
>NULL is not assigned because of invalid trigger name. The later
>is better and has less impact.
>
>Signed-off-by: Srinivas Pandruvada
><srinivas.pandruvada@linux.intel.com>

 Sorry to say I missed this in review.
Indio_dev->trig is a pointer to the trigger being used by the device NOT the trigger provided by the device.  If the device provides a trigger, the pointer to that is stored somewhere in iio_priv.

Hence the bug is not in the core but in the sensor hub trigger creation and freeing code.

Sorry again that I did not pick up on this before as this is not the first driver to confuse this. In mitigation it is clearly documented as intern (i.e. not for driver assignment) in iio.h

When I get a few mins I will check if we have any other equivalent cases that have slipped through the net... 

Jonathan
>---
> drivers/iio/industrialio-trigger.c | 7 +++++--
> 1 file changed, 5 insertions(+), 2 deletions(-)
>
>diff --git a/drivers/iio/industrialio-trigger.c
>b/drivers/iio/industrialio-trigger.c
>index bf5e70a..4dc4247 100644
>--- a/drivers/iio/industrialio-trigger.c
>+++ b/drivers/iio/industrialio-trigger.c
>@@ -342,13 +342,16 @@ static ssize_t iio_trigger_write_current(struct
>device *dev,
> 	if (oldtrig == trig)
> 		return len;
> 
>-	if (trig && indio_dev->info->validate_trigger) {
>+	if (!trig)
>+		return -EINVAL;
>+
>+	if (indio_dev->info->validate_trigger) {
> 		ret = indio_dev->info->validate_trigger(indio_dev, trig);
> 		if (ret)
> 			return ret;
> 	}
> 
>-	if (trig && trig->ops && trig->ops->validate_device) {
>+	if (trig->ops && trig->ops->validate_device) {
> 		ret = trig->ops->validate_device(trig, indio_dev);
> 		if (ret)
> 			return ret;

-- 
Sent from my Android phone with K-9 Mail. Please excuse my brevity.
