Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:46025 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751496AbbGSKFT (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 19 Jul 2015 06:05:19 -0400
Message-ID: <55AB765D.3090707@kernel.org>
Date: Sun, 19 Jul 2015 11:05:17 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Hartmut Knaack <knaack.h@gmx.de>, linux-iio@vger.kernel.org
CC: Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Irina Tirdea <irina.tirdea@intel.com>,
	Vlad Dogaru <vlad.dogaru@intel.com>
Subject: Re: [PATCH 4/8] iio:magnetometer:bmc150_magn: replace magic value
References: <cover.1437090791.git.knaack.h@gmx.de> <10d009333e7ce8c43f17c50c03a1f3d0a1dda11f.1437090791.git.knaack.h@gmx.de>
In-Reply-To: <10d009333e7ce8c43f17c50c03a1f3d0a1dda11f.1437090791.git.knaack.h@gmx.de>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 17/07/15 09:52, Hartmut Knaack wrote:
> Construct the scanmask using its descriptive axis names (as used in
> iio_chan_spec) instead of a 'magic' value.
> 
> Signed-off-by: Hartmut Knaack <knaack.h@gmx.de>
Applied to the togreg branch of iio.git, pushed out as
testing for the autobuilders to play with it.

Thanks,

Jonathan
> ---
> Does this look better?
Certainly slightly clearer what is going on.
> 
>  drivers/iio/magnetometer/bmc150_magn.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/magnetometer/bmc150_magn.c b/drivers/iio/magnetometer/bmc150_magn.c
> index 7da4ce9409e8..f1b6a4dc40ea 100644
> --- a/drivers/iio/magnetometer/bmc150_magn.c
> +++ b/drivers/iio/magnetometer/bmc150_magn.c
> @@ -651,7 +651,9 @@ static const struct iio_info bmc150_magn_info = {
>  	.driver_module = THIS_MODULE,
>  };
>  
> -static const unsigned long bmc150_magn_scan_masks[] = {0x07, 0};
> +static const unsigned long bmc150_magn_scan_masks[] = {
> +					BIT(AXIS_X) | BIT(AXIS_Y) | BIT(AXIS_Z),
> +					0};
>  
>  static irqreturn_t bmc150_magn_trigger_handler(int irq, void *p)
>  {
> 

