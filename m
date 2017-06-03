Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-eopbgr40115.outbound.protection.outlook.com ([40.107.4.115]:36864
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751211AbdFCVaA (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 3 Jun 2017 17:30:00 -0400
Subject: Re: [PATCH v15 00/13] mux controller abstraction and iio/i2c muxes
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Peter Rosin <peda@lysator.liu.se>,
        open list <linux-kernel@vger.kernel.org>,
        Wolfram Sang <wsa@the-dreams.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Jonathan Corbet <corbet@lwn.net>, linux-i2c@vger.kernel.org,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-doc@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Colin Ian King <colin.king@canonical.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Philipp Zabel <p.zabel@pengutronix.de>, kernel@pengutronix.de
References: <1494791476-14599-1-git-send-email-peda@lysator.liu.se>
 <20170603102627.GA24274@kroah.com>
 <CAExDi1QZsccMm_0v90Wx5Bxi7XYT_eNBWRJ51Neb8nWa4GD-+A@mail.gmail.com>
 <20170603193445.GA18851@kroah.com>
 <CAMHZB6F64BNWHa6KRWN4EH2uuaedxcNVgPJ3zfB_=No+9kteNw@mail.gmail.com>
From: Peter Rosin <peda@axentia.se>
Message-ID: <c6db1b4b-5bf2-96e8-a4fc-f5932c660b18@axentia.se>
Date: Sat, 3 Jun 2017 23:29:47 +0200
MIME-Version: 1.0
In-Reply-To: <CAMHZB6F64BNWHa6KRWN4EH2uuaedxcNVgPJ3zfB_=No+9kteNw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 2017-06-03 22:26, Luc Van Oostenryck wrote:
> On Sat, Jun 3, 2017 at 9:34 PM, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
>> On Sat, Jun 03, 2017 at 08:37:21PM +0200, Luc Van Oostenryck wrote:
>>> On Sat, Jun 3, 2017 at 12:26 PM, Greg Kroah-Hartman
>>> <gregkh@linuxfoundation.org> wrote:
>>>> On Sun, May 14, 2017 at 09:51:03PM +0200, Peter Rosin wrote:
>>>>> From: Peter Rosin <peda@axentia.se>
>>>>>
>>>>> Hi Greg,
>>>>>
>>>>> Philipp found problems in v14 with using a mutex for locking that was
>>>>> the outcome of the review for v13, so I'm now using a semaphore instead
>>>>> of the rwsem that was in v13. That at least got rid of the scary call
>>>>> to downgrade_write. However, I'm still unsure about what you actually
>>>>> meant with your comment about lack of sparse markings [1]. I did add
>>>>> __must_check to the funcs that selects the mux, but I've got this
>>>>> feeling that this is not what you meant?
>>>>
>>>> I thought there was a way to mark a function as requiring a lock be held
>>>> when it is being called.  Does sparse not support that anymore?
>>>
>>> sparse still support these annotations, of course.
>>> In this case, I suppose you're talking about '__must_hold()' which
>>> *must* be used instead of a pair of '__releases()' + '__acquires()'
>>> when the lock is help on function entry and exit.
>>
>> Ah, yes, that's what I was thinking of.  I don't know if sparse can
>> track things like this across an exported symbol, so I doubt it really
>> will help here.  Sorry for the noise.
> 
> No problem, I'm glad to help for sparse related things.
> 
> I didn't saw the code in question because the lkml.org link Peter
> gave didn't work for me and I don't know much about exported symbols
> (but I think the sole effect is to add some data in some symbol table).
> But these annotations just work based on the declarations, very much
> like type checking. So if you have something in scope like the following:
> 
> void do_stuff_locked(struct s *ptr) __must_hold(*ptr);
> 
> ...
> 
> void do_stuff_unlocked(struct s *ptr)
> {
>         ...
>         do_stuff_locked(ptr);        // will warn
>         ...
> }
> 
> You will have a warning from sparse unless the code preceding and following
> the call to do_stuff_locked() lock & then unlock 'ptr', generaly
> indirectly by a pair
> of functions, the one before with an '__acquires()' in its declaration
> the one after
> with a '__releases()' in its declaration:
> 
> void lock_stuff(struct s *ptr) __acquires(*ptr);
> void unlock_stuff(struct s *ptr) __releases(*ptr);
> 
> void do_stuff_unlocked(struct s *ptr)
> {
>         lock_stuff(ptr);
>         do_stuff_locked(ptr);        // won't warn
>         unlock_stuff(ptr);
> }

Ok, thanks for the explanation! The above was what I gathered when I
looked around, and since it didn't really fit the usage pattern of the
mux api I was stomped. When comparing the mux code with the above,
mux_control_select would be an __acquires (albeit a conditional one,
but let's not muddy the waters unnecessarily) and mux_control_deselect
would be a __releases.

But for long time mux consumers, like the video mux, it must be OK to
only acquire the mux, and not release it right away in the same context,
which I assume will be very hard for sparse to handle sanely? E.g. I
think sparse also complains if there are unbalanced __acquires and
__releases in some context, no?

Cheers,
peda

BTW, the core mux code is at the below link if the lkml link continues
to fail:
https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git/commit/?h=char-misc-testing&id=a3b02a9c6591ce154cd44e2383406390a45b530c
