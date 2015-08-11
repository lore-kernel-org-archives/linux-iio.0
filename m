Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from 19pmail.ess.barracuda.com ([64.235.150.244]:57245 "EHLO
	19pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752728AbbHKQE5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 11 Aug 2015 12:04:57 -0400
From: Greg Wilson-Lindberg <GWilson@sakuraus.com>
To: Michael Welling <mwelling@ieee.org>
CC: Daniel Baluta <daniel.baluta@gmail.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Date: Tue, 11 Aug 2015 09:00:21 -0700
Subject: RE: BBB IIO ADC access not working
Message-ID: <782E3A02C2EB2347BEA6DEA69DC7AB86021D3CBD3DB3@sfamail.SAKURAUS.LOCAL>
References: <782E3A02C2EB2347BEA6DEA69DC7AB86021D3CB08DDB@sfamail.SAKURAUS.LOCAL>
 <CAEnQRZAwD+s0C4et9OTeWrwaq3ZDy3+g0YT_KKMUst_PM31DyA@mail.gmail.com>
 <782E3A02C2EB2347BEA6DEA69DC7AB86021D3CB09132@sfamail.SAKURAUS.LOCAL>
 <20150806180730.GA1360@deathstar>
 <782E3A02C2EB2347BEA6DEA69DC7AB86021D3CB0937F@sfamail.SAKURAUS.LOCAL>
 <20150810223338.GA23548@deathstar>
In-Reply-To: <20150810223338.GA23548@deathstar>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hello Michael,

.....
> Try increasing the charge-delay and see if you can find a 
> value where it stops happening.
> 
> Something tells me that it won't fix the issue.
> 
> Where is the source tree for this kernel?
> Which dtb are you using?
>  

I increased the charge-delay to 0x10000 and left the system over night with no user
interaction and it was locked up this morning, I think I'm going to have to agree 
that changing that to a larger number will not fix the problem.

Here is a link to the dts that we use:
http://pastebin.com/5nU27sML
I did not include the standard dtsi files that we include from the linux source tree,
just the files that we built ourselves or that we modified.

RCN replied thusly to my request for the source tree:
   Here's the kernel source, the config we use is "bb.org_defconfig"
   https://github.com/beagleboard/linux/tree/3.14.40-ti-r62

Thanks for your help in tracking down this problem.

Regards,
Greg
