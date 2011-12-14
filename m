Return-Path: <gregkh@suse.de>
Date: Tue, 13 Dec 2011 16:00:43 -0800
From: Greg KH <gregkh@suse.de>
To: "J.I. Cameron" <jic23@cam.ac.uk>
Cc: Greg KH <greg@kroah.com>, Lars-Peter Clausen <lars@metafoo.de>,
	Jonathan Cameron <jic23@kernel.org>, devel@driverdev.osuosl.org,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH] staging:iio: Setup buffer access functions when
 allocating the buffer
Message-ID: <20111214000043.GA23927@suse.de>
References: <1323684545-11188-1-git-send-email-lars@metafoo.de>
 <20111213004659.GB11553@kroah.com>
 <8847cb76-be5b-41d3-b893-968bb9cb937a@email.android.com>
 <20111213073831.GB20154@suse.de>
 <Prayer.1.3.4.1112130848080.6245@hermes-2.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Prayer.1.3.4.1112130848080.6245@hermes-2.csi.cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

On Tue, Dec 13, 2011 at 08:48:08AM +0000, J.I. Cameron wrote:
> >>>Make a decision, don't force someone else to make it for you...
> >>Defaults are sensible. Preventing other peoples use cases are not.
> >
> >Ok, but you do agree that this patch is broken as-is, right?
> Not sure I do.  I admit it isn't a patch I really cared about either way,
> but it is just providing a trivial bit of boiler plate removal.
> The buffer allocation and access functions are always pared and all I see
> here is moving the access funcs bit inside the allocation call?
> 
> Perhaps I have missunderstood what you don't like?

I don't like anything that forces the builder of the kernel to choose
the buffer type, that should be done by the driver, or it should be
dynamic and changable, and you need to provide documentation as to why
you would want to change the buffer type.

greg k-h
