Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:35820 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751891AbeCXNXi (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 24 Mar 2018 09:23:38 -0400
Date: Sat, 24 Mar 2018 13:23:31 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: John Syne <rodrigosiqueiramelo@gmail.com>
Cc: John Syne <john3909@gmail.com>, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, Barry Song <21cnbao@gmail.com>,
        daniel.baluta@nxp.com
Subject: Re: [PATCH v3 2/8] staging:iio:ade7854: Fix the wrong number of
 bits to read
Message-ID: <20180324132331.03af7f4e@archlinux>
In-Reply-To: <5a7be7d02989db19d35f6d919fc9bce995666a55.1521813782.git.rodrigosiqueiramelo@gmail.com>
References: <cover.1521813782.git.rodrigosiqueiramelo@gmail.com>
        <5a7be7d02989db19d35f6d919fc9bce995666a55.1521813782.git.rodrigosiqueiramelo@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, 23 Mar 2018 11:25:48 -0300
John Syne <rodrigosiqueiramelo@gmail.com> wrote:

> Fixes: correctly handle the data size in the read operation for I2C
> 
> The function ade7854_i2c_read_reg_32() have to invoke the
> i2c_master_recv() for read 32 bits values, however, the counter is set
> to 3 which means 24 bits. This patch fixes the wrong size of 24 bits, to
> 32 bits.
> 
> Signed-off-by: John Syne <john3909@gmail.com>
> Signed-off-by: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
Applied with fixed 'fixes' tag.

Jonathan

> ---
> Changes in v3:
>  - Clarify authorship
>  - Add Fixes tag in the commit message
> 
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

