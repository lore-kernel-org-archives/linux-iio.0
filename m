Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:41516 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754355Ab3A3V2S (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 30 Jan 2013 16:28:18 -0500
Message-ID: <5109906F.5060508@kernel.org>
Date: Wed, 30 Jan 2013 21:28:15 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Denis CIOCCA <denis.ciocca@st.com>
CC: Lars-Peter Clausen <lars@metafoo.de>,
	Denis Ciocca <denis.ciocca@gmail.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: STMicroelectronics IIO driver
References: <1359157488-15969-1-git-send-email-denis.ciocca@st.com> <51068BAE.9090801@metafoo.de> <5106DC2F.60501@kernel.org> <135947692.Y65oJdCdPt@elitebook-8460p>
In-Reply-To: <135947692.Y65oJdCdPt@elitebook-8460p>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 01/29/2013 09:51 AM, Denis CIOCCA wrote:
>> Applied to togreg branch of iio.git.  Note there was some fuzz on patches
>> 2 and 3  + need to do a merge on patch 2 due to makefile changes.  Denis,
>> could you verify I didn't mess it up (as I am occasionally known to do ;)
> 
> I tested the driver and I didn't find any problems, there is only one little 
> wrong label in Kconfig of iio/st_sensors/Kconfig:
As I've never said my tree won't rebase or remain consistent,
I've just applied this inside the original patch.

> 
> ---
>  drivers/iio/common/st_sensors/Kconfig |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/common/st_sensors/Kconfig 
> b/drivers/iio/common/st_sensors/Kconfig
> index 84b2dca..865f1ca 100644
> --- a/drivers/iio/common/st_sensors/Kconfig
> +++ b/drivers/iio/common/st_sensors/Kconfig
> @@ -1,5 +1,5 @@
>  #
> -# Hid Sensor common modules
> +# STMicroelectronics sensors common library
>  #
>  
>  config IIO_ST_SENSORS_I2C
> 
