Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:60715 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755403AbdETRzF (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 20 May 2017 13:55:05 -0400
Subject: Re: [PATCH v3] staging: iio: light: Replace symbolic permissions as
 per coding style
To: surenderpolsani@gmail.com, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        gregor.boirie@parrot.com
Cc: singhalsimran0@gmail.com, maitysanchayan@gmail.com,
        eraretuya@gmail.com, linux-iio@vger.kernel.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Jon Brenner <Jon.Brenner@ams.com>,
        Brian Masney <masneyb@onstation.org>
References: <20170519082041.GA18353@kroah.com>
 <1495186632-31114-1-git-send-email-surenderpolsani@gmail.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <e374d59a-c216-a19b-a3a1-a26a862f0ae5@kernel.org>
Date: Sat, 20 May 2017 18:55:02 +0100
MIME-Version: 1.0
In-Reply-To: <1495186632-31114-1-git-send-email-surenderpolsani@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 19/05/17 10:37, surenderpolsani@gmail.com wrote:
> From: Surender Polsani <surenderpolsani@gmail.com>
> 
> Fixed the following checkpatch.pl warnings:
> octal permissions are more preferable than symbolic permissions
> 
> Replaced DEVICE_ATTR family macros with DEVICE_ATTR_RW family
> as suggested by Greg K-H. Changed attributes and function
> names where ever required to satisfy internal macro definitions
> like __ATTR__RW().
> 
> Signed-off-by: Surender Polsani <surenderpolsani@gmail.com>
Nicely presented patch, but it runs into the fact that some of these
shouldn't exist as hand rolled attrs in the first place.

Some of theses should be handled through the various info_mask and
event_info_mask bitmaps + read_raw etc.

This would be a much less mechanical change however...

See inline and I'll try and pick out which ones.

Brian is working on this driver as well at the moment so there may
well be some clashes.

Perhaps you two could confer on who will target what?  Saves
everyone time to work together!

Jonathan

p.s. Brian if you'd prefer I just apply this and you rebase as
appropriate that's fine with me as well...
> ---
> Changes for v3:
> 
> - Reverted some changes from previous version and made
>    changes as suggested by Greg K-H.
> 
> Changes for v2:
> 
> - Made few changes as suggested by Greg K-H and modified
>    description accordingly.
> ---
>   drivers/staging/iio/light/tsl2x7x_core.c | 62 ++++++++++++++------------------
>   1 file changed, 26 insertions(+), 36 deletions(-)
> 
> diff --git a/drivers/staging/iio/light/tsl2x7x_core.c b/drivers/staging/iio/light/tsl2x7x_core.c
> index af3910b..4de1408 100644
> --- a/drivers/staging/iio/light/tsl2x7x_core.c
> +++ b/drivers/staging/iio/light/tsl2x7x_core.c
> @@ -919,7 +919,7 @@ static void tsl2x7x_prox_cal(struct iio_dev *indio_dev)
>   		tsl2x7x_chip_on(indio_dev);
>   }
>   
> -static ssize_t tsl2x7x_power_state_show(struct device *dev,
> +static ssize_t power_state_show(struct device *dev,
>   					struct device_attribute *attr,
>   					char *buf)
>   {
> @@ -928,7 +928,7 @@ static ssize_t tsl2x7x_power_state_show(struct device *dev,
>   	return snprintf(buf, PAGE_SIZE, "%d\n", chip->tsl2x7x_chip_status);
>   }
>   
> -static ssize_t tsl2x7x_power_state_store(struct device *dev,
> +static ssize_t power_state_store(struct device *dev,
>   					 struct device_attribute *attr,
>   					 const char *buf, size_t len)
>   {
> @@ -946,7 +946,7 @@ static ssize_t tsl2x7x_power_state_store(struct device *dev,
>   	return len;
>   }
>   
> -static ssize_t tsl2x7x_gain_available_show(struct device *dev,
> +static ssize_t in_illuminance0_calibscale_available_show(struct device *dev,
>   					   struct device_attribute *attr,
>   					   char *buf)
>   {
> @@ -964,14 +964,14 @@ static ssize_t tsl2x7x_gain_available_show(struct device *dev,
>   	return snprintf(buf, PAGE_SIZE, "%s\n", "1 8 16 120");
>   }
>   
> -static ssize_t tsl2x7x_prox_gain_available_show(struct device *dev,
> +static ssize_t in_proximity0_calibscale_available_show(struct device *dev,
>   						struct device_attribute *attr,
>   						char *buf)
>   {
>   		return snprintf(buf, PAGE_SIZE, "%s\n", "1 2 4 8");
>   }
>   
> -static ssize_t tsl2x7x_als_time_show(struct device *dev,
> +static ssize_t in_illuminance0_integration_time_show(struct device *dev,
>   				     struct device_attribute *attr,
>   				     char *buf)
>   {
> @@ -986,7 +986,7 @@ static ssize_t tsl2x7x_als_time_show(struct device *dev,
>   	return snprintf(buf, PAGE_SIZE, "%d.%03d\n", y, z);
>   }
>   
> -static ssize_t tsl2x7x_als_time_store(struct device *dev,
> +static ssize_t in_illuminance0_integration_time_store(struct device *dev,
>   				      struct device_attribute *attr,
>   				      const char *buf, size_t len)
>   {
> @@ -1014,7 +1014,7 @@ static ssize_t tsl2x7x_als_time_store(struct device *dev,
>   static IIO_CONST_ATTR(in_illuminance0_integration_time_available,
>   		".00272 - .696");
>   
> -static ssize_t tsl2x7x_als_cal_target_show(struct device *dev,
> +static ssize_t in_illuminance0_target_input_show(struct device *dev,
>   					   struct device_attribute *attr,
>   					   char *buf)
>   {
> @@ -1024,7 +1024,7 @@ static ssize_t tsl2x7x_als_cal_target_show(struct device *dev,
>   			chip->tsl2x7x_settings.als_cal_target);
>   }
>   
> -static ssize_t tsl2x7x_als_cal_target_store(struct device *dev,
> +static ssize_t in_illuminance0_target_input_store(struct device *dev,
>   					    struct device_attribute *attr,
>   					    const char *buf, size_t len)
>   {
> @@ -1044,7 +1044,7 @@ static ssize_t tsl2x7x_als_cal_target_store(struct device *dev,
>   }
>   
>   /* persistence settings */
> -static ssize_t tsl2x7x_als_persistence_show(struct device *dev,
> +static ssize_t in_intensity0_thresh_period_show(struct device *dev,
>   					    struct device_attribute *attr,
>   					    char *buf)
>   {
> @@ -1061,7 +1061,7 @@ static ssize_t tsl2x7x_als_persistence_show(struct device *dev,
>   	return snprintf(buf, PAGE_SIZE, "%d.%03d\n", y, z);
>   }
>   
> -static ssize_t tsl2x7x_als_persistence_store(struct device *dev,
> +static ssize_t in_intensity0_thresh_period_store(struct device *dev,
>   					     struct device_attribute *attr,
>   					     const char *buf, size_t len)
>   {
> @@ -1092,7 +1092,7 @@ static ssize_t tsl2x7x_als_persistence_store(struct device *dev,
>   	return IIO_VAL_INT_PLUS_MICRO;
>   }
>   
> -static ssize_t tsl2x7x_prox_persistence_show(struct device *dev,
> +static ssize_t in_proximity0_thresh_period_show(struct device *dev,
>   					     struct device_attribute *attr,
>   					     char *buf)
>   {
> @@ -1109,7 +1109,7 @@ static ssize_t tsl2x7x_prox_persistence_show(struct device *dev,
>   	return snprintf(buf, PAGE_SIZE, "%d.%03d\n", y, z);
>   }
>   
> -static ssize_t tsl2x7x_prox_persistence_store(struct device *dev,
> +static ssize_t in_proximity0_thresh_period_store(struct device *dev,
>   					      struct device_attribute *attr,
>   					      const char *buf, size_t len)
>   {
> @@ -1140,7 +1140,7 @@ static ssize_t tsl2x7x_prox_persistence_store(struct device *dev,
>   	return IIO_VAL_INT_PLUS_MICRO;
>   }
>   
> -static ssize_t tsl2x7x_do_calibrate(struct device *dev,
> +static ssize_t in_illuminance0_calibrate_store(struct device *dev,
>   				    struct device_attribute *attr,
>   				    const char *buf, size_t len)
>   {
> @@ -1158,7 +1158,7 @@ static ssize_t tsl2x7x_do_calibrate(struct device *dev,
>   	return len;
>   }
>   
> -static ssize_t tsl2x7x_luxtable_show(struct device *dev,
> +static ssize_t in_illuminance0_lux_table_show(struct device *dev,
>   				     struct device_attribute *attr,
>   				     char *buf)
>   {
> @@ -1186,7 +1186,7 @@ static ssize_t tsl2x7x_luxtable_show(struct device *dev,
>   	return offset;
>   }
>   
> -static ssize_t tsl2x7x_luxtable_store(struct device *dev,
> +static ssize_t in_illuminance0_lux_table_store(struct device *dev,
>   				      struct device_attribute *attr,
>   				      const char *buf, size_t len)
>   {
> @@ -1226,7 +1226,7 @@ static ssize_t tsl2x7x_luxtable_store(struct device *dev,
>   	return len;
>   }
>   
> -static ssize_t tsl2x7x_do_prox_calibrate(struct device *dev,
> +static ssize_t in_proximity0_calibrate_store(struct device *dev,
>   					 struct device_attribute *attr,
>   					 const char *buf, size_t len)
>   {
> @@ -1498,35 +1498,25 @@ static int tsl2x7x_write_raw(struct iio_dev *indio_dev,
>   	return 0;
>   }
>   
> -static DEVICE_ATTR(power_state, S_IRUGO | S_IWUSR,
> -		tsl2x7x_power_state_show, tsl2x7x_power_state_store);
> +static DEVICE_ATTR_RW(power_state);
>   
> -static DEVICE_ATTR(in_proximity0_calibscale_available, S_IRUGO,
> -		tsl2x7x_prox_gain_available_show, NULL);
> +static DEVICE_ATTR_RO(in_proximity0_calibscale_available);
>   
> -static DEVICE_ATTR(in_illuminance0_calibscale_available, S_IRUGO,
> -		tsl2x7x_gain_available_show, NULL);
> +static DEVICE_ATTR_RO(in_illuminance0_calibscale_available);
There is core support for these, but as it's not well documented now
fair enough to do it like this for now...
>   
> -static DEVICE_ATTR(in_illuminance0_integration_time, S_IRUGO | S_IWUSR,
> -		tsl2x7x_als_time_show, tsl2x7x_als_time_store);
> +static DEVICE_ATTR_RW(in_illuminance0_integration_time);
Should be iio_chan_spec mask_separate as  BIT(IIO_CHAN_INFO_INT_TIME)
and support added to read_raw and write_raw callbacks of iio_info
structure.
>   
> -static DEVICE_ATTR(in_illuminance0_target_input, S_IRUGO | S_IWUSR,
> -		tsl2x7x_als_cal_target_show, tsl2x7x_als_cal_target_store);
> +static DEVICE_ATTR_RW(in_illuminance0_target_input);
>   
> -static DEVICE_ATTR(in_illuminance0_calibrate, S_IWUSR, NULL,
> -		tsl2x7x_do_calibrate);
> +static DEVICE_ATTR_WO(in_illuminance0_calibrate);
>   
> -static DEVICE_ATTR(in_proximity0_calibrate, S_IWUSR, NULL,
> -		tsl2x7x_do_prox_calibrate);
> +static DEVICE_ATTR_WO(in_proximity0_calibrate);
>   
> -static DEVICE_ATTR(in_illuminance0_lux_table, S_IRUGO | S_IWUSR,
> -		tsl2x7x_luxtable_show, tsl2x7x_luxtable_store);
> +static DEVICE_ATTR_RW(in_illuminance0_lux_table);
>   
> -static DEVICE_ATTR(in_intensity0_thresh_period, S_IRUGO | S_IWUSR,
> -		tsl2x7x_als_persistence_show, tsl2x7x_als_persistence_store);
> +static DEVICE_ATTR_RW(in_intensity0_thresh_period);
As below.
>   
> -static DEVICE_ATTR(in_proximity0_thresh_period, S_IRUGO | S_IWUSR,
> -		tsl2x7x_prox_persistence_show, tsl2x7x_prox_persistence_store);
> +static DEVICE_ATTR_RW(in_proximity0_thresh_period);
Should be in the iio_event_spec mask_separate as BIT(IIO_EV_INFO_PERIOD) and
add the relevant reading and writing code to tsl2x7x_read_thresh
(which would then be obviously misnamed and need renaming)
>   
>   /* Use the default register values to identify the Taos device */
>   static int tsl2x7x_device_id(unsigned char *id, int target)
> 

