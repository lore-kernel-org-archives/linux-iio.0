Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-52.csi.cam.ac.uk ([131.111.8.152]:60154 "EHLO
	ppsw-52.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750774Ab0JXWtU (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 24 Oct 2010 18:49:20 -0400
Message-ID: <4CC4B951.1060408@cam.ac.uk>
Date: Sun, 24 Oct 2010 23:55:13 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: Mike Frysinger <vapier@gentoo.org>
CC: linux-iio@vger.kernel.org,
	device-drivers-devel@blackfin.uclinux.org,
	Michael Hennerich <michael.hennerich@analog.com>
Subject: Re: [PATCH 14/14] staging: iio: adc: new ad799x driver
References: <1287865757-1031-1-git-send-email-vapier@gentoo.org> <1287865757-1031-14-git-send-email-vapier@gentoo.org>
In-Reply-To: <1287865757-1031-14-git-send-email-vapier@gentoo.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/23/10 21:29, Mike Frysinger wrote:
> From: Michael Hennerich <michael.hennerich@analog.com>
> 
> Driver for ad7991, ad7995, ad7999, ad7992, ad7993, ad7994, ad7997 and
> ad7998 multichannel ADC.
Another one that has already merged.


> 
> Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
> Signed-off-by: Mike Frysinger <vapier@gentoo.org>
> ---
>  drivers/staging/iio/adc/Kconfig       |   20 +
>  drivers/staging/iio/adc/Makefile      |    4 +
>  drivers/staging/iio/adc/ad799x.h      |  168 ++++++
>  drivers/staging/iio/adc/ad799x_core.c |  912 +++++++++++++++++++++++++++++++++
>  drivers/staging/iio/adc/ad799x_ring.c |  281 ++++++++++
>  5 files changed, 1385 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/staging/iio/adc/ad799x.h
>  create mode 100644 drivers/staging/iio/adc/ad799x_core.c
>  create mode 100644 drivers/staging/iio/adc/ad799x_ring.c
...
