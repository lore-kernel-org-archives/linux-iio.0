Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:56333 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751153AbbCNSyE (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 14 Mar 2015 14:54:04 -0400
Message-ID: <550483C9.9040702@kernel.org>
Date: Sat, 14 Mar 2015 18:54:01 +0000
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
I was hoping to get some time to look at better ways of fixing this,
but what you have here is a definite improvement so we'll take this
for now and kick working the best fix out into the long grass.

The whole balance of what is in the release function here vs isn't
is wrong here.

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

