Return-Path: <SRS0=R6MS=5I=gmail.com=luc.vanoostenryck@kernel.org>
MIME-Version: 1.0
In-Reply-To: <c6db1b4b-5bf2-96e8-a4fc-f5932c660b18@axentia.se>
References: <1494791476-14599-1-git-send-email-peda@lysator.liu.se>
 <20170603102627.GA24274@kroah.com> <CAExDi1QZsccMm_0v90Wx5Bxi7XYT_eNBWRJ51Neb8nWa4GD-+A@mail.gmail.com>
 <20170603193445.GA18851@kroah.com> <CAMHZB6F64BNWHa6KRWN4EH2uuaedxcNVgPJ3zfB_=No+9kteNw@mail.gmail.com>
 <c6db1b4b-5bf2-96e8-a4fc-f5932c660b18@axentia.se>
From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Date: Sun, 4 Jun 2017 00:21:33 +0200
Message-ID: <CAMHZB6GVRytMR1O0Vg3FwUZZkjrKmnfiLTgiFR+oxZ+wEaNGQA@mail.gmail.com>
Subject: Re: [PATCH v15 00/13] mux controller abstraction and iio/i2c muxes
To: Peter Rosin <peda@axentia.se>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Peter Rosin <peda@lysator.liu.se>,
	open list <linux-kernel@vger.kernel.org>, Wolfram Sang <wsa@the-dreams.de>,
	Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Jonathan Corbet <corbet@lwn.net>, linux-i2c@vger.kernel.org,
	devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
	linux-doc@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
	Colin Ian King <colin.king@canonical.com>, Paul Gortmaker <paul.gortmaker@windriver.com>,
	Philipp Zabel <p.zabel@pengutronix.de>, kernel@pengutronix.de
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-iio@vger.kernel.org>

On Sat, Jun 3, 2017 at 11:29 PM, Peter Rosin <peda@axentia.se> wrote:
> On 2017-06-03 22:26, Luc Van Oostenryck wrote:
>> On Sat, Jun 3, 2017 at 9:34 PM, Greg Kroah-Hartman
>> <gregkh@linuxfoundation.org> wrote:
>>> On Sat, Jun 03, 2017 at 08:37:21PM +0200, Luc Van Oostenryck wrote:
>>>> On Sat, Jun 3, 2017 at 12:26 PM, Greg Kroah-Hartman
>>>> <gregkh@linuxfoundation.org> wrote:
>>>>> On Sun, May 14, 2017 at 09:51:03PM +0200, Peter Rosin wrote:
>>>>>> From: Peter Rosin <peda@axentia.se>
>>>>>>
>>>>>> Hi Greg,
>>>>>>
>>>>>> Philipp found problems in v14 with using a mutex for locking that was
>>>>>> the outcome of the review for v13, so I'm now using a semaphore instead
>>>>>> of the rwsem that was in v13. That at least got rid of the scary call
>>>>>> to downgrade_write. However, I'm still unsure about what you actually
>>>>>> meant with your comment about lack of sparse markings [1]. I did add
>>>>>> __must_check to the funcs that selects the mux, but I've got this
>>>>>> feeling that this is not what you meant?
>>>>>
>>>>> I thought there was a way to mark a function as requiring a lock be held
>>>>> when it is being called.  Does sparse not support that anymore?
>>>>
>>>> sparse still support these annotations, of course.
>>>> In this case, I suppose you're talking about '__must_hold()' which
>>>> *must* be used instead of a pair of '__releases()' + '__acquires()'
>>>> when the lock is help on function entry and exit.
>>>
>>> Ah, yes, that's what I was thinking of.  I don't know if sparse can
>>> track things like this across an exported symbol, so I doubt it really
>>> will help here.  Sorry for the noise.
>>
>> No problem, I'm glad to help for sparse related things.
>>
>> I didn't saw the code in question because the lkml.org link Peter
>> gave didn't work for me and I don't know much about exported symbols
>> (but I think the sole effect is to add some data in some symbol table).
>> But these annotations just work based on the declarations, very much
>> like type checking. So if you have something in scope like the following:
>>
>> void do_stuff_locked(struct s *ptr) __must_hold(*ptr);
>>
>> ...
>>
>> void do_stuff_unlocked(struct s *ptr)
>> {
>>         ...
>>         do_stuff_locked(ptr);        // will warn
>>         ...
>> }
>>
>> You will have a warning from sparse unless the code preceding and following
>> the call to do_stuff_locked() lock & then unlock 'ptr', generaly
>> indirectly by a pair
>> of functions, the one before with an '__acquires()' in its declaration
>> the one after
>> with a '__releases()' in its declaration:
>>
>> void lock_stuff(struct s *ptr) __acquires(*ptr);
>> void unlock_stuff(struct s *ptr) __releases(*ptr);
>>
>> void do_stuff_unlocked(struct s *ptr)
>> {
>>         lock_stuff(ptr);
>>         do_stuff_locked(ptr);        // won't warn
>>         unlock_stuff(ptr);
>> }
>
> Ok, thanks for the explanation! The above was what I gathered when I
> looked around, and since it didn't really fit the usage pattern of the
> mux api I was stomped. When comparing the mux code with the above,
> mux_control_select would be an __acquires (albeit a conditional one,
> but let's not muddy the waters unnecessarily) and mux_control_deselect
> would be a __releases.
>
> But for long time mux consumers, like the video mux, it must be OK to
> only acquire the mux, and not release it right away in the same context,
> which I assume will be very hard for sparse to handle sanely? E.g. I
> think sparse also complains if there are unbalanced __acquires and
> __releases in some context, no?

Yes, there are some limitations.

You can do conditional locks, it's what spin_trylock() and
{read,write}_trylock()
do. something like the following will be OK:

void do_stuff_unlocked(struct s *ptr)
{
         if (trylock_stuff(ptr)) {
                  do_stuff_locked(ptr);        // won't warn
                  unlock_stuff(ptr);
         }
}

sparse won't complain because everything is correct within each block.
But something that sparse will complain about would be:

void foobar(struct s *ptr)
{
         if (some condition)
                  lock_stuff(ptr);
                                                           // will warn
         ... some code ...

         if (same condition) {
                  do_stuff_locked(ptr);
                  unlock_stuff(ptr);
         }
}

While correct from the point of view of locking, sparse won't be able
to take into account
that indeed, the two ifs are fro the same condition. sparse will only
see that after the first
if there will be one path where the lock will be held and another one
where it won't and
will this issue a 'different lock contexts for basic block' warning.

For this mux code, for example, the function mux_control_select() will
have a problem
because depending on the return value of __mux_control_select() you will want to
take back the lock or not, so the exit state of this function is not
well defined regarding
locking. It's the same for mux_control_try_select().

I hope this render the possibilities a bit clearer.
Cheers,
-- Luc
