Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-41.csi.cam.ac.uk ([131.111.8.141]:33301 "EHLO
	ppsw-41.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750733Ab0JXXCq (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 24 Oct 2010 19:02:46 -0400
Message-ID: <4CC4BC77.5070807@cam.ac.uk>
Date: Mon, 25 Oct 2010 00:08:39 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: Mike Frysinger <vapier@gentoo.org>
CC: linux-iio@vger.kernel.org,
	device-drivers-devel@blackfin.uclinux.org
Subject: Re: [PATCH] staging: iio: adis16350: add missing reference to temp
 offset
References: <1287954783-751-1-git-send-email-vapier@gentoo.org>
In-Reply-To: <1287954783-751-1-git-send-email-vapier@gentoo.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/24/10 22:13, Mike Frysinger wrote:
> We declare this attr but never link it in to the attr list.
> 
I have an equivalent sat in the general cleanup series for
that driver, but seeing as the series is stalled pending
tracking down an issue...
> Signed-off-by: Mike Frysinger <vapier@gentoo.org>
Acked-by: Jonathan Cameron <jic23@cam.ac.uk>
> ---
>  drivers/staging/iio/imu/adis16350_core.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/staging/iio/imu/adis16350_core.c b/drivers/staging/iio/imu/adis16350_core.c
> index 97c1ec8..cf7176b 100644
> --- a/drivers/staging/iio/imu/adis16350_core.c
> +++ b/drivers/staging/iio/imu/adis16350_core.c
> @@ -570,6 +570,7 @@ static struct attribute *adis16350_attributes[] = {
>  	&iio_dev_attr_temp_y_raw.dev_attr.attr,
>  	&iio_dev_attr_temp_z_raw.dev_attr.attr,
>  	&iio_const_attr_temp_scale.dev_attr.attr,
> +	&iio_const_attr_temp_offset.dev_attr.attr,
>  	&iio_dev_attr_in1_raw.dev_attr.attr,
>  	&iio_const_attr_in1_scale.dev_attr.attr,
>  	&iio_dev_attr_sampling_frequency.dev_attr.attr,

