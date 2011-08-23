Return-Path: <malas@tcoe.iitm.ac.in>
From: "malas" <malas@tcoe.iitm.ac.in>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: linux-iio@vger.kernel.org
Subject: Re: ad7793 iio-ring test read issue - Reg
Date: Tue, 23 Aug 2011 16:55:52 +0530
Message-Id: <20110823112234.M44553@tcoe.iitm.ac.in>
In-Reply-To: <4E538D35.7090508@cam.ac.uk>
References: <20110823080829.M36921@tcoe.iitm.ac.in> <4E538D35.7090508@cam.ac.uk>
MIME-Version: 1.0
Content-Type: text/plain;
	charset=iso-8859-1
List-ID: <linux-iio@vger.kernel.org>



Dear Jonathan Cameron,

The kernel version I am using is :

---------------------------------------------------------------------
midas@ubuntu:~/Mala/Telemedicine/uclinux_source/uc2010_source/uclinux/2010R1$ svn info 
Path: .
URL: svn://blackfin.uclinux.org/uclinux-dist/branches/2010R1
Repository Root: svn://blackfin.uclinux.org/uclinux-dist
Repository UUID: 3e2a5524-39e8-4cb9-84a9-c49da69cba3a
Revision: 10161
Node Kind: directory
Schedule: normal
Last Changed Author: vapier
Last Changed Rev: 10136
Last Changed Date: 2011-04-02 22:36:15 +0530 (Sat, 02 Apr 2011)
---------------------------------------------------------------------

Regards
Mala

On Tue, 23 Aug 2011 12:21:25 +0100, Jonathan Cameron wrote
> On 08/23/11 09:18, malas wrote:
> > 
> > Dear Michael Hennerich,
> > 
> > 
> > I shall post iio quesris in this mail list as per your suggestions.
> > 
> > AD7793 driver is built into kernel. The chip gets configured and am able to read data on
> > continuous mode via spi interface using ad7793 driver at kernel level.
> > 
> > While testing userspace test iio-ring to read data from ring buffer, generic_buffer code
> > was executed, it  proceeds till opening /sys/bus/iio/devices/device0:buffer0 and
> > Read call fails.
> Question 1: What's the kernel and where did you get it from? (Interfaces are moving
> fast so it's plausible you've fallen in a hole where userspace wasn't matching 
> kernelspace).
> > 
> > In fs I can list the iio device ad7793 with following properties get/set.
> > 
> > root:/> ls /sys/bus/iio/devices/device0\:buffer0/
> > bytes_per_datum  enable           power            subsystem
> > dev              length           scan_elements    uevent
> > root:/>
> > 
> > I find access0 and event0 missing in this list. Is that the reason for read() fails.
> Yes.  Question is why and without kernel version I don't know where to look 
> I'm afraid.
> 
> > 
> > Please help.
> > 
> > Thanks
> > Mala
> > --
> > Open WebMail Project (http://openwebmail.org)
> > 
> > 
> > 
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >


--
Open WebMail Project (http://openwebmail.org)
