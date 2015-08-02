Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:45409 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750972AbbHBRc6 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 2 Aug 2015 13:32:58 -0400
Subject: Re: [PATCH 3/6] iio: trigger: Add missing fields in kernel docs
To: Cristina Opriceana <cristina.opriceana@gmail.com>
References: <cover.1437737942.git.cristina.opriceana@gmail.com>
 <36176268d5ee1e7ee1ab2d0b306ceb66f4f5f6af.1437737942.git.cristina.opriceana@gmail.com>
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	daniel.baluta@intel.com
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <55BE5447.6080507@kernel.org>
Date: Sun, 2 Aug 2015 18:32:55 +0100
MIME-Version: 1.0
In-Reply-To: <36176268d5ee1e7ee1ab2d0b306ceb66f4f5f6af.1437737942.git.cristina.opriceana@gmail.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 24/07/15 14:20, Cristina Opriceana wrote:
> Fix kernel docs warnings by adding the missing description
> for each of the existing function parameters.
> 
> Signed-off-by: Cristina Opriceana <cristina.opriceana@gmail.com>
A few comments inline.
> ---
>  drivers/iio/industrialio-trigger.c | 27 ++++++++++++++++++++++++---
>  1 file changed, 24 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/industrialio-trigger.c b/drivers/iio/industrialio-trigger.c
> index d31098e..cae2939 100644
> --- a/drivers/iio/industrialio-trigger.c
> +++ b/drivers/iio/industrialio-trigger.c
> @@ -40,7 +40,14 @@ static DEFINE_MUTEX(iio_trigger_list_lock);
>  
>  /**
>   * iio_trigger_read_name() - retrieve useful identifying name
> - **/
> + * @dev:	device that holds the iio_trigger
The dev structure is within the struct iio_trigger rather than the other
way around. It is there to give it it a presence in the device model.
I'd keep this statement vague and say perhaps,
device associated with the iio_trigger.
> + * @attr:	pointer to the device_attribute structure that is
> + *		being processed
> + * @buf:	buffer to print the name into
> + *
> + * Return: a negative number on failure or the number of written
> + *	   characters on success.
> + */
>  static ssize_t iio_trigger_read_name(struct device *dev,
>  				     struct device_attribute *attr,
>  				     char *buf)
> @@ -288,10 +295,17 @@ EXPORT_SYMBOL_GPL(iio_dealloc_pollfunc);
>  
>  /**
>   * iio_trigger_read_current() - trigger consumer sysfs query current trigger
> + * @dev:	Device this iio_dev belongs to
Again, this implies a tighter relationship than is actually true.
The dev isn't the underlying device (e.g. the spi one or i2c one
but rather one created by the iio subsystem to give the iio_dev a
presence in the device model - on the iio sysfs bus).
> + * @attr:	Pointer to the device_attribute structure that
> + *		is being processed
> + * @buf:	Buffer where the current trigger name will be printed into
>   *
>   * For trigger consumers the current_trigger interface allows the trigger
>   * used by the device to be queried.
> - **/
> + *
> + * Return: a negative number on failure, the number of characters written
> + *	   on success or 0 if no trigger is available
> + */
>  static ssize_t iio_trigger_read_current(struct device *dev,
>  					struct device_attribute *attr,
>  					char *buf)
> @@ -305,11 +319,18 @@ static ssize_t iio_trigger_read_current(struct device *dev,
>  
>  /**
>   * iio_trigger_write_current() - trigger consumer sysfs set current trigger
> + * @dev:	Device that this iio_dev belongs to
> + * @attr:	Device attribute that is being processed
> + * @buf:	String buffer that holds the name of the trigger
> + * @len:	Length of the trigger name held by buf
>   *
>   * For trigger consumers the current_trigger interface allows the trigger
>   * used for this device to be specified at run time based on the trigger's
>   * name.
> - **/
> + *
> + * Return: negative error code on failure or length of the buffer
> + *	   on success
> + */
>  static ssize_t iio_trigger_write_current(struct device *dev,
>  					 struct device_attribute *attr,
>  					 const char *buf,
> 

