Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:34925 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751488AbbBUSxr (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 21 Feb 2015 13:53:47 -0500
Message-ID: <54E8D439.7010701@kernel.org>
Date: Sat, 21 Feb 2015 18:53:45 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Martin Fuzzey <mfuzzey@parkeon.com>, linux-iio@vger.kernel.org
Subject: Re: [RESEND PATCH] iio: core: Fix double free.
References: <20150219141744.27201.80796.stgit@localhost>
In-Reply-To: <20150219141744.27201.80796.stgit@localhost>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 19/02/15 14:17, Martin Fuzzey wrote:
> When an error occurred during event registration memory was freed twice
> resulting in kernel memory corruption and a crash in unrelated code.
> 
> The problem was caused by
> 	iio_device_unregister_eventset()
> 	iio_device_unregister_sysfs()
> 
> being called twice, once on the error path and then
> again via iio_dev_release().
> 
> Fix this by making these two functions idempotent so they
> may be called multiple times.
> 
> The problem was observed before applying
> 	78b33216 iio:core: Handle error when mask type is not separate
> 
> Signed-off-by: Martin Fuzzey <mfuzzey@parkeon.com>
Good find.  I'm trying to get my head around why those functions are
in the release rather than the unregister.  Need to think on this
a little more to work out if this is the right fix or is papering
over a nastier issue.

Jonathan
> ---
>  drivers/iio/industrialio-core.c  |    5 +++--
>  drivers/iio/industrialio-event.c |    1 +
>  2 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> index af3e76d..f009d05 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -832,8 +832,7 @@ static int iio_device_add_channel_sysfs(struct iio_dev *indio_dev,
>   * @attr_list: List of IIO device attributes
>   *
>   * This function frees the memory allocated for each of the IIO device
> - * attributes in the list. Note: if you want to reuse the list after calling
> - * this function you have to reinitialize it using INIT_LIST_HEAD().
> + * attributes in the list.
>   */
>  void iio_free_chan_devattr_list(struct list_head *attr_list)
>  {
> @@ -841,6 +840,7 @@ void iio_free_chan_devattr_list(struct list_head *attr_list)
>  
>  	list_for_each_entry_safe(p, n, attr_list, l) {
>  		kfree(p->dev_attr.attr.name);
> +		list_del(&p->l);
>  		kfree(p);
>  	}
>  }
> @@ -921,6 +921,7 @@ static void iio_device_unregister_sysfs(struct iio_dev *indio_dev)
>  
>  	iio_free_chan_devattr_list(&indio_dev->channel_attr_list);
>  	kfree(indio_dev->chan_attr_group.attrs);
> +	indio_dev->chan_attr_group.attrs = NULL;
>  }
>  
>  static void iio_dev_release(struct device *device)
> diff --git a/drivers/iio/industrialio-event.c b/drivers/iio/industrialio-event.c
> index 0c1e37e..35c02ae 100644
> --- a/drivers/iio/industrialio-event.c
> +++ b/drivers/iio/industrialio-event.c
> @@ -493,6 +493,7 @@ int iio_device_register_eventset(struct iio_dev *indio_dev)
>  error_free_setup_event_lines:
>  	iio_free_chan_devattr_list(&indio_dev->event_interface->dev_attr_list);
>  	kfree(indio_dev->event_interface);
> +	indio_dev->event_interface = NULL;
>  	return ret;
>  }
>  
> 

