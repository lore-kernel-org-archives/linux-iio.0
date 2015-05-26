Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from 19pmail.ess.barracuda.com ([64.235.150.244]:59785 "EHLO
	19pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751378AbbEZSFc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 26 May 2015 14:05:32 -0400
From: Greg Wilson-Lindberg <GWilson@sakuraus.com>
To: Michael Welling <mwelling@ieee.org>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Date: Tue, 26 May 2015 11:04:57 -0700
Subject: RE: BBB touch screen and ADC interactions
Message-ID: <782E3A02C2EB2347BEA6DEA69DC7AB86021D3C87D740@sfamail.SAKURAUS.LOCAL>
References: <782E3A02C2EB2347BEA6DEA69DC7AB86021D3C87D113@sfamail.SAKURAUS.LOCAL>
 <20150519230932.GA15718@deathray>
 <782E3A02C2EB2347BEA6DEA69DC7AB86021D3C87D46F@sfamail.SAKURAUS.LOCAL>
 <F4A1ABDE-E030-405D-A0BB-A4CD80E9F84F@ieee.org>
 <782E3A02C2EB2347BEA6DEA69DC7AB86021D3C87D47E@sfamail.SAKURAUS.LOCAL>
 <20150520003435.GA16055@deathray>
 <782E3A02C2EB2347BEA6DEA69DC7AB86021D3C87D53C@sfamail.SAKURAUS.LOCAL>
 <20150520221417.GA21017@deathray>
 <782E3A02C2EB2347BEA6DEA69DC7AB86021D3C87D549@sfamail.SAKURAUS.LOCAL>
 <20150520230409.GA21360@deathray> <20150526174255.GA7739@deathray>
In-Reply-To: <20150526174255.GA7739@deathray>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

> > It should.
> 
> Greg,
> 
> Have you had any success using the buffer enable/disable mechanism?
> 
Hi Michael,
Yes, it seems to be working, even with the 3.14 kernel. I've been fighting some hardware problems on our prototype so I haven't been able to test it as well as I would like.

Regards,
Greg 

> Regards,
> 
> Michael
> 