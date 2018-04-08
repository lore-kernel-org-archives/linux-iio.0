Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([46.235.226.198]:56998 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752487AbeDHPkV (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 8 Apr 2018 11:40:21 -0400
Date: Sun, 8 Apr 2018 16:40:17 +0100
From: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To: Tom Lebreux <tomlebreux@cock.li>
Cc: linux-iio@vger.kernel.org
Subject: Re: Moving ad2s90 out of staging
Message-ID: <20180408164003.6c0e7242@archlinux>
In-Reply-To: <6d00d7b9-dbae-b542-f670-473d326fa01b@cock.li>
References: <63f2588d-0edd-9115-74a4-d0743fb358c1@cock.li>
        <20180317222001.5846a58f@archlinux>
        <6d00d7b9-dbae-b542-f670-473d326fa01b@cock.li>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

> 
> > The velocity input could be connected to any normal ADC.  At that point we
> > could support it by using the consumer interfaces for IIO reasonably well.
> > However, for now just stick to the absolute position that we can get digitally!
> > 
> > As for other things.
> > IIO_CHAN_INFO_RAW only seems a bit odd given the nature of resolvers
> > means we know the 'units' and hence can provide the scale.
> >   
> Are you saying we should provide the scale in addition to the RAW info? I'm
> not sure what the value of the scale should be in this case.
> 

Given we have rotation defined (indirectly via angular velocity) as being 
in degrees (IIRC) it will be whatever we need to multiply the raw register
value by to get an answer in degrees.

Jonathan
