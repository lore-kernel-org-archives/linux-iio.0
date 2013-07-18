Return-Path: <marex@denx.de>
From: Marek Vasut <marex@denx.de>
To: Otavio Salvador <otavio@ossystems.com.br>
Subject: Re: ADC setting for differential and single-ended channels
Date: Thu, 18 Jul 2013 05:31:01 +0200
Cc: Jonathan Cameron <jic23@kernel.org>,
 linux-iio@vger.kernel.org,
 Mario Goulart <mario@ossystems.com.br>,
 "Lars-Peter Clausen" <lars@metafoo.de>
References: <CAP9ODKq7TkBnpQSvwMRT0Cdy5wwfDGZ3E0ddP5vHkEgmskbcyg@mail.gmail.com> <814feb73-b2b3-4f23-8066-4221b75ac0b9@email.android.com> <CAP9ODKr4qC3EuRwbx9=dcTMvYjT2sAMTdBBsYs_-Z82rQ0e2DQ@mail.gmail.com>
In-Reply-To: <CAP9ODKr4qC3EuRwbx9=dcTMvYjT2sAMTdBBsYs_-Z82rQ0e2DQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Message-Id: <201307180531.02207.marex@denx.de>
List-ID: <linux-iio@vger.kernel.org>

Dear Otavio Salvador,

> On Wed, Jul 17, 2013 at 4:12 PM, Jonathan Cameron <jic23@kernel.org> wrote:
> > Otavio Salvador <otavio@ossystems.com.br> wrote:
> >>Hello,
> >>
> >>Mario and I are working at TI ADS124x driver and this chip can be used
> >>in two ways:
> >>
> >>In case of ADS1247:
> >> - 2 differential channels
> >> - 3 single-ended channels
> >>
> >>In the first case it take two inputs and the chip returns the
> >>difference between them; in the second case it does the same but you
> >>must choose one channel to be the negative reference for all the other
> >>inputs. This is how we understood the datasheet however the
> >>single-ended use is quite confusing on it so we might be wrong.
> >>
> >>So we'd like to know the best way to handle those cases in the driver.
> >>
> >>One alternative we discussed is to use two attributes in the dts as:
> >> ...
> >> #channels = <2>;
> >> channels = <0 3
> >> 
> >>                    1 2>;
> >>
> >>So it'd take two channels. One composed by input 0 and input 3 and
> >>another composed by input 1 and input 2.
> >>
> >>On the another case, we'd use:
> >>  ...
> >>  #channels = <3>
> >>  channels = <0 3
> >>  
> >>                     1 3
> >>                     2 3>;
> >>
> >>So it'd take three channels and all them comparing to input 3.
> >>
> >>Are we in the right route? Any hints how to better solve this?
> >>
> > Another option is to leave it entirely up to user space.  See max1363
> > driver where both single ended and differential channels are supported
> > at the same time with care taken in buffered mode.
> > 
> > Not sure if that works for your case?
> 
> I think it is nicer to have it set in the dt; we need the dt anyway so
> it seems logical to get it setting  the right channel.

Can you please elaborate why is it logical?

I took a brief look over the datasheet [1], here are the facts I see (correct me 
if I'm wrong). I first looked at Figure 51. :

- ADS1246 has two input channels
- ADS1247 has four input channels
- ADS1428 has eight input channels

- Each one of the 2/4/8 input channels can be connected to either P(+) or N(-) 
of the amplifier (figure 53) for the ADC.

- Apparently, according to Figure 51. , it is possible to have only one P and 
one N channel enabled at time (and therefore sample only one pair of channels 
with the ADC) since the P and N rails are shared by all the inputs and there's 
only one ADC block.

Therefore, the userland would have to export sysfs file for each of the channels 
where one would write if the channel is possitive(+) / negative(-) / 
not_connected(NC) and then trigger the start of sampling.

What do you think?

[1] http://www.ti.com/lit/ds/symlink/ads1247.pdf

Best regards,
Marek Vasut
