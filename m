Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:42831 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751814AbdDIIpm (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 9 Apr 2017 04:45:42 -0400
Subject: Re: [PATCH v2 3/5] iio: trigger: add set_trigger callback to notify
 device
To: Fabrice Gasnier <fabrice.gasnier@st.com>, linux@armlinux.org.uk,
        robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1491495116-7209-1-git-send-email-fabrice.gasnier@st.com>
 <1491495116-7209-4-git-send-email-fabrice.gasnier@st.com>
Cc: linux-iio@vger.kernel.org, mark.rutland@arm.com,
        mcoquelin.stm32@gmail.com, alexandre.torgue@st.com,
        lars@metafoo.de, knaack.h@gmx.de, pmeerw@pmeerw.net,
        benjamin.gaignard@linaro.org, benjamin.gaignard@st.com
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <98a89a18-a1e7-5e5b-663a-25b23c352444@kernel.org>
Date: Sun, 9 Apr 2017 09:45:39 +0100
MIME-Version: 1.0
In-Reply-To: <1491495116-7209-4-git-send-email-fabrice.gasnier@st.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 06/04/17 17:11, Fabrice Gasnier wrote:
> Add 'set_trigger' callback to iio info structure. This allows device
> to be notified when a trigger (or no trigger) has been assigned. This
> maybe useful for instance in non buffered mode (e.g. event triggered).
> This is called, after trigger and device side validate callbacks have
> been called.
> 
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
Seems sensible to me...

J
> ---
> Changes in v2:
> - Added set_trigger callback used in remaining patches
> ---
>  drivers/iio/industrialio-trigger.c | 6 ++++++
>  include/linux/iio/iio.h            | 2 ++
>  2 files changed, 8 insertions(+)
> 
> diff --git a/drivers/iio/industrialio-trigger.c b/drivers/iio/industrialio-trigger.c
> index 978e1592..010bdf2 100644
> --- a/drivers/iio/industrialio-trigger.c
> +++ b/drivers/iio/industrialio-trigger.c
> @@ -434,6 +434,12 @@ static ssize_t iio_trigger_write_current(struct device *dev,
>  			goto out_trigger_put;
>  	}
>  
> +	if (indio_dev->info->set_trigger) {
> +		ret = indio_dev->info->set_trigger(indio_dev, trig);
> +		if (ret)
> +			goto out_trigger_put;
> +	}
> +
>  	indio_dev->trig = trig;
>  
>  	if (oldtrig) {
> diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
> index 3f5ea2e..9f51065 100644
> --- a/include/linux/iio/iio.h
> +++ b/include/linux/iio/iio.h
> @@ -399,6 +399,7 @@ static inline bool iio_channel_has_available(const struct iio_chan_spec *chan,
>   * @write_event_value:	write a configuration value for the event.
>   * @validate_trigger:	function to validate the trigger when the
>   *			current trigger gets changed.
> + * @set_trigger:	function to notify current trigger gets changed.
>   * @update_scan_mode:	function to configure device and scan buffer when
>   *			channels have changed
>   * @debugfs_reg_access:	function to read or write register value of device
> @@ -478,6 +479,7 @@ struct iio_info {
>  
>  	int (*validate_trigger)(struct iio_dev *indio_dev,
>  				struct iio_trigger *trig);
> +	int (*set_trigger)(struct iio_dev *indio_dev, struct iio_trigger *trig);
>  	int (*update_scan_mode)(struct iio_dev *indio_dev,
>  				const unsigned long *scan_mask);
>  	int (*debugfs_reg_access)(struct iio_dev *indio_dev,
> 

