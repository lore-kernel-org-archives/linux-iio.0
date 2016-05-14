Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:35678 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753385AbcENRVc (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 14 May 2016 13:21:32 -0400
Subject: Re: staging:iio:triggers introduce iio_trigger_ops to take const bits
 out of iio_trig_structure.
To: Dan Carpenter <dan.carpenter@oracle.com>, jic23@cam.ac.uk
References: <20160510080304.GA5874@mwanda>
Cc: linux-iio@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <ba1a12fd-0574-8d04-8c8f-982fb09df3e4@kernel.org>
Date: Sat, 14 May 2016 18:21:30 +0100
MIME-Version: 1.0
In-Reply-To: <20160510080304.GA5874@mwanda>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/05/16 09:03, Dan Carpenter wrote:
> Hello Jonathan Cameron,
> 
> The patch d29f73db7910: "staging:iio:triggers introduce
> iio_trigger_ops to take const bits out of iio_trig_structure." from
> Aug 12, 2011, leads to the following static checker warning:
> 
> 	drivers/iio/industrialio-trigger.c:376 iio_trigger_write_current()
> 	error: we previously assumed 'indio_dev->trig->ops' could be null (see line 367)
> 
> drivers/iio/industrialio-trigger.c
>    360  
>    361          if (trig && trig->ops && trig->ops->validate_device) {
>                             ^^^^^^^^^
> New check.
> 
>    362                  ret = trig->ops->validate_device(trig, indio_dev);
>    363                  if (ret)
>    364                          return ret;
>    365          }
>    366  
>    367          indio_dev->trig = trig;
>    368  
>    369          if (oldtrig) {
>    370                  if (indio_dev->modes & INDIO_EVENT_TRIGGERED)
>    371                          iio_trigger_detach_poll_func(oldtrig,
>    372                                                       indio_dev->pollfunc_event);
>    373                  iio_trigger_put(oldtrig);
>    374          }
>    375          if (indio_dev->trig) {
>    376                  iio_trigger_get(indio_dev->trig);
>                         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> Dereferenced inside the function without checking.
> 
>    377                  if (indio_dev->modes & INDIO_EVENT_TRIGGERED)
>    378                          iio_trigger_attach_poll_func(indio_dev->trig,
>    379                                                       indio_dev->pollfunc_event);
>    380          }
> 
Good point - trig->ops is not optional at all (exactly as it has the module handle).  
Not exactly a new issue but will good to clean it up at some point.

Funnily enough this exact question got raised recently and I foolishly though it
was just a documentation thing, whereas clearly quite a bit of the code in here
makes it 'look' optional when it never was.

We probably should sanity check and fault out in any attempt to register
a trigger without an ops structure though.

I'll put a patch together shortly to do this.

Jonathan
> regards,
> dan carpenter
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

