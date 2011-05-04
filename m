Return-Path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: Jonathan Cameron <jic23@cam.ac.uk>
Subject: Re: [PATCH 00/99] IIO: moving forward patch set.
Date: Wed, 4 May 2011 15:33:21 +0200
Cc: linux-iio@vger.kernel.org,
 Michael.Hennerich@analog.com
References: <1304510351-10922-1-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1304510351-10922-1-git-send-email-jic23@cam.ac.uk>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Message-Id: <201105041533.21498.arnd@arndb.de>
List-ID: <linux-iio@vger.kernel.org>

On Wednesday 04 May 2011, Jonathan Cameron wrote:
> First to Arnd: Obviously I'm not expecting you to review this
> 'little' set. I just wanted to keep you in the loop on what happened
> with your suggestions.
> 

Thanks for the update, this looks like excellent progress!

I've briefly looked over most of the patches and they all look good
to me, I especially like the total diffstat of 
 112 files changed, 7402 insertions(+), 12638 deletions(-)

One of the main problems we discussed earlier is the chardev interface
with its event handling, and I think you got it exactly right now, but
I'm not completely sure if I understand correctly what you do there,
so maybe you can explain how it works with the new buffer device.

Ideally, that could be in man-page style so it can go into section 4 of
the man pages, /usr/share/man/man4/iio.4.

	Arnd
