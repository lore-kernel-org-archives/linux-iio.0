Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-io0-f176.google.com ([209.85.223.176]:33226 "EHLO
	mail-io0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751788AbbHJWdr (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 10 Aug 2015 18:33:47 -0400
Received: by ioii16 with SMTP id i16so184567650ioi.0
        for <linux-iio@vger.kernel.org>; Mon, 10 Aug 2015 15:33:47 -0700 (PDT)
Date: Mon, 10 Aug 2015 17:33:40 -0500
From: Michael Welling <mwelling@ieee.org>
To: Greg Wilson-Lindberg <GWilson@sakuraus.com>
Cc: Michael Welling <mwelling@ieee.org>,
	Daniel Baluta <daniel.baluta@gmail.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: BBB IIO ADC access not working
Message-ID: <20150810223338.GA23548@deathstar>
References: <782E3A02C2EB2347BEA6DEA69DC7AB86021D3CB08DDB@sfamail.SAKURAUS.LOCAL>
 <CAEnQRZAwD+s0C4et9OTeWrwaq3ZDy3+g0YT_KKMUst_PM31DyA@mail.gmail.com>
 <782E3A02C2EB2347BEA6DEA69DC7AB86021D3CB09132@sfamail.SAKURAUS.LOCAL>
 <20150806180730.GA1360@deathstar>
 <782E3A02C2EB2347BEA6DEA69DC7AB86021D3CB0937F@sfamail.SAKURAUS.LOCAL>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <782E3A02C2EB2347BEA6DEA69DC7AB86021D3CB0937F@sfamail.SAKURAUS.LOCAL>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, Aug 10, 2015 at 03:22:58PM -0700, Greg Wilson-Lindberg wrote:
> I added the charge-delay, it does make the system last longer before the touch screen locks up, but it does still lock up.  The program that I'm testing this from is written in qt, the main GUI loop is still running, even though the touch screen has locked up, so the calls to the IIO lib are still being made, although I don't know if I'm getting back the same data as the last time it worked, or I'm not getting back any data at all.
> 
> I tested it with the sampling set to twice a second, and the touch screen locked up more quickly than when set to only sample once a second.
>

Odd.

Try increasing the charge-delay and see if you can find a value where it stops happening.

Something tells me that it won't fix the issue.

Where is the source tree for this kernel?
Which dtb are you using?
 
> Regards,
> Greg
> 

