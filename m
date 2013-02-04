Return-Path: <linux@roeck-us.net>
Date: Mon, 4 Feb 2013 08:37:04 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
	devicetree-discuss@lists.ozlabs.org,
	Naveen Krishna Chatradhi <ch.naveen@samsung.com>,
	Doug Anderson <dianders@chromium.org>,
	Tomasz Figa <tomasz.figa@gmail.com>,
	Grant Likely <grant.likely@secretlab.ca>,
	Rob Herring <rob.herring@calxeda.com>
Subject: Re: [PATCH v2 4/4] iio: Add OF support
Message-ID: <20130204163704.GA18187@roeck-us.net>
References: <1359853180-5664-1-git-send-email-linux@roeck-us.net>
 <1359853180-5664-5-git-send-email-linux@roeck-us.net>
 <510E7195.4070803@metafoo.de>
 <20130203162213.GA21576@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130203162213.GA21576@roeck-us.net>
List-ID: <linux-iio@vger.kernel.org>

On Sun, Feb 03, 2013 at 08:22:13AM -0800, Guenter Roeck wrote:
[ ... ]

> > > +
> > > +	/* NULL terminated array to save passing size */
> > > +	chans = kzalloc(sizeof(*chans)*(nummaps + 1), GFP_KERNEL);
> > 
> > I think using kcalloc makes sense here.
> > 
> that would leave chan->data uninitialized, and I would have to initialize it
> explicitly. also, if additional fields are ever added, we would risk having
> uninitialized fields. Using kzalloc avoids a potential future error case, so I
> would prefer to keep it.
> 
Please ignore this one.

Looks like my brain was too flu-foggy to realize that kcalloc does clear the
memory.

Guenter
