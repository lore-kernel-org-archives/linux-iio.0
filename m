Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:44642 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752295AbbFNPCE (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 14 Jun 2015 11:02:04 -0400
Message-ID: <557D976A.2010803@kernel.org>
Date: Sun, 14 Jun 2015 16:02:02 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Irina Tirdea <irina.tirdea@intel.com>, linux-iio@vger.kernel.org,
	Hartmut Knaack <knaack.h@gmx.de>
CC: linux-kernel@vger.kernel.org, Vlad Dogaru <vlad.dogaru@intel.com>
Subject: Re: [PATCH v2 16/17] iio: accel: mma9553: document use of mutex
References: <1428939664-12503-1-git-send-email-irina.tirdea@intel.com> <1428939664-12503-17-git-send-email-irina.tirdea@intel.com>
In-Reply-To: <1428939664-12503-17-git-send-email-irina.tirdea@intel.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 13/04/15 16:41, Irina Tirdea wrote:
> Fix checkpatch.pl --strict check:
> CHECK: struct mutex definition without comment
> +     struct mutex mutex;
> 
> Signed-off-by: Irina Tirdea <irina.tirdea@intel.com>
Applied.

Thanks,


> ---
>  drivers/iio/accel/mma9553.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/iio/accel/mma9553.c b/drivers/iio/accel/mma9553.c
> index 08f28c3..a605280 100644
> --- a/drivers/iio/accel/mma9553.c
> +++ b/drivers/iio/accel/mma9553.c
> @@ -182,6 +182,10 @@ struct mma9553_conf_regs {
>  
>  struct mma9553_data {
>  	struct i2c_client *client;
> +	/*
> +	 * 1. Serialize access to HW (requested by mma9551_core API).
> +	 * 2. Serialize sequences that power on/off the device and access HW.
> +	 */
>  	struct mutex mutex;
>  	struct mma9553_conf_regs conf;
>  	struct mma9553_event events[MMA9553_EVENTS_INFO_SIZE];
> 

