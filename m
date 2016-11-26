Return-Path: <peda@axentia.se>
Subject: Re: [PATCH v4 0/7] mux controller abstraction and iio/i2c muxes
To: <linux-kernel@vger.kernel.org>
References: <1480000687-5630-1-git-send-email-peda@axentia.se>
CC: Wolfram Sang <wsa@the-dreams.de>, Rob Herring <robh+dt@kernel.org>, "Mark
 Rutland" <mark.rutland@arm.com>, Jonathan Cameron <jic23@kernel.org>,
	"Hartmut Knaack" <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>,
	"Peter Meerwald-Stadler" <pmeerw@pmeerw.net>, Jonathan Corbet
	<corbet@lwn.net>, "Arnd Bergmann" <arnd@arndb.de>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, <linux-i2c@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-iio@vger.kernel.org>,
	<linux-doc@vger.kernel.org>
From: Peter Rosin <peda@axentia.se>
Message-ID: <8e4c6895-c06f-3412-26ea-dfb02d52d328@axentia.se>
Date: Sat, 26 Nov 2016 19:38:09 +0100
MIME-Version: 1.0
In-Reply-To: <1480000687-5630-1-git-send-email-peda@axentia.se>
Content-Type: text/plain; charset="windows-1252"
List-ID: <linux-iio@vger.kernel.org>

On 2016-11-24 16:18, Peter Rosin wrote:
> v3 -> v4 changes
> - added support for having the mux-controller in a child node of a
>   mux-consumer if it is a sole consumer, to hopefully even further satisfy
>   the complaint from Rob (and later Lars-Peter) about dt complexity.
> - the above came at the cost of some rather horrible refcounting code,
>   please review and suggest how it should be done...
> 
> v2 -> v3 changes
> - have the mux-controller in the parent node of any mux-controller consumer,
>   to hopefully satisfy complaint from Rob about dt complexity.

I did some further tests and both of these attempts to support fancier
devicetree bindings have severe problems. I will remove them for v5 and
go back to having a phandle reference to the mux-controller from the
consumer (unless I get some revelation of course and just get it). I'm
simply not yet understanding the driver model well enough to pull this
off at the moment...

Cheers,
Peter
