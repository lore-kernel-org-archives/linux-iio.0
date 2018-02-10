Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:40444 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751040AbeBJPvi (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 10 Feb 2018 10:51:38 -0500
Date: Sat, 10 Feb 2018 15:51:35 +0000
From: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Pavel Roskin <plroskin@gmail.com>, linux-iio@vger.kernel.org
Subject: Re: Best practices for sending digital data
Message-ID: <20180210155135.1be34ebc@archlinux>
In-Reply-To: <df0652c1-80cf-bf69-252d-0859a7cff7c8@metafoo.de>
References: <CAN_72e2eEoLKNUqte=xmUCyLj6L+asJVL9k_rqXGJd1ky7v=Cw@mail.gmail.com>
        <20180208101837.00001c55@huawei.com>
        <df0652c1-80cf-bf69-252d-0859a7cff7c8@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, 8 Feb 2018 18:51:52 +0100
Lars-Peter Clausen <lars@metafoo.de> wrote:

> On 02/08/2018 11:18 AM, Jonathan Cameron wrote:
> > On Wed, 7 Feb 2018 14:15:30 -0800
> > Pavel Roskin <plroskin@gmail.com> wrote:>>  
> >> I understand that the IIO layer tries to be helpful with
> >> standardization, but I believe it's too restrictive.
> >>  
> > So the question is what is the alternative to adding new channel types
> > when they are needed?
> >   
> [...]
> > 2) We add magic 'user defined types'.  The problem then is that
> >    the primary purpose of not just throwing all the drivers in with
> >    their own interfaces is gone.  There is no standardization at all and
> >    every device needs it's own userspace code.  
> 
> Just want to add that this is a 'misc' device and this option is still on
> the table. If you think the standard IIO ABI is too restrictive and you'd
> rather have a device specific ABI you can write a misc driver for your
> device. Or directly write a userspace driver.
> 
> The preferred solution of course is to work with the IIO framework and come
> up with solutions for the shortcomings.

Good point!   It is always a trade off between getting something out
that is good for your own personal use case and having something more
generic and useful to a wider audience who often don't want to know exactly
what hardware they are dealing with.  Frameworks sometimes make things
harder in the kernel, but that trades off against more consistency from
the userspace side of things.

Jonathan

> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

