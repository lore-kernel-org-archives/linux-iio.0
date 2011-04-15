Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-41.csi.cam.ac.uk ([131.111.8.141]:37678 "EHLO
	ppsw-41.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752585Ab1DOMvR (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 15 Apr 2011 08:51:17 -0400
Message-ID: <4DA83FB5.7000501@cam.ac.uk>
Date: Fri, 15 Apr 2011 13:53:09 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: michael.hennerich@analog.com
CC: linux-iio@vger.kernel.org, drivers@analog.com,
	device-drivers-devel@blackfin.uclinux.org
Subject: Re: [PATCH] IIO-onwards: trigger: iio-trig-sysfs: Avoid double free.
References: <1302870582-14958-1-git-send-email-michael.hennerich@analog.com>
In-Reply-To: <1302870582-14958-1-git-send-email-michael.hennerich@analog.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 04/15/11 13:29, michael.hennerich@analog.com wrote:
> From: Michael Hennerich <michael.hennerich@analog.com>
> 
> 
Good catch.

Given I haven't 'officially' posted this lot yet, do you mind
if I merge the fixes into the patch that caused the problem?
(with crediting of course!)

Could keep them separate but that will make for confusing reviewing
once I haven't posted the patches.. (probably later today).

> Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
> ---
>  drivers/staging/iio/trigger/iio-trig-sysfs.c |    1 -
>  1 files changed, 0 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/staging/iio/trigger/iio-trig-sysfs.c b/drivers/staging/iio/trigger/iio-trig-sysfs.c
> index 5cd55ac..6d3dee3 100644
> --- a/drivers/staging/iio/trigger/iio-trig-sysfs.c
> +++ b/drivers/staging/iio/trigger/iio-trig-sysfs.c
> @@ -134,7 +134,6 @@ static int iio_sysfs_trigger_probe(int id)
>  	t->id = id;
>  	t->trig = iio_allocate_trigger_named(name);
>  	if (!t->trig) {
> -		kfree(name);
>  		ret = -ENOMEM;
>  		goto free_t;
>  	}

