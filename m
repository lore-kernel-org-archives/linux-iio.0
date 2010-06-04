Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-30.csi.cam.ac.uk ([131.111.8.130]:42724 "EHLO
	ppsw-30.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754098Ab0FDK5q (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 4 Jun 2010 06:57:46 -0400
Message-ID: <4C08DC46.8010907@cam.ac.uk>
Date: Fri, 04 Jun 2010 11:58:14 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: Barry Song <21cnbao@gmail.com>
CC: gregkh@suse.de, linux-iio@vger.kernel.org
Subject: Re: [PATCH 2/3] adis16400: fix some minor issues and clean-up
References: <1275643194-25328-1-git-send-email-21cnbao@gmail.com> <1275643194-25328-2-git-send-email-21cnbao@gmail.com> <1275643194-25328-3-git-send-email-21cnbao@gmail.com>
In-Reply-To: <1275643194-25328-3-git-send-email-21cnbao@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 06/04/10 10:19, Barry Song wrote:
> 1. move adis16400_spi_read_burst() to adis16400_ring.c since it is only
>    called there
> 2. add the lost calling to adis16400_self_test()
> 3. codes cleanup
> 
Same issue with commit comment location
> Signed-off-by: Barry Song <21cnbao@gmail.com>
Acked-by: Jonathan Cameron <jic23@cam.ac.uk>
> ---
>  drivers/staging/iio/imu/adis16400.h      |    6 --
>  drivers/staging/iio/imu/adis16400_core.c |   84 +++++++----------------------
>  drivers/staging/iio/imu/adis16400_ring.c |   48 +++++++++++++++++
>  3 files changed, 70 insertions(+), 71 deletions(-)
...
