Return-Path: <eraretuya@gmail.com>
Date: Sat, 12 Nov 2016 22:32:45 +0800
From: Eva Rachel Retuya <eraretuya@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, Michael.Hennerich@analog.com,
	knaack.h@gmx.de, pmeerw@pmeerw.net, gregkh@linuxfoundation.org
Subject: Re: [PATCH 2/2] staging: iio: ad7606: move out of staging
Message-ID: <20161112143242.GB2214@Socrates-DK>
References: <1478846078-22207-1-git-send-email-eraretuya@gmail.com>
 <1478846078-22207-3-git-send-email-eraretuya@gmail.com>
 <266c2aad-1938-1dc7-0b22-b2f3b2d80e68@metafoo.de>
 <280ee49f-7217-6dfc-dcc0-a6c8800144cd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <280ee49f-7217-6dfc-dcc0-a6c8800144cd@kernel.org>
List-ID: <linux-iio@vger.kernel.org>

On Sat, Nov 12, 2016 at 02:26:51PM +0000, Jonathan Cameron wrote:
> On 11/11/16 14:22, Lars-Peter Clausen wrote:
> > On 11/11/2016 07:34 AM, Eva Rachel Retuya wrote:
> >> Move the ad7606 driver from staging/iio/adc to iio/adc. Also, update the
> >> corresponding Makefile and Kconfig associated with the change.
> > 
> > This is obviously OK, but when you generate a patch that moves files use
> > `git format-patch -M ...`. This will generate a more compact patch.
> > 
> I tend to make an exception for staging graduation patches.
> The mere posting of the whole driver by not using the move detection
> makes for really easy review of whether we have forgotten something
> else that needs cleanup before the graduation.
> 
> Most of the time -M is much more sensible!
> 
> Jonathan

Should I use this -M on version 2 or still go with the previous method?

Thanks,
Eva
