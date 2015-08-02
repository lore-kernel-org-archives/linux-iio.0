Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:45343 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751568AbbHBRZC (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 2 Aug 2015 13:25:02 -0400
Subject: Re: [PATCH 1/6] iio: core: Add function params for kernel docs
To: Cristina Opriceana <cristina.opriceana@gmail.com>
References: <cover.1437737942.git.cristina.opriceana@gmail.com>
 <0301f753bd699ce58336c5418443a9e0358b8ffb.1437737942.git.cristina.opriceana@gmail.com>
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	daniel.baluta@intel.com
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <55BE526B.2080302@kernel.org>
Date: Sun, 2 Aug 2015 18:24:59 +0100
MIME-Version: 1.0
In-Reply-To: <0301f753bd699ce58336c5418443a9e0358b8ffb.1437737942.git.cristina.opriceana@gmail.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 24/07/15 14:16, Cristina Opriceana wrote:
> This patch adds the missing fields in kernel docs to remove
> some warnings that appear when the IIO Documentation DocBook
> is generated.
> 
> Signed-off-by: Cristina Opriceana <cristina.opriceana@gmail.com>
Mostly good.  Some typos.  (some from the original).

Fixed up as noted below and applied to the togreg branch of iio.git
Thanks,

Jonathan
> ---
>  drivers/iio/industrialio-core.c | 25 ++++++++++++++++++++-----
>  1 file changed, 20 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> index d8051cd..da643b9 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -406,10 +406,16 @@ EXPORT_SYMBOL_GPL(iio_enum_write);
>  
>  /**
>   * iio_format_value() - Formats a IIO value into its string representation
> - * @buf: The buffer to which the formated value gets written
> - * @type: One of the IIO_VAL_... constants. This decides how the val and val2
> - *        parameters are formatted.
> - * @vals: pointer to the values, exact meaning depends on the type parameter.
> + * @buf:	The buffer to which the formated value gets written
formatted
> + * @type:	One of the IIO_VAL_... constants. This decides how the val
> + *		and val2 parameters are formatted.
> + * @size:	Number of IIO value entries contained in vals
> + * @vals:	Pointer to the values, exact meaning depends on the
> + *		type parameter.
> + *
> + * Return: 0 by default, a negative number on failiure or the
failure
> + *	   total number of characters written for a type that belongs
> + *	   to the IIO_VAL_... constant.
>   */
>  ssize_t iio_format_value(char *buf, unsigned int type, int size, int *vals)
>  {
> @@ -1096,6 +1102,11 @@ EXPORT_SYMBOL_GPL(devm_iio_device_free);
>  
>  /**
>   * iio_chrdev_open() - chrdev file open for buffer access and ioctls
> + * @inode:	Inode structure for identifying the device in the file system
> + * @filp:	File structure for iio device used to keep and later access
> + *		private data
> + *
> + * Return: 0 on success or -EBUSY if the device is already opened
>   **/
>  static int iio_chrdev_open(struct inode *inode, struct file *filp)
>  {
> @@ -1114,7 +1125,11 @@ static int iio_chrdev_open(struct inode *inode, struct file *filp)
>  
>  /**
>   * iio_chrdev_release() - chrdev file close buffer access and ioctls
> - **/
> + * @inode:	Inode structure pointer for the char device
> + * @filp:	File structure pointer for the char device
> + *
> + * Return: 0 for successful release
> + */
>  static int iio_chrdev_release(struct inode *inode, struct file *filp)
>  {
>  	struct iio_dev *indio_dev = container_of(inode->i_cdev,
> 

