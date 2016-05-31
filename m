Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:45612 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750927AbcEaUXJ (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 31 May 2016 16:23:09 -0400
In-Reply-To: <1464724070-20123-1-git-send-email-luisbg@osg.samsung.com>
References: <1464724070-20123-1-git-send-email-luisbg@osg.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Subject: Re: [PATCH] staging: iio: accel: remove impossible condition
From: Jonathan Cameron <jic23@kernel.org>
Date: Tue, 31 May 2016 21:23:03 +0100
To: Luis de Bethencourt <luisbg@osg.samsung.com>,
	linux-kernel@vger.kernel.org
CC: gregkh@linuxfoundation.org, knaack.h@gmx.de, lars@metafoo.de,
	ciorneiioana@gmail.com, janani.rvchndrn@gmail.com, afd@ti.com,
	linux-iio@vger.kernel.org, devel@driverdev.osuosl.org
Message-ID: <40EDFB63-D09B-4933-8935-9540119FC00C@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org



On 31 May 2016 20:47:50 BST, Luis de Bethencourt <luisbg@osg.samsung.com> wrote:
>val is set to the value of ret right after ret is checked. If ret is
>not
>zero it goes to error_ret. So only value ret can have is zero, which
>makes
>the switch (val & 0x03) only match the case 0x00. Removing the switch
>and
>since val is only used for this, removing val as well.
There is clearly an issue here. However it looks like it is that if(ret) which is wrong.

The code as it stands clearly doesn't work as intended. Fixing the bug would be

 more useful than removing code that 'should' be accessible.

I happen to fire the relevant hardware up yesterday for the first time in a while so

can easily verify the operation of a fix if you want to take another look.

Jonathan
>
>Signed-off-by: Luis de Bethencourt <luisbg@osg.samsung.com>
>---
> drivers/staging/iio/accel/sca3000_core.c | 16 ++--------------
> 1 file changed, 2 insertions(+), 14 deletions(-)
>
>diff --git a/drivers/staging/iio/accel/sca3000_core.c
>b/drivers/staging/iio/accel/sca3000_core.c
>index a8f533a..94656f6 100644
>--- a/drivers/staging/iio/accel/sca3000_core.c
>+++ b/drivers/staging/iio/accel/sca3000_core.c
>@@ -586,7 +586,7 @@ static ssize_t sca3000_read_frequency(struct device
>*dev,
> {
> 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> 	struct sca3000_state *st = iio_priv(indio_dev);
>-	int ret, len = 0, base_freq = 0, val;
>+	int ret, len = 0, base_freq = 0;
> 
> 	mutex_lock(&st->lock);
> 	ret = __sca3000_get_base_freq(st, st->info, &base_freq);
>@@ -596,20 +596,8 @@ static ssize_t sca3000_read_frequency(struct
>device *dev,
> 	mutex_unlock(&st->lock);
> 	if (ret)
> 		goto error_ret;
>-	val = ret;
> 	if (base_freq > 0)
>-		switch (val & 0x03) {
>-		case 0x00:
>-		case 0x03:
>-			len = sprintf(buf, "%d\n", base_freq);
>-			break;
>-		case 0x01:
>-			len = sprintf(buf, "%d\n", base_freq / 2);
>-			break;
>-		case 0x02:
>-			len = sprintf(buf, "%d\n", base_freq / 4);
>-			break;
>-	}
>+		len = sprintf(buf, "%d\n", base_freq);
> 
> 	return len;
> error_ret_mut:

-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity.
