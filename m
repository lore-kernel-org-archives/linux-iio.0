Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-io0-f171.google.com ([209.85.223.171]:36698 "EHLO
	mail-io0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752869AbbH2Acd (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 28 Aug 2015 20:32:33 -0400
Received: by ioej130 with SMTP id j130so27949305ioe.3
        for <linux-iio@vger.kernel.org>; Fri, 28 Aug 2015 17:32:32 -0700 (PDT)
Date: Fri, 28 Aug 2015 19:32:26 -0500
From: Michael Welling <mwelling@ieee.org>
To: Greg Wilson-Lindberg <GWilson@sakuraus.com>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: Adding MAX1363 to BBB
Message-ID: <20150829003143.GA21865@deathstar>
References: <782E3A02C2EB2347BEA6DEA69DC7AB86021D3CBD4699@sfamail.SAKURAUS.LOCAL>
 <20150824165433.GA3398@deathstar>
 <782E3A02C2EB2347BEA6DEA69DC7AB86021D3CBD498E@sfamail.SAKURAUS.LOCAL>
 <20150827191616.GA8285@deathstar>
 <782E3A02C2EB2347BEA6DEA69DC7AB86021D3CBD49A5@sfamail.SAKURAUS.LOCAL>
 <20150827204225.GA3789@deathstar>
 <782E3A02C2EB2347BEA6DEA69DC7AB86021D3CBD49AB@sfamail.SAKURAUS.LOCAL>
 <782E3A02C2EB2347BEA6DEA69DC7AB86021D3CBD49B7@sfamail.SAKURAUS.LOCAL>
 <782E3A02C2EB2347BEA6DEA69DC7AB86021D3CBD4A61@sfamail.SAKURAUS.LOCAL>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <782E3A02C2EB2347BEA6DEA69DC7AB86021D3CBD4A61@sfamail.SAKURAUS.LOCAL>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, Aug 28, 2015 at 04:56:20PM -0700, Greg Wilson-Lindberg wrote:
> 
> I've got the system running, but I get an invalid argument error on the call to iio_buffer_refill().  I'm basically using the same code as for the tsadc, just added in a fourth channel, and none of the setup calls are returning errors, but the first iio_buffer_refill() call returns an error.  I've dumped out the parameter that is being passed to the iio_buffer_refill() call and it is the same as the value that was returned from the iio_device_create_buffer() call.
> 
> I've looked at the libiio source and I don't see anything obvious that should return invalid argument for the iio_buffer_refill() call.
>

I believe that you need to register an interrupt for buffered access to work.

Do you have an interrupt connected and registered?

