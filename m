Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:55710 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750751AbbAAMMi (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 1 Jan 2015 07:12:38 -0500
Message-ID: <54A539B5.1090207@kernel.org>
Date: Thu, 01 Jan 2015 12:12:37 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Roberta Dobrescu <roberta.dobrescu@gmail.com>,
	linux-iio@vger.kernel.org
CC: octavian.purdila@intel.com, daniel.baluta@intel.com,
	lars@metafoo.de, Michael.Hennerich@analog.com, knaack.h@gmx.de,
	pmeerw@pmeerw.net
Subject: Re: [PATCH 2/3] iio: accel: mma8452: Remove trailing whitespace
References: <1419965875-4298-1-git-send-email-roberta.dobrescu@gmail.com> <1419965875-4298-3-git-send-email-roberta.dobrescu@gmail.com>
In-Reply-To: <1419965875-4298-3-git-send-email-roberta.dobrescu@gmail.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 30/12/14 18:57, Roberta Dobrescu wrote:
> This patch fixes the following checkpatch.pl error:
> ERROR: trailing whitespace
> 
> Signed-off-by: Roberta Dobrescu <roberta.dobrescu@gmail.com>
Applied to the togreg branch of iio.git.

Thanks
> ---
>  drivers/iio/accel/mma8452.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
> index 3c12d49..5b80657 100644
> --- a/drivers/iio/accel/mma8452.c
> +++ b/drivers/iio/accel/mma8452.c
> @@ -111,7 +111,7 @@ static const int mma8452_samp_freq[8][2] = {
>  	{6, 250000}, {1, 560000}
>  };
>  
> -/* 
> +/*
>   * Hardware has fullscale of -2G, -4G, -8G corresponding to raw value -2048
>   * The userspace interface uses m/s^2 and we declare micro units
>   * So scale factor is given by:
> 

