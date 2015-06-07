Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:47489 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751048AbbFGPdm (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 7 Jun 2015 11:33:42 -0400
Message-ID: <55746454.5060904@kernel.org>
Date: Sun, 07 Jun 2015 16:33:40 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Daniel Baluta <daniel.baluta@intel.com>, pmeerw@pmeerw.net
CC: knaack.h@gmx.de, lars@metafoo.de, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 1/6] iio: magnetometer: mmc35240: i2c device name should
 be lower case
References: <1433502195-30296-1-git-send-email-daniel.baluta@intel.com> <1433502195-30296-2-git-send-email-daniel.baluta@intel.com>
In-Reply-To: <1433502195-30296-2-git-send-email-daniel.baluta@intel.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 05/06/15 12:03, Daniel Baluta wrote:
> This is the standard convention for i2c device name and
> also this is the name used in some Intel platforms DT
> files.
> 
> Fixes: abeb6b1e7b ("iio: magnetometer: Add support for MEMSIC MMC35240")
> Signed-off-by: Daniel Baluta <daniel.baluta@intel.com>
applied to the togreg branch of iio.git

Thanks,
> ---
>  drivers/iio/magnetometer/mmc35240.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/magnetometer/mmc35240.c b/drivers/iio/magnetometer/mmc35240.c
> index aa6e25d..417eca1 100644
> --- a/drivers/iio/magnetometer/mmc35240.c
> +++ b/drivers/iio/magnetometer/mmc35240.c
> @@ -490,7 +490,7 @@ static const struct acpi_device_id mmc35240_acpi_match[] = {
>  MODULE_DEVICE_TABLE(acpi, mmc35240_acpi_match);
>  
>  static const struct i2c_device_id mmc35240_id[] = {
> -	{"MMC35240", 0},
> +	{"mmc35240", 0},
>  	{}
>  };
>  MODULE_DEVICE_TABLE(i2c, mmc35240_id);
> 

