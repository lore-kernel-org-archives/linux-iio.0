Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from 19pmail.ess.barracuda.com ([64.235.154.230]:36030 "EHLO
	19pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750986AbbHTSlU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 20 Aug 2015 14:41:20 -0400
From: Greg Wilson-Lindberg <GWilson@sakuraus.com>
To: Michael Welling <mwelling@ieee.org>
CC: Daniel Baluta <daniel.baluta@gmail.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Date: Thu, 20 Aug 2015 11:41:03 -0700
Subject: RE: BBB IIO ADC access not working
Message-ID: <782E3A02C2EB2347BEA6DEA69DC7AB86021D3CBD4519@sfamail.SAKURAUS.LOCAL>
References: <20150819175230.GA29773@deathstar>
 <782E3A02C2EB2347BEA6DEA69DC7AB86021D3CBD444B@sfamail.SAKURAUS.LOCAL>
 <20150819204847.GA28779@deathstar>
 <782E3A02C2EB2347BEA6DEA69DC7AB86021D3CBD4454@sfamail.SAKURAUS.LOCAL>
 <20150819212906.GC29773@deathstar>
 <782E3A02C2EB2347BEA6DEA69DC7AB86021D3CBD445E@sfamail.SAKURAUS.LOCAL>
 <20150819214242.GB28779@deathstar>
 <782E3A02C2EB2347BEA6DEA69DC7AB86021D3CBD44D6@sfamail.SAKURAUS.LOCAL>
 <20150820161359.GA5167@deathstar>
 <782E3A02C2EB2347BEA6DEA69DC7AB86021D3CBD4502@sfamail.SAKURAUS.LOCAL>
 <20150820173101.GB5167@deathstar>
In-Reply-To: <20150820173101.GB5167@deathstar>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

 

> -----Original Message-----
> From: Michael Welling [mailto:mwelling79@gmail.com] On Behalf 
> Of Michael Welling
> Sent: Thursday, August 20, 2015 10:31 AM
> To: Greg Wilson-Lindberg
> Cc: Daniel Baluta; linux-iio@vger.kernel.org
> Subject: Re: BBB IIO ADC access not working
> 
> On Thu, Aug 20, 2015 at 10:27:30AM -0700, Greg Wilson-Lindberg wrote:
> > 
> > 
> > > -----Original Message-----
> > > From: Greg Wilson-Lindberg
> > > Sent: Thursday, August 20, 2015 9:19 AM
> > > To: 'Michael Welling'
> > > Cc: Daniel Baluta; linux-iio@vger.kernel.org
> > > Subject: RE: BBB IIO ADC access not working
> > > 
> > >  
> > > 
> > > > -----Original Message-----
> > > > From: Michael Welling [mailto:mwelling79@gmail.com] On 
> Behalf Of 
> > > > Michael Welling
> > > > Sent: Thursday, August 20, 2015 9:14 AM
> > > > To: Greg Wilson-Lindberg
> > > > Cc: Daniel Baluta; linux-iio@vger.kernel.org
> > > > Subject: Re: BBB IIO ADC access not working
> > > > 
> > > > On Thu, Aug 20, 2015 at 08:50:28AM -0700, Greg
> > > Wilson-Lindberg wrote:
> > > > >  
> > > > > 
> > > > > > -----Original Message-----
> > > > > > From: Michael Welling [mailto:mwelling79@gmail.com] On
> > > Behalf Of
> > > > > > Michael Welling
> > > > > > Sent: Wednesday, August 19, 2015 2:43 PM
> > > > > > To: Greg Wilson-Lindberg
> > > > > > Cc: Daniel Baluta; linux-iio@vger.kernel.org
> > > > > > Subject: Re: BBB IIO ADC access not working
> > > > > > 
> > > > > > On Wed, Aug 19, 2015 at 02:34:39PM -0700, Greg
> > > > Wilson-Lindberg wrote:
> > > > > > > 
> > > > > > > So, in that case, can I just open it once and 
> leave it open?
> > > > > > 
> > > > > > Yes.
> > > > > > 
> > > > > > > Is it reading from a buffer, or is it reading what is
> > > > > > current in the ADC? 
> > > > > > 
> > > > > > It is the current reading.
> > > > > > 
> > > > > > > Can I just set up a timer to get readings to average then?
> > > > > > 
> > > > > > Sure.
> > > > > > 
> > > > > > Here are some helper functions:
> > > > > > 
> > > > > > int iio_adc_open_channel(int dev_num, int chan_num) {
> > > > > > 	char filename[255];
> > > > > > 
> > > > > > 	sprintf(filename,
> > > > > > "/sys/bus/iio/devices/iio:device%d/in_voltage%d_raw",
> > > > > > 			dev_num, chan_num);
> > > > > > 
> > > > > > 	return open(filename, O_RDONLY); }
> > > > > > 
> > > > > > int iio_adc_read_channel(int fd) {
> > > > > > 	int count;
> > > > > > 	char buffer[255];
> > > > > > 	int value = -1;
> > > > > > 
> > > > > > 	lseek(fd,0,SEEK_SET);
> > > > > > 
> > > > > > 	count = read(fd, buffer, 255);
> > > > > > 
> > > > > > 	if (count > 0)
> > > > > > 		value = strtoul(buffer, NULL, 10);
> > > > > > 
> > > > > > 	return value;
> > > > > > }
> > > > > > 
> > > > > > Example usage:
> > > > > > 
> > > > > > int fd;
> > > > > > .
> > > > > > .
> > > > > > 
> > > > > > fd = iio_adc_open_channel(0, 4); .
> > > > > > .
> > > > > > 
> > > > > > while (1)
> > > > > > {
> > > > > > 	printf("ADC = %x\n", iio_adc_read_channel(fd)); }
> > > > > > 
> > > > > > 
> > > > > 
> > > > > I converted to using this interface and left the 
> system running 
> > > > > overnight and the touch screen was locked up this morning.
> > > > 
> > > > This is without any modifications to the kernel?
> > > > 
> > > 
> > > This was still running the kernel modifications.  I've 
> restarted it 
> > > this morning without the kernel modifications.
> > 
> > I just dumped what I'm reading from the sys fs and all I'm 
> getting back is -1.
> 
> Are you doing error checking on the file descriptor on open?
> > 
> 

You were right, I had gone back to the original kernel that RCN shipped with 
the image and it doesn't export /sys/bus/iio.

I rebuilt the 3.14.49-ti-r62 kernel, which is the same release as the kernel in the image, but it does export /sys/bus/iio, so that much is working better.

But (there's always a but, isn't there), I'm reading three channels from the ADC, 4, 5, & 6. Channel 4 gets a good reading maybe 60% of the time I read it. Channel 5 
gets a good reading maybe every 40-50 tries. Channel 6 hardly ever gets a good
reading.

I guess I could just loop if I get a busy response, although I don't know how many 
times I will get that return before I get a good reading.

