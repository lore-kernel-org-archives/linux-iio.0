Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.15.15]:63448 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753326AbaLNMcT (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Sun, 14 Dec 2014 07:32:19 -0500
Message-ID: <548D8347.2020006@gmx.de>
Date: Sun, 14 Dec 2014 13:32:07 +0100
From: Hartmut Knaack <knaack.h@gmx.de>
MIME-Version: 1.0
To: Richard Weinberger <richard@nod.at>, jic23@kernel.org
CC: harald@ccbib.org, lars@metafoo.de, pmeerw@pmeerw.net,
	sanjeev_sharma@mentor.com, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] iio: dht11: Fix out-of-bounds read
References: <1417563176-31972-1-git-send-email-richard@nod.at> <1417563176-31972-5-git-send-email-richard@nod.at>
In-Reply-To: <1417563176-31972-5-git-send-email-richard@nod.at>
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Richard Weinberger schrieb am 03.12.2014 um 00:32:
> As we access i-1 we must not start with i=0.
> 
> Signed-off-by: Richard Weinberger <richard@nod.at>
Acked-by: Hartmut Knaack <knaack.h@gmx.de>
> ---
>  drivers/iio/humidity/dht11.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/humidity/dht11.c b/drivers/iio/humidity/dht11.c
> index fbcd7cb..5dfe71b 100644
> --- a/drivers/iio/humidity/dht11.c
> +++ b/drivers/iio/humidity/dht11.c
> @@ -90,7 +90,7 @@ static int dht11_decode(struct dht11 *dht11, int offset)
>  	unsigned char temp_int, temp_dec, hum_int, hum_dec, checksum;
>  
>  	/* Calculate timestamp resolution */
> -	for (i = 0; i < dht11->num_edges; ++i) {
> +	for (i = 1; i < dht11->num_edges; ++i) {
>  		t = dht11->edges[i].ts - dht11->edges[i-1].ts;
>  		if (t > 0 && t < timeres)
>  			timeres = t;
> 

