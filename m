Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:46059 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752819AbbGSKIe (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 19 Jul 2015 06:08:34 -0400
Message-ID: <55AB7720.8040204@kernel.org>
Date: Sun, 19 Jul 2015 11:08:32 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Hartmut Knaack <knaack.h@gmx.de>, linux-iio@vger.kernel.org
CC: Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Irina Tirdea <irina.tirdea@intel.com>,
	Vlad Dogaru <vlad.dogaru@intel.com>
Subject: Re: [PATCH 6/8] iio:magnetometer:bmc150_magn: protect runtime_resume
 with mutex
References: <cover.1437090791.git.knaack.h@gmx.de> <d6c36de684250b41333124b476b0d29bab00b22a.1437090791.git.knaack.h@gmx.de>
In-Reply-To: <d6c36de684250b41333124b476b0d29bab00b22a.1437090791.git.knaack.h@gmx.de>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 17/07/15 09:52, Hartmut Knaack wrote:
> Protect bmc150_magn_runtime_resume() with a mutex, as done with other
> suspend/resume functions.
> 
> Signed-off-by: Hartmut Knaack <knaack.h@gmx.de>
Looks fine to me, but given we are getting into more complex patches, I'll
let this sit on the list for Irina and others to have a look at.

Jonathan
> ---
>  drivers/iio/magnetometer/bmc150_magn.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/magnetometer/bmc150_magn.c b/drivers/iio/magnetometer/bmc150_magn.c
> index e1f804b2b244..ac0cdbde813b 100644
> --- a/drivers/iio/magnetometer/bmc150_magn.c
> +++ b/drivers/iio/magnetometer/bmc150_magn.c
> @@ -1052,9 +1052,14 @@ static int bmc150_magn_runtime_resume(struct device *dev)
>  {
>  	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
>  	struct bmc150_magn_data *data = iio_priv(indio_dev);
> +	int ret;
>  
> -	return bmc150_magn_set_power_mode(data, BMC150_MAGN_POWER_MODE_NORMAL,
> -					  true);
> +	mutex_lock(&data->mutex);
> +	ret = bmc150_magn_set_power_mode(data, BMC150_MAGN_POWER_MODE_NORMAL,
> +					 true);
> +	mutex_unlock(&data->mutex);
> +
> +	return ret;
>  }
>  #endif
>  
> 

