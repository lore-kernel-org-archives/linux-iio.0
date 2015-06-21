Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:44091 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751246AbbFUN5m (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 21 Jun 2015 09:57:42 -0400
Message-ID: <5586C2D4.9090009@kernel.org>
Date: Sun, 21 Jun 2015 14:57:40 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Vlad Dogaru <vlad.dogaru@intel.com>, irina.tirdea@intel.com,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: magn: bmc150: add support for bmc156
References: <1434097899-13984-1-git-send-email-vlad.dogaru@intel.com> <1434097899-13984-3-git-send-email-vlad.dogaru@intel.com>
In-Reply-To: <1434097899-13984-3-git-send-email-vlad.dogaru@intel.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 12/06/15 09:31, Vlad Dogaru wrote:
> The BMC156 is a slightly less capable version of BMC150 which lacks
> support for magnetometer thresholds.  Since this driver does not support
> those anyway, adding support is trivial.
> 
> Datasheet is available at
> https://ae-bst.resource.bosch.com/media/products/dokumente/bmc156_1/BST-BMC156-DS000-01.pdf
> 
> Signed-off-by: Vlad Dogaru <vlad.dogaru@intel.com>
Applied,

Thanks,

Jonathan
> ---
>  drivers/iio/magnetometer/bmc150_magn.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/iio/magnetometer/bmc150_magn.c b/drivers/iio/magnetometer/bmc150_magn.c
> index a0e64f1..cd00271 100644
> --- a/drivers/iio/magnetometer/bmc150_magn.c
> +++ b/drivers/iio/magnetometer/bmc150_magn.c
> @@ -1089,12 +1089,14 @@ static const struct dev_pm_ops bmc150_magn_pm_ops = {
>  
>  static const struct acpi_device_id bmc150_magn_acpi_match[] = {
>  	{"BMC150B", 0},
> +	{"BMC156B", 0},
>  	{},
>  };
>  MODULE_DEVICE_TABLE(acpi, bmc150_magn_acpi_match);
>  
>  static const struct i2c_device_id bmc150_magn_id[] = {
>  	{"bmc150_magn", 0},
> +	{"bmc156_magn", 0},
>  	{},
>  };
>  MODULE_DEVICE_TABLE(i2c, bmc150_magn_id);
> 

--
To unsubscribe from this list: send the line "unsubscribe linux-iio" in
