Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:54095 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754123AbcJKSpt (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 11 Oct 2016 14:45:49 -0400
Subject: Re: [PATCH] Staging: iio: fix a MAINTAINERS entry
To: Dan Carpenter <dan.carpenter@oracle.com>,
        Lars-Peter Clausen <lars@metafoo.de>
References: <20161011111129.GA16475@mwanda>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <a8a83926-b65a-a94d-8370-87975bccb95d@kernel.org>
Date: Tue, 11 Oct 2016 19:45:47 +0100
MIME-Version: 1.0
In-Reply-To: <20161011111129.GA16475@mwanda>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 11/10/16 12:12, Dan Carpenter wrote:
> The "drivers/" part of the path name was missing.
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Applied - thanks.

Jonathan
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 0c7d973..63f15c9 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -779,7 +779,7 @@ S:	Supported
>  F:	drivers/iio/*/ad*
>  X:	drivers/iio/*/adjd*
>  F:	drivers/staging/iio/*/ad*
> -F:	staging/iio/trigger/iio-trig-bfin-timer.c
> +F:	drivers/staging/iio/trigger/iio-trig-bfin-timer.c
>  
>  ANALOG DEVICES INC DMA DRIVERS
>  M:	Lars-Peter Clausen <lars@metafoo.de>
> 

