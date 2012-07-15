Return-Path: <lars@metafoo.de>
Message-ID: <50032F46.9040904@metafoo.de>
Date: Sun, 15 Jul 2012 22:59:50 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Hartmut Knaack <knaack.h@gmx.de>
CC: linux-iio@vger.kernel.org, jic23@kernel.org
Subject: Re: [PATCH 1/2] fixes for adt7410
References: <50032AC1.1030207@gmx.de>
In-Reply-To: <50032AC1.1030207@gmx.de>
Content-Type: text/plain; charset=ISO-8859-15
List-ID: <linux-iio@vger.kernel.org>

On 07/15/2012 10:40 PM, Hartmut Knaack wrote:
> This patch adds some checks prior to accessing device attribute lists in industrialio-event.c.
> 
> Signed-off-by: Harmut Knaack <knaack.h@gmx.de>
> ---
> diff --git a/drivers/iio/industrialio-event.c b/drivers/iio/industrialio-event.c
> index b49059d..fe68e90 100644
> --- a/drivers/iio/industrialio-event.c
> +++ b/drivers/iio/industrialio-event.c
> @@ -425,11 +425,13 @@ int iio_device_register_eventset(struct iio_dev *indio_dev)
>                 *attrcount_orig);
>      attrn = attrcount_orig;
>      /* Add all elements from the list. */
> -    list_for_each_entry(p,
> -                &indio_dev->event_interface->dev_attr_list,
> -                l)
> -        indio_dev->event_interface->group.attrs[attrn++] =
> -            &p->dev_attr.attr;
> +    if (indio_dev->event_interface->dev_attr_list.next)

next should never be NULL. If it is this means that INIT_LIST_HEAD has not
been called on the list and the correct fix is to make sure that it is called.

> +        list_for_each_entry(p,
> +                &indio_dev->event_interface->dev_attr_list,
> +                l)
> +            indio_dev->event_interface->group.attrs[attrn++] =
> +                &p->dev_attr.attr;
> +
>      indio_dev->groups[indio_dev->groupcounter++] =
>          &indio_dev->event_interface->group;
>  
> @@ -447,7 +449,9 @@ void iio_device_unregister_eventset(struct iio_dev *indio_dev)
>  {
>      if (indio_dev->event_interface == NULL)
>          return;
> -    __iio_remove_event_config_attrs(indio_dev);
> -    kfree(indio_dev->event_interface->group.attrs);
> +    if (indio_dev->event_interface->dev_attr_list.next)
> +        __iio_remove_event_config_attrs(indio_dev);

Same here.

> +    if (indio_dev->event_interface->group.attrs)
> +        kfree(indio_dev->event_interface->group.attrs);

kfree does a check for NULL itself.

>      kfree(indio_dev->event_interface);
>  }
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
