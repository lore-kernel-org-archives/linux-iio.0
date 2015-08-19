Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from 19pmail.ess.barracuda.com ([64.235.150.244]:46552 "EHLO
	19pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751440AbbHSVey convert rfc822-to-8bit (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 19 Aug 2015 17:34:54 -0400
From: Greg Wilson-Lindberg <GWilson@sakuraus.com>
To: Michael Welling <mwelling@ieee.org>
CC: Daniel Baluta <daniel.baluta@gmail.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Date: Wed, 19 Aug 2015 14:34:39 -0700
Subject: RE: BBB IIO ADC access not working
Message-ID: <782E3A02C2EB2347BEA6DEA69DC7AB86021D3CBD445E@sfamail.SAKURAUS.LOCAL>
References: <20150818173703.GA5096@deathstar>
 <782E3A02C2EB2347BEA6DEA69DC7AB86021D3CBD42D8@sfamail.SAKURAUS.LOCAL>
 <20150818181324.GC5096@deathstar>
 <782E3A02C2EB2347BEA6DEA69DC7AB86021D3CBD4340@sfamail.SAKURAUS.LOCAL>
 <20150818223114.GA1372@deathstar>
 <782E3A02C2EB2347BEA6DEA69DC7AB86021D3CBD43DF@sfamail.SAKURAUS.LOCAL>
 <20150819175230.GA29773@deathstar>
 <782E3A02C2EB2347BEA6DEA69DC7AB86021D3CBD444B@sfamail.SAKURAUS.LOCAL>
 <20150819204847.GA28779@deathstar>
 <782E3A02C2EB2347BEA6DEA69DC7AB86021D3CBD4454@sfamail.SAKURAUS.LOCAL>
 <20150819212906.GC29773@deathstar>
In-Reply-To: <20150819212906.GC29773@deathstar>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

 

> -----Original Message-----
> From: Michael Welling [mailto:mwelling79@gmail.com] On Behalf 
> Of Michael Welling
> Sent: Wednesday, August 19, 2015 2:29 PM
> To: Greg Wilson-Lindberg
> Cc: Daniel Baluta; linux-iio@vger.kernel.org
> Subject: Re: BBB IIO ADC access not working
> 
> On Wed, Aug 19, 2015 at 02:13:10PM -0700, Greg Wilson-Lindberg wrote:
> > 
> > I'm not using 
> /sys/bus/iio/devices/iio:device0/in_voltageX_raw in my 
> > program, I'm using the iio buffer system.
> > 
> > I tried using cat /sys/bus/iio/devices/iio:device0/in_voltageX_raw 
> > while my program was running and it worked a couple of 
> times, and got 
> > busy a bit also, then the touch screen locked up.
> 
> This is expected because when the buffer is enabled the 
> device IS busy.
> > 
> > I have not tried to use 
> > /sys/bus/iio/devices/iio:device0/in_voltageX_raw from in my 
> program, I 
> > was hoping for a lighter weight access that didn't require so many 
> > opens & closes. I'm under the impression that I can only 
> get one reading per open if I try to read 
> /sys/bus/iio/devices/iio:device0/in_voltageX_raw.
> > Or can I get multiple readings if I do multiple reads.
> >
> 
> You should be able to keep the file descriptor open and 
> perform multiple reads.
> 
> It is necessary lseek before reading from the same channel again.
> 
> lseek(fd, 0, SEEK_SET);
> 
> You will need a separate file descriptor for each channel.
>  

So, in that case, can I just open it once and leave it open?
Is it reading from a buffer, or is it reading what is current in the ADC? 
Can I just set up a timer to get readings to average then?
