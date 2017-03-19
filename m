Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:48366 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751697AbdCSKrP (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 19 Mar 2017 06:47:15 -0400
Subject: Re: [PATCH] iio: accel: Prefer unsigned int to bare use of unsigned
To: Miguel Robles <miguel.robles@farole.net>, lars@metafoo.de,
        knaack.h@gmx.de
References: <1489707345-20053-1-git-send-email-miguel.robles@farole.net>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <4fbe24d7-ffd6-00a6-c217-75b3294c5c0a@kernel.org>
Date: Sun, 19 Mar 2017 10:37:42 +0000
MIME-Version: 1.0
In-Reply-To: <1489707345-20053-1-git-send-email-miguel.robles@farole.net>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 16/03/17 23:35, Miguel Robles wrote:
> Fix checkpatch warnings:
> WARNING: Prefer 'unsigned int' to bare use of 'unsigned'
> 
> Signed-off-by: Miguel Robles <miguel.robles@farole.net>
Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.

Thanks,

Jonathan
> ---
>  drivers/iio/accel/bma180.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/accel/bma180.c b/drivers/iio/accel/bma180.c
> index 0890934..dd84e87 100644
> --- a/drivers/iio/accel/bma180.c
> +++ b/drivers/iio/accel/bma180.c
> @@ -41,11 +41,11 @@ struct bma180_data;
>  
>  struct bma180_part_info {
>  	const struct iio_chan_spec *channels;
> -	unsigned num_channels;
> +	unsigned int num_channels;
>  	const int *scale_table;
> -	unsigned num_scales;
> +	unsigned int num_scales;
>  	const int *bw_table;
> -	unsigned num_bw;
> +	unsigned int num_bw;
>  
>  	u8 int_reset_reg, int_reset_mask;
>  	u8 sleep_reg, sleep_mask;
> @@ -408,7 +408,7 @@ static void bma250_chip_disable(struct bma180_data *data)
>  	dev_err(&data->client->dev, "failed to disable the chip\n");
>  }
>  
> -static ssize_t bma180_show_avail(char *buf, const int *vals, unsigned n,
> +static ssize_t bma180_show_avail(char *buf, const int *vals, unsigned int n,
>  				 bool micros)
>  {
>  	size_t len = 0;
> 

