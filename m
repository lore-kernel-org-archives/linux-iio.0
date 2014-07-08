Return-Path: <zubair.lutfullah@gmail.com>
From: "Zubair Lutfullah :" <zubair.lutfullah@gmail.com>
Date: Tue, 8 Jul 2014 19:53:45 +0100
To: Jonathan Cameron <jic23@kernel.org>
Cc: Jan Kardell <jan.kardell@telliq.com>, Zubair Lutfullah:
	zubair.lutfullah@gmail.com,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-iio@vger.kernel.org, linux-omap@vger.kernel.org,
	Rachna Patil <rachna@ti.com>
Subject: Re: [PATCH] iio: ti_am335x_adc: Use same step id at FIFOs both ends
Message-ID: <20140708185344.GA4868@gmail.com>
References: <1402521498-11535-1-git-send-email-jan.kardell@telliq.com>
 <53A555A7.7070800@kernel.org>
 <20140621102658.GA5177@gmail.com>
 <53A80840.5050906@telliq.com>
 <53BAD468.8090908@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <53BAD468.8090908@kernel.org>
List-ID: <linux-iio@vger.kernel.org>

On Mon, Jul 07, 2014 at 06:10:00PM +0100, Jonathan Cameron wrote:
> On 23/06/14 11:58, Jan Kardell wrote:
> >Zubair Lutfullah : skriver:
> >>On Sat, Jun 21, 2014 at 10:51:35AM +0100, Jonathan Cameron wrote:
> >>>On 11/06/14 22:18, Jan Kardell wrote:
> >>>>Since AI lines could be selected at will (linux-3.11) the sending
> >>>>and receiving ends of the FIFO does not agree about what step is used
> >>>>for a line. It only works if the last lines are used, like 5,6,7,
> >>>>and fails if ie 2,4,6 is selected in DT.
> >>>>
> >>>>Signed-off-by: Jan Kardell <jan.kardell@telliq.com>
> >>>I'd like an ack / review from someone more familiar with this part than I
> >>>am. I have cc'd a few people who might offer a view.
> >>Been a while since I've seen this driver.
> >>I'll try a bit..
> >>
> >>>Thanks,
> >>>
> >>>Jonathan (IIO maintainer)
> >>>>---
> >>>>  drivers/iio/adc/ti_am335x_adc.c | 2 +-
> >>>>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>>>
> >>>>diff --git a/drivers/iio/adc/ti_am335x_adc.c b/drivers/iio/adc/ti_am335x_adc.c
> >>>>index a4db302..d5dc4c6 100644
> >>>>--- a/drivers/iio/adc/ti_am335x_adc.c
> >>>>+++ b/drivers/iio/adc/ti_am335x_adc.c
> >>>>@@ -374,7 +374,7 @@ static int tiadc_read_raw(struct iio_dev *indio_dev,
> >>>>              return -EAGAIN;
> >>>>          }
> >>>>      }
> >>>>-    map_val = chan->channel + TOTAL_CHANNELS;
> >>>>+    map_val = adc_dev->channel_step[chan->scan_index];
> >>Looking at the code again.
> >>Could you tell me if using map_val = step_en will work?
> >>
> I'm completely lost!  Zubair, has Jan answered your query?
> (he says trying to avoid diving into the data sheets)
> 

Sorry for the long delays.

Yes Jan has answered my query.

It took a while to bring up my Beagle again.

But you can put my <Tested-by>.

And I think I figured out where things went awry.

It used to be that, the single channel read would read all channels.
Despite what was configured in DT. And then return the required channel.

When Sebastian fixed that in  mfd: input: iio: ti_amm335x: Rework TSC/ADC synchronization

This bug crept up. only the required channel is enabled. But when reading the fifo
it is checked against the old incorrect channel id.

I am guessing he would check the driver by enabling all channels like I do. ;)

A very nice bug caught by Jan.

Cheers
ZubairLK
