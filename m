Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-io0-f181.google.com ([209.85.223.181]:36185 "EHLO
	mail-io0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752505AbbHTQOX (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 20 Aug 2015 12:14:23 -0400
Received: by iodv127 with SMTP id v127so51576392iod.3
        for <linux-iio@vger.kernel.org>; Thu, 20 Aug 2015 09:14:22 -0700 (PDT)
Date: Thu, 20 Aug 2015 11:14:14 -0500
From: Michael Welling <mwelling@ieee.org>
To: Greg Wilson-Lindberg <GWilson@sakuraus.com>
Cc: Daniel Baluta <daniel.baluta@gmail.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: BBB IIO ADC access not working
Message-ID: <20150820161359.GA5167@deathstar>
References: <20150818223114.GA1372@deathstar>
 <782E3A02C2EB2347BEA6DEA69DC7AB86021D3CBD43DF@sfamail.SAKURAUS.LOCAL>
 <20150819175230.GA29773@deathstar>
 <782E3A02C2EB2347BEA6DEA69DC7AB86021D3CBD444B@sfamail.SAKURAUS.LOCAL>
 <20150819204847.GA28779@deathstar>
 <782E3A02C2EB2347BEA6DEA69DC7AB86021D3CBD4454@sfamail.SAKURAUS.LOCAL>
 <20150819212906.GC29773@deathstar>
 <782E3A02C2EB2347BEA6DEA69DC7AB86021D3CBD445E@sfamail.SAKURAUS.LOCAL>
 <20150819214242.GB28779@deathstar>
 <782E3A02C2EB2347BEA6DEA69DC7AB86021D3CBD44D6@sfamail.SAKURAUS.LOCAL>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <782E3A02C2EB2347BEA6DEA69DC7AB86021D3CBD44D6@sfamail.SAKURAUS.LOCAL>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, Aug 20, 2015 at 08:50:28AM -0700, Greg Wilson-Lindberg wrote:
>  
> 
> > -----Original Message-----
> > From: Michael Welling [mailto:mwelling79@gmail.com] On Behalf 
> > Of Michael Welling
> > Sent: Wednesday, August 19, 2015 2:43 PM
> > To: Greg Wilson-Lindberg
> > Cc: Daniel Baluta; linux-iio@vger.kernel.org
> > Subject: Re: BBB IIO ADC access not working
> > 
> > On Wed, Aug 19, 2015 at 02:34:39PM -0700, Greg Wilson-Lindberg wrote:
> > > 
> > > So, in that case, can I just open it once and leave it open?
> > 
> > Yes.
> > 
> > > Is it reading from a buffer, or is it reading what is 
> > current in the ADC? 
> > 
> > It is the current reading.
> > 
> > > Can I just set up a timer to get readings to average then?
> > 
> > Sure.
> > 
> > Here are some helper functions:
> > 
> > int iio_adc_open_channel(int dev_num, int chan_num) {
> > 	char filename[255];
> > 
> > 	sprintf(filename, 
> > "/sys/bus/iio/devices/iio:device%d/in_voltage%d_raw",
> > 			dev_num, chan_num);
> > 
> > 	return open(filename, O_RDONLY);
> > }
> > 
> > int iio_adc_read_channel(int fd)
> > {
> > 	int count;
> > 	char buffer[255];
> > 	int value = -1;
> > 
> > 	lseek(fd,0,SEEK_SET);
> > 
> > 	count = read(fd, buffer, 255);
> > 
> > 	if (count > 0)
> > 		value = strtoul(buffer, NULL, 10);
> > 
> > 	return value;
> > }
> > 
> > Example usage:
> > 
> > int fd;
> > .
> > .
> > 
> > fd = iio_adc_open_channel(0, 4);
> > .
> > .
> > 
> > while (1)
> > {
> > 	printf("ADC = %x\n", iio_adc_read_channel(fd)); }
> > 
> > 
> 
> I converted to using this interface and left the system running overnight and 
> the touch screen was locked up this morning.

This is without any modifications to the kernel?

