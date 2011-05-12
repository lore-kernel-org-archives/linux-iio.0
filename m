Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-52.csi.cam.ac.uk ([131.111.8.152]:47828 "EHLO
	ppsw-52.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932110Ab1ELOFI (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 12 May 2011 10:05:08 -0400
Message-ID: <4DCBE9B0.8060501@cam.ac.uk>
Date: Thu, 12 May 2011 15:07:44 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: Prashant Shah <pshah.mumbai@gmail.com>
CC: linux-iio@vger.kernel.org
Subject: Re: drivers for usb daq card
References: <BANLkTikjnjSRtDRBHjXeMfHAOEsVzkkwag@mail.gmail.com> <4DBBDFE7.5060207@cam.ac.uk> <BANLkTinejkJViZ_tX8QyivPh14nzVNfjWA@mail.gmail.com>
In-Reply-To: <BANLkTinejkJViZ_tX8QyivPh14nzVNfjWA@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi

Firstly sorry for the extremely slow reply.  I read the email on my phone
and as I haven't figured out how to reply inline, I thought - I'll do it
tomorrow - then completely forgot.  Ooops.
> 
> On Sat, Apr 30, 2011 at 3:39 PM, Jonathan Cameron <jic23@cam.ac.uk> wrote:
>> On 04/30/11 08:33, Prashant Shah wrote:
>>> Hi,
>>> I was initially trying to do that with the comedi based system but I
>>> was suggest to try working with the IIO sub system.
>> That's curious. I was going to suggest you looked at comedi!
>> Out of interest, what was the reason given?
> 
> http://lists.kernelnewbies.org/pipermail/kernelnewbies/2011-April/001616.html
Hmm. Greg may be speculating a touch there.  New drivers maybe...
> 
>>> I am newbie so I dont want to do something that will be hard
>>> for me to work with :)
>> Two initial questions.  Do you have the full docs? NI haven't been
>> helpful to my requests in the past (which has put me off ever using
>> their kit again).
> 
> I dont have any docs other than what is available on their website. Is
> it possible to track the usb traffic and work with that.
It's certainly possible and having looked at the above post I see you have
made some progress. Any luck getting it working?
> The device
> that I am working with in pretty basic and we are interested in only
> the getting the analog input data for the time being.
> 
>> Secondly, why does this want to be in kernel space?
> 
> There are few similar devices in the staging/comedi/drivers area. I am
> just following them! I dont know whether comedi can work with libusb.
Directly, it probably can't.  Comedi goes through a library though (iirc)
so it would probably be possible to do things at that level.

Jonathan
