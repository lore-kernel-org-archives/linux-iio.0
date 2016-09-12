Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:41833 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755570AbcILTTw (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 12 Sep 2016 15:19:52 -0400
Subject: Re: [PATCH] iio: accel: mxc6255: Fix chip-id check
To: Hans de Goede <hdegoede@redhat.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
References: <20160911162916.22495-1-hdegoede@redhat.com>
Cc: linux-iio@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <d429f1be-6821-486d-698c-361b1dd448de@kernel.org>
Date: Mon, 12 Sep 2016 20:19:46 +0100
MIME-Version: 1.0
In-Reply-To: <20160911162916.22495-1-hdegoede@redhat.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 11/09/16 17:29, Hans de Goede wrote:
> The initial commit adding support for the mxc6225 assumed the
> mxc6225 has a chip-id of 0xe5 based on testing on a single Allwinner
> A23 tablet with a mxc6225. Testing on a bunch of other Allwinner
> tablets have shown that the chip-id for the mxc6225 is not constant.
> 
> A datasheet for the MXC6255 which I've found online says that bits
> 7 and 6 of the chip-id register are undefined (for the mxc6255), testing
> on 5 different tablets with a mxc6225 has found the following ids:
> 0x25, 0x45, 0x65, 0x85, 0xe5. So it seems that for the mxc6225 bits
> 7, 6 and 5 of the chip-id register are undefined.
> 
> This commit adjusts the chip-id check so that the mxc6255 driver
> properly recognizes the mxc6225 in all these tablets.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
As this is trivial I'll slip it in late for the pull request I'm
just doing.

Applied to the togreg branch of iio.git.

Thanks,

Jonathan
> ---
>  drivers/iio/accel/mxc6255.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
> 
> diff --git a/drivers/iio/accel/mxc6255.c b/drivers/iio/accel/mxc6255.c
> index 50343a7..0abad69 100644
> --- a/drivers/iio/accel/mxc6255.c
> +++ b/drivers/iio/accel/mxc6255.c
> @@ -26,7 +26,6 @@
>  #define MXC6255_REG_YOUT		0x01
>  #define MXC6255_REG_CHIP_ID		0x08
>  
> -#define MXC6225_CHIP_ID			0xe5
>  #define MXC6255_CHIP_ID			0x05
>  
>  /*
> @@ -155,11 +154,7 @@ static int mxc6255_probe(struct i2c_client *client,
>  		return ret;
>  	}
>  
> -	switch (chip_id) {
> -	case MXC6225_CHIP_ID:
> -	case MXC6255_CHIP_ID:
> -		break;
> -	default:
> +	if ((chip_id & 0x1f) != MXC6255_CHIP_ID) {
>  		dev_err(&client->dev, "Invalid chip id %x\n", chip_id);
>  		return -ENODEV;
>  	}
> 

