Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:40760 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751031AbeCRJsH (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 18 Mar 2018 05:48:07 -0400
Date: Sun, 18 Mar 2018 09:48:01 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
Cc: John Syne <john3909@gmail.com>, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, Barry Song <21cnbao@gmail.com>,
        daniel.baluta@nxp.com
Subject: Re: [PATCH v2 2/8] staging:iio:ade7854: Fix the wrong number of
 bits to read
Message-ID: <20180318094801.47e61123@archlinux>
In-Reply-To: <b5f76bfcf37667a473ec962bfafadc7f9455bec6.1521239766.git.rodrigosiqueiramelo@gmail.com>
References: <cover.1521239766.git.rodrigosiqueiramelo@gmail.com>
        <b5f76bfcf37667a473ec962bfafadc7f9455bec6.1521239766.git.rodrigosiqueiramelo@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, 16 Mar 2018 19:48:51 -0300
Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com> wrote:

> The function ade7854_i2c_read_reg_32() have to invoke the
> i2c_master_recv() for read 32 bits values, however, the counter is set
> to 3 which means 24 bits. This patch fixes the wrong size of 24 bits, to
> 32 bits. Finally, this patch is based on John Syne patches.
> 
> Signed-off-by: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
> Signed-off-by: John Syne <john3909@gmail.com>
Same issue with clarifying the authorship.  Also for these fixes
ideally include a 'fixes' tag to the original commit. It makes
life easy for the scripts the stable maintainers use to work
out when things should apply.

Here I would imagine it is the original commit that added the driver,
though we may have had enough changes over the years to make these
hard to apply.

Jonathan

> ---
>  drivers/staging/iio/meter/ade7854-i2c.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/iio/meter/ade7854-i2c.c b/drivers/staging/iio/meter/ade7854-i2c.c
> index 4437f1e33261..37c957482493 100644
> --- a/drivers/staging/iio/meter/ade7854-i2c.c
> +++ b/drivers/staging/iio/meter/ade7854-i2c.c
> @@ -191,7 +191,7 @@ static int ade7854_i2c_read_reg_32(struct device *dev,
>  	if (ret < 0)
>  		goto out;
>  
> -	ret = i2c_master_recv(st->i2c, st->rx, 3);
> +	ret = i2c_master_recv(st->i2c, st->rx, 4);
>  	if (ret < 0)
>  		goto out;
>  

