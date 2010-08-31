Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-32.csi.cam.ac.uk ([131.111.8.132]:35055 "EHLO
	ppsw-32.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754603Ab0HaSTY (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 31 Aug 2010 14:19:24 -0400
Message-ID: <4C7D48CE.9060106@cam.ac.uk>
Date: Tue, 31 Aug 2010 19:24:14 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: Manuel Stahl <manuel.stahl@iis.fraunhofer.de>
CC: greg@kroah.com, linux-iio@vger.kernel.org
Subject: Re: [PATCH 1/6] staging:iio rename ring attributes
References: <1283247175-12835-1-git-send-email-manuel.stahl@iis.fraunhofer.de> <1283247175-12835-2-git-send-email-manuel.stahl@iis.fraunhofer.de>
In-Reply-To: <1283247175-12835-2-git-send-email-manuel.stahl@iis.fraunhofer.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 08/31/10 10:32, Manuel Stahl wrote:
> bps -> bytes_per_datum
> ring_enable -> enable
As a heads up... This breaks the example code in Documentation. I'll clean
that up when I have a moment.  My fault given I changed the abi doc
and didn't carry it through.

Greg - No problems with anything actually built by the kernel so don't let
this hold the patch up.
 
> Signed-off-by: Manuel Stahl <manuel.stahl@iis.fraunhofer.de>
> Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
> ---
>  drivers/staging/iio/accel/adis16209_ring.c |    2 +-
>  drivers/staging/iio/accel/adis16240_ring.c |    2 +-
>  drivers/staging/iio/accel/lis3l02dq_ring.c |    2 +-
>  drivers/staging/iio/accel/sca3000_ring.c   |   10 ++--
>  drivers/staging/iio/adc/max1363_ring.c     |    4 +-
>  drivers/staging/iio/gyro/adis16260_ring.c  |    2 +-
>  drivers/staging/iio/imu/adis16300_ring.c   |    2 +-
>  drivers/staging/iio/imu/adis16350_ring.c   |    2 +-
>  drivers/staging/iio/imu/adis16400_ring.c   |    2 +-
>  drivers/staging/iio/industrialio-ring.c    |    8 ++--
>  drivers/staging/iio/ring_generic.h         |   22 +++++-----
>  drivers/staging/iio/ring_sw.c              |   58 ++++++++++++++--------------
>  drivers/staging/iio/ring_sw.h              |   12 +++---
>  13 files changed, 64 insertions(+), 64 deletions(-)
> 
