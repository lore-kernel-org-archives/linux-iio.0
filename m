Return-Path: <dmitry.torokhov@gmail.com>
Date: Tue, 4 Jun 2013 09:57:07 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Jonathan Cameron <jic23@kernel.org>, linux-input@vger.kernel.org,
	linux-iio@vger.kernel.org, Samuel Ortiz <sameo@linux.intel.com>,
	Jonathan Cameron <jic23@cam.ac.uk>, Felipe Balbi <balbi@ti.com>,
	"Patil, Rachna" <rachna@ti.com>,
	Pantelis Antoniou <panto@antoniou-consulting.com>
Subject: Re: [PATCH 07/19] iio: adc: am335x: Add DT support
Message-ID: <20130604165705.GH26400@core.coreip.homeip.net>
References: <1369681926-22185-1-git-send-email-bigeasy@linutronix.de>
 <1369681926-22185-8-git-send-email-bigeasy@linutronix.de>
 <51AB79CE.2000001@kernel.org>
 <20130604101202.GA1151@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130604101202.GA1151@linutronix.de>
List-ID: <linux-iio@vger.kernel.org>

On Tue, Jun 04, 2013 at 12:12:02PM +0200, Sebastian Andrzej Siewior wrote:
> * Jonathan Cameron | 2013-06-02 17:58:54 [+0100]:
> 
> >On 05/27/2013 08:11 PM, Sebastian Andrzej Siewior wrote:
> >> From: "Patil, Rachna" <rachna@ti.com>
> >> 
> >> Add DT support for client ADC driver.
> >> 
> >> [ panto@antoniou-consulting.com : use of_get_child_by_name
> >> 	instead of of_find_node_by_name ]
> >> 
> >> Signed-off-by: Pantelis Antoniou <panto@antoniou-consulting.com>
> >> Signed-off-by: Patil, Rachna <rachna@ti.com>
> >> Signed-off-by: Felipe Balbi <balbi@ti.com>
> >> [bigeasy: shift the code to the left]
> >> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> >Acked-by: Jonathan Cameron <jic23@kernel.org>
> >
> >I would take this directly but then I'd imagine that will cause havoc
> >when the later patches are applied and touch both iio and mfd.
> 
> Yeah, I have no idea what to do here since it would be best to grab the
> series in one go. The fact that I hear nothing from input/mfd does not
> make it easier :)

It looks like it will have to go through MFD tree.

Thanks.

-- 
Dmitry
