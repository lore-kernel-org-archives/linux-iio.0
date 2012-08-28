Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:40291 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751199Ab2H1Tlm (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 28 Aug 2012 15:41:42 -0400
Message-ID: <503D1EF4.5070706@kernel.org>
Date: Tue, 28 Aug 2012 20:41:40 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Peter Meerwald <pmeerw@pmeerw.net>
CC: Jonathan Cameron <jic23@cam.ac.uk>, linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: fix typos
References: <1345985019-24288-1-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1345985019-24288-1-git-send-email-pmeerw@pmeerw.net>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 08/26/2012 01:43 PM, Peter Meerwald wrote:
> Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
merge to togreg branch.
> ---
>  drivers/iio/industrialio-core.c |    2 +-
>  include/linux/iio/iio.h         |    6 +++---
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> index 2ec266e..47c1ffa 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -729,7 +729,7 @@ static int iio_device_register_sysfs(struct iio_dev *indio_dev)
>  	attrcount = attrcount_orig;
>  	/*
>  	 * New channel registration method - relies on the fact a group does
> -	 * not need to be initialized if it is name is NULL.
> +	 * not need to be initialized if its name is NULL.
>  	 */
>  	if (indio_dev->channels)
>  		for (i = 0; i < indio_dev->num_channels; i++) {
> diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
> index be82936..f323e7b 100644
> --- a/include/linux/iio/iio.h
> +++ b/include/linux/iio/iio.h
> @@ -164,7 +164,7 @@ ssize_t iio_enum_write(struct iio_dev *indio_dev,
>   * IIO_ENUM() - Initialize enum extended channel attribute
>   * @_name:	Attribute name
>   * @_shared:	Whether the attribute is shared between all channels
> - * @_e:		Pointer to a iio_enum struct
> + * @_e:		Pointer to an iio_enum struct
>   *
>   * This should usually be used together with IIO_ENUM_AVAILABLE()
>   */
> @@ -180,9 +180,9 @@ ssize_t iio_enum_write(struct iio_dev *indio_dev,
>  /**
>   * IIO_ENUM_AVAILABLE() - Initialize enum available extended channel attribute
>   * @_name:	Attribute name ("_available" will be appended to the name)
> - * @_e:		Pointer to a iio_enum struct
> + * @_e:		Pointer to an iio_enum struct
>   *
> - * Creates a read only attribute which list all the available enum items in a
> + * Creates a read only attribute which lists all the available enum items in a
>   * space separated list. This should usually be used together with IIO_ENUM()
>   */
>  #define IIO_ENUM_AVAILABLE(_name, _e) \
> 
