Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:51504 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750738AbaKLHGK (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 12 Nov 2014 02:06:10 -0500
From: Jingoo Han <jg1.han@samsung.com>
To: 'Daniel Baluta' <daniel.baluta@intel.com>
Cc: 'Andrew Morton' <akpm@linux-foundation.org>,
	'Greg Kroah-Hartman' <gregkh@linuxfoundation.org>,
	'Joe Perches' <joe@perches.com>,
	'Jonathan Cameron' <jic23@kernel.org>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	"'David S. Miller'" <davem@davemloft.net>,
	'Mauro Carvalho Chehab' <mchehab@osg.samsung.com>,
	'Antti Palosaari' <crope@iki.fi>,
	'Hartmut Knaack' <knaack.h@gmx.de>,
	'Lars-Peter Clausen' <lars@metafoo.de>,
	'Peter Meerwald' <pmeerw@pmeerw.net>,
	'Jingoo Han' <jg1.han@samsung.com>
References: <1415716594-18145-1-git-send-email-daniel.baluta@intel.com>
In-reply-to: <1415716594-18145-1-git-send-email-daniel.baluta@intel.com>
Subject: Re: [PATCH] MAINTAINERS: Add IIO include files
Date: Wed, 12 Nov 2014 16:06:52 +0900
Message-id: <000801cffe47$3c87f570$b597e050$%han@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tuesday, November 11, 2014 11:37 PM, Daniel Baluta wrote:
> 
> Files under include/linux/iio were not reported as part
> of the IIO subsystem.
> 
> Reported-by: Cristina Ciocan <cristina.ciocan@intel.com>
> Signed-off-by: Daniel Baluta <daniel.baluta@intel.com>

(+cc Hartmut Knaack, Lars-Peter Clausen, Peter Meerwald)

Reviewed-by: Jingoo Han <jg1.han@samsung.com>

Best regards,
Jingoo Han

> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index b2f927b..ebb9c38 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4631,6 +4631,7 @@ L:	linux-iio@vger.kernel.org
>  S:	Maintained
>  F:	drivers/iio/
>  F:	drivers/staging/iio/
> +F:	include/linux/iio/
> 
>  IKANOS/ADI EAGLE ADSL USB DRIVER
>  M:	Matthieu Castet <castet.matthieu@free.fr>
> --
> 1.9.1

