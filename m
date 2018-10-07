Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:58464 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726976AbeJHCmt (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 7 Oct 2018 22:42:49 -0400
Date: Sun, 7 Oct 2018 20:34:26 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc: <linux-iio@vger.kernel.org>, <Michael.Hennerich@analog.com>,
        <Dragos.Bogdan@analog.com>, <knaack.h@gmx.de>, <pmeerw@pmeerw.net>
Subject: Re: [PATCH 4/4] staging: iio: ad5933: Add of_device_id table
Message-ID: <20181007203426.448fefdb@archlinux>
In-Reply-To: <20181002115800.12399-4-alexandru.ardelean@analog.com>
References: <20181002115800.12399-1-alexandru.ardelean@analog.com>
        <20181002115800.12399-4-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, 2 Oct 2018 14:58:00 +0300
Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:

> From: Dragos Bogdan <dragos.bogdan@analog.com>
> 
> As part of finalizing the device-tree support for this driver, this patch
> adds the of_device_id table with supported devices.
> 
> Signed-off-by: Dragos Bogdan <dragos.bogdan@analog.com>
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
> ---
>  drivers/staging/iio/impedance-analyzer/ad5933.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/staging/iio/impedance-analyzer/ad5933.c b/drivers/staging/iio/impedance-analyzer/ad5933.c
> index 04208a1df48e..ab8b93fd39ed 100644
> --- a/drivers/staging/iio/impedance-analyzer/ad5933.c
> +++ b/drivers/staging/iio/impedance-analyzer/ad5933.c
> @@ -809,6 +809,14 @@ static int ad5933_remove(struct i2c_client *client)
>  	return 0;
>  }
>  
> +static const struct of_device_id of_ad5933_match[] = {
> +	{ .compatible = "adi,ad5933", 0},
> +	{ .compatible = "adi,ad5934", 0},
> +	{},
> +};
I would expect this to also be assigned to the driver of_match_table.

I know it'll pick it up via the device_id if not, but it's not how
it is ultimately intended to work.

Jonathan
> +
> +MODULE_DEVICE_TABLE(of, of_ad5933_match);
> +
>  static const struct i2c_device_id ad5933_id[] = {
>  	{ "ad5933", 0 },
>  	{ "ad5934", 0 },
