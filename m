Return-Path: <grundler@google.com>
MIME-Version: 1.0
In-Reply-To: <4E5CB5CD.5060301@cam.ac.uk>
References: <20110826011542.GK5975@shale.localdomain>
	<CANEJEGtys_kBMMPstRahrYq956g22ZgowySxvOCqUpHww6x29w@mail.gmail.com>
	<4E5CB5CD.5060301@cam.ac.uk>
Date: Tue, 30 Aug 2011 09:14:53 -0700
Message-ID: <CANEJEGsohYnKXNUKUSfBpXofcNdt13bY_mnFZRUWMpewNjUykg@mail.gmail.com>
Subject: Re: STAGING:iio:light: fix ISL29018 init to handle brownout
From: Grant Grundler <grundler@google.com>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: Dan Carpenter <error27@gmail.com>, linux-iio@vger.kernel.org,
        devel@driverdev.osuosl.org
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On Tue, Aug 30, 2011 at 3:05 AM, Jonathan Cameron <jic23@cam.ac.uk> wrote:
....
>> I did change one basic behavior that I think was also broken: cache
>> the value regardless of if the transaction completed successfully or
>> not.
> Don't do that. =C2=A0That means userspace will get an invalid value if it=
 reads
> in the meantime. If you have an error on a hardware bus - tell userspace =
about
> it and don't 'guess' what is in the register.

Ah ok - I didn't know this was part of the path to/from user space.

>
> Otherwise patch looks fine to me.

OK - I'll restore previous behavior and submit another patch.

cheers!
grant
