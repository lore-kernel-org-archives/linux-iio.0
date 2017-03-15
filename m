Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:58269 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751416AbdCOWOa (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 15 Mar 2017 18:14:30 -0400
Subject: Re: [PATCH v4 2/2] staging: iio: ad9834: Remove unnecessary goto
 statement
To: sayli karnik <karniksayli1995@gmail.com>,
        outreachy-kernel@googlegroups.com
References: <cover.1489424208.git.karniksayli1995@gmail.com>
 <0ed151986770fac23cae759d2092683cced90dc1.1489424208.git.karniksayli1995@gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <8ffdf514-0fd7-7adf-a7b4-2ab2a4802d81@kernel.org>
Date: Wed, 15 Mar 2017 22:14:29 +0000
MIME-Version: 1.0
In-Reply-To: <0ed151986770fac23cae759d2092683cced90dc1.1489424208.git.karniksayli1995@gmail.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 13/03/17 17:56, sayli karnik wrote:
> The patch removes unnecessary use of goto statement.
> 
> Signed-off-by: sayli karnik <karniksayli1995@gmail.com>
Applied. Thanks,

Jonathan
> ---
> v3:
> Uncompressed return logic to avoid calling the function twice
> 
>  drivers/staging/iio/frequency/ad9834.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/iio/frequency/ad9834.c b/drivers/staging/iio/frequency/ad9834.c
> index 2dffe48..af108e9 100644
> --- a/drivers/staging/iio/frequency/ad9834.c
> +++ b/drivers/staging/iio/frequency/ad9834.c
> @@ -149,7 +149,7 @@ static ssize_t ad9834_write(struct device *dev,
>  
>  	ret = kstrtoul(buf, 10, &val);
>  	if (ret)
> -		goto error_ret;
> +		return ret;
>  
>  	mutex_lock(&st->lock);
>  	switch ((u32)this_attr->address) {
> @@ -211,7 +211,6 @@ static ssize_t ad9834_write(struct device *dev,
>  	}
>  	mutex_unlock(&st->lock);
>  
> -error_ret:
>  	return ret ? ret : len;
>  }
>  
> 

