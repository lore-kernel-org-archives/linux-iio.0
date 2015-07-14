Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:41086 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752503AbbGNVC4 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 14 Jul 2015 17:02:56 -0400
In-Reply-To: <1436880983-29017-4-git-send-email-gizero@gmail.com>
References: <1436880983-29017-1-git-send-email-gizero@gmail.com> <1436880983-29017-4-git-send-email-gizero@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Subject: Re: [PATCH 4/4] iio: adc: mcp320x: update dt-bindings help
From: Jonathan Cameron <jic23@kernel.org>
Date: Tue, 14 Jul 2015 22:02:53 +0100
To: Andrea Galbusera <gizero@gmail.com>
CC: linux-iio@vger.kernel.org
Message-ID: <611F71DC-AABD-4A17-B604-A32A8FF549C1@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org



On 14 July 2015 14:36:23 BST, Andrea Galbusera <gizero@gmail.com> wrote:
>Signed-off-by: Andrea Galbusera <gizero@gmail.com>
Again no need for separate patch. All 3 are adding the new part support and so should be 1 patch.

I will fix up when applying.
>---
> Documentation/devicetree/bindings/iio/adc/mcp320x.txt | 1 +
> 1 file changed, 1 insertion(+)
>
>diff --git a/Documentation/devicetree/bindings/iio/adc/mcp320x.txt
>b/Documentation/devicetree/bindings/iio/adc/mcp320x.txt
>index b851843..2a1f3af 100644
>--- a/Documentation/devicetree/bindings/iio/adc/mcp320x.txt
>+++ b/Documentation/devicetree/bindings/iio/adc/mcp320x.txt
>@@ -18,6 +18,7 @@ Required properties:
> 				"mcp3202"
> 				"mcp3204"
> 				"mcp3208"
>+				"mcp3301"
> 
> 
> Examples:

-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity.
