Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-41.csi.cam.ac.uk ([131.111.8.141]:39522 "EHLO
	ppsw-41.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751140Ab1GTM5y (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 20 Jul 2011 08:57:54 -0400
Message-ID: <4E26D0D5.2050708@cam.ac.uk>
Date: Wed, 20 Jul 2011 13:57:57 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: michael.hennerich@analog.com
CC: linux-iio@vger.kernel.org,
	device-drivers-devel@blackfin.uclinux.org, drivers@analog.com
Subject: Re: [PATCH] iio: adc: New driver for AD7280A Lithium Ion Battery
 Monitoring System
References: <1311165378-28380-1-git-send-email-michael.hennerich@analog.com>
In-Reply-To: <1311165378-28380-1-git-send-email-michael.hennerich@analog.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 07/20/11 13:36, michael.hennerich@analog.com wrote:
> From: Michael Hennerich <michael.hennerich@analog.com>
> 
> The AD7280A monitoring system contains all the functions required for
> general purpose monitoring and maintenance of stacked
> lithium ion batteries as used in hybrid electric vehicles,
> battery backup applications, etc.
> 
> Changes since V1:
> 
> Make cell channels all type IIO_IN_DIFF, update documentation accordingly.
> Remove unused and redundant defines.
> Use SI units where applicable.
> Remove unnecessary wrapper function.
> Remove redundant initialization.
> Add comments where requested.
> Revise event handler.
> Use const where applicable.
> 
One unnecessary include - adc.h (which is more important given
I've removed the file in a set that Greg is sitting on till
3.1-rc1 is out ;)  I'm fine with this going faster if Greg wants
to take it, it's just that scrapping that include will avoid a merge
issue down the line.

Otherwise fine by me.

> Reviewed-by: Jonathan Cameron <jic23@cam.ac.uk>
> Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
Acked-by: Jonathan Cameron <jic23@cam.ac.uk>

Just for reference, I think your signed-off should always be the top entry.
