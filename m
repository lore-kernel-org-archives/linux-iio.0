Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from szxga07-in.huawei.com ([45.249.212.35]:52888 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S932164AbeGARHy (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 1 Jul 2018 13:07:54 -0400
Date: Sun, 1 Jul 2018 18:07:40 +0100
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Lars-Peter Clausen <lars@metafoo.de>
CC: Daniel Baluta <daniel.baluta@gmail.com>,
        <linux-iio@vger.kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Eugen Hristev <eugen.hristev@microchip.com>
Subject: Re: Potential IIO meeting / future directions discussion at ELCE
 2018 - Edinburgh 22-24 Oct
Message-ID: <20180701180740.000076e2@huawei.com>
In-Reply-To: <39e72ff3-47a6-e895-cffc-7f7aefe3b7b1@metafoo.de>
References: <20180628152425.00007abc@huawei.com>
        <59135b1f-0020-3132-c283-38893ffb860e@metafoo.de>
        <CAEnQRZA16Abt6GYYVk1rKGqTLWT7hPcw0=iMQLqkWefp=JekOg@mail.gmail.com>
        <20180701120927.000061dc@huawei.com>
        <39e72ff3-47a6-e895-cffc-7f7aefe3b7b1@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sun, 1 Jul 2018 17:16:35 +0200
Lars-Peter Clausen <lars@metafoo.de> wrote:

> On 07/01/2018 01:09 PM, Jonathan Cameron wrote:
> > On Fri, 29 Jun 2018 10:48:01 +0300
> > Daniel Baluta <daniel.baluta@gmail.com> wrote:
> >   
> >> On Thu, Jun 28, 2018 at 8:11 PM, Lars-Peter Clausen <lars@metafoo.de> wrote:  
> >>> On 06/28/2018 04:24 PM, Jonathan Cameron wrote:    
> >>>> Hi All,
> >>>>
> >>>> I know at least a few IIO developers are likely to be at the Embedded Linux
> >>>> Conference Europe in a few months time.   Hence this email is exploring the
> >>>> possibility of us doing something we have never done for IIO before and have
> >>>> a formal meet up.   I would propose the topics to discuss would be loosely
> >>>> around future directions for IIO development.  This might consist of actual
> >>>> proposals or simply discussion of pain points.
> >>>>
> >>>> I'm not sure how long a session would be sensible, but one possibility is
> >>>> to propose it as a BoF as that fits in their standard schedule without needing
> >>>> any additional organization - I think by default that only gives us an hour or
> >>>> so.  However, the deadline to propose one of those is this Sunday so things are
> >>>> little tight.  We don't need a fully planned schedule but it would be good to
> >>>> have made a start.  If we decide to do this I'll write an abstract and submit it.
> >>>>
> >>>> So I'm looking for topics and some idea of who is going to be there
> >>>> or might be persuaded to make the trip!    
> >>> I'll be at ELCE and I'm very interested in sitting down and having a longer
> >>> discussion about the state of the framework, potential future developments,
> >>> their requirements and how to get there.
> >>>
> >>> I think a BoF would be good as a discussion starter and then maybe follow up
> >>> on that with the people who are interested and have a more focused discussion.    
> >>
> >> I'll be there. Although, I'm mainly involved now with IIO via Outreachy/GSoC
> >> I think it is a good idea to have the meeting in the form of a BoF.
> >>
> >> CC-ing Eugen, I noticed he has done a lot of work recently in the IIO area.
> >>
> >> thanks,
> >> Daniel.  
> > 
> > Cool - so it sounds like there is enough interest (given the very short notice!)
> > to apply for a BoF.  The tricky bit is I need to put together an abstract by
> > later today.
> > 
> > So off the top of my head topics that come to mind are:
> > 
> > 1. Userspace ABI pain points - the recent extensive discussions around the energy
> >    meters have certainly shown there are some nasty corners.  The currently open
> >    question about floating point support is also interesting (though we may well have
> >    come to a conclusion about that long before October).  
> 
> Some things about ABI
> 
> 1.a. Is cross device ABI achievable or are we moving towards IIO being a
> simple userspace and kernelspace bridge with each driver having its own
> ABI? Is IIO the new drivers/misc?

Good points. I'll work them into the abstract.

Hmm. 900 word limit so it's not going to give much detail - but hopefully
just enough to get the right crowd there for the discussion!

Jonathan
> 
> 1.c. Beyond demos and toys. Is IIO suitable for real-world applications?
> 
> >  
> > 2. High performance usecases - (Lars leading this one if he is willing)
> >    DMA buffers and moving that infrastructure forward.  There is a lot of
> >    out of kernel code around this currently, it would be nice to drag it in
> >    once we are sure on how it should work long term!
> > 
> > 3. Missing in kernel consumer infrastructure.  We never implemented consumer
> >    interfaces for events.  I assume this may be because no one cares, but
> >    it does sometimes feel like we are working around that in some of the
> >    use cases rather than just fixing it.
> > 
> > 4. The Front end / back end split. This is most interesting for SoC ADCs where
> >    we currently put out an IIO interface to userspace that no one cares about
> >    (sometimes).  The plan was always to make that optional.  Would be interesting
> >    to explore pushing this forward.  This includes things like the little used
> >    available callbacks.
> > 
> > 5. General performance questions - can we narrow the gap with the dodgy userspace
> >    hacks?
> > 
> > N. General process discussion - Is the current maintainer / review process
> >    quick enough that it isn't causing anyone too much pain?  What can we do
> >    better?  I'm always happy to get some feedback on this btw.
> > 
> > So if at all possible, what I'm looking for is additional (of better) ideas to put
> > down as somewhat of a placeholder to show we have lots to talk about.
> > 
> > If not I'll throw the above in with some editing.
> > 
> > Jonathan
> >   
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


