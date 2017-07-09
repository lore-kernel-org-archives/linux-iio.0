Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:52764 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752225AbdGISMI (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 9 Jul 2017 14:12:08 -0400
Date: Sun, 9 Jul 2017 19:12:02 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Colin King <colin.king@canonical.com>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Hans de Goede <hdegoede@redhat.com>,
        Rob Herring <robh@kernel.org>, linux-iio@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: accel: make array init_data static to reduce code
 size
Message-ID: <20170709191202.29cd4c3f@kernel.org>
In-Reply-To: <20170707155519.18736-1-colin.king@canonical.com>
References: <20170707155519.18736-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri,  7 Jul 2017 16:55:19 +0100
Colin King <colin.king@canonical.com> wrote:

> From: Colin Ian King <colin.king@canonical.com>
> 
> Making the const array init_data static rather having it on the
> stack saves us a couple hundreds of bytes:
> 
> Before:
>    text	   data	    bss	    dec	    hex	filename
>    3175	    848	      0	   4023	    fb7	drivers/iio/accel/da311.o
> 
> After:
>    text	   data	    bss	    dec	    hex	filename
>    2860	    936	      0	   3796	    ed4	drivers/iio/accel/da311.o
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
Applied.

Thanks,

Jonathan
> ---
>  drivers/iio/accel/da311.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/accel/da311.c b/drivers/iio/accel/da311.c
> index 537cfa8b6edf..c0c1620d2a2f 100644
> --- a/drivers/iio/accel/da311.c
> +++ b/drivers/iio/accel/da311.c
> @@ -139,7 +139,7 @@ static int da311_register_mask_write(struct i2c_client *client, u16 addr,
>  /* Init sequence taken from the android driver */
>  static int da311_reset(struct i2c_client *client)
>  {
> -	const struct {
> +	static const struct {
>  		u16 addr;
>  		u8 mask;
>  		u8 data;

