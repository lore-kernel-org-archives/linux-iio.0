Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-db5eur01on0102.outbound.protection.outlook.com ([104.47.2.102]:23050
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1168632AbdDXLhc (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 24 Apr 2017 07:37:32 -0400
Subject: Re: [PATCH v14 00/11] mux controller abstraction and iio/i2c muxes
To: Philipp Zabel <p.zabel@pengutronix.de>
References: <1493022995-16917-1-git-send-email-peda@axentia.se>
 <1493031179.2446.9.camel@pengutronix.de>
CC: Jonathan Cameron <jic23@kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Wolfram Sang <wsa@the-dreams.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Jonathan Corbet <corbet@lwn.net>, <linux-i2c@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <linux-doc@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Colin Ian King <colin.king@canonical.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        <kernel@pengutronix.de>
From: Peter Rosin <peda@axentia.se>
Message-ID: <2d978956-d247-917d-4150-a6723917a733@axentia.se>
Date: Mon, 24 Apr 2017 13:37:19 +0200
MIME-Version: 1.0
In-Reply-To: <1493031179.2446.9.camel@pengutronix.de>
Content-Type: text/plain; charset="utf-8"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 2017-04-24 12:52, Philipp Zabel wrote:
> On Mon, 2017-04-24 at 10:36 +0200, Peter Rosin wrote:
>> Hi!
>>
>> The big change since v13 is that the mux state is now locked with a mutex
>> instead of an rwsem. Other that that, it is mostly restructuring and doc
>> changes. There are a few other "real" changes as well, but those changes
>> feel kind of minor. I guess what I'm trying to say is that although the
>> list of changes for v14 is longish, it's still basically the same as last
>> time.
> 
> I have hooked this up to the video-multiplexer and now I trigger
> the lockdep debug_check_no_locks_held error message when selecting the
> mux input from userspace:
> 
> $ media-ctl --links "'imx6-mipi-csi2':1->'ipu1_csi0_mux':0[1]"
> [   66.258368] 
> [   66.259919] =====================================
> [   66.265369] [ BUG: media-ctl/258 still has locks held! ]
> [   66.270810] 4.11.0-rc8-20170424-1+ #1305 Not tainted
> [   66.275863] -------------------------------------
> [   66.282158] 1 lock held by media-ctl/258:
> [   66.286464]  #0:  (&mux->lock){+.+.+.}, at: [<8074a6c0>] mux_control_select+0x24/0x50
> [   66.294424] 
> [   66.294424] stack backtrace:
> [   66.298980] CPU: 0 PID: 258 Comm: media-ctl Not tainted 4.11.0-rc8+ #1305
> [   66.306771] Hardware name: Freescale i.MX6 Quad/DualLite (Device Tree)
> [   66.313334] Backtrace: 
> [   66.315858] [<8010e5a4>] (dump_backtrace) from [<8010e8ac>] (show_stack+0x20/0x24)
> [   66.323473]  r7:80e518d0 r6:80e518d0 r5:600d0013 r4:00000000
> [   66.329190] [<8010e88c>] (show_stack) from [<80496cf4>] (dump_stack+0xb0/0xdc)
> [   66.336470] [<80496c44>] (dump_stack) from [<8017e404>] (debug_check_no_locks_held+0xb8/0xbc)
> [   66.345043]  r9:ae8566b8 r8:ad88dc84 r7:ad88df58 r6:ad88dc84 r5:ad88df58 r4:ae856400
> [   66.352837] [<8017e34c>] (debug_check_no_locks_held) from [<8012b258>] (do_exit+0x79c/0xcc8)
> [   66.361321] [<8012aabc>] (do_exit) from [<8012d25c>] (do_group_exit+0x4c/0xcc)
> [   66.368581]  r7:000000f8
> [   66.371161] [<8012d210>] (do_group_exit) from [<8012d2fc>] (__wake_up_parent+0x0/0x30)
> [   66.379120]  r7:000000f8 r6:76f71798 r5:00000000 r4:00000001
> [   66.384837] [<8012d2dc>] (SyS_exit_group) from [<80109380>] (ret_fast_syscall+0x0/0x1c)
> 
> That correctly warns that the media-ctl process caused the mux->lock to
> be locked and still held when the process exited. Do we need a usage
> counter based mechanism for muxes that are (indirectly) controlled from
> userspace?

Ok, so the difference is probably that the rwsem locking primitive
don't have any lockdep checking hooked up. Because the rwsem was
definitely held in the same way in v13 as the mutex is now held in
v14, so there's no fundamental difference.

So, yes, we can use some kind of refcount scheme to not hold an actual
mutex for the duration of the mux select/deselect, but that doesn't
really change anything. Userspace is still locking something, and that
seems dangerous. How do you make sure that mux_control_deselect is
called as it should?

What I don't like about abandoning the lock is that there is still a
need to support the multi-consumer case and then you need some way
of keeping track of waiters. A lock does this, and any attempt to open
code that will get messy.

What might be better is to support some kind of exclusive mux, i.e. a
mux that only allows one consumer per mux controller. Then the mux core
could trust that exclusive consumer to not fuck things up for itself and
thus have no lock at all for select/deselect for the exclusive case. Or
perhaps keep a refcount (as you suggested) for the exclusive case so
that mux_control_try_select still makes sense, because you still want
that, right? 

The question then becomes how to best tell the mux core that you want
an exclusive mux. I see two options. Either you declare a mux controller
as exclusive up front somehow (in the device tree presumably), or you
add a mux_control_get_exclusive call that makes further calls to
mux_control_get{,_exclusive} fail with -EBUSY. I think I like the
latter better, if that can be made to work...

Cheers,
peda
