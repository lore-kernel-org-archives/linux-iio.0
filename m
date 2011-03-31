Return-Path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: Jonathan Cameron <jic23@cam.ac.uk>
Subject: Re: [RFC PATCH 00/21] IIO: Channel registration rework, buffer chardev combining and rewrite of triggers as 'virtual' irq_chips.
Date: Thu, 31 Mar 2011 17:28:49 +0200
Cc: linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 tglx@linutronix.de
References: <1301583255-28468-1-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1301583255-28468-1-git-send-email-jic23@cam.ac.uk>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Message-Id: <201103311728.50077.arnd@arndb.de>
List-ID: <linux-iio@vger.kernel.org>

On Thursday 31 March 2011, Jonathan Cameron wrote:
> I'm afraid what in many ways makes sense as three separate
> series have gotten rather intertwined.  I can probably unpick
> them but it will involve a lot of intermediate code in
> lis3l02dq (which is our fiddly example for this set) that I'd
> rather avoid.  Hence lets have a guide to what various people
> might be interested in:

Hi Jonathan,

Great to see your progress here. Unfortunately I currently don't
have much time to look at the patches in the necessary depth,
since I'll be travelling for the next two weeks up till ELC
in San Francisco. I might find some time to look at the patches,
but don't promise anything now, so please remind me later
if you want specific feedback.

	Arnd
