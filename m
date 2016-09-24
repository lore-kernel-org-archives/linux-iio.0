Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:59351 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750838AbcIXPcd (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 24 Sep 2016 11:32:33 -0400
Subject: Re: [PATCH 2/7] iio: Rename a jump label in
 iio_buffer_store_watermark()
To: SF Markus Elfring <elfring@users.sourceforge.net>,
        linux-iio@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
References: <566ABCD9.1060404@users.sourceforge.net>
 <c11fbb47-1fd3-4e9e-042e-0f271cfef814@users.sourceforge.net>
 <50eb1352-fb0a-1cf5-70d8-48fe8f98b9eb@users.sourceforge.net>
Cc: LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org,
        Julia Lawall <julia.lawall@lip6.fr>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <dfb5e8de-8217-ba50-017a-6a3c20209419@kernel.org>
Date: Sat, 24 Sep 2016 16:32:30 +0100
MIME-Version: 1.0
In-Reply-To: <50eb1352-fb0a-1cf5-70d8-48fe8f98b9eb@users.sourceforge.net>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 24/09/16 07:25, SF Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Sat, 24 Sep 2016 06:54:49 +0200
> 
> Adjust jump labels according to the current Linux coding style convention.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
I'm not necessarily against this change which does perhaps clarify the code
ever so slightly, but I am interested to know where 
'current Linux coding style convention' comes from?

Jonathan
> ---
>  drivers/iio/industrialio-buffer.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
> index 7a4d9499..a865af8 100644
> --- a/drivers/iio/industrialio-buffer.c
> +++ b/drivers/iio/industrialio-buffer.c
> @@ -1028,16 +1028,16 @@ static ssize_t iio_buffer_store_watermark(struct device *dev,
>  
>  	if (val > buffer->length) {
>  		ret = -EINVAL;
> -		goto out;
> +		goto unlock;
>  	}
>  
>  	if (iio_buffer_is_active(indio_dev->buffer)) {
>  		ret = -EBUSY;
> -		goto out;
> +		goto unlock;
>  	}
>  
>  	buffer->watermark = val;
> -out:
> +unlock:
>  	mutex_unlock(&indio_dev->mlock);
>  
>  	return ret ? ret : len;
> 

