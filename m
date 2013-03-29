Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:46712 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752915Ab3C2Jha (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 29 Mar 2013 05:37:30 -0400
Message-ID: <515560D8.9080906@kernel.org>
Date: Fri, 29 Mar 2013 09:37:28 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@kernel.org>
CC: linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
	Laxman Dewangan <ldewangan@nvidia.com>
Subject: Re: [PATCH 0/4] iio:magnetometer:ak8975 cleanup and move out of staging.
References: <1364144310-32251-1-git-send-email-jic23@kernel.org>
In-Reply-To: <1364144310-32251-1-git-send-email-jic23@kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Laxman, any thoughts on these?

I'm not in an immediate rush with this series, but have never been in
favour of keeping things queued up for too long!

Jonathan

On 03/24/2013 04:58 PM, Jonathan Cameron wrote:
> When I proposed moving this out of staging a while back, Lars-Peter
> pointed out a few 'unusual' elements in the driver.  This series
> addresses those and the interesting question of what the NOSTART flag
> was doing there in the read code (came up in the dicussion of one of
> Lars-Peter's points).
> 
> The caching in the write is a little unnecessary, but isn't technically
> incorrect so I haven't touched that.
> 
> If anyone has one of these to test and make sure the changes haven't
> broken anything that would be great!
> 
> Thanks,
> 
> Jonathan
> 
> Jonathan Cameron (4):
>   staging:iio:magnetometer:ak8975 drop unused eoc_irq
>   staging:iio:magnetometer:ak8975 drop I2C_M_NOSTART flag in read_data
>   staging:iio:magnetometer:ak8975 use standard i2c_smbus read functions.
>   iio:magnetometer:ak8975 move driver out of staging
> 
>  drivers/iio/magnetometer/Kconfig          |  11 +
>  drivers/iio/magnetometer/Makefile         |   1 +
>  drivers/iio/magnetometer/ak8975.c         | 485 ++++++++++++++++++++++++++++
>  drivers/staging/iio/magnetometer/Kconfig  |  11 -
>  drivers/staging/iio/magnetometer/Makefile |   1 -
>  drivers/staging/iio/magnetometer/ak8975.c | 520 ------------------------------
>  6 files changed, 497 insertions(+), 532 deletions(-)
>  create mode 100644 drivers/iio/magnetometer/ak8975.c
>  delete mode 100644 drivers/staging/iio/magnetometer/ak8975.c
> 
