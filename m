Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:47512 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752556AbbFGPei (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 7 Jun 2015 11:34:38 -0400
Message-ID: <5574648C.2090100@kernel.org>
Date: Sun, 07 Jun 2015 16:34:36 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Daniel Baluta <daniel.baluta@intel.com>, pmeerw@pmeerw.net
CC: knaack.h@gmx.de, lars@metafoo.de, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 5/6] iio: magnetometer: mmc35240: Fix sensitivity on
 z-axis
References: <1433502195-30296-1-git-send-email-daniel.baluta@intel.com> <1433502195-30296-6-git-send-email-daniel.baluta@intel.com>
In-Reply-To: <1433502195-30296-6-git-send-email-daniel.baluta@intel.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 05/06/15 12:03, Daniel Baluta wrote:
> Datasheet says (Page 2) that typical value for sensitivity
> for 16 bits mode on Z-axis is 770. Anyhow, looking at the
> input driver provided by Memsic the value for MMC35240 is
> 1024.
> 
> Also, testing shows that using 1024 for Z-axis senzitivity
> offers better results.
> 
> Fixes: abeb6b1e7b ("iio: magnetometer: Add support for MEMSIC MMC35240")
> Signed-off-by: Daniel Baluta <daniel.baluta@intel.com>
applied 
> ---
>  drivers/iio/magnetometer/mmc35240.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/magnetometer/mmc35240.c b/drivers/iio/magnetometer/mmc35240.c
> index 7bc72b3..73fa111 100644
> --- a/drivers/iio/magnetometer/mmc35240.c
> +++ b/drivers/iio/magnetometer/mmc35240.c
> @@ -77,7 +77,7 @@ static const struct {
>  } mmc35240_props_table[] = {
>  	/* 16 bits, 100Hz ODR */
>  	{
> -		{1024, 1024, 770},
> +		{1024, 1024, 1024},
>  		32768,
>  	},
>  	/* 16 bits, 200Hz ODR */
> 

