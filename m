Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:56195 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932811AbbLSQl2 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 19 Dec 2015 11:41:28 -0500
Subject: Re: [PATCH v3] Staging: iio: accel: Fixed NULL comparison style
To: Bhaktipriya Shridhar <bhaktipriya96@gmail.com>, knaack.h@gmx.de,
	lars@metafoo.de, pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
	ciorneiioana@gmail.com, cristina.moraru09@gmail.com,
	dan.carpenter@oracle.com, josselin.costanzi@mobile-devices.fr
References: <20151213151513.GA5059@Karyakshetra>
Cc: linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <567588B5.9000004@kernel.org>
Date: Sat, 19 Dec 2015 16:41:25 +0000
MIME-Version: 1.0
In-Reply-To: <20151213151513.GA5059@Karyakshetra>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 13/12/15 15:15, Bhaktipriya Shridhar wrote:
> The variable u8 **rx_p, is a pointer-to-pointer and hence the check
> should
> be "if (!*rx_p)" and not "if (!rx_p)".
> In the earlier version, checkpatch.pl gave the following check, which
> was incorrect:
> CHECK: Comparison to NULL could be written "!rx_p"
> +       if (*rx_p == NULL) {
> 
> Signed-off-by: Bhaktipriya Shridhar <bhaktipriya96@gmail.com>
Applied to the togreg branch of iio.git with the addition of the driver name
in the patch title.

Thanks

Jonathan
> ---
>  Changes in v3:
>         - Replaced "if (!rx_p)" with "if (!*rx_p)"
> 	- Changes are made on the original code
> 
>  drivers/staging/iio/accel/sca3000_ring.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/iio/accel/sca3000_ring.c b/drivers/staging/iio/accel/sca3000_ring.c
> index 20b878d..1920dc60 100644
> --- a/drivers/staging/iio/accel/sca3000_ring.c
> +++ b/drivers/staging/iio/accel/sca3000_ring.c
> @@ -48,7 +48,7 @@ static int sca3000_read_data(struct sca3000_state *st,
>  		}
>  	};
>  	*rx_p = kmalloc(len, GFP_KERNEL);
> -	if (*rx_p == NULL) {
> +	if (!*rx_p) {
>  		ret = -ENOMEM;
>  		goto error_ret;
>  	}
> 

