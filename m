Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:35899 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752140AbcENSDZ (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 14 May 2016 14:03:25 -0400
Subject: Re: [PATCH -next] iio: pressure: bmp280: fix error message for wrong
 chip id
To: Akinobu Mita <akinobu.mita@gmail.com>, linux-iio@vger.kernel.org
References: <1461854393-2853-1-git-send-email-akinobu.mita@gmail.com>
Cc: Matt Ranostay <mranostay@gmail.com>,
	Vlad Dogaru <vlad.dogaru@intel.com>,
	Christoph Mair <christoph.mair@gmail.com>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <e37fe955-d0d6-61c8-7f18-b21210a86c00@kernel.org>
Date: Sat, 14 May 2016 19:03:23 +0100
MIME-Version: 1.0
In-Reply-To: <1461854393-2853-1-git-send-email-akinobu.mita@gmail.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 28/04/16 15:39, Akinobu Mita wrote:
> The bmp280 driver also supports BMP180 which has a different chip id
> with BMP280.  The probe routine verifies that the device reports the
> correct chip id but the error message is confusing as if BMP280's chip
> id is always expected.
> 
> Reported-by: Matt Ranostay <mranostay@gmail.com>
> Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
> Cc: Matt Ranostay <mranostay@gmail.com>
> Cc: Vlad Dogaru <vlad.dogaru@intel.com>
> Cc: Christoph Mair <christoph.mair@gmail.com>
> Cc: Jonathan Cameron <jic23@kernel.org>
> Cc: Hartmut Knaack <knaack.h@gmx.de>
> Cc: Lars-Peter Clausen <lars@metafoo.de>
> Cc: Peter Meerwald <pmeerw@pmeerw.net>
Applied to the fixes-togreg-post-rc1 branch of iio.git
Clue to what happens next with this is in the branch name ;)

Thanks,

Jonathan
> ---
>  drivers/iio/pressure/bmp280.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/pressure/bmp280.c b/drivers/iio/pressure/bmp280.c
> index 2f1498e..724452d 100644
> --- a/drivers/iio/pressure/bmp280.c
> +++ b/drivers/iio/pressure/bmp280.c
> @@ -879,8 +879,8 @@ static int bmp280_probe(struct i2c_client *client,
>  	if (ret < 0)
>  		return ret;
>  	if (chip_id != id->driver_data) {
> -		dev_err(&client->dev, "bad chip id.  expected %x got %x\n",
> -			BMP280_CHIP_ID, chip_id);
> +		dev_err(&client->dev, "bad chip id.  expected %lx got %x\n",
> +			id->driver_data, chip_id);
>  		return -EINVAL;
>  	}
>  
> 

