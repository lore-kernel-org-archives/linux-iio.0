Return-Path: <hadess@hadess.net>
Message-ID: <1404916405.10032.3.camel@nuvo>
Subject: Re: User-space API for accelerometer(s)?
From: Bastien Nocera <hadess@hadess.net>
To: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
Cc: Jonathan Cameron <jic23@kernel.org>, Srinivas Pandruvada
 <srinivas.pandruvada@linux.intel.com>, Reyad Attiyat
 <reyad.attiyat@gmail.com>,  linux-iio@vger.kernel.org, Benjamin Tissoires
 <benjamin.tissoires@redhat.com>,  Lars-Peter Clausen <lars@metafoo.de>
Date: Wed, 09 Jul 2014 16:33:25 +0200
In-Reply-To: <53B59837.8080907@jic23.retrosnub.co.uk>
References: <1403100542.30918.29.camel@nuvo>
			 <CA+BWVUSqrJhFwKXHL5q=mwcxmasfkpNB6EqEXC6jPfg0ytOVzA@mail.gmail.com>
			 <53A224AB.9090305@linux.intel.com> <1403176834.30918.32.camel@nuvo>
		 <53A57414.8000104@kernel.org> <1404216616.7785.1.camel@nuvo>
	 <53B59837.8080907@jic23.retrosnub.co.uk>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

On Thu, 2014-07-03 at 18:51 +0100, Jonathan Cameron wrote:
<snip>
> We did also have a uinput based approach at one point but it was fairly clunky.
> That took data from iio buffers and pushed it back into the kernel via inputs
> userspace driver support. Not particularly nice but I thought I'd best mention
> it!

This is how I went in the end:
https://github.com/hadess/iio-sensor-proxy/

It's still far too resource hungry compared to the amount of work it's
doing (1 full percent of CPU!), and the rotation is too sensitive.

But, along with this systemd patch:
http://cgit.freedesktop.org/systemd/systemd/commit/?id=a545c6e1aa31b4d7e80c9d3609d9fc4fc9921498

It works out of the box with GNOME's orientation plugin.

I think that the code could also do with a bit more cleanup.

Please drop me a mail privately or file an issue if you can test this on
various systems (other models of Yoga and the Surface would be nice to
test), and I'll add it to the list of tested devices.

Cheers
