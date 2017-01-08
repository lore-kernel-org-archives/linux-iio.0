Return-Path: <SRS0=H5qc=YW=axentia.se=peda@kernel.org>
Subject: Re: [PATCH v7 00/12] mux controller abstraction and iio/i2c muxes
To: Wolfram Sang <wsa@the-dreams.de>
References: <1483532187-28494-1-git-send-email-peda@axentia.se>
 <20170108105129.GB1983@katana>
Cc: linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Jonathan Cameron <jic23@kernel.org>,
 Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>,
 Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Jonathan Corbet
 <corbet@lwn.net>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-i2c@vger.kernel.org,
 devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-doc@vger.kernel.org
From: Peter Rosin <peda@axentia.se>
Message-ID: <8765343f-f1a7-d66a-6aae-e45c3debe06b@axentia.se>
Date: Sun, 8 Jan 2017 22:56:22 +0100
MIME-Version: 1.0
In-Reply-To: <20170108105129.GB1983@katana>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-iio@vger.kernel.org>

On 2017-01-08 11:51, Wolfram Sang wrote:
> Hi peda,
> 
>> One thing that I would like to do, but don't see a solution
>> for, is to move the mux control code that is present in
>> various drivers in drivers/i2c/muxes to this new minimalistic
>> muxing subsystem, thus converting all present i2c muxes (but
>> perhaps not gates and arbitrators) to be i2c-mux-simple muxes.
> 
> In a few lines, what is preventing that?

i2c-mux-gpio has the auto-detect for mux-/parent-locked and (old
style?) support for specifying what gpios to use with platform data
from code (i.e. not from dt/acpi). All of that gets messier if
someone else (the mux) owns the gpios.

i2c-mux-pinctrl has similar issues.

i2c-mux-reg has the platform data from code issue, plus a read-write
mode (mux is write only, at least as-is).

i2c-mux-pca954x has things going on like irqs (not applied yet) and
a reset gpio that makes it a poor candidate for something generic.

i2c-mux-mlxcplc could probably be converted (I don't think it existed
when I wrote the quoted paragraph).

So, since there are issues with just about all of the i2c muxes, the
only way forward that I see would be to instantiate the mux locally
and feed it to the generic i2c-mux-simple, but what would be the point
of that? There would still be a handful of i2c-mux drivers under
drivers/i2c/muxes.

Maybe some of the above are non-issues and maybe I have failed to see
some issue? I didn't think too hard about it...

>> I'm using an rwsem to lock a mux, but that isn't really a
>> perfect fit. Is there a better locking primitive that I don't
>> know about that fits better? I had a mutex at one point, but
>> that didn't allow any concurrent accesses at all. At least
>> the rwsem allows concurrent access as long as all users
>> agree on the mux state, but I suspect that the rwsem will
>> degrade to the mutex situation pretty quickly if there is
>> any contention.
> 
> Maybe ask this question in a seperate email thread on lkml cc-ing the
> locking gurus (with a pointer to this thread)?

I don't think there is a suitable primitive. In order to get
something that really matches, I think the users need to hint
how long they (think they) are going to lock the mux. And
then it no longer a primitive, methinks. It something that is
much heavier...

>> Also, the "mux" name feels a bit ambitious, there are many muxes
>> in the world, and this tiny bit of code is probably not good
>> enough to be a nice fit for all...
> 
> "... and it probably never will support anything other than
> AT-harddisks, as that's all I have..." ;))

:-)

> Thanks for this work!

And thanks for looking!

Cheers,
peda
