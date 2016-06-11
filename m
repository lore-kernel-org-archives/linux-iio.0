Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:52295 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751927AbcFKQ3P (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 11 Jun 2016 12:29:15 -0400
Subject: Re: [PATCH] iio: (ms5637) Add Measurement Specialties explicit MS5805
 and MS5837 support
To: "Markezana, William" <William.Markezana@te.com>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>
References: <A02AF0B2-1B1A-477E-952B-AA332C6650FE@te.com>
 <alpine.DEB.2.02.1605312318400.9332@pmeerw.net>
 <CY1PR01MB1947A8160E9C24A9398543EA95470@CY1PR01MB1947.prod.exchangelabs.com>
 <07bdfb5d-5113-2174-a1dd-dec7af0bcf9b@kernel.org>
 <CY1PR01MB1947F70E574A7D6F4FEB281A955C0@CY1PR01MB1947.prod.exchangelabs.com>
Cc: "knaack.h@gmx.de" <knaack.h@gmx.de>,
	"lars@metafoo.de" <lars@metafoo.de>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <cc8127ad-7136-2600-161f-cd331e797733@kernel.org>
Date: Sat, 11 Jun 2016 17:29:12 +0100
MIME-Version: 1.0
In-Reply-To: <CY1PR01MB1947F70E574A7D6F4FEB281A955C0@CY1PR01MB1947.prod.exchangelabs.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 06/06/16 09:12, Markezana, William wrote:
> iio: (ms5637) Add Measurement Specialties explicit MS5805 and MS5837 support
> 
> Signed-off-by: William Markezana <william.markezana@meas-spec.com>
Please send a new series, with [PATCH V2] as the title for a new version.
Try applying this with git AM and you'll see the fun it makes from this
commit message.

Fixed up and applied with some fuzz to the togreg branch of iio.git
Initially pushed out as testing for the autobuilders to play with it.

Thanks,

Jonathan
> ---
>  drivers/iio/pressure/ms5637.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/pressure/ms5637.c b/drivers/iio/pressure/ms5637.c
> index e8d0e0d..66f1a4c 100644
> --- a/drivers/iio/pressure/ms5637.c
> +++ b/drivers/iio/pressure/ms5637.c
> @@ -1,6 +1,6 @@
>  /*
> - * ms5637.c - Support for Measurement-Specialties ms5637 and ms8607
> - *            pressure & temperature sensor
> + * ms5637.c - Support for Measurement-Specialties MS5637, MS5805
> + *            MS5837 and MS8607 pressure & temperature sensor
>   *
>   * Copyright (c) 2015 Measurement-Specialties
>   *
> @@ -11,6 +11,10 @@
>   * Datasheet:
>   *  http://www.meas-spec.com/downloads/MS5637-02BA03.pdf
>   * Datasheet:
> + *  http://www.meas-spec.com/downloads/MS5805-02BA01.pdf
> + * Datasheet:
> + *  http://www.meas-spec.com/downloads/MS5837-30BA.pdf
> + * Datasheet:
>   *  http://www.meas-spec.com/downloads/MS8607-02BA01.pdf
>   */
>  
> @@ -170,7 +174,9 @@ static int ms5637_probe(struct i2c_client *client,
>  
>  static const struct i2c_device_id ms5637_id[] = {
>  	{"ms5637", 0},
> -	{"ms8607-temppressure", 1},
> +	{"ms5805", 0},
> +	{"ms5837", 0},
> +	{"ms8607-temppressure", 0},
>  	{}
>  };
>  
> 

