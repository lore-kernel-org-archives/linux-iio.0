Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:47507 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752140AbbFGPe2 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 7 Jun 2015 11:34:28 -0400
Message-ID: <55746482.5030506@kernel.org>
Date: Sun, 07 Jun 2015 16:34:26 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Daniel Baluta <daniel.baluta@intel.com>, pmeerw@pmeerw.net
CC: knaack.h@gmx.de, lars@metafoo.de, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 4/6] iio: magnetometer: mmc35240: Use a smaller sleep
 value
References: <1433502195-30296-1-git-send-email-daniel.baluta@intel.com> <1433502195-30296-5-git-send-email-daniel.baluta@intel.com>
In-Reply-To: <1433502195-30296-5-git-send-email-daniel.baluta@intel.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 05/06/15 12:03, Daniel Baluta wrote:
> According to datasheet, Page 8, minimum wait time to complete
> measurement is 10ms. Adjusting this value will increase the
> userspace polling rate.
> 
> Fixes: abeb6b1e7b ("iio: magnetometer: Add support for MEMSIC MMC35240")
> Signed-off-by: Daniel Baluta <daniel.baluta@intel.com>
Applied to the togreg branch of iio.git.

Thanks,
> ---
>  drivers/iio/magnetometer/mmc35240.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/magnetometer/mmc35240.c b/drivers/iio/magnetometer/mmc35240.c
> index 7fff38e..7bc72b3 100644
> --- a/drivers/iio/magnetometer/mmc35240.c
> +++ b/drivers/iio/magnetometer/mmc35240.c
> @@ -219,7 +219,8 @@ static int mmc35240_take_measurement(struct mmc35240_data *data)
>  			return ret;
>  		if (reg_status & MMC35240_STATUS_MEAS_DONE_BIT)
>  			break;
> -		msleep(20);
> +		/* minimum wait time to complete measurement is 10 ms */
> +		usleep_range(10000, 11000);
>  	}
>  
>  	if (tries < 0) {
> 

