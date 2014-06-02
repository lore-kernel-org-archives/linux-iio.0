Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtprelay0154.hostedemail.com ([216.40.44.154]:34317 "EHLO
	smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750701AbaFBRXO (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 2 Jun 2014 13:23:14 -0400
Received: from smtprelay.hostedemail.com (ff-bigip1 [10.5.19.254])
	by smtpgrave04.hostedemail.com (Postfix) with ESMTP id 062CDB197E
	for <linux-iio@vger.kernel.org>; Mon,  2 Jun 2014 17:14:34 +0000 (UTC)
Message-ID: <1401729252.5770.13.camel@joe-AO725>
Subject: Re: [PATCH] fix some coding style problem in
 drivers/staging/iio/frequency/ad9832.c
From: Joe Perches <joe@perches.com>
To: Federico Di Pierro <nierro92@gmail.com>
Cc: jic23@kernel.org, gregkh@linuxfoundation.org, jg1.han@samsung.com,
	sachin.kamat@linaro.org, linux-iio@vger.kernel.org,
	devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Date: Mon, 02 Jun 2014 10:14:12 -0700
In-Reply-To: <538CAEBD.5040501@gmail.com>
References: <538CAEBD.5040501@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
Mime-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, 2014-06-02 at 19:05 +0200, Federico Di Pierro wrote:
> Hi!

Hello Federico.

> This is my latest task of the eudyptula challenge.

Your patch subject should be something like:

[PATCH] staging: iio: kernel style neatening

> Just a very small patch! It fixes 3 little coding style problems.
> I'm using linux-next.

linux/drivers/staging/iio/frequency/ad9832.c
[]
@@ -73,7 +73,7 @@ static int ad9832_write_phase(struct ad9
 }
 
 static ssize_t ad9832_write(struct device *dev,
-               struct device_attribute *attr,
+                           struct device_attribute *attr,
                const char *buf,
                size_t len)


checkpatch is a brainless little tool.

Please make sure your own brain is engaged when
acting on or verifying any warnings it emits.

Please expand the indented line range to include
all the arguments of the function.



