Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-io0-f178.google.com ([209.85.223.178]:34988 "EHLO
	mail-io0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965228AbbHKRCr (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 11 Aug 2015 13:02:47 -0400
Received: by iodt126 with SMTP id t126so17568516iod.2
        for <linux-iio@vger.kernel.org>; Tue, 11 Aug 2015 10:02:46 -0700 (PDT)
Date: Tue, 11 Aug 2015 12:02:35 -0500
From: Michael Welling <mwelling@ieee.org>
To: Greg Wilson-Lindberg <GWilson@sakuraus.com>
Cc: Michael Welling <mwelling@ieee.org>,
	Daniel Baluta <daniel.baluta@gmail.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: BBB IIO ADC access not working
Message-ID: <20150811170233.GA1872@deathstar>
References: <782E3A02C2EB2347BEA6DEA69DC7AB86021D3CB08DDB@sfamail.SAKURAUS.LOCAL>
 <CAEnQRZAwD+s0C4et9OTeWrwaq3ZDy3+g0YT_KKMUst_PM31DyA@mail.gmail.com>
 <782E3A02C2EB2347BEA6DEA69DC7AB86021D3CB09132@sfamail.SAKURAUS.LOCAL>
 <20150806180730.GA1360@deathstar>
 <782E3A02C2EB2347BEA6DEA69DC7AB86021D3CB0937F@sfamail.SAKURAUS.LOCAL>
 <20150810223338.GA23548@deathstar>
 <782E3A02C2EB2347BEA6DEA69DC7AB86021D3CBD3DB3@sfamail.SAKURAUS.LOCAL>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <782E3A02C2EB2347BEA6DEA69DC7AB86021D3CBD3DB3@sfamail.SAKURAUS.LOCAL>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, Aug 11, 2015 at 09:00:21AM -0700, Greg Wilson-Lindberg wrote:
> Hello Michael,
> 
> .....
> > Try increasing the charge-delay and see if you can find a 
> > value where it stops happening.
> > 
> > Something tells me that it won't fix the issue.
> > 
> > Where is the source tree for this kernel?
> > Which dtb are you using?
> >  
> 
> I increased the charge-delay to 0x10000 and left the system over night with no user
> interaction and it was locked up this morning, I think I'm going to have to agree 
> that changing that to a larger number will not fix the problem.
> 
> Here is a link to the dts that we use:
> http://pastebin.com/5nU27sML
> I did not include the standard dtsi files that we include from the linux source tree,
> just the files that we built ourselves or that we modified.

I do not see the modification that you made to the touchscreen registration.

Guessing you modified this file for the charge-delay:
https://github.com/beagleboard/linux/blob/3.14.40-ti-r62/arch/arm/boot/dts/am335x-bone-ti-tscadc-4-wire.dtsi

> 
> RCN replied thusly to my request for the source tree:
>    Here's the kernel source, the config we use is "bb.org_defconfig"
>    https://github.com/beagleboard/linux/tree/3.14.40-ti-r62
> 
> Thanks for your help in tracking down this problem.

I will compare the drivers in this kernel to the latest work in the mainline.

> 
> Regards,
> Greg
