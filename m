Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:35747 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752956AbcEDOga (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 4 May 2016 10:36:30 -0400
Subject: Re: trigger->ops structure optional?
To: Gwendal Grignou <gwendal@chromium.org>,
	Lars-Peter Clausen <lars@metafoo.de>, pmeerw@pmeerw.net
References: <CAMHSBOWLL=O=gRwUhepuKzyGwMeiVfDw2N2A7FwQBwS-_yk+fQ@mail.gmail.com>
Cc: linux-iio@vger.kernel.org, Dmitry Torokhov <dtor@google.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <3c55b363-5b1f-37c9-84ed-09dc8ca43154@kernel.org>
Date: Wed, 4 May 2016 09:19:34 +0100
MIME-Version: 1.0
In-Reply-To: <CAMHSBOWLL=O=gRwUhepuKzyGwMeiVfDw2N2A7FwQBwS-_yk+fQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 03/05/16 17:22, Gwendal Grignou wrote:
> When I decided to compile a driver with a trigger as a module, I
> realized that I needed to add a trigger ops structure with the .owner
> field set to THIS_MODULE.
> The reason is iio_trigger_put() calls module_put(trig->ops->owner),
> which is a noop if the driver is compiled within the kernel.
> Otherwise, trigger->ops is considered optional.
It's only a partial protection as module removal can still be forced,
but it does stop 'accidental' removals when in use.

Indeed, the ops structure in general is not optional though as you
say all the function pointers are.  It is rather unusual not
to have a set_state callback though as most sources of triggers can
be disabled at source (exception perhaps being interrupt sources
from external sources...)
> 
> We could add a test there to not call module_put() if ops is NULL, but
> we wouldn't have the module refcount protection anymore; the trigger
> could be removed while still in use given iio_trigger_unregister()
> does not check if the trigger is still in use.
> 
> To address that issue, should we make trigger->ops mandatory - its
> function members could still be optional?
> If we go this way, shall we go even further and fold the ops structure
> within iio_trigger?
The purpose for the separation is to keep the function pointers in a
constant structure rather than alongside elements that are modified.

Standard practice from a simple security point of view if nothing else.

So fundamentally trigger_ops is not optional and we aren't going to
merge it into struct iio_trigger.

Jonathan

> 
> Gwendal.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

