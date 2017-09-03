Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:56866 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751611AbdICMNd (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 3 Sep 2017 08:13:33 -0400
Date: Sun, 3 Sep 2017 13:13:28 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Peter Rosin <peda@axentia.se>
Cc: "Gustavo A. R. Silva" <garsilva@embeddedor.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH] iio: multiplexer: add NULL check on devm_kzalloc() and
 devm_kmemdup() return values
Message-ID: <20170903131328.78a5d08a@archlinux>
In-Reply-To: <aaff7b8f-5fc3-e811-b334-42d323dfbf2e@axentia.se>
References: <20170707045311.GA4535@embeddedgus>
        <df6ae9c6-8ac7-368b-a1c2-4403387df02b@axentia.se>
        <0ba9b76f-41f8-3171-2eb7-d9abbe106674@axentia.se>
        <20170709181023.54458b6c@kernel.org>
        <aaff7b8f-5fc3-e811-b334-42d323dfbf2e@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sat, 26 Aug 2017 08:09:43 +0200
Peter Rosin <peda@axentia.se> wrote:

> On 2017-07-09 19:10, Jonathan Cameron wrote:
> > On Fri, 7 Jul 2017 11:26:35 +0200
> > Peter Rosin <peda@axentia.se> wrote:
> >   
> >> On 2017-07-07 06:57, Peter Rosin wrote:  
> >>> On 2017-07-07 06:53, Gustavo A. R. Silva wrote:    
> >>>> Check return values from call to devm_kzalloc() and devm_kmemup()    
> >>>
> >>> If someone cares enough: s/devm_kmemup/evm_kmemdup/    
> >>
> >> Strange, there seems to be some inherent shortage of 'd' characters...
> >>
> >> Cheers,
> >> pea :-)
> >>  
> >>>     
> >>>> in order to prevent a NULL pointer dereference.
> >>>>
> >>>> This issue was detected using Coccinelle and the following semantic patch:
> >>>>
> >>>> @@
> >>>> expression x;
> >>>> identifier fld;
> >>>> @@
> >>>>
> >>>> * x = devm_kzalloc(...);
> >>>>    ... when != x == NULL
> >>>>    x->fld
> >>>>
> >>>> Cc: Peter Rosin <peda@axentia.se>
> >>>> Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>    
> >>>
> >>> Either way,
> >>>
> >>> Reviewed-by: Peter Rosin <peda@axentia.se>
> >>>
> >>> Thanks!
> >>>  
> > The relevant patch adding the file in questions hasn't yet worked it's
> > way back to the iio tree so I can't apply this until it does.
> > 
> > That is likely to be a few weeks away yet.  Please give me a poke if
> > I seem to have forgotten it!  
> 
> Hi Jonathan!
> 
> I saw a patch from Christophe JAILLET [1] and it seemed familiar so I
> did a bit of digging. Now, I did go back and check this a couple of
> weeks after you request, but iio-mux.c still wasn't in the iio tree,
> and then I did forgot about it. Sorry. But here's the poke...
> 

Applied.  Thanks - this one had completely dropped off the back of my
patch queue. Oops.

Jonathan

> Cheers,
> Peter
> 
> [1] https://lkml.org/lkml/2017/8/26/3
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

