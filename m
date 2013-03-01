Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.active-venture.com ([67.228.131.205]:51642 "EHLO
	mail.active-venture.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751121Ab3CARUy (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 1 Mar 2013 12:20:54 -0500
Date: Fri, 1 Mar 2013 09:20:59 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: linux-iio@vger.kernel.org
Subject: Re: IIO_BUFFER - IIO_TRIGGERED_BUFFER circular dependency
Message-ID: <20130301172059.GA23500@roeck-us.net>
References: <20130301043222.GA5606@roeck-us.net>
 <5130AF56.8020407@metafoo.de>
 <20130301144111.GA31945@roeck-us.net>
 <5130C37D.6050907@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <5130C37D.6050907@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, Mar 01, 2013 at 04:04:29PM +0100, Lars-Peter Clausen wrote:
> On 03/01/2013 03:41 PM, Guenter Roeck wrote:
> > On Fri, Mar 01, 2013 at 02:38:30PM +0100, Lars-Peter Clausen wrote:
> >> On 03/01/2013 05:32 AM, Guenter Roeck wrote:
> >>> Hi all,
> >>>
> >>> IIO_TRIGGERED_BUFFER depends on IIO_BUFFER because of:
> >>>
> >>> drivers/iio/industrialio-triggered-buffer.c:20:16: error:
> >>> ‘iio_sw_buffer_preenable’ undeclared here (not in a function)
> >>>
> >>> On the other side, it is often selected as follows.
> >>>
> >>> 	select IIO_TRIGGERED_BUFFER if (IIO_BUFFER)
> >>>
> >>> For that reason, selecting IIO_BUFFER in the IIO_TRIGGERED_BUFFER declaration
> >>> results in a circular dependency. Sometimes the "if (IIO_BUFFER)" when selecting
> >>> IIO_TRIGGERED_BUFFER is missing, though, which can result in the compile error.
> >>>
> >>> What is the proper solution ?
> >>> - Add "if (IIO_BUFFER)" whenever IIO_TRIGGERED_BUFFER is selected
> >>> or
> >>> - Remove "if (IIO_BUFFER)" from IIO_TRIGGERED_BUFFER selection and add "select
> >>>   IIO_BUFFER" to the IIO_TRIGGERED_BUFFER declaration
> >>>
> >>> I would prefer the latter to solve the problem for good.
> >>
> >> Hi,
> >>
> >> This is a bit tricky, some drivers have optional buffer support, so they
> >> only select the helper module if buffer support is enabled, since they don't
> >> use the helper module if buffer support is disabled. Other driver though
> >> always want buffer support so they select the helper module unconditionally.
> >> So far it was the responsibility of the driver's Kconfig entry to make sure
> >> that if it selects IIO_TRIGGERED_BUFFER it needs to make sure that
> >> IIO_BUFFER is also selected. As far as I can see all drivers do this
> >> currently. Which one breaks things for you?
> >>
> > It is a randconfig thing, so it breaks in some of my nightly randconfig builds,
> > and it has also been reported as build failure in the official builds. I can dig
> > out some affected configurations and send it to you if you like.
> 
> Yes that would be great, thanks.
> 
> > but the gist of
> > it is that IIO_TRIGGERED_BUFFER can be selected without IIO_BUFFER, but depends
> > on it. That just isn't correct. Of course, the other option might be to make
> > IIO_TRIGGERED_BUFFER dependent on IIO_BUFFER. Would that be acceptable ?
> > 
> 
> That won't work, you can overwrite 'depends on' by selecting the symbol.
> 
> But the reason why there is a cyclic dependency is not because of the
> 'select IIO_TRIGGERED_BUFFER if (IIO_BUFFER)' but rather because
> IIO_TRIGGERED_BUFFER is in an 'if IIO_BUFFER' section. Moving it out there
> fixes the cyclic dependency error. But creates a recursive dependency warning.
> 
> I think we could avoid this warning by introducing a new symbol. E.g.
> IIO_BUFFER_INTERN (bad name). IIO_BUFFER_INTERN won't be user selectable. It
> will be selected by IIO_BUFFER and IIO_TRIGGERED_BUFFER and if it is
> selected buffer support is built. E.g. something like this:
> 
Agreed, that would also solve the need of selecting IIO_BUFFER as well if
IIO_TRIGGERED_BUFFER is selected. For now I solved the problem with the two
patches I submitted, so assuming those are accepted I guess this one or
something similar can wait for -next.

Thanks,
Guenter
