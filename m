Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:56076 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750796AbcCEPZX (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 5 Mar 2016 10:25:23 -0500
Subject: Re: [PATCH v2 2/5] iio:magnetometer:ak8975: remove unused field
To: Gregor Boirie <gregor.boirie@parrot.com>, linux-iio@vger.kernel.org
References: <cover.1457001111.git.gregor.boirie@parrot.com>
 <e85b1a9125f8f6aa7d82c087e84e473cda1e9757.1457001111.git.gregor.boirie@parrot.com>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Irina Tirdea <irina.tirdea@intel.com>,
	Cristina Moraru <cristina.moraru09@gmail.com>,
	Daniel Baluta <daniel.baluta@intel.com>,
	Julia Lawall <Julia.Lawall@lip6.fr>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <56DAFA60.6070609@kernel.org>
Date: Sat, 5 Mar 2016 15:25:20 +0000
MIME-Version: 1.0
In-Reply-To: <e85b1a9125f8f6aa7d82c087e84e473cda1e9757.1457001111.git.gregor.boirie@parrot.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 03/03/16 10:44, Gregor Boirie wrote:
> Remove unused struct ak8975_data attrs field.
> 
> Signed-off-by: Gregor Boirie <gregor.boirie@parrot.com>
Applied.
> ---
>  drivers/iio/magnetometer/ak8975.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/iio/magnetometer/ak8975.c b/drivers/iio/magnetometer/ak8975.c
> index 11059b2..896b13e3 100644
> --- a/drivers/iio/magnetometer/ak8975.c
> +++ b/drivers/iio/magnetometer/ak8975.c
> @@ -361,7 +361,6 @@ static const struct ak_def ak_def_array[AK_MAX_TYPE] = {
>  struct ak8975_data {
>  	struct i2c_client	*client;
>  	const struct ak_def	*def;
> -	struct attribute_group	attrs;
>  	struct mutex		lock;
>  	u8			asa[3];
>  	long			raw_to_gauss[3];
> 

