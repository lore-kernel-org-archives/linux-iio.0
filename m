Return-Path: <daniel.baluta@gmail.com>
MIME-Version: 1.0
Sender: daniel.baluta@gmail.com
In-Reply-To: <20150527172907.GT11588@mwanda>
References: <1432678798-22903-1-git-send-email-rodriguez.twister@gmail.com>
	<CAEnQRZC4XwYE1anLNCSyd=mTw0_cATS6_95x9CXTL49gxpJGUA@mail.gmail.com>
	<20150527172418.GA22971@gmail.com>
	<20150527172907.GT11588@mwanda>
Date: Thu, 28 May 2015 08:31:21 +0300
Message-ID: <CAEnQRZAxtqm2kCfrbaJgRuA1nL-q5Dz7-+9T-hkkbpv9ZS4Viw@mail.gmail.com>
Subject: Re: [PATCH 1/2] staging: iio_simple_dummy: fix init
From: Daniel Baluta <daniel.baluta@intel.com>
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Vladimirs Ambrosovs <rodriguez.twister@gmail.com>, Daniel Baluta <daniel.baluta@intel.com>,
	Lars-Peter Clausen <lars@metafoo.de>, "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, driverdev-devel@linuxdriverproject.org,
	Peter Meerwald <pmeerw@pmeerw.net>, Hartmut Knaack <knaack.h@gmx.de>,
	Cristina Georgiana Opriceana <cristina.opriceana@gmail.com>, Jonathan Cameron <jic23@kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On Wed, May 27, 2015 at 8:29 PM, Dan Carpenter <dan.carpenter@oracle.com> wrote:
> On Wed, May 27, 2015 at 08:24:18PM +0300, Vladimirs Ambrosovs wrote:
>> On Wed, May 27, 2015 at 09:21:28AM +0300, Daniel Baluta wrote:
>> > Hi,
>> >
>> > On Wed, May 27, 2015 at 1:19 AM, Vladimirs Ambrosovs
>> > <rodriguez.twister@gmail.com> wrote:
>> > > This patch fixes the init function for the iio_simple_dummy driver.
>> > > The main issues were absence of kfree for the allocated array, and no
>> > > devices being removed in case the probe function fails, running in a loop.
>> > >
>> > > The iio_dummy_remove function was also changed:
>> > >         * The return value was changed to void
>> > >         * The check for return value of iio_simple_dummy_events_unregister()
>> > > The reason for this changes is that, as per implementation,
>> > > events_unregister function always returns 0, so we are safe not to check
>> > > return value. As a result the return value for iio_dummy_remove function
>> > > becomes useless as well, hence return value type change.
>> >
>> > While at it I think we can also make
>> > iio_simple_dummy_events_unregister return type void.
>> > Nice to see that people pay attention to the dummy module :).
>> >
>> > As part of Outreachy program, Cristina (CC'ed) will work on making the
>> > IIO dummy driver
>> > more useful with the final goal of moving it out of staging.
>> >
>> > http://kernelnewbies.org/OutreachyIntro
>> >
>> >
>> Thanks, that's a good point. Should I re-submit the patch, or better
>> reject the changes, and leave it to Cristina to address in scope of
>> Outreachy project?
>
> No no.  Please resend the patches.

Agree.
