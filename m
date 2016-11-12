Return-Path: <tony@atomide.com>
Date: Sat, 12 Nov 2016 09:56:19 -0800
From: Tony Lindgren <tony@atomide.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Nicolae Rosia <Nicolae_Rosia@mentor.com>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: twl4030-madc: convert to DT only
Message-ID: <20161112175619.GE7129@atomide.com>
References: <1478946096-1314-1-git-send-email-Nicolae_Rosia@mentor.com>
 <18487c16-04ee-b65a-c773-27a2965db8b3@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <18487c16-04ee-b65a-c773-27a2965db8b3@kernel.org>
List-ID: <linux-iio@vger.kernel.org>

* Jonathan Cameron <jic23@kernel.org> [161112 05:21]:
> On 12/11/16 10:21, Nicolae Rosia wrote:
> > All users are DT only and it makes no sense to keep dead code.
> > twl4030_madc_platform_data is unused and can now be removed
> > from include/i2c/twl.h
> > 
> Whilst we don't 'have' to be nice to out of tree users, the advantage
> in code reduction here is pretty limited.
>
> So I'm doubtful unless Tony confirms that this is a sensible move and that
> the rest of the elements of twl4030 support are going the same way.

Yeah well mach-omap2 is all device tree only now. We still do have
the platform_data init around in the unlikely case we still need
to revert it for some regression. But I'm queuing patches for v4.10
to drop the rest of the platform_data based init and will merge
them assuming no problems.

If this helps cleaning up the rest of the twl related code then
sure makes sense to me. If this is not blocking other clean-up,
maybe wait until v4.11 merge window to be safe on this one.

Regards,

Tony
