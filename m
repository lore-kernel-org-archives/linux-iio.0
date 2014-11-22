Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:39873 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750761AbaKVKjc (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 22 Nov 2014 05:39:32 -0500
Message-ID: <547067DE.9050304@kernel.org>
Date: Sat, 22 Nov 2014 10:39:26 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Vlad Dogaru <vlad.dogaru@intel.com>, linux-iio@vger.kernel.org,
	mranostay@gmail.com
Subject: Re: [PATCH 1/2] iio: rename proximity sensors in kernel config
References: <1416237169-10707-1-git-send-email-vlad.dogaru@intel.com> <1416237169-10707-2-git-send-email-vlad.dogaru@intel.com>
In-Reply-To: <1416237169-10707-2-git-send-email-vlad.dogaru@intel.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 17/11/14 15:12, Vlad Dogaru wrote:
> Up till now, there was only a single sensor in the drivers/iio/proximity
> directory, and the config subsection was called 'Lightning sensors'.
> This will no longer be true once we introduce a general-purpose
> proximity sensor.
> 
> Signed-off-by: Vlad Dogaru <vlad.dogaru@intel.com>
Hmm.  The lightning sensor is such an oddity I think I'd prefer that
you just add a second menu in this kconfig file for more
conventional proximity sensors.

Thanks,

Jonathan
> ---
>  drivers/iio/proximity/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/proximity/Kconfig b/drivers/iio/proximity/Kconfig
> index 0c8cdf5..a131ead 100644
> --- a/drivers/iio/proximity/Kconfig
> +++ b/drivers/iio/proximity/Kconfig
> @@ -2,7 +2,7 @@
>  # Proximity sensors
>  #
>  
> -menu "Lightning sensors"
> +menu "Proximity sensors"
>  
>  config AS3935
>  	tristate "AS3935 Franklin lightning sensor"
> 

