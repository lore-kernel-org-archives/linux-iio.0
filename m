Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([46.235.226.198]:48314 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725726AbeLBFV4 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 2 Dec 2018 00:21:56 -0500
Date: Sat, 1 Dec 2018 18:08:47 +0000
From: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To: Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Cc: linux-iio@vger.kernel.org, kernel-usp@googlegroups.com
Subject: Re: Questions about the contributing process
Message-ID: <20181201180847.1394579b@archlinux>
In-Reply-To: <CAHd-oW4U-BGs+Enf07SP_XXWDPv4bzOM6KM83FX54gKWpW7hXw@mail.gmail.com>
References: <CAHd-oW4U-BGs+Enf07SP_XXWDPv4bzOM6KM83FX54gKWpW7hXw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sat, 1 Dec 2018 14:51:07 -0200
Matheus Tavares Bernardino <matheus.bernardino@usp.br> wrote:

> Hello everyone
Hi Matheus.
> 
> It's been a few months since I started sending patches, but there are
> still some points about the process that I do not quite understand. I
> would be really grateful if anyone could help clarify them for me.
> 
> 1) How do we credit more than one person as an author? Here at the
> University of São Paulo we sometimes develop patches in pair
> programming, and I don't really know if in these cases we should just
> add the S-o-B of both authors or add the "Co-Developed-by" tag (or
> something else). Also, is this something specific to each subsystem?

It's certainly an interesting one and an area we probably need to
have a solution for in general given that methodologies such
as pair programming are becoming more common.

For IIO I have no real problem with multiple sign offs though slight
preference for having that and Co-Developed-by to explain the
additional signed-off-by is part of the actual developer's
Developer Certificate of Origin rather than one indicating having
'handled the patch' line mine is...

I've not often come across this one but see it's in submitting-patches.rst
and is nice and clear so I'll be pushing for people to do this in future! 

> 
> 2) Does iio have a test infrastructure? I know there are autobuilders
> playing with the iio.git testing branch, but how does it work? Also,
> if there is no test beyond building, is there some plan to make such
> an infrastructure in the near future?

This is indeed an area we are very weak on.  Partly this is about the
difficulty of having any sort of centralised test facility given the
huge number of devices that would be needed.  Hence it comes down
to individual developers testing patches that touch their drivers.
I assume that some of the larger companies have automated test setups
but don't actually know that.

I've thought about building a small CI setup myself but never actually
had the time to get it all wired up.  A certain class of device would
be fairly easy, though it would still require proper wiring rather than
the bunch of probes I often end up with whilst testing!
Others such as motion sensors would require another
level of automation to do any sort of thorough testing.

Hence all we have running all the time is the 0day build bots that
Intel kindly provide for the community.  Those will do a lot of build
and boot testing but there is no IIO specific testing in there. Kernelci
and other boot test focused systems will hit the code once it reaches linux-next
which is after Greg pulls it (a couple of times a cycle).

Any progress in this area would be great. One day my garage may finally
gain a permanent test rig, but it's not at the top of my list for holiday
projects.

I know from the day job CI system, the huge amount of work in getting a
system set up and the constant maintenance burden that comes with it.
The effort of kernelci has certainly made the tooling easier to get
and use, but it is the perpetual issue with flakey hardware that keeps
things busy once you reach a certain scale of testing.  Have 10+ boards
and one of them will almost always be broken either physically or
in software terms.  For some classes of sensor we could standardise
on a host which would reduce the chance of this. The SoC ADCs won't
work for this though.

> 
> 3) When a reviewer sends an Acked-by, but I still have to send a v2
> for some reason (maybe adjusting the patch message, e.g.), should I
> add the Acked-by in v2 or that's something the maintainers will do?

If there are no substantial changes to the actual code, or they are ones
the person giving the tags requested, please add any tags to your V2.
I will occasionally remember to go back through old series because I know
someone gave a tag, but mostly I will only look at the latest version when
applying and assume all tags will already be there.

If you know I have missed one on a particular series, please point it
out as I may well not have pushed out a non rebasing version of the tree
(the main togreg branch) yet and so can edit the history to add the tag.
I often do this for DT reviews when I've assumed the patch was so simple
Rob wouldn't comment, neglecting how thorough he sometimes is and the
review comes in post me applying it!

> 
> Thank you
> Matheus

All good thought provoking questions (particularly the testing one!).
Keep them coming as it's useful stuff for everyone to know.

There is the new Subsystem maintainer doc that I need to sit down and
write for IIO. https://lwn.net/Articles/772882/ (pay walled currently)

https://lwn.net/ml/linux-kernel/154225759358.2499188.15268218778137905050.stgit@dwillia2-desk3.amr.corp.intel.com/#t

I'll try and remember to put the answers to these in there.
Note it'll probably be the Xmas week before I sit down and write that though.

Jonathan
