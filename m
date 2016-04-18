Return-Path: <amsfield22@gmail.com>
Date: Sun, 17 Apr 2016 21:56:22 -0700
From: Alison Schofield <amsfield22@gmail.com>
To: "Andrew F. Davis" <afd@ti.com>
Cc: Jonathan Cameron <jic23@kernel.org>, knaack.h@gmx.de, lars@metafoo.de,
	pmeerw@pmeerw.net, kgene@kernel.org, k.kozlowski@samsung.com,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/5] iio: health: afe4404: use regmap to retrieve
 struct device
Message-ID: <20160418045621.GA2835@d830.WORKGROUP>
References: <cover.1460314070.git.amsfield22@gmail.com>
 <2dd23e55fa7c2d16c577146eefd4a84046d2b838.1460314070.git.amsfield22@gmail.com>
 <57129101.7000503@kernel.org>
 <5713D0F8.20303@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5713D0F8.20303@ti.com>
List-ID: <linux-iio@vger.kernel.org>

On Sun, Apr 17, 2016 at 01:07:52PM -0500, Andrew F. Davis wrote:
> On 04/16/2016 02:22 PM, Jonathan Cameron wrote:
> > On 10/04/16 20:07, Alison Schofield wrote:
> >> Driver includes struct regmap and struct device in its global data.
> >> Remove the struct device and use regmap API to retrieve device info.
> >>
> 
> Why? This adds nothing but more code to get dev through some
> container_of trickery when we could just keep a dev pointer in the data
> structure.
> 
> Andrew

Thanks for the review and response.  The why would be for
simplification and uniformity across IIO.

I think I see your point in general, but not sure I get your
specific concerns with these afe4403/04 drivers.

The drivers only use the device struct in probe and then
again at device remove time.  At probe, the change no
longer stores it in the global data. At remove the
regmap_get_device() func is a simple dereference to retrieve
the device struct. That's the simplification: we don't carry
that ptr in global data waiting for the opportunity to use it
at device remove.  We just find it when we need it at device
remove.  (Perhaps these devices are getting removed frequently?)

Regards,
alisons
