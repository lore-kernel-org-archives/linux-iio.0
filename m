Return-Path: <knaack.h@gmx.de>
Message-ID: <540F7BB5.2080801@gmx.de>
Date: Wed, 10 Sep 2014 00:14:13 +0200
From: Hartmut Knaack <knaack.h@gmx.de>
MIME-Version: 1.0
To: Irina Tirdea <irina.tirdea@intel.com>,
 Jonathan Cameron <jic23@kernel.org>,
 linux-iio@vger.kernel.org
CC: Lars-Peter Clausen <lars@metafoo.de>,
 Peter Meerwald <pmeerw@pmeerw.net>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: gyro: bmg160: only set power state if PM_RUNTIME
 is defined
References: <1410185127-13039-1-git-send-email-irina.tirdea@intel.com>
In-Reply-To: <1410185127-13039-1-git-send-email-irina.tirdea@intel.com>
Content-Type: text/plain; charset=ISO-8859-15
List-ID: <linux-iio@vger.kernel.org>

Irina Tirdea schrieb, Am 08.09.2014 16:05:
> When CONFIG_PM_RUNTIME is not defined and bmg160 tries to power
> off the device, bmg160_set_power_state will call pm_runtime_put_autosuspend,
> which is not implemented (wil return -ENOSYS).
> 
> Only call bmg160_set_power_state when CONFIG_PM_RUNTIME is defined.
> 
> Signed-off-by: Irina Tirdea <irina.tirdea@intel.com>
Acked-by: Hartmut Knaack <knaack.h@gmx.de>
> ---
> 
> Changes in v2:
>  - moved ifdef CONFIG_PM_RUNTIME inside bmg160_set_power_state as
> Hartmut Knaack suggested
> 
>  drivers/iio/gyro/bmg160.c |    2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/iio/gyro/bmg160.c b/drivers/iio/gyro/bmg160.c
> index 7524698..1f967e0d 100644
> --- a/drivers/iio/gyro/bmg160.c
> +++ b/drivers/iio/gyro/bmg160.c
> @@ -237,6 +237,7 @@ static int bmg160_chip_init(struct bmg160_data *data)
>  
>  static int bmg160_set_power_state(struct bmg160_data *data, bool on)
>  {
> +#ifdef CONFIG_PM_RUNTIME
>  	int ret;
>  
>  	if (on)
> @@ -251,6 +252,7 @@ static int bmg160_set_power_state(struct bmg160_data *data, bool on)
>  			"Failed: bmg160_set_power_state for %d\n", on);
>  		return ret;
>  	}
> +#endif
>  
>  	return 0;
>  }
> 
