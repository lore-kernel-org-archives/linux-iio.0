Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:25096 "EHLO mga04.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755085AbcGKPyF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 11 Jul 2016 11:54:05 -0400
From: "Breana, Tiberiu A" <tiberiu.a.breana@intel.com>
To: Alison Schofield <amsfield22@gmail.com>,
	"jic23@kernel.org" <jic23@kernel.org>
CC: "mranostay@gmail.com" <mranostay@gmail.com>,
	"knaack.h@gmx.de" <knaack.h@gmx.de>,
	"lars@metafoo.de" <lars@metafoo.de>,
	"pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 2/3] iio: humidity: am2315: set up buffer timestamps for
 non-zero values
Date: Mon, 11 Jul 2016 15:54:02 +0000
Message-ID: <4586F61A4A291F4DA44D32824E7C0F40235BAB4C@IRSMSX109.ger.corp.intel.com>
References: <cover.1468203399.git.amsfield22@gmail.com>
 <b246c9e7acf284069789cce4228b8d0e1733bbc8.1468203399.git.amsfield22@gmail.com>
In-Reply-To: <b246c9e7acf284069789cce4228b8d0e1733bbc8.1468203399.git.amsfield22@gmail.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

> -----Original Message-----
> From: Alison Schofield [mailto:amsfield22@gmail.com]
> Sent: Monday, July 11, 2016 6:26 PM
> To: jic23@kernel.org
> Cc: Breana, Tiberiu A <tiberiu.a.breana@intel.com>; mranostay@gmail.com;
> knaack.h@gmx.de; lars@metafoo.de; pmeerw@pmeerw.net; linux-
> iio@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: [PATCH 2/3] iio: humidity: am2315: set up buffer timestamps for non-
> zero values
> 
> Use the iio_pollfunc_store_time parameter during triggered buffer set-up to get
> valid timestamps.
> 
> Signed-off-by: Alison Schofield <amsfield22@gmail.com>
> Cc: Daniel Baluta <daniel.baluta@gmail.com>
> ---

+1
Reviewed-By: Tiberiu Breana <tiberiu.a.breana@intel.com>

>  drivers/iio/humidity/am2315.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/humidity/am2315.c b/drivers/iio/humidity/am2315.c
> index 3e200f6..ff96b6d 100644
> --- a/drivers/iio/humidity/am2315.c
> +++ b/drivers/iio/humidity/am2315.c
> @@ -244,7 +244,7 @@ static int am2315_probe(struct i2c_client *client,
>  	indio_dev->channels = am2315_channels;
>  	indio_dev->num_channels = ARRAY_SIZE(am2315_channels);
> 
> -	ret = iio_triggered_buffer_setup(indio_dev, NULL,
> +	ret = iio_triggered_buffer_setup(indio_dev, iio_pollfunc_store_time,
>  					 am2315_trigger_handler, NULL);
>  	if (ret < 0) {
>  		dev_err(&client->dev, "iio triggered buffer setup failed\n");
> --
> 2.1.4

