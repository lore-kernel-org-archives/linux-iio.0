Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:46918 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726526AbeKYUuD (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 25 Nov 2018 15:50:03 -0500
Date: Sun, 25 Nov 2018 09:59:16 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, knaack.h@gmx.de,
        pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, kernel-usp@googlegroups.com
Subject: Re: [PATCH v2] staging: iio: ad5933: add device tree support
Message-ID: <20181125095916.58de5773@archlinux>
In-Reply-To: <20181124131857.ur6rt7nnjinmj6gm@smtp.gmail.com>
References: <20181124131857.ur6rt7nnjinmj6gm@smtp.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sat, 24 Nov 2018 11:18:57 -0200
Marcelo Schmitt <marcelo.schmitt1@gmail.com> wrote:

> Add a of_device_id struct variable and subsequent call to
> MODULE_DEVICE_TABLE macro to complete device tree support.
> 
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.  Note we'll need a binding
doc for this before it can leave staging.

Thanks,

Jonathan

> ---
>  drivers/staging/iio/impedance-analyzer/ad5933.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/staging/iio/impedance-analyzer/ad5933.c b/drivers/staging/iio/impedance-analyzer/ad5933.c
> index edb8b540bbf1..6faa2700dc8d 100644
> --- a/drivers/staging/iio/impedance-analyzer/ad5933.c
> +++ b/drivers/staging/iio/impedance-analyzer/ad5933.c
> @@ -771,9 +771,18 @@ static const struct i2c_device_id ad5933_id[] = {
>  
>  MODULE_DEVICE_TABLE(i2c, ad5933_id);
>  
> +static const struct of_device_id ad5933_of_match[] = {
> +	{ .compatible = "adi,ad5933" },
> +	{ .compatible = "adi,ad5934" },
> +	{ },
> +};
> +
> +MODULE_DEVICE_TABLE(of, ad5933_of_match);
> +
>  static struct i2c_driver ad5933_driver = {
>  	.driver = {
>  		.name = "ad5933",
> +		.of_match_table = ad5933_of_match,
>  	},
>  	.probe = ad5933_probe,
>  	.remove = ad5933_remove,
