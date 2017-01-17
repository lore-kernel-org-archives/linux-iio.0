Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35617 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750787AbdAQBIG (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 16 Jan 2017 20:08:06 -0500
Subject: Re: [PATCH v2 1/2] devicetree: add Garmin vendor prefix
To: Matt Ranostay <matt@ranostay.consulting>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org
References: <20161229051306.28547-1-matt@ranostay.consulting>
Cc: jic23@kernel.org, Rob Herring <robh@kernel.org>
From: Marek Vasut <marek.vasut@gmail.com>
Message-ID: <06f2cde2-ac7e-d0e5-5e35-a4946d0398f8@gmail.com>
Date: Tue, 17 Jan 2017 02:07:56 +0100
MIME-Version: 1.0
In-Reply-To: <20161229051306.28547-1-matt@ranostay.consulting>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 12/29/2016 06:13 AM, Matt Ranostay wrote:

Some commit message / description of the company would be useful.

> Cc: Rob Herring <robh@kernel.org>
> Signed-off-by: Matt Ranostay <matt@ranostay.consulting>
> ---
> Changes from v1:
> * switch to stock ticker for Garmin Limited
> 
>  Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
> index 16d3b5e7f5d1..5749bfc5fc5b 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.txt
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
> @@ -107,6 +107,7 @@ firefly	Firefly
>  focaltech	FocalTech Systems Co.,Ltd
>  friendlyarm	Guangzhou FriendlyARM Computer Tech Co., Ltd
>  fsl	Freescale Semiconductor
> +grmn	Garmin Limited

Why grmn ? Why not 'garmin' ? Also, the rest uses Ltd. , so make it
consistent ?

>  ge	General Electric Company
>  geekbuying	GeekBuying
>  gef	GE Fanuc Intelligent Platforms Embedded Systems, Inc.
> 


-- 
Best regards,
Marek Vasut
