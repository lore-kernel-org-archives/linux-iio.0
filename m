Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:36854 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754994AbdFXU5r (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 24 Jun 2017 16:57:47 -0400
Date: Sat, 24 Jun 2017 21:57:42 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: linux-iio@vger.kernel.org
Subject: Re: [PATCH 38/38] iio: drop iio_info.driver_module and
 iio_trigger_ops.owner.
Message-ID: <20170624215742.1bbb516d@kernel.org>
In-Reply-To: <87aa917c-8e89-83f5-0ca4-ca8bb40e9b18@metafoo.de>
References: <20170529155154.22580-1-jic23@kernel.org>
        <20170529155154.22580-39-jic23@kernel.org>
        <87aa917c-8e89-83f5-0ca4-ca8bb40e9b18@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, 12 Jun 2017 18:16:56 +0200
Lars-Peter Clausen <lars@metafoo.de> wrote:

> On 05/29/2017 05:51 PM, Jonathan Cameron wrote:
> > diff --git a/include/linux/iio/trigger.h b/include/linux/iio/trigger.h
> > index 2e1800ad265b..ff2b7c7a9652 100644
> > --- a/include/linux/iio/trigger.h
> > +++ b/include/linux/iio/trigger.h
> > @@ -34,7 +34,6 @@ struct iio_trigger;  
> 
> Update to the kernel-doc is missing here.
Just so I don't forget.  This patch also needs to remove the
bit of code that insists there is an iio_trigger_ops so that
the owner field can be read.

Will do a new version, perhaps tomorrow.

Thanks,

Jonathan
> 
> >   * instances of a given device.
> >   **/
> >  struct iio_trigger_ops {
> > -	struct module *owner;
> >  	int (*set_trigger_state)(struct iio_trigger *trig, bool state);
> >  	int (*try_reenable)(struct iio_trigger *trig);
> >  	int (*validate_device)(struct iio_trigger *trig,
> >  
> 

