Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from co9ehsobe004.messaging.microsoft.com ([207.46.163.27]:44931
	"EHLO co9outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751070Ab3ARXCM (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 18 Jan 2013 18:02:12 -0500
From: "Getz, Robin" <robin.getz@analog.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
	Alessandro Rubini <rubini@gnudd.com>,
	"greg@kroah.com" <greg@kroah.com>
Subject: Re: [PATCH] IIO ADC support for AD7923
Date: Fri, 18 Jan 2013 18:02:12 -0500
CC: "christophe.leroy@c-s.fr" <christophe.leroy@c-s.fr>,
	"jic23@cam.ac.uk" <jic23@cam.ac.uk>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"patrick.vasseur@c-s.fr" <patrick.vasseur@c-s.fr>
References: <50F199F7.7020600@metafoo.de> <20130117171100.GA24398@mail.gnudd.com> <50F83695.506@metafoo.de>
In-Reply-To: <50F83695.506@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Message-ID: <201301181802.14382.robin.getz@analog.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu 17 Jan 2013 12:36, Lars-Peter Clausen pondered:
> On 01/17/2013 06:11 PM, Alessandro Rubini wrote:
> > [...]
> >
> > But yes, you are right. I'm working on another I/O subsystem. We are
> > gong to release zio-1.0 in a few days, because the thing is mature
> > and used in production.

Neither means it's a good idea for upstream :)

> Still it's a very bad idea to have two subsystem which have a huge overlap
> in both functionality and targeted devices. It will gives us all lots of
> headaches later on. As IIO continues to evolve it will get support for some
> of the features that only ZIO supports at the moment and as ZIO grows it
> will get support for features currently only supported by IIO. So in the
> end we have two frameworks for the very same purpose.

I want to strongly agree with Lars-Peter. Lets work together on one thing - 
which tries to solve all the our system level issues. As an end user - I 
don't want to re-write userspace for multiple interfaces to the same 
underlying ADC/DACs.

I don't know how Greg feels about another subsystem in the kernel which 
duplicates existing functionality/targetted devices - but it doesn't sound 
like a good idea to me.

> > I hope to meet you in person at fosdem and be able to talk over a beer
> > or two.
>
> Looking forward to meeting you :)

Hopefully you can come to some logical conclusions over a friendly beverage. 
Even if you can't decide on how to merge things (plan for adding missing 
features from one to the other), maybe it's just deciding on how to get as 
much reuse as possible (duplication of device register and bit definitions?)

-Robin

