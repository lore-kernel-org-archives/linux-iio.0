Return-Path: <lars@metafoo.de>
Subject: Re: [PATCH 0/4] IIO wrapper drivers, dpot-dac and envelope-detector
To: Peter Rosin <peda@axentia.se>, linux-kernel@vger.kernel.org
References: <1476955562-13673-1-git-send-email-peda@axentia.se>
Cc: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
 Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Rob Herring
 <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org
From: Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <9b8c0789-566d-67a3-b4f5-dbe4c69f6932@metafoo.de>
Date: Thu, 20 Oct 2016 14:55:12 +0200
MIME-Version: 1.0
In-Reply-To: <1476955562-13673-1-git-send-email-peda@axentia.se>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-iio@vger.kernel.org>

On 10/20/2016 11:25 AM, Peter Rosin wrote:
> Hi!
> 
> These two drivers share the fact that they wrap another iio channel,
> and I use the first in combination with the second, which is why I'm
> submitting them as a pair.
> 
> The first driver is a simple wrapper converting an iio dpot into an
> iio dac. It only changes the unit and scale. It also does not add any
> fancy iio buffer support that I don't need. I suppose that can be
> added. By someone else :-)
> 
> Please look over the scale conversion, notably for the fractional log2
> case that I don't need myself, so is untested. Maybe I should just
> remove it?
> 
> Also, is there some agreed-upon way to dig out the maximum value from
> an iio channel? If so, "dpot-dac,max-ohms" can be eliminated from the
> dt bindings, which would have been nice...

Yes, this is something we could really use. In a sense it exists for the
devices with buffer-capable channels where there is the real_bits field
which tells us the data width of the channel. But a dedicated mechanism for
querying the maximum (and minimum) valid code seems like a useful feature.
Not only for in-kernel clients, but also for userspace.

> 
> I'm also wondering if I'm somehow abusing the regulator? I only added
> it to get rid of a "dpot-dac,max-voltage" thing from the dt bindings.
> It feels right though, but maybe I should do more with it than check
> its voltage? What?

Enable the regulator when it is in use?

> 
> The second driver (the envelope detector) is more involved. It also
> explains why I need the dpot-dac driver. I wanted the envelope
> detector to be generic and work with any dac, but I had a dpot...
> 
> The envelope detector was previously discussed late last year [1],
> and this is what I came up with instead of that mess.
> 
> There are a couple of things to be said about the envelope detector,
> one question is where it should live? I placed it in the adc directory,
> but maybe it deserves an iio directory of its own? I'm also a bit
> worried that the name is a wee bit too generic. But what is a good
> name? I don't want it to be too long like dac-comp-envelope-detector
> and something like dac-comp-env-det is just unreadable. Naming is
> difficult... And suggestions?

Yeah, it is a bit tricky. It is a envelope detector built from discrete
components, but of course there are many more ways to build one. If you have
a codename for your platform you could use this for the DT compatible
string, like 'vendor,foobar-envelope-detector'.

> 
> Another thing is that I'm not 100% satisfied with the fact that you
> have to decide at instantiation if you are going to invert the search
> or not (search from below). But in order for that to be selectable
> at runtime with a channel attribute of some sort, I need to be able
> to rebind the interrupt to the other edge and I want to do that
> without releasing the irq and grabbing it again (someone might
> otherwise steal the irq, making the driver lose the irq all together).
> I don't see any API to change the irq trigger condition. Is there
> such a thing?
> 
> Anyway, despite all the above questions and remarks, this works for
> me. Please consider applying.

In general this series looks really good, good and clear implementation as
well as documentation. A few minor bits here and there, but that is normal.
