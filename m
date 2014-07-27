Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:54868 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752069AbaG0QkC (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Sun, 27 Jul 2014 12:40:02 -0400
Message-ID: <53D52BF3.6020903@kernel.org>
Date: Sun, 27 Jul 2014 17:42:27 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Martin Fuzzey <mfuzzey@parkeon.com>, linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: core: Fix double free.
References: <20140721132215.11583.81979.stgit@localhost>
In-Reply-To: <20140721132215.11583.81979.stgit@localhost>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 21/07/14 14:22, Martin Fuzzey wrote:
> When an error occured during event registration memory was freed twice
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
Good catch.

Applied to the fixes-togreg branch of iio.git and marked
for stable.

Given the timing this might end up waiting until after the upcoming merge
windows closes. It's been there a long time with you being the first to notice
so I'm not that fussed about rushing it out and annoying Linus!

Jonathan
> ---
>   drivers/iio/industrialio-core.c  |    5 +++--
>   drivers/iio/industrialio-event.c |    1 +
>   2 files changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> index 4b1f375..fa06197 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -828,8 +828,7 @@ static int iio_device_add_channel_sysfs(struct iio_dev *indio_dev,
>    * @attr_list: List of IIO device attributes
>    *
>    * This function frees the memory allocated for each of the IIO device
> - * attributes in the list. Note: if you want to reuse the list after calling
> - * this function you have to reinitialize it using INIT_LIST_HEAD().
> + * attributes in the list.
>    */
>   void iio_free_chan_devattr_list(struct list_head *attr_list)
>   {
> @@ -837,6 +836,7 @@ void iio_free_chan_devattr_list(struct list_head *attr_list)
>
>   	list_for_each_entry_safe(p, n, attr_list, l) {
>   		kfree(p->dev_attr.attr.name);
> +		list_del(&p->l);
>   		kfree(p);
>   	}
>   }
> @@ -917,6 +917,7 @@ static void iio_device_unregister_sysfs(struct iio_dev *indio_dev)
>
>   	iio_free_chan_devattr_list(&indio_dev->channel_attr_list);
>   	kfree(indio_dev->chan_attr_group.attrs);
> +	indio_dev->chan_attr_group.attrs = NULL;
>   }
>
>   static void iio_dev_release(struct device *device)
> diff --git a/drivers/iio/industrialio-event.c b/drivers/iio/industrialio-event.c
> index bfbf4d4..ad7a35f 100644
> --- a/drivers/iio/industrialio-event.c
> +++ b/drivers/iio/industrialio-event.c
> @@ -492,6 +492,7 @@ int iio_device_register_eventset(struct iio_dev *indio_dev)
>   error_free_setup_event_lines:
>   	iio_free_chan_devattr_list(&indio_dev->event_interface->dev_attr_list);
>   	kfree(indio_dev->event_interface);
> +	indio_dev->event_interface = NULL;
>   	return ret;
>   }
>
>

