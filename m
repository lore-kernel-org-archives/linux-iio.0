Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:47656 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751265AbcFZQIz (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 26 Jun 2016 12:08:55 -0400
Subject: Re: [PATCH V2] iio: (ms5637) Add Measurement Specialties explicit
 MS5805 and MS5837 support
To: "Markezana, William" <William.Markezana@te.com>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>
References: <53A6D8FB-3F95-4A9E-BB5F-D317B61CCFBC@te.com>
Cc: "knaack.h@gmx.de" <knaack.h@gmx.de>,
	"lars@metafoo.de" <lars@metafoo.de>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <8dd807ab-065b-f310-4cb3-64efde68a715@kernel.org>
Date: Sun, 26 Jun 2016 17:08:53 +0100
MIME-Version: 1.0
In-Reply-To: <53A6D8FB-3F95-4A9E-BB5F-D317B61CCFBC@te.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 12/06/16 09:06, Markezana, William wrote:
> iio: (ms5637) Add Measurement Specialties explicit MS5805 and MS5837 support
> 
> Signed-off-by: William Markezana <william.markezana@meas-spec.com>
I fixed up and applied the previous version... Let me know
if there is any difference from this (looks superficially the same).

Sorry for the confusion.

Jonathan
> ---
> drivers/iio/pressure/ms5637.c | 12 +++++++++---
> 1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/pressure/ms5637.c b/drivers/iio/pressure/ms5637.c
> index e8d0e0d..66f1a4c 100644
> --- a/drivers/iio/pressure/ms5637.c
> +++ b/drivers/iio/pressure/ms5637.c
> @@ -1,6 +1,6 @@
> /*
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
> @@ -170,7 +174,9 @@ static int ms5637_probe(struct i2c_client *client,
> static const struct i2c_device_id ms5637_id[] = {
>   {"ms5637", 0},
> - {"ms8607-temppressure", 1},
> + {"ms5805", 0},
> + {"ms5837", 0},
> + {"ms8607-temppressure", 0},
>   {}
> };
> --
> 2.1.4
> 
> 
> N�����r��y���b�X��ǧv�^�)޺{.n�+����{��*"��^n�r���z���h����&���G���h�(�階�ݢj"���m�����z�ޖ���f���h���~�mml==
> 

