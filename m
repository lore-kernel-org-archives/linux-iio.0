Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:52374 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752491AbcEVTl0 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 22 May 2016 15:41:26 -0400
Subject: Re: [PATCH 20/54] MAINTAINERS: Add file patterns for iio device tree
 bindings
To: Geert Uytterhoeven <geert@linux-m68k.org>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1463907991-7916-1-git-send-email-geert@linux-m68k.org>
 <1463907991-7916-21-git-send-email-geert@linux-m68k.org>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	linux-iio@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <f80bdfd1-fdb7-1fb7-3be4-2c76a0c04ea7@kernel.org>
Date: Sun, 22 May 2016 20:41:23 +0100
MIME-Version: 1.0
In-Reply-To: <1463907991-7916-21-git-send-email-geert@linux-m68k.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 22/05/16 10:05, Geert Uytterhoeven wrote:
> Submitters of device tree binding documentation may forget to CC
> the subsystem maintainer if this is missing.
> 
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Cc: Jonathan Cameron <jic23@kernel.org>
> Cc: Hartmut Knaack <knaack.h@gmx.de>
> Cc: Lars-Peter Clausen <lars@metafoo.de>
> Cc: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
> Cc: linux-iio@vger.kernel.org
Applied. Thanks.
> ---
> Please apply this patch directly if you want to be involved in device
> tree binding documentation for your subsystem.
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index cd7793520e2cccfc..5cf50bf461c4255e 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -5786,6 +5786,7 @@ R:	Lars-Peter Clausen <lars@metafoo.de>
>  R:	Peter Meerwald-Stadler <pmeerw@pmeerw.net>
>  L:	linux-iio@vger.kernel.org
>  S:	Maintained
> +F:	Documentation/devicetree/bindings/iio/
>  F:	drivers/iio/
>  F:	drivers/staging/iio/
>  F:	include/linux/iio/
> 

