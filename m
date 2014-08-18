Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([87.118.82.44]:37288 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751478AbaHRInI (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Mon, 18 Aug 2014 04:43:08 -0400
Date: Mon, 18 Aug 2014 10:43:03 +0200 (CEST)
From: Peter Meerwald <pmeerw@pmeerw.net>
To: Lars-Peter Clausen <lars@metafoo.de>
cc: Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>, linux-iio@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: Add designated reviewers for IIO
 subsystem
In-Reply-To: <1408350589-22372-1-git-send-email-lars@metafoo.de>
Message-ID: <alpine.DEB.2.01.1408181042300.4583@pmeerw.net>
References: <1408350589-22372-1-git-send-email-lars@metafoo.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, 18 Aug 2014, Lars-Peter Clausen wrote:

> Add those persons who generally tend to review new IIO patches to the list of
> designated reviewers to make sure that they are Cc'ed on new patches.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> ---
> Hartmut, Peter if you are OK with this please ack the patch, otherwise I can
> respin it to remove you.

Acked-by: Peter Meerwald <pmeerw@pmeerw.net>

> ---
>  MAINTAINERS | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index aefa948..3f77be0 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4580,6 +4580,9 @@ F:	drivers/media/rc/iguanair.c
>  
>  IIO SUBSYSTEM AND DRIVERS
>  M:	Jonathan Cameron <jic23@kernel.org>
> +R:	Hartmut Knaack <knaack.h@gmx.de>
> +R:	Lars-Peter Clausen <lars@metafoo.de>
> +R:	Peter Meerwald <pmeerw@pmeerw.net>
>  L:	linux-iio@vger.kernel.org
>  S:	Maintained
>  F:	drivers/iio/
> 

-- 

Peter Meerwald
+43-664-2444418 (mobile)
