Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:41084 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752712AbbGNVBY (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 14 Jul 2015 17:01:24 -0400
In-Reply-To: <1436880983-29017-3-git-send-email-gizero@gmail.com>
References: <1436880983-29017-1-git-send-email-gizero@gmail.com> <1436880983-29017-3-git-send-email-gizero@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Subject: Re: [PATCH 3/4] iio: adc: mcp320x: Kconfig update description
From: Jonathan Cameron <jic23@kernel.org>
Date: Tue, 14 Jul 2015 22:01:20 +0100
To: Andrea Galbusera <gizero@gmail.com>
CC: linux-iio@vger.kernel.org
Message-ID: <CBD00571-7D94-49C4-814F-D0D6F86EABC5@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org



On 14 July 2015 14:36:22 BST, Andrea Galbusera <gizero@gmail.com> wrote:
>Signed-off-by: Andrea Galbusera <gizero@gmail.com>
Doesn't need a separate patch.  If this is only issue I will merge it with patch 2 whilst applying it.
>---
> drivers/iio/adc/Kconfig | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
>
>diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
>index 7c55658..f074b6a 100644
>--- a/drivers/iio/adc/Kconfig
>+++ b/drivers/iio/adc/Kconfig
>@@ -207,8 +207,8 @@ config MCP320X
> 	depends on SPI
> 	help
> 	  Say yes here to build support for Microchip Technology's
>-	  MCP3001, MCP3002, MCP3004, MCP3008, MCP3201, MCP3202, MCP3204 or
>-	  MCP3208 analog to digital converter.
>+	  MCP3001, MCP3002, MCP3004, MCP3008, MCP3201, MCP3202, MCP3204,
>+	  MCP3208 or MCP3301 analog to digital converter.
> 
>	  This driver can also be built as a module. If so, the module will be
> 	  called mcp320x.

-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity.
