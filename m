Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:54882 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752175AbbGTRyL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 20 Jul 2015 13:54:11 -0400
From: "Tirdea, Irina" <irina.tirdea@intel.com>
To: Hartmut Knaack <knaack.h@gmx.de>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
CC: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	"Dogaru, Vlad" <vlad.dogaru@intel.com>
Subject: RE: [PATCH 8/8] iio:magnetometer:bmc150_magn: use descriptive name
 for mask
Date: Mon, 20 Jul 2015 17:52:43 +0000
Message-ID: <1F3AC3675D538145B1661F571FE1805F2F06C20C@irsmsx105.ger.corp.intel.com>
References: <cover.1437090791.git.knaack.h@gmx.de>
 <81887eb78fef9a2a6c589cb6d4b1f5329c7149b6.1437090791.git.knaack.h@gmx.de>
In-Reply-To: <81887eb78fef9a2a6c589cb6d4b1f5329c7149b6.1437090791.git.knaack.h@gmx.de>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org



> -----Original Message-----
> From: Hartmut Knaack [mailto:knaack.h@gmx.de]
> Sent: 17 July, 2015 11:53
> To: linux-iio@vger.kernel.org
> Cc: Jonathan Cameron; Lars-Peter Clausen; Peter Meerwald; Tirdea, Irina; Dogaru, Vlad
> Subject: [PATCH 8/8] iio:magnetometer:bmc150_magn: use descriptive name for mask
> 
> Define and use a descriptive name for the repetition registers data mask,
> instead of a 'magic' value.
>

Missed this hardcoded value. Thanks for catching this!

Acked-by: Irina Tirdea <irina.tirdea@intel.com>
 
> Signed-off-by: Hartmut Knaack <knaack.h@gmx.de>
> ---
>  drivers/iio/magnetometer/bmc150_magn.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/magnetometer/bmc150_magn.c b/drivers/iio/magnetometer/bmc150_magn.c
> index bdcf49ee75df..e8cf08ee2d15 100644
> --- a/drivers/iio/magnetometer/bmc150_magn.c
> +++ b/drivers/iio/magnetometer/bmc150_magn.c
> @@ -85,6 +85,7 @@
>  #define BMC150_MAGN_REG_HIGH_THRESH		0x50
>  #define BMC150_MAGN_REG_REP_XY			0x51
>  #define BMC150_MAGN_REG_REP_Z			0x52
> +#define BMC150_MAGN_REG_REP_DATAMASK		GENMASK(7, 0)
> 
>  #define BMC150_MAGN_REG_TRIM_START		0x5D
>  #define BMC150_MAGN_REG_TRIM_END		0x71
> @@ -559,7 +560,7 @@ static int bmc150_magn_write_raw(struct iio_dev *indio_dev,
>  			}
>  			ret = regmap_update_bits(data->regmap,
>  						 BMC150_MAGN_REG_REP_XY,
> -						 0xFF,
> +						 BMC150_MAGN_REG_REP_DATAMASK,
>  						 BMC150_MAGN_REPXY_TO_REGVAL
>  						 (val));
>  			mutex_unlock(&data->mutex);
> @@ -575,7 +576,7 @@ static int bmc150_magn_write_raw(struct iio_dev *indio_dev,
>  			}
>  			ret = regmap_update_bits(data->regmap,
>  						 BMC150_MAGN_REG_REP_Z,
> -						 0xFF,
> +						 BMC150_MAGN_REG_REP_DATAMASK,
>  						 BMC150_MAGN_REPZ_TO_REGVAL
>  						 (val));
>  			mutex_unlock(&data->mutex);
> --
> 2.4.3

