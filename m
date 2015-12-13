Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:38271 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751747AbbLMLII (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 13 Dec 2015 06:08:08 -0500
Date: Sun, 13 Dec 2015 14:07:44 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Bhaktipriya Shridhar <bhaktipriya96@gmail.com>,
	Joe Perches <joe@perches.com>
Cc: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
	pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
	ciorneiioana@gmail.com, cristina.moraru09@gmail.com,
	josselin.costanzi@mobile-devices.fr, linux-iio@vger.kernel.org,
	devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Staging: iio: accel: Fixed NULL comparison style
Message-ID: <20151213110744.GC5177@mwanda>
References: <20151213095427.GA6159@Karyakshetra>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20151213095427.GA6159@Karyakshetra>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sun, Dec 13, 2015 at 12:54:27PM +0300, Bhaktipriya Shridhar wrote:
> This patch fixes checkpatch.pl check:
> CHECK: Comparison to NULL could be written "!rx_p"
> +       if (*rx_p == NULL) {
> 

Actually it should be "if (!*rx_p)".  checkpatch.pl appears to have a
bug here.

regards,
dan carpenter

> Signed-off-by: Bhaktipriya Shridhar <bhaktipriya96@gmail.com>
> ---
>  drivers/staging/iio/accel/sca3000_ring.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/iio/accel/sca3000_ring.c b/drivers/staging/iio/accel/sca3000_ring.c
> index 20b878d..5339b10 100644
> --- a/drivers/staging/iio/accel/sca3000_ring.c
> +++ b/drivers/staging/iio/accel/sca3000_ring.c
> @@ -48,7 +48,7 @@ static int sca3000_read_data(struct sca3000_state *st,
>  		}
>  	};
>  	*rx_p = kmalloc(len, GFP_KERNEL);
> -	if (*rx_p == NULL) {
> +	if (!rx_p) {
>  		ret = -ENOMEM;
>  		goto error_ret;
>  	}
> -- 
> 2.1.4
