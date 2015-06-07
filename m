Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:47495 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752119AbbFGPd4 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 7 Jun 2015 11:33:56 -0400
Message-ID: <55746462.5080301@kernel.org>
Date: Sun, 07 Jun 2015 16:33:54 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Daniel Baluta <daniel.baluta@intel.com>, pmeerw@pmeerw.net
CC: knaack.h@gmx.de, lars@metafoo.de, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 2/6] iio: magnetometer: mmc35240: NULL terminate attribute
 array
References: <1433502195-30296-1-git-send-email-daniel.baluta@intel.com> <1433502195-30296-3-git-send-email-daniel.baluta@intel.com>
In-Reply-To: <1433502195-30296-3-git-send-email-daniel.baluta@intel.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 05/06/15 12:03, Daniel Baluta wrote:
> This avoid nasty crashes when registering the IIO device.
> 
> Fixes: abeb6b1e7b ("iio: magnetometer: Add support for MEMSIC MMC35240")
> Signed-off-by: Daniel Baluta <daniel.baluta@intel.com>
Applied to the togreg branch of iio.git
> ---
>  drivers/iio/magnetometer/mmc35240.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/iio/magnetometer/mmc35240.c b/drivers/iio/magnetometer/mmc35240.c
> index 417eca1..9d62c53 100644
> --- a/drivers/iio/magnetometer/mmc35240.c
> +++ b/drivers/iio/magnetometer/mmc35240.c
> @@ -125,6 +125,7 @@ static const struct iio_chan_spec mmc35240_channels[] = {
>  
>  static struct attribute *mmc35240_attributes[] = {
>  	&iio_const_attr_sampling_frequency_available.dev_attr.attr,
> +	NULL
>  };
>  
>  static const struct attribute_group mmc35240_attribute_group = {
> 

