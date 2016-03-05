Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:56061 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750796AbcCEPYs (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 5 Mar 2016 10:24:48 -0500
Subject: Re: [PATCH v2 1/5] iio:magnetometer:ak8975: fix uninitialized chipset
To: Gregor Boirie <gregor.boirie@parrot.com>, linux-iio@vger.kernel.org
References: <cover.1457001111.git.gregor.boirie@parrot.com>
 <2a478132d071a144e6621832ac3badd2f636d61a.1457001111.git.gregor.boirie@parrot.com>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Irina Tirdea <irina.tirdea@intel.com>,
	Cristina Moraru <cristina.moraru09@gmail.com>,
	Daniel Baluta <daniel.baluta@intel.com>,
	Julia Lawall <Julia.Lawall@lip6.fr>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <56DAFA3D.7090305@kernel.org>
Date: Sat, 5 Mar 2016 15:24:45 +0000
MIME-Version: 1.0
In-Reply-To: <2a478132d071a144e6621832ac3badd2f636d61a.1457001111.git.gregor.boirie@parrot.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 03/03/16 10:44, Gregor Boirie wrote:
> ak_def_array bounds are not properly checked in case of ACPI matching
> failure. GCC warns with the following message at line 799:
> ‘chipset’ may be used uninitialized in this function.
> 
> Signed-off-by: Gregor Boirie <gregor.boirie@parrot.com>
Applied.
> ---
>  drivers/iio/magnetometer/ak8975.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/magnetometer/ak8975.c b/drivers/iio/magnetometer/ak8975.c
> index 9c5c9ef..11059b2 100644
> --- a/drivers/iio/magnetometer/ak8975.c
> +++ b/drivers/iio/magnetometer/ak8975.c
> @@ -774,8 +774,11 @@ static int ak8975_probe(struct i2c_client *client,
>  	if (id) {
>  		chipset = (enum asahi_compass_chipset)(id->driver_data);
>  		name = id->name;
> -	} else if (ACPI_HANDLE(&client->dev))
> +	} else if (ACPI_HANDLE(&client->dev)) {
>  		name = ak8975_match_acpi_device(&client->dev, &chipset);
> +		if (!name)
> +			return -ENODEV;
> +	}
>  	else
>  		return -ENOSYS;
>  
> 

