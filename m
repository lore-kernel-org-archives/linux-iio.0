Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:40799 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752132AbbGNUEQ (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 14 Jul 2015 16:04:16 -0400
In-Reply-To: <1436885814-29155-4-git-send-email-daniel.baluta@intel.com>
References: <1436885814-29155-1-git-send-email-daniel.baluta@intel.com> <1436885814-29155-4-git-send-email-daniel.baluta@intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Subject: Re: [PATCH 3/3] iio: magnetometer: mmc35240: fix SET/RESET sequence
From: Jonathan Cameron <jic23@kernel.org>
Date: Tue, 14 Jul 2015 21:04:11 +0100
To: Daniel Baluta <daniel.baluta@intel.com>
CC: viorel.suman@intel.com, knaack.h@gmx.de, lars@metafoo.de,
	pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Message-ID: <18BF4A9F-0C9F-4DB6-9F4D-E91A904DBBB1@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org



On 14 July 2015 15:56:54 BST, Daniel Baluta <daniel.baluta@intel.com> wrote:
>From: Viorel Suman <viorel.suman@intel.com>
>
>The RESET operation invoked in the last instance will align
>in the natural way all 3 axis and the chip top view.
What is the result of the bug?
Just trying to assess urgency of the patch!
>
>Signed-off-by: Viorel Suman <viorel.suman@intel.com>
>Signed-off-by: Daniel Baluta <daniel.baluta@intel.com>
>---
> drivers/iio/magnetometer/mmc35240.c | 7 ++++---
> 1 file changed, 4 insertions(+), 3 deletions(-)
>
>diff --git a/drivers/iio/magnetometer/mmc35240.c
>b/drivers/iio/magnetometer/mmc35240.c
>index f4d7495..a53efd2 100644
>--- a/drivers/iio/magnetometer/mmc35240.c
>+++ b/drivers/iio/magnetometer/mmc35240.c
>@@ -215,14 +215,15 @@ static int mmc35240_init(struct mmc35240_data
>*data)
> 
> 	/*
> 	 * make sure we restore sensor characteristics, by doing
>-	 * a RESET/SET sequence
>+	 * a SET/RESET sequence, the axis polarity being naturally
>+	 * aligned after RESET
> 	 */
>-	ret = mmc35240_hw_set(data, false);
>+	ret = mmc35240_hw_set(data, true);
> 	if (ret < 0)
> 		return ret;
> 	usleep_range(MMC53240_WAIT_SET_RESET, MMC53240_WAIT_SET_RESET + 1);
> 
>-	ret = mmc35240_hw_set(data, true);
>+	ret = mmc35240_hw_set(data, false);
> 	if (ret < 0)
> 		return ret;
> 

-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity.
