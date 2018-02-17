Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:45046 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750771AbeBQMGa (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 17 Feb 2018 07:06:30 -0500
Date: Sat, 17 Feb 2018 12:06:26 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Harald Geyer <harald@ccbib.org>
Cc: linux-iio@vger.kernel.org, Edward Attfield <edward@attfield.ca>
Subject: Re: [PATCH] iio: dht11: Improve detection of sensor type
Message-ID: <20180217120626.728c3aaa@archlinux>
In-Reply-To: <1518347380-9624-1-git-send-email-harald@ccbib.org>
References: <1518347380-9624-1-git-send-email-harald@ccbib.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sun, 11 Feb 2018 11:09:40 +0000
Harald Geyer <harald@ccbib.org> wrote:

> The old code was based on a DHT11 datasheet which specifies a measurement
> range of 20%-90% RH. Turns out the sensor actually reports values outside
> this range, so we should support it as far as possible.
> 
> Reported-by: Edward Attfield <edward@attfield.ca>
> Signed-off-by: Harald Geyer <harald@ccbib.org>
Applied to the togreg branch of iio.git and pushed out as
testing for the autobuilders to play with it.

Thanks,

Jonathan

> ---
>  drivers/iio/humidity/dht11.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/humidity/dht11.c b/drivers/iio/humidity/dht11.c
> index df6bab4..1a9f8f4 100644
> --- a/drivers/iio/humidity/dht11.c
> +++ b/drivers/iio/humidity/dht11.c
> @@ -159,7 +159,7 @@ static int dht11_decode(struct dht11 *dht11, int offset)
>  	}
>  
>  	dht11->timestamp = ktime_get_boot_ns();
> -	if (hum_int < 20) {  /* DHT22 */
> +	if (hum_int < 4) {  /* DHT22: 100000 = (3*256+232)*100 */
>  		dht11->temperature = (((temp_int & 0x7f) << 8) + temp_dec) *
>  					((temp_int & 0x80) ? -100 : 100);
>  		dht11->humidity = ((hum_int << 8) + hum_dec) * 100;

