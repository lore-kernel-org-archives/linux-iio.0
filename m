Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:45818 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755310Ab2GLTaD (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 12 Jul 2012 15:30:03 -0400
Message-ID: <4FFF25B8.7050008@kernel.org>
Date: Thu, 12 Jul 2012 20:30:00 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: srinivas pandruvada <srinivas.pandruvada@intel.com>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH] IIO: core: Add hysteresis in channel spec
References: <1341865351-6673-1-git-send-email-srinivas.pandruvada@intel.com>
In-Reply-To: <1341865351-6673-1-git-send-email-srinivas.pandruvada@intel.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 07/09/2012 09:22 PM, srinivas pandruvada wrote:
> Added hysteresis to the list of channel info enumeration, shared
> /separate bit defines and to postfix channel info strings.
> 
> Signed-off-by: srinivas pandruvada <srinivas.pandruvada@intel.com>
I'm fine with this, but typically we only merge these sorts of things
in the same patch series as the first driver to use them (make it
much more obvious what the point is!)

Jonathan
> ---
>  drivers/iio/industrialio-core.c |    1 +
>  include/linux/iio/iio.h         |    5 +++++
>  2 files changed, 6 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> index 1ddd886..ceb5d90 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -92,6 +92,7 @@ static const char * const iio_chan_info_postfix[] = {
>  	[IIO_CHAN_INFO_FREQUENCY] = "frequency",
>  	[IIO_CHAN_INFO_PHASE] = "phase",
>  	[IIO_CHAN_INFO_HARDWAREGAIN] = "hardwaregain",
> +	[IIO_CHAN_INFO_HYSTERESIS] = "hysteresis",
>  };
>  
>  const struct iio_chan_spec
> diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
> index 3a4f6a3..9ed1063 100644
> --- a/include/linux/iio/iio.h
> +++ b/include/linux/iio/iio.h
> @@ -35,6 +35,7 @@ enum iio_chan_info_enum {
>  	IIO_CHAN_INFO_FREQUENCY,
>  	IIO_CHAN_INFO_PHASE,
>  	IIO_CHAN_INFO_HARDWAREGAIN,
> +	IIO_CHAN_INFO_HYSTERESIS,
>  };
>  
>  #define IIO_CHAN_INFO_SHARED_BIT(type) BIT(type*2)
> @@ -100,6 +101,10 @@ enum iio_chan_info_enum {
>  	IIO_CHAN_INFO_SEPARATE_BIT(IIO_CHAN_INFO_HARDWAREGAIN)
>  #define IIO_CHAN_INFO_HARDWAREGAIN_SHARED_BIT			\
>  	IIO_CHAN_INFO_SHARED_BIT(IIO_CHAN_INFO_HARDWAREGAIN)
> +#define IIO_CHAN_INFO_HYSTERESIS_SEPARATE_BIT			\
> +	IIO_CHAN_INFO_SEPARATE_BIT(IIO_CHAN_INFO_HYSTERESIS)
> +#define IIO_CHAN_INFO_HYSTERESIS_SHARED_BIT			\
> +	IIO_CHAN_INFO_SHARED_BIT(IIO_CHAN_INFO_HYSTERESIS)
>  
>  enum iio_endian {
>  	IIO_CPU,
> 


