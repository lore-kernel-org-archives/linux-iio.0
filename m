Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:53943 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936021AbcJVSCJ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 22 Oct 2016 14:02:09 -0400
Subject: Re: [PATCH v3 2/5] iio: dac: mcp4725: fix incorrect comment
To: Tomas Novotny <tomas.novotny@tbs-biometrics.com>,
        devicetree@vger.kernel.org
References: <1476812589-18333-1-git-send-email-tomas.novotny@tbs-biometrics.com>
 <1476812589-18333-3-git-send-email-tomas.novotny@tbs-biometrics.com>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        Yong Li <sdliyong@gmail.com>, linux-iio@vger.kernel.org,
        Tomas Novotny <tomas@novotny.cz>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <c224e323-fff8-cc79-b10d-99c7ddea1b51@kernel.org>
Date: Sat, 22 Oct 2016 19:02:07 +0100
MIME-Version: 1.0
In-Reply-To: <1476812589-18333-3-git-send-email-tomas.novotny@tbs-biometrics.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 18/10/16 18:43, Tomas Novotny wrote:
> From: Tomas Novotny <tomas@novotny.cz>
> 
> Number 2 is referencing to the settings with the largest available
> resistor.
> 
> No functional change.
> 
> Signed-off-by: Tomas Novotny <tomas@novotny.cz>
Thanks,

Applied to the togreg branch of iio.git and pushed out as testing.

Jonathan
> ---
>  drivers/iio/dac/mcp4725.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/dac/mcp4725.c b/drivers/iio/dac/mcp4725.c
> index 1f55d1b..e481f38 100644
> --- a/drivers/iio/dac/mcp4725.c
> +++ b/drivers/iio/dac/mcp4725.c
> @@ -374,7 +374,7 @@ static int mcp4725_probe(struct i2c_client *client,
>  	}
>  	pd = (inbuf[0] >> 1) & 0x3;
>  	data->powerdown = pd > 0 ? true : false;
> -	data->powerdown_mode = pd ? pd - 1 : 2; /* largest register to gnd */
> +	data->powerdown_mode = pd ? pd - 1 : 2; /* largest resistor to gnd */
>  	data->dac_value = (inbuf[1] << 4) | (inbuf[2] >> 4);
>  
>  	err = iio_device_register(indio_dev);
> 

