Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:44937 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932075AbdBKJo4 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 11 Feb 2017 04:44:56 -0500
Subject: Re: [PATCH] iio: 104-quad-8: Fix off-by-one error when addressing
 flag register
To: William Breathitt Gray <vilhelm.gray@gmail.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
References: <20170209150341.GA29292@sophia>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <d89a328a-4873-021e-a92b-f0498cb49d03@kernel.org>
Date: Sat, 11 Feb 2017 09:37:35 +0000
MIME-Version: 1.0
In-Reply-To: <20170209150341.GA29292@sophia>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 09/02/17 15:03, William Breathitt Gray wrote:
> The flag register is offset by 1 from the respective channel data
> register. This patch fixes an off-by-one error when attempting to read a
> channel flag register where the base address was not properly offset.
> 
> Fixes: 28e5d3bb0325 ("iio: 104-quad-8: Add IIO support for the ACCES 104-QUAD-8")
> Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
Applied to the fixes-togreg-post-rc1 branch of iio.git
Clue to when this will go upstream is in the name ;)

Thanks,

Jonathan
> ---
>  drivers/iio/counter/104-quad-8.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/counter/104-quad-8.c b/drivers/iio/counter/104-quad-8.c
> index a5913e97945e..f9b8fc9ae13f 100644
> --- a/drivers/iio/counter/104-quad-8.c
> +++ b/drivers/iio/counter/104-quad-8.c
> @@ -76,7 +76,7 @@ static int quad8_read_raw(struct iio_dev *indio_dev,
>  			return IIO_VAL_INT;
>  		}
>  
> -		flags = inb(base_offset);
> +		flags = inb(base_offset + 1);
>  		borrow = flags & BIT(0);
>  		carry = !!(flags & BIT(1));
>  
> 

