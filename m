Return-Path: <SRS0=5njp=C4=linuxfoundation.org=gregkh@kernel.org>
Date: Thu, 30 Nov 2017 16:41:24 +0000
From: Greg KH <gregkh@linuxfoundation.org>
To: Arvind Yadav <arvind.yadav.cs@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
	knaack.h@gmx.de, pmeerw@pmeerw.net, samuel@sortiz.org,
	linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH 2/3] staging: irda: Handle return value of
 platform_get_irq
Message-ID: <20171130164124.GB17869@kroah.com>
References: <1512056616-21065-1-git-send-email-arvind.yadav.cs@gmail.com>
 <1512056616-21065-3-git-send-email-arvind.yadav.cs@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1512056616-21065-3-git-send-email-arvind.yadav.cs@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

On Thu, Nov 30, 2017 at 09:13:35PM +0530, Arvind Yadav wrote:
> platform_get_irq() can fail here and we must check its return value.
> 
> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
> ---
>  drivers/staging/irda/drivers/pxaficp_ir.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)

Did you read drivers/staging/irda/TODO?

thanks,

greg k-h
