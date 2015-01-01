Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:55707 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750751AbbAAMLr (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 1 Jan 2015 07:11:47 -0500
Message-ID: <54A53980.8040708@kernel.org>
Date: Thu, 01 Jan 2015 12:11:44 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Roberta Dobrescu <roberta.dobrescu@gmail.com>,
	linux-iio@vger.kernel.org
CC: octavian.purdila@intel.com, daniel.baluta@intel.com,
	lars@metafoo.de, Michael.Hennerich@analog.com, knaack.h@gmx.de,
	pmeerw@pmeerw.net
Subject: Re: [PATCH 1/3] iio: accel: kxcjk-1013: Add a blank line after declarations
References: <1419965875-4298-1-git-send-email-roberta.dobrescu@gmail.com> <1419965875-4298-2-git-send-email-roberta.dobrescu@gmail.com>
In-Reply-To: <1419965875-4298-2-git-send-email-roberta.dobrescu@gmail.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 30/12/14 18:57, Roberta Dobrescu wrote:
> This patch fixes the following checkpatch.pl warning:
> WARNING: Missing a blank line after declarations
> 
> Signed-off-by: Roberta Dobrescu <roberta.dobrescu@gmail.com>
Applied to the togreg branch of iio.git - initially pushed out
as testing for the autobuilders to play.

Thanks,

Jonathan
> ---
>  drivers/iio/accel/kxcjk-1013.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/iio/accel/kxcjk-1013.c b/drivers/iio/accel/kxcjk-1013.c
> index da2fe93..b3a2da5 100644
> --- a/drivers/iio/accel/kxcjk-1013.c
> +++ b/drivers/iio/accel/kxcjk-1013.c
> @@ -1134,6 +1134,7 @@ static const char *kxcjk1013_match_acpi_device(struct device *dev,
>  					       enum kx_chipset *chipset)
>  {
>  	const struct acpi_device_id *id;
> +
>  	id = acpi_match_device(dev->driver->acpi_match_table, dev);
>  	if (!id)
>  		return NULL;
> 

