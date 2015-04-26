Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:42569 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751562AbbDZStP (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 26 Apr 2015 14:49:15 -0400
Message-ID: <553D3329.6080002@kernel.org>
Date: Sun, 26 Apr 2015 19:49:13 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Irina Tirdea <irina.tirdea@intel.com>, linux-iio@vger.kernel.org,
	Hartmut Knaack <knaack.h@gmx.de>
CC: linux-kernel@vger.kernel.org, Vlad Dogaru <vlad.dogaru@intel.com>
Subject: Re: [PATCH v2 10/17] iio: accel: mma9553: use GENMASK
References: <1428939664-12503-1-git-send-email-irina.tirdea@intel.com> <1428939664-12503-11-git-send-email-irina.tirdea@intel.com>
In-Reply-To: <1428939664-12503-11-git-send-email-irina.tirdea@intel.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 13/04/15 16:40, Irina Tirdea wrote:
> Use GENMASK instead of BIT or direct value to
> define a mask.
> 
> Signed-off-by: Irina Tirdea <irina.tirdea@intel.com>
> Suggested-by: Hartmut Knaack <knaack.h@gmx.de>
Applied.
> ---
>  drivers/iio/accel/mma9553.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/accel/mma9553.c b/drivers/iio/accel/mma9553.c
> index a6b74de..47cb14b 100644
> --- a/drivers/iio/accel/mma9553.c
> +++ b/drivers/iio/accel/mma9553.c
> @@ -63,8 +63,8 @@
>  #define MMA9553_MASK_STATUS_STEPCHG		BIT(13)
>  #define MMA9553_MASK_STATUS_ACTCHG		BIT(12)
>  #define MMA9553_MASK_STATUS_SUSP		BIT(11)
> -#define MMA9553_MASK_STATUS_ACTIVITY		(BIT(10) | BIT(9) | BIT(8))
> -#define MMA9553_MASK_STATUS_VERSION		0x00FF
> +#define MMA9553_MASK_STATUS_ACTIVITY		GENMASK(10, 8)
> +#define MMA9553_MASK_STATUS_VERSION		GENMASK(7, 0)
>  
>  #define MMA9553_REG_STEPCNT			0x02
>  #define MMA9553_REG_DISTANCE			0x04
> 

