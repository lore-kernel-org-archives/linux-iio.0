Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.9]:40764 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750981Ab3GREL3 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 18 Jul 2013 00:11:29 -0400
From: Marek Vasut <marex@denx.de>
To: Otavio Salvador <otavio@ossystems.com.br>
Subject: Re: ADC setting for differential and single-ended channels
Date: Thu, 18 Jul 2013 06:11:28 +0200
Cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
	Mario Goulart <mario@ossystems.com.br>,
	"Lars-Peter Clausen" <lars@metafoo.de>
References: <CAP9ODKq7TkBnpQSvwMRT0Cdy5wwfDGZ3E0ddP5vHkEgmskbcyg@mail.gmail.com> <CAP9ODKqXg4DwXs3eXPrNR1j3fw4_H5bt+xwfuYMHuYgM+QrKPg@mail.gmail.com> <201307180608.09345.marex@denx.de>
In-Reply-To: <201307180608.09345.marex@denx.de>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Message-Id: <201307180611.28853.marex@denx.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

[...]

> > >> 
> > >> I think it is nicer to have it set in the dt; we need the dt anyway so
> > >> it seems logical to get it setting  the right channel.
> > > 
> > > Can you please elaborate why is it logical?
> > > 
> > > I took a brief look over the datasheet [1], here are the facts I see
> > > (correct me if I'm wrong). I first looked at Figure 51. :
> > > 
> > > - ADS1246 has two input channels
> > > - ADS1247 has four input channels
> > > - ADS1428 has eight input channels
> > > 
> > > - Each one of the 2/4/8 input channels can be connected to either P(+)
> > > or N(-) of the amplifier (figure 53) for the ADC.
> > > 
> > > - Apparently, according to Figure 51. , it is possible to have only one
> > > P and one N channel enabled at time (and therefore sample only one
> > > pair of channels with the ADC) since the P and N rails are shared by
> > > all the inputs and there's only one ADC block.
> > > 
> > > Therefore, the userland would have to export sysfs file for each of the
> > > channels where one would write if the channel is possitive(+) /
> > > negative(-) / not_connected(NC) and then trigger the start of sampling.
> > > 
> > > What do you think?
> > 
> > This does not make them act as differential  against each other.
> > 
> > We can have several combinations as:
> > 
> > 0 - P / 1 - N (differential)
> > 0 - P / 1 - P / 2 - P / 3 - N (all differential to 3)
> > and so on.
> > 
> > So how userland would tell which would be the differential to use?
> > 
> > Our board has:
> > 
> > 0 against 1
> > 2 against 3
> > 
> > but it is a design choice.
> > 
> > Am I missing something?
> 
> echo 'P' > /sys/.../chan_mux_0
> echo 'P' > /sys/.../chan_mux_2
> echo 'N' > /sys/.../chan_mux_1
> echo 'N' > /sys/.../chan_mux_3
> 
> Like this for example ;-) And this could be nicely implemented via IIO, but
> I believe there might even already be an IIO API for this stuff.

btw. you might even implement some kind of channel sets, where you could have 
mapping between 1 P-channel : N N-channel or the other way around , but this 
seems rather complex. I'm just adding this here as an option that came to me.

Best regards,
Marek Vasut
