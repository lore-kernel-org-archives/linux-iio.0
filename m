Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:58090 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964788AbbHHLqH (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 8 Aug 2015 07:46:07 -0400
Subject: Re: [PATCH v2] iio: trigger: Add missing fields in kernel docs
To: Cristina Opriceana <cristina.opriceana@gmail.com>
References: <7f6bc59643f226ee60469e2b4917126061cef956.1438861163.git.cristina.opriceana@gmail.com>
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	daniel.baluta@intel.com
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <55C5EBFD.1020503@kernel.org>
Date: Sat, 8 Aug 2015 12:46:05 +0100
MIME-Version: 1.0
In-Reply-To: <7f6bc59643f226ee60469e2b4917126061cef956.1438861163.git.cristina.opriceana@gmail.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 06/08/15 12:56, Cristina Opriceana wrote:
> Fix kernel docs warnings by adding the missing description
> for each of the existing function parameters.
> 
> Signed-off-by: Cristina Opriceana <cristina.opriceana@gmail.com>
Applied to the togreg branch of iio.git

Thanks,
> ---
> Changes in v2:
>  - Change @dev description in all functions to illustrate better the
>  connection with IIO devices or IIO trigger.
> 
>  drivers/iio/industrialio-trigger.c | 27 ++++++++++++++++++++++++---
>  1 file changed, 24 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/industrialio-trigger.c b/drivers/iio/industrialio-trigger.c
> index d31098e..570606c 100644
> --- a/drivers/iio/industrialio-trigger.c
> +++ b/drivers/iio/industrialio-trigger.c
> @@ -40,7 +40,14 @@ static DEFINE_MUTEX(iio_trigger_list_lock);
>  
>  /**
>   * iio_trigger_read_name() - retrieve useful identifying name
> - **/
> + * @dev:	device associated with the iio_trigger
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
> + * @dev:	device associated with an industrial I/O device
> + * @attr:	pointer to the device_attribute structure that
> + *		is being processed
> + * @buf:	buffer where the current trigger name will be printed into
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
> + * @dev:	device associated with an industrial I/O device
> + * @attr:	device attribute that is being processed
> + * @buf:	string buffer that holds the name of the trigger
> + * @len:	length of the trigger name held by buf
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

