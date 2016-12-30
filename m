Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:53177 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754444AbcL3U0O (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 30 Dec 2016 15:26:14 -0500
Subject: Re: [PATCH v2 1/2] devicetree: add Garmin vendor prefix
To: Matt Ranostay <matt@ranostay.consulting>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org
References: <20161229051306.28547-1-matt@ranostay.consulting>
Cc: Rob Herring <robh@kernel.org>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <144bd616-1b5a-970a-edcb-13ebf67178f1@kernel.org>
Date: Fri, 30 Dec 2016 20:26:09 +0000
MIME-Version: 1.0
In-Reply-To: <20161229051306.28547-1-matt@ranostay.consulting>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 29/12/16 05:13, Matt Ranostay wrote:
> Cc: Rob Herring <robh@kernel.org>
> Signed-off-by: Matt Ranostay <matt@ranostay.consulting>
Rob, just to check - is this the right way to go with prefixes?
It's awfully ugly in this case ;)

Jonathan
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
>  ge	General Electric Company
>  geekbuying	GeekBuying
>  gef	GE Fanuc Intelligent Platforms Embedded Systems, Inc.
> 

