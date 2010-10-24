Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-52.csi.cam.ac.uk ([131.111.8.152]:40253 "EHLO
	ppsw-52.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932680Ab0JXUhL (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 24 Oct 2010 16:37:11 -0400
Message-ID: <4CC49A57.1010303@cam.ac.uk>
Date: Sun, 24 Oct 2010 21:43:03 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: Mike Frysinger <vapier@gentoo.org>
CC: linux-iio@vger.kernel.org, uclinux-dist-devel@blackfin.uclinux.org
Subject: Re: [Uclinux-dist-devel] [PATCH] staging: iio: new ADT7316/7/8 and
 ADT7516/7/9 driver
References: <1287865409-32171-1-git-send-email-vapier@gentoo.org> <4CC478D1.2070604@cam.ac.uk> <AANLkTi=XB4nqfWAmEmE=VR3HqEmKvgEcQLTzbYOS8P9O@mail.gmail.com>
In-Reply-To: <AANLkTi=XB4nqfWAmEmE=VR3HqEmKvgEcQLTzbYOS8P9O@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/24/10 19:19, Mike Frysinger wrote:
> On Sun, Oct 24, 2010 at 14:20, Jonathan Cameron wrote:
>> DAC interfaces need thorough discussion. That doesn't prevent merging
>> but note they will almost certainly change somewhat. I'm not all that
>> familiar with these devices so I'm happy to have others propose the
>> interface, but it needs to be proposed widely and discussed before we
>> commit to it.  Hence we won't have a stable userspace abi for now.
> 
> at this point, we have so many ADI drivers out of tree (40 something
> at this point) that we want to focus on getting in first, and then we
> can talk about rewriting different approaches.  
Sure. In the vast majority of the drivers I've looked at so far I'm happy
to see them merge asap.  This one breaks abi's that do exist fairly
thoroughly, but even then it's fine as long as you tack on a TODO file
indicating what needs to be done.  New abi's can indeed be pinned
down when in tree given we are in staging (not nearly so easy in
the majority of the tree for good reasons, but here we are offering
no guarantees on abis being stable).  Having said that, the disadvantage
is that many of these drivers include a lot of cut and paste and errors
slip in and get propogated (see they whole event interface for triggers
issue that I'll hopefully get out of the tree for the next merge window!)
> every cycle we attempt
> to submit, there's some new ABI/API rewrite that keeps us out.  so
> when we do get around to fixing things, we miss another cycle and the
> next one brings yet another rewrite.  and we never seem to get time to
> address the fundamentals since we're tied up with bit shifting.
I know how you feel and sympathise.  If I know there are drivers
coming I tend to hold up any major changes until they have merged
and fix the new drivers along with the rest.  You guys do a lot of
good work on drivers so I would love to assist when possible.  I know
it is often the way things work out, but mass driver submissions when
the merge window is open is generally a bad idea. 
> 
> so if you could highlight the tree with the pending rewrite patches, i
> can merge them now, get things fixed, and then post the drivers again.
There are no rewrite patches currently queued anywhere.   All remaining
stuff I am holding is related to cleanup and merges (together rather
than into tree!) in various drivers.  One other related to docs that
probably won't make this merge window (it's on list).

I only post a real tree when we have big changes that need testing.  Generally we
keep things ticking over as they come in and going directly into Greg KH's
staging-next and hence linux-next.


As a general rule, whilst I'm doing a fairly full review, I'll highlight
any bits that I really want to see changed and the others can all be picked
up later.

Thanks for all your hardwork.

Jonathan
> -mike
> 

