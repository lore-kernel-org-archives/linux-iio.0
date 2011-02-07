Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-52.csi.cam.ac.uk ([131.111.8.152]:47118 "EHLO
	ppsw-52.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751318Ab1BGQDa (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 7 Feb 2011 11:03:30 -0500
Message-ID: <4D5017D6.90009@cam.ac.uk>
Date: Mon, 07 Feb 2011 16:03:34 +0000
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: "Hennerich, Michael" <Michael.Hennerich@analog.com>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"device-drivers-devel@blackfin.uclinux.org"
	<device-drivers-devel@blackfin.uclinux.org>
Subject: Re: [PATCH 0/4] staging:iio:meter clean up and dead code removal.
References: <1296934459-15760-1-git-send-email-jic23@cam.ac.uk> <544AC56F16B56944AEC3BD4E3D591771324C1BAA0D@LIMKCMBX1.ad.analog.com>
In-Reply-To: <544AC56F16B56944AEC3BD4E3D591771324C1BAA0D@LIMKCMBX1.ad.analog.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 02/07/11 15:34, Hennerich, Michael wrote:
> Jonathan Cameron wrote on 2011-02-05:
>> This is very much the starting point for bashing the meter drivers
>> into shape.  For now I've just removed most of the unused code and stubs.
> 
> Instead of removing the stubs - I would rather prefer implementing them.
I agree in the ideal case.  But even then, it is much easier to review a patch
that adds this functionality from scratch than it is to review one that relies
on large amounts of existing dead code.
> But I think you're right this dead code is not going to be useful either.
> 
>> I have also cleaned up spi bus handling.  I may well have gotten that
>> bit wrong so please do take a look.  In some cases this involved
>> turning one transfer into two so as to clarify what the code was doing.
>> This may cause issues if the spi bus drivers don't play the game
>> properly or as if I got the conversion wrong.
> 
> Looks right - but I had to double check with the datasheet.
> The SPI write then read behavior is a bit undefined.
> In particular, what is shifted out on the MOSI pin during the receive part.
> 
> Some implementations send zero/one or repeat the last word in the shift register, while others tristate MOSI.
> If the target slave device in questions also listens on MOSI while it drives MISO,
> unpredicted behavior my result.
Strange, I thought this was defined as always sending zero if not provided.  If not
then I would suggest we point this inconsistency out to the spi guys and fix it up
in those implementations that don't conform.  Otherwise as you say, one needs
to always specify the other direction just to make sure nothing weird happens.
All my testing is on ancient pxa boards, so I know that they always send zeros and
dump whatever is recieved.
> 
> It's therefore sometimes necessary to use full duplex transfer and drive
> MOSI to a known good state. You basically removed this, but the ADExxxx
> Parts don't seem to depend on this.
> 
>> Next job is to pin down, standardise and document the sysfs interface
>> for these parts.  Anyone care to take this on?
> 
> Considering the complexity and number of new arguments, this is going to take some time.
> But it has to be done. Unfortunately right now I'm a bit loaded with other stuff.
> But I'll open a tracker item for me to look at.
Cool.  If I get really board I might do a data sheet trawl and try and pin this down
in the meantime.
> 
>> Note I have currently left the ade7758 driver alone as it is by far
>> the most complex and didn't suffer the large amount of dead code to be
>> found in the others.
>>
>> All comments as ever welcome.  I'd also like to know what test
>> coverage we have on these parts.
> 
> The ADE7758 is the only one I have test hardware. Ideally we bring this one
> in a good shape and add support for the other parts to it.
Works for me.  Though they are pretty different so I'm not sure a unified driver
would work terribly well for these.  Could be wrong though :)
> 
>> Thanks,
>>
>> Jonathan
>>
>> Jonathan Cameron (4):
>>   staging:iio:meter remove stubs from ade7753.
>>   staging:iio:meter remove stubs from ade7754.
>>   staging:iio:meter remove stubs from ade7759.
>>   staging:iio:meter remove stubs from ade7854.
>  drivers/staging/iio/meter/ade7753.c     |  200 +++++++----------------
>  -------- drivers/staging/iio/meter/ade7753.h     |   64 ----------
>  drivers/staging/iio/meter/ade7754.c     |  165 ++++-------------------
> 
> Greetings,
> Michael
> 
> --
> Analog Devices GmbH      Wilhelm-Wagenfeld-Str. 6      80807 Muenchen
> Sitz der Gesellschaft: Muenchen; Registergericht: Muenchen HRB 40368; Geschaeftsfuehrer:Dr.Carsten Suckrow, Thomas Wessel, William A. Martin, Margaret Seif
> 
> 
> 

