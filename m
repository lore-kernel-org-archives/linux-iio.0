Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:39288 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754546AbdERJGN (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 18 May 2017 05:06:13 -0400
Date: Thu, 18 May 2017 11:06:03 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: surenderpolsani@gmail.com
Cc: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, gregor.boirie@parrot.com,
        devel@driverdev.osuosl.org, eraretuya@gmail.com,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        maitysanchayan@gmail.com, singhalsimran0@gmail.com
Subject: Re: [PATCH] staging: iio: light: Replace symbolic permissions as per
 coding style
Message-ID: <20170518090603.GA27644@kroah.com>
References: <1495096589-5846-1-git-send-email-surenderpolsani@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1495096589-5846-1-git-send-email-surenderpolsani@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, May 18, 2017 at 02:06:29PM +0530, surenderpolsani@gmail.com wrote:
> From: Surender Polsani <surenderpolsani@gmail.com>
> 
> Fixed the following checkpatch.pl warnings:
> octal permissions are more preferable than symbolic permissions
> 
> Signed-off-by: Surender Polsani <surenderpolsani@gmail.com>
> ---
>  drivers/staging/iio/light/tsl2x7x_core.c | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/staging/iio/light/tsl2x7x_core.c b/drivers/staging/iio/light/tsl2x7x_core.c
> index af3910b..c63fe6a 100644
> --- a/drivers/staging/iio/light/tsl2x7x_core.c
> +++ b/drivers/staging/iio/light/tsl2x7x_core.c
> @@ -1498,34 +1498,34 @@ static int tsl2x7x_write_raw(struct iio_dev *indio_dev,
>  	return 0;
>  }
>  
> -static DEVICE_ATTR(power_state, S_IRUGO | S_IWUSR,
> +static DEVICE_ATTR(power_state, 0644,
>  		tsl2x7x_power_state_show, tsl2x7x_power_state_store);

How about using DEVICE_ATTR_RW() and DEVICE_ATTR_RO() instead?

thanks,

greg k-h
