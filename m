Return-Path: <SRS0=XUW9=5I=linuxfoundation.org=gregkh@kernel.org>
Date: Sat, 3 Jun 2017 19:31:21 +0900
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Peter Rosin <peda@lysator.liu.se>
Cc: linux-kernel@vger.kernel.org, Peter Rosin <peda@axentia.se>,
	Wolfram Sang <wsa@the-dreams.de>, Rob Herring <robh+dt@kernel.org>,
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
Subject: Re: [PATCH v15 00/13] mux controller abstraction and iio/i2c muxes
Message-ID: <20170603103121.GA9599@kroah.com>
References: <1494791476-14599-1-git-send-email-peda@lysator.liu.se>
 <20170603102627.GA24274@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170603102627.GA24274@kroah.com>
List-ID: <linux-iio@vger.kernel.org>

On Sat, Jun 03, 2017 at 07:26:27PM +0900, Greg Kroah-Hartman wrote:
> On Sun, May 14, 2017 at 09:51:03PM +0200, Peter Rosin wrote:
> > From: Peter Rosin <peda@axentia.se>
> > 
> > Hi Greg,
> > 
> > Philipp found problems in v14 with using a mutex for locking that was
> > the outcome of the review for v13, so I'm now using a semaphore instead
> > of the rwsem that was in v13. That at least got rid of the scary call
> > to downgrade_write. However, I'm still unsure about what you actually
> > meant with your comment about lack of sparse markings [1]. I did add
> > __must_check to the funcs that selects the mux, but I've got this
> > feeling that this is not what you meant?
> 
> I thought there was a way to mark a function as requiring a lock be held
> when it is being called.  Does sparse not support that anymore?

Anyway, not a big deal.  I still worry about the calls blocking when
people are not expecting them to, but it is just the nature of th api I
guess.

All now queued up, nice work, thanks for sticking with this.

greg k-h
