Return-Path: <grundler@google.com>
MIME-Version: 1.0
In-Reply-To: <4E5D1057.3020706@cam.ac.uk>
References: <20110826011542.GK5975@shale.localdomain>
	<CANEJEGtys_kBMMPstRahrYq956g22ZgowySxvOCqUpHww6x29w@mail.gmail.com>
	<4E5CB5CD.5060301@cam.ac.uk>
	<CANEJEGsohYnKXNUKUSfBpXofcNdt13bY_mnFZRUWMpewNjUykg@mail.gmail.com>
	<4E5D1057.3020706@cam.ac.uk>
Date: Tue, 30 Aug 2011 09:45:02 -0700
Message-ID: <CANEJEGsfWCz3WaeS4dACqkb4NJhrNWSGaB7PBC2+aSx6=tU8Tg@mail.gmail.com>
Subject: Re: STAGING:iio:light: fix ISL29018 init to handle brownout
From: Grant Grundler <grundler@google.com>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: Dan Carpenter <error27@gmail.com>, linux-iio@vger.kernel.org,
        devel@driverdev.osuosl.org
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On Tue, Aug 30, 2011 at 9:31 AM, Jonathan Cameron <jic23@cam.ac.uk> wrote:
> On 08/30/11 17:14, Grant Grundler wrote:
>> On Tue, Aug 30, 2011 at 3:05 AM, Jonathan Cameron <jic23@cam.ac.uk> wrot=
e:
>> ....
>>>> I did change one basic behavior that I think was also broken: cache
>>>> the value regardless of if the transaction completed successfully or
>>>> not.
>>> Don't do that. =C2=A0That means userspace will get an invalid value if =
it reads
>>> in the meantime. If you have an error on a hardware bus - tell userspac=
e about
>>> it and don't 'guess' what is in the register.
>>
>> Ah ok - I didn't know this was part of the path to/from user space.
> It plausibly isn't, I didn't go over it closely enough to be sure.

Ok. After thinking about it more, it might not matter anyway.

> Even if not, it's a nasty complexity that will bite someone at some stage=
.
> Mostly comes down to code doing what other code does in the same situatio=
n
> rather than trying to be clever.

The whole error handling path one ugly bit of "nasty complexity". If a regi=
ster
write fails, the register contents will be unknown. We will have no idea wh=
at
value is in the register or if the device is even still alive.
The cached value can't represent "known HW state" at that point and should
probably be marked "invalid" until either the value is succesfully
read or the next
write succeeds.

BTW, I didn't consider this particularly clever - just the code was
easier to read. :)

I don't think it really matters how the "cached value" is handled as
long as the error gets returned.  I'm just going to implement whatever
you prefer. :)

cheers,
grant
