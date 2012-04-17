Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-52.csi.cam.ac.uk ([131.111.8.152]:36672 "EHLO
	ppsw-52.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751721Ab2DQHPx (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 17 Apr 2012 03:15:53 -0400
Message-ID: <4F8D18A0.9030108@cam.ac.uk>
Date: Tue, 17 Apr 2012 08:15:44 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: Laxman Dewangan <ldewangan@nvidia.com>
CC: grant.likely@secretlab.ca, rob.herring@calxeda.com,
	rdunlap@xenotime.net, linux@arm.linux.org.uk,
	gregkh@linuxfoundation.org, broonie@opensource.wolfsonmicro.com,
	swarren@nvidia.com, cbouatmailru@gmail.com, olof@lixom.net,
	linus.walleij@linaro.org, lars@metafoo.de, bfreed@chromium.org,
	grundler@chromium.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-iio@vger.kernel.org, devel@driverdev.osuosl.org
Subject: Re: [PATCH 2/3] staging: iio: light: of: Fix vendor prefix of isl29018
References: <1334645155-13799-1-git-send-email-ldewangan@nvidia.com> <1334645155-13799-3-git-send-email-ldewangan@nvidia.com>
In-Reply-To: <1334645155-13799-3-git-send-email-ldewangan@nvidia.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 4/17/2012 7:45 AM, Laxman Dewangan wrote:
> ISL29018 is from Intersil Corporation and the vendor prefix
> for this part should be "isl", at least not "invn" for OF
> compatibility.
Fine with me.  Not really my domain other than where it sits though!
Send on to Greg when you get acks from device tree side.
>
> Signed-off-by: Laxman Dewangan<ldewangan@nvidia.com>
Acked-by: Jonathan Cameron <jic23@kernel.org>
> ---
>   drivers/staging/iio/light/isl29018.c |    2 +-
>   1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/staging/iio/light/isl29018.c b/drivers/staging/iio/light/isl29018.c
> index 38ec52b..ee220ae 100644
> --- a/drivers/staging/iio/light/isl29018.c
> +++ b/drivers/staging/iio/light/isl29018.c
> @@ -593,7 +593,7 @@ static const struct i2c_device_id isl29018_id[] = {
>   MODULE_DEVICE_TABLE(i2c, isl29018_id);
>
>   static const struct of_device_id isl29018_of_match[] = {
> -	{ .compatible = "invn,isl29018", },
> +	{ .compatible = "isl,isl29018", },
>   	{ },
>   };
>   MODULE_DEVICE_TABLE(of, isl29018_of_match);

