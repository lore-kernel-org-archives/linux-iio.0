Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:49834 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753192AbcIRLyt (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 18 Sep 2016 07:54:49 -0400
Subject: Re: [PATCH] iio: accel: mma7660: fix missing MODULE_DEVICE_TABLE(i2c)
To: Hans de Goede <hdegoede@redhat.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
References: <20160911162926.22538-1-hdegoede@redhat.com>
Cc: linux-iio@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <8f678c1e-f1ce-0e19-b775-56fc1b8a0244@kernel.org>
Date: Sun, 18 Sep 2016 12:54:45 +0100
MIME-Version: 1.0
In-Reply-To: <20160911162926.22538-1-hdegoede@redhat.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 11/09/16 17:29, Hans de Goede wrote:
> Add missing MODULE_DEVICE_TABLE(i2c) this fixes autoloading on
> devicetree using systems.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Applied to the togreg branch of iio.git.  Initially pushed out
as testing for the autobuilders to play with it.

Thanks,

Jonathan
> ---
>  drivers/iio/accel/mma7660.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/iio/accel/mma7660.c b/drivers/iio/accel/mma7660.c
> index 0acdee5..03beadf 100644
> --- a/drivers/iio/accel/mma7660.c
> +++ b/drivers/iio/accel/mma7660.c
> @@ -251,6 +251,7 @@ static const struct i2c_device_id mma7660_i2c_id[] = {
>  	{"mma7660", 0},
>  	{}
>  };
> +MODULE_DEVICE_TABLE(i2c, mma7660_i2c_id);
>  
>  static const struct acpi_device_id mma7660_acpi_id[] = {
>  	{"MMA7660", 0},
> 

