Return-Path: <vapier.adi@gmail.com>
MIME-Version: 1.0
Sender: vapier.adi@gmail.com
In-Reply-To: <4CC478D1.2070604@cam.ac.uk>
References: <1287865409-32171-1-git-send-email-vapier@gentoo.org> <4CC478D1.2070604@cam.ac.uk>
From: Mike Frysinger <vapier@gentoo.org>
Date: Sun, 24 Oct 2010 14:19:28 -0400
Message-ID: <AANLkTi=XB4nqfWAmEmE=VR3HqEmKvgEcQLTzbYOS8P9O@mail.gmail.com>
Subject: Re: [Uclinux-dist-devel] [PATCH] staging: iio: new ADT7316/7/8 and
 ADT7516/7/9 driver
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: linux-iio@vger.kernel.org, uclinux-dist-devel@blackfin.uclinux.org
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On Sun, Oct 24, 2010 at 14:20, Jonathan Cameron wrote:
> DAC interfaces need thorough discussion. That doesn't prevent merging
> but note they will almost certainly change somewhat. I'm not all that
> familiar with these devices so I'm happy to have others propose the
> interface, but it needs to be proposed widely and discussed before we
> commit to it. =C2=A0Hence we won't have a stable userspace abi for now.

at this point, we have so many ADI drivers out of tree (40 something
at this point) that we want to focus on getting in first, and then we
can talk about rewriting different approaches.  every cycle we attempt
to submit, there's some new ABI/API rewrite that keeps us out.  so
when we do get around to fixing things, we miss another cycle and the
next one brings yet another rewrite.  and we never seem to get time to
address the fundamentals since we're tied up with bit shifting.

so if you could highlight the tree with the pending rewrite patches, i
can merge them now, get things fixed, and then post the drivers again.
-mike
