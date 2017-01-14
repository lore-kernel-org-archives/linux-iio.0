Return-Path: <SRS0=wt21=Y4=onstation.org=masneyb@kernel.org>
Date: Sat, 14 Jan 2017 15:00:51 -0500
From: Brian Masney <masneyb@onstation.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, gregkh@linuxfoundation.org,
	devel@driverdev.osuosl.org, knaack.h@gmx.de, lars@metafoo.de,
	pmeerw@pmeerw.net, linux-kernel@vger.kernel.org,
	ldewangan@nvidia.com
Subject: Re: [PATCH 02/19] staging: iio: isl29028: remove enable flag from
 isl29028_enable_proximity()
Message-ID: <20170114200050.spnbtiazo6metsi3@basecamp.onstation.org>
References: <1480817983-32359-1-git-send-email-masneyb@onstation.org>
 <1480817983-32359-3-git-send-email-masneyb@onstation.org>
 <c578b88b-9b8a-b3a3-ae05-bfd6f7522871@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <c578b88b-9b8a-b3a3-ae05-bfd6f7522871@kernel.org>
List-ID: <linux-iio@vger.kernel.org>

On Sun, Dec 04, 2016 at 11:16:04AM +0000, Jonathan Cameron wrote:
> On 04/12/16 02:19, Brian Masney wrote:
> > isl29028_enable_proximity() has a boolean argument named enable. This
> > function is only called once and the enable flag is set to true in that
> > call. This patch removes the enable parameter from that function.
> > 
> > Signed-off-by: Brian Masney <masneyb@onstation.org>
>
> The first thing that strikes me about this, is why do we have an enable
> only function?
> 
> I think the intention was probably that we also disable the proximity
> sensing after the
> reading was done...  Ideally we'd do this a little more cleverly,
> perhaps using runtime
> pm so that if someone is requesting a stream of proximity measurements,
> we won't end up
> powering up and down each time.
> 
> It's a little 'interesting' as we would want to power this element down
> even if we do
> have a continuous stream of reads on the ALS.  As such we may need to
> roll our own
> equivalent of runtime pm.
> 
> In the first instance, I'd just put a disable after the reading is
> taken.  This will
> make a bit of a mockery of the faster sampling frequencies but there we
> are!
>
> ---------------------
>
> On second thoughts (stupid email is hiding somewhere to be sent when I
> have wifi so can't reply to it) perhaps this is a coarse way of only
> turning proximity on if the LED is present?  Not sure...

Hi Jonathan,

I chained your two replies together above. I am probably stating the
obvious here, but I've verified with an oscilloscope that the IRDR pin
that drives the external LED is off when the chip is first initialized
and ALS readings are taken. The IRDR pin fluctuates between high and low
every 100us (if memory serves me right) once the first proximity reading
is taken until the chip is suspended.

What do you think about enabling runtime auto suspend after say 2
seconds for the whole device? There is the situation that you describe
where if someone is continuously polling the ALS but asks for a single
proximity reading. The external LED will stay on in that case. Once the
chip is suspended, and later resumes, the IRDR pin that drives the
external LED will be off until the user asks for another proximity
reading. That would allow for the faster sampling frequency.

If you still prefer, I'll go the route of shutting down the IRDR pin
after a proximity reading is taken.

Brian
