Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-41.csi.cam.ac.uk ([131.111.8.141]:53407 "EHLO
	ppsw-41.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935795Ab1JFLDE (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 6 Oct 2011 07:03:04 -0400
Message-ID: <4E8D8CE1.4070201@cam.ac.uk>
Date: Thu, 06 Oct 2011 12:11:29 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: Dan Carpenter <dan.carpenter@oracle.com>
CC: Greg Kroah-Hartman <gregkh@suse.de>,
	Bryan Freed <bfreed@chromium.org>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Arnd Bergmann <arnd@arndb.de>, linux-iio@vger.kernel.org,
	devel@driverdev.osuosl.org, kernel-janitors@vger.kernel.org
Subject: Re: [patch 2/2] Staging: iio/light/tsl2563: fix compile warning
References: <20111006061536.GB14701@elgon.mountain>
In-Reply-To: <20111006061536.GB14701@elgon.mountain>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/06/11 07:15, Dan Carpenter wrote:
> This fixes a compile warning:
> drivers/staging/iio/light/tsl2563.c:696:2:
> 	warning: initialization from incompatible pointer type [enabled by d=
efault]
> drivers/staging/iio/light/tsl2563.c:696:2:
> 	warning: (near initialization for =E2=80=98tsl2563_info.write_event_=
value=E2=80=99) [enabled by default]
>=20
> The tsl2563_write_thresh() function returns zero on success and error
> codes on failure, so nothing is lost by making the return type int
> instead of ssize_t.
You are quite right. This is a silly cut and paste mistake on my part.
Thanks.
>=20
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Acked-by: Jonathan Cameron <jic23@cam.ac.uk>
>=20
> diff --git a/drivers/staging/iio/light/tsl2563.c b/drivers/staging/ii=
o/light/tsl2563.c
> index 8977f58..a5e08b3 100644
> --- a/drivers/staging/iio/light/tsl2563.c
> +++ b/drivers/staging/iio/light/tsl2563.c
> @@ -569,7 +569,7 @@ static int tsl2563_read_thresh(struct iio_dev *in=
dio_dev,
>  	return 0;
>  }
> =20
> -static ssize_t tsl2563_write_thresh(struct iio_dev *indio_dev,
> +static int tsl2563_write_thresh(struct iio_dev *indio_dev,
>  				  u64 event_code,
>  				  int val)
>  {
>=20

