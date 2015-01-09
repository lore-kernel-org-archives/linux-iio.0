Return-Path: <iivanov@mm-sol.com>
Message-ID: <1420818639.28652.5.camel@mm-sol.com>
Subject: Re: [PATCH] iio: Simplify IIO provider access locking mechanism
From: "Ivan T. Ivanov" <iivanov@mm-sol.com>
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
 Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Fri, 09 Jan 2015 17:50:39 +0200
In-Reply-To: <54AFF6C4.9020306@metafoo.de>
References: <1420817893-5858-1-git-send-email-iivanov@mm-sol.com>
	 <54AFF6C4.9020306@metafoo.de>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>


On Fri, 2015-01-09 at 16:41 +0100, Lars-Peter Clausen wrote:
> On 01/09/2015 04:38 PM, Ivan T. Ivanov wrote:
> > Instead of checking whether provider module is still
> > loaded on every access to device just lock module to
> > memory when client get reference to provider device.
> > 
> 
> This has nothing to do with the module, it's about the device. In the Linux
> device driver model as device can be unbound at any time and the IIO
> framework needs to handle this.
> 

Hm. Probably i am missing something here, but is this
still true if we have reference to device structure?

Regards,
Ivan
