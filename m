Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from 19pmail.ess.barracuda.com ([64.235.154.231]:50460 "EHLO
	19pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752792AbbHaQBT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 31 Aug 2015 12:01:19 -0400
From: Greg Wilson-Lindberg <GWilson@sakuraus.com>
To: Michael Welling <mwelling@ieee.org>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Date: Mon, 31 Aug 2015 09:01:07 -0700
Subject: RE: Adding MAX1363 to BBB
Message-ID: <782E3A02C2EB2347BEA6DEA69DC7AB86021D3CBD4AB2@sfamail.SAKURAUS.LOCAL>
References: <782E3A02C2EB2347BEA6DEA69DC7AB86021D3CBD4699@sfamail.SAKURAUS.LOCAL>
 <20150824165433.GA3398@deathstar>
 <782E3A02C2EB2347BEA6DEA69DC7AB86021D3CBD498E@sfamail.SAKURAUS.LOCAL>
 <20150827191616.GA8285@deathstar>
 <782E3A02C2EB2347BEA6DEA69DC7AB86021D3CBD49A5@sfamail.SAKURAUS.LOCAL>
 <20150827204225.GA3789@deathstar>
 <782E3A02C2EB2347BEA6DEA69DC7AB86021D3CBD49AB@sfamail.SAKURAUS.LOCAL>
 <782E3A02C2EB2347BEA6DEA69DC7AB86021D3CBD49B7@sfamail.SAKURAUS.LOCAL>
 <782E3A02C2EB2347BEA6DEA69DC7AB86021D3CBD4A61@sfamail.SAKURAUS.LOCAL>
 <20150829003143.GA21865@deathstar>
In-Reply-To: <20150829003143.GA21865@deathstar>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

 

> -----Original Message-----
> From: Michael Welling [mailto:mwelling79@gmail.com] On Behalf 
> Of Michael Welling
> Sent: Friday, August 28, 2015 5:32 PM
> To: Greg Wilson-Lindberg
> Cc: linux-iio@vger.kernel.org
> Subject: Re: Adding MAX1363 to BBB
> 
> On Fri, Aug 28, 2015 at 04:56:20PM -0700, Greg Wilson-Lindberg wrote:
> > 
> > I've got the system running, but I get an invalid argument 
> error on the call to iio_buffer_refill().  I'm basically 
> using the same code as for the tsadc, just added in a fourth 
> channel, and none of the setup calls are returning errors, 
> but the first iio_buffer_refill() call returns an error.  
> I've dumped out the parameter that is being passed to the 
> iio_buffer_refill() call and it is the same as the value that 
> was returned from the iio_device_create_buffer() call.
> > 
> > I've looked at the libiio source and I don't see anything 
> obvious that should return invalid argument for the 
> iio_buffer_refill() call.
> >
> 
> I believe that you need to register an interrupt for buffered 
> access to work.
> 
> Do you have an interrupt connected and registered?
> 

Nope, no interrupt.  So I guess I would need to ask, how would I register the interrupt in the Device Tree?

Or, alternatively, can I just get individual readings through IIO?
 