Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:52379 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752493AbcEVTmK (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 22 May 2016 15:42:10 -0400
Subject: Re: [PATCH 45/54] MAINTAINERS: Add file patterns for staging iio
 device tree bindings
To: Geert Uytterhoeven <geert@linux-m68k.org>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1463907991-7916-1-git-send-email-geert@linux-m68k.org>
 <1463907991-7916-46-git-send-email-geert@linux-m68k.org>
Cc: linux-iio@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <9b7f6db5-2acb-5093-d30f-2eebee796abc@kernel.org>
Date: Sun, 22 May 2016 20:42:08 +0100
MIME-Version: 1.0
In-Reply-To: <1463907991-7916-46-git-send-email-geert@linux-m68k.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 22/05/16 10:06, Geert Uytterhoeven wrote:
> Submitters of device tree binding documentation may forget to CC
> the subsystem maintainer if this is missing.
> 
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Cc: Jonathan Cameron <jic23@kernel.org>
> Cc: linux-iio@vger.kernel.org
Applied - thanks.

Jonathan
> ---
> Please apply this patch directly if you want to be involved in device
> tree binding documentation for your subsystem.
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index f11355314880838b..5c96827ea93d5d7c 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -10867,6 +10867,7 @@ STAGING - INDUSTRIAL IO
>  M:	Jonathan Cameron <jic23@kernel.org>
>  L:	linux-iio@vger.kernel.org
>  S:	Odd Fixes
> +F:	Documentation/devicetree/bindings/staging/iio/
>  F:	drivers/staging/iio/
>  
>  STAGING - LIRC (LINUX INFRARED REMOTE CONTROL) DRIVERS
> 

