Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:46002 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760756Ab3BIQz1 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 9 Feb 2013 11:55:27 -0500
Message-ID: <51167F7E.8020701@kernel.org>
Date: Sat, 09 Feb 2013 16:55:26 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@kernel.org>
CC: linux-iio@vger.kernel.org, Laxman Dewangan <ldewangan@nvidia.com>
Subject: Re: [PATCH 0/2] iio:st_sensors more fixes when !IIO_CONFIG_TRIGGER
References: <1360428867-5040-1-git-send-email-jic23@kernel.org>
In-Reply-To: <1360428867-5040-1-git-send-email-jic23@kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 02/09/2013 04:54 PM, Jonathan Cameron wrote:
> Here is how I would suggest dealing with the issues pointed out by
> Randy when buildling without trigger support.

Sorry, miss send of this patch when I meant the ak8975 one that will
follow in a mo.
> 
> Jonathan
> 
> Jonathan Cameron (2):
>   iio:triggers Protect functions in triggers.h from use when not
>     compiled
>   iio:st_sensors fix build when !CONFIG_IIO_TRIGGER
> 
>  drivers/iio/accel/st_accel_core.c       | 9 +++++++--
>  drivers/iio/accel/st_accel_i2c.c        | 1 -
>  drivers/iio/accel/st_accel_spi.c        | 1 -
>  drivers/iio/gyro/st_gyro_core.c         | 9 +++++++--
>  drivers/iio/gyro/st_gyro_i2c.c          | 1 -
>  drivers/iio/gyro/st_gyro_spi.c          | 1 -
>  drivers/iio/magnetometer/st_magn_core.c | 1 -
>  drivers/iio/magnetometer/st_magn_i2c.c  | 1 -
>  drivers/iio/magnetometer/st_magn_spi.c  | 1 -
>  include/linux/iio/trigger.h             | 5 +++++
>  10 files changed, 19 insertions(+), 11 deletions(-)
> 
