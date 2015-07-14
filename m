Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:41098 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752683AbbGNVEZ (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 14 Jul 2015 17:04:25 -0400
In-Reply-To: <1436880983-29017-1-git-send-email-gizero@gmail.com>
References: <1436880983-29017-1-git-send-email-gizero@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Subject: Re: [PATCH 1/4] iio: adc: mcp320x: add masking of unknown bits
From: Jonathan Cameron <jic23@kernel.org>
Date: Tue, 14 Jul 2015 22:04:23 +0100
To: Andrea Galbusera <gizero@gmail.com>
CC: linux-iio@vger.kernel.org
Message-ID: <50E24B24-6DC9-4ECB-8752-B974BD6C53E8@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org



On 14 July 2015 14:36:20 BST, Andrea Galbusera <gizero@gmail.com> wrote:
>According to the datasheet, the 2 MSBs for parts 3001 and 3201 are
>unspecified and should be masked out
Theoretical issue or one with observed bad effects?

Changes the path and timing of this getting applied. Patch itself is fine either way!
>
>Signed-off-by: Andrea Galbusera <gizero@gmail.com>
>---
>
>This was already suggested but for some reason got lost during review
>of a
>previous patch. See http://marc.info/?l=linux-iio&m=140748835509583&w=2
>and following discussion
>
> drivers/iio/adc/mcp320x.c | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
>
>diff --git a/drivers/iio/adc/mcp320x.c b/drivers/iio/adc/mcp320x.c
>index 8d9c9b9..0673ee7 100644
>--- a/drivers/iio/adc/mcp320x.c
>+++ b/drivers/iio/adc/mcp320x.c
>@@ -114,13 +114,13 @@ static int mcp320x_adc_conversion(struct mcp320x
>*adc, u8 channel,
> 
> 	switch (device_index) {
> 	case mcp3001:
>-		return (adc->rx_buf[0] << 5 | adc->rx_buf[1] >> 3);
>+		return ((adc->rx_buf[0] & 0x1f) << 5 | adc->rx_buf[1] >> 3);
> 	case mcp3002:
> 	case mcp3004:
> 	case mcp3008:
> 		return (adc->rx_buf[0] << 2 | adc->rx_buf[1] >> 6);
> 	case mcp3201:
>-		return (adc->rx_buf[0] << 7 | adc->rx_buf[1] >> 1);
>+		return ((adc->rx_buf[0] & 0x1f) << 7 | adc->rx_buf[1] >> 1);
> 	case mcp3202:
> 	case mcp3204:
> 	case mcp3208:

-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity.
