Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:59972 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727579AbeKPV6U (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 16 Nov 2018 16:58:20 -0500
Date: Fri, 16 Nov 2018 11:46:15 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Slawomir Stepien <sst@poczta.fm>
Cc: lars@metafoo.de, knaack.h@gmx.de, pmeerw@pmeerw.net,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH 0/2] Use OF API to get the driver data
Message-ID: <20181116114615.3caec263@archlinux>
In-Reply-To: <20181116094722.1070-1-sst@poczta.fm>
References: <20181116094722.1070-1-sst@poczta.fm>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, 16 Nov 2018 10:47:20 +0100
Slawomir Stepien <sst@poczta.fm> wrote:

> This patch series will change how the driver finds out the device data. Now it
> will first try to use OF API and then, if needed, fallback to the spi framework
> capabilities.

Hi Slawomir.

A quick process point.  The cover letter should definitely mention the driver
the patch is changing.

iio:potentiometer:mcp4131: Use OF API to get the driver data.

No need to resend for that though, just one for future reference!

Thanks,

Jonathan
> 
> Slawomir Stepien (2):
>   iio: potentiometer: mcp4131: use of_device_get_match_data()
>   iio: potentiometer mcp4131: use spi_get_device_id() only when needed
> 
>  drivers/iio/potentiometer/mcp4131.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
> 
