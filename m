Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:38848 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757430Ab3EVVIl (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 22 May 2013 17:08:41 -0400
Message-ID: <519D33D7.4040805@kernel.org>
Date: Wed, 22 May 2013 22:08:39 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Alexandre Relange <alexandre@relange.org>
CC: Jonathan Cameron <jic23@cam.ac.uk>, linux-iio@vger.kernel.org,
	trivial@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: Correct HID light sensor name in comments
References: <20130516135455.GA16014@Pinea-Alexandre>
In-Reply-To: <20130516135455.GA16014@Pinea-Alexandre>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 05/16/2013 02:54 PM, Alexandre Relange wrote:
> The original driver was pasted from accelerometer driver, but the name
> of the ID was not changed. This patch fixes this comment.
> 
> Signed-off-by: Alexandre Relange <alexandre@relange.org>
Applied to the togreg branch of iio.git
Thanks.
> ---
>  drivers/iio/light/hid-sensor-als.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/light/hid-sensor-als.c b/drivers/iio/light/hid-sensor-als.c
> index 80d68ff..cdc2cad 100644
> --- a/drivers/iio/light/hid-sensor-als.c
> +++ b/drivers/iio/light/hid-sensor-als.c
> @@ -31,7 +31,7 @@
>  #include "../common/hid-sensors/hid-sensor-trigger.h"
>  
>  /*Format: HID-SENSOR-usage_id_in_hex*/
> -/*Usage ID from spec for Accelerometer-3D: 0x200041*/
> +/*Usage ID from spec for Ambiant-Light: 0x200041*/
>  #define DRIVER_NAME "HID-SENSOR-200041"
>  
>  #define CHANNEL_SCAN_INDEX_ILLUM 0
> 
