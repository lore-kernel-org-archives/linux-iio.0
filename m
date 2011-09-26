Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-41.csi.cam.ac.uk ([131.111.8.141]:32779 "EHLO
	ppsw-41.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750975Ab1IZIZo (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 26 Sep 2011 04:25:44 -0400
Message-ID: <4E8038FE.7030104@cam.ac.uk>
Date: Mon, 26 Sep 2011 09:34:06 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: "Hennerich, Michael" <Michael.Hennerich@analog.com>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"Device-drivers-devel@blackfin.uclinux.org"
	<Device-drivers-devel@blackfin.uclinux.org>
Subject: Re: [PATCH 00/16] staging:iio:adc cleanups / fixes.
References: <1316779302-12357-1-git-send-email-jic23@cam.ac.uk> <544AC56F16B56944AEC3BD4E3D59177146E7272AFA@LIMKCMBX1.ad.analog.com>
In-Reply-To: <544AC56F16B56944AEC3BD4E3D59177146E7272AFA@LIMKCMBX1.ad.analog.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 09/26/11 08:55, Hennerich, Michael wrote:
> Jonathan Cameron wrote on 2011-09-23:
>> Hi Michael,
>>
>> Result of doing a careful review of these fundamentally clean
>> drivers.  A few actual bug fixes and quite a few cases of moving
>> to prefered means of doing things (not using IIO_CHAN for starters).
>>
>> Please look over these as I may well have 'cleaned' things into
>> not working.  Only functional changes beyond bug fixes are that
>> we now have event _en attributes for the ad799x (read only and always
>> equal to 1) and what happens with gpio request failures has changed
>> in the ad7606.
> 
> Hi Jonathan,
> 
> Great work. Looks good except for one patch I've NACKed.
> 
> [PATCH 03/16] staging:iio:adc:ad799x fix incorrect setting of configuration register on single channel read.
Dropped.
> 
> Thanks!
You are welcome.  I was so nearly happy with these drivers it made
sense to just spend a few mins hammering the last few corners.

Have you given any thought to which drivers we want to take with
us through the review process for moving the core out of staging?

Jonathan
> 
> -Michael
> 
> 
>> Thanks,
>>
>> Jonathan
>>
>> Jonathan Cameron (16):
>>   staging:iio:adc:ad799x fix incorrect scan_type descriptions.
>>   staging:iio:adc:ad799x stop using IIO_CHAN macro.
>>   staging:iio:adc:ad799x fix incorrect setting of configuration
>>     register on single channel read.
>>   staging:iio:adc:ad799x trivial: use the convenient chan struct.
>>   staging:iio:adc:ad799x use a table for frequency values rather than
>>     big switch. staging:iio:adc:ad799x avoid bouncing back and forth
>>     from iio_priv space. staging:iio:adc:ad799x use the core handling
>>     for as much of the events as possible.
>>   staging:iio:adc:ad799x set the device name only once.
>>   staging:iio:adc:ad799x address and scan_index always match so stop
>>     using address
>>   staging:iio:adc:ad7606 add local define for chan_spec structures.
>>   staging:iio:adc:ad7606 trivial code style fix.
>>   staging:iio:adc:ad7606 make gpio request failures more consistent
>>   staging;iio:adc:ad7606 use iio_sw_buffer_preenable rather than local
>>     equiv
>>   staging:iio:adc:ad7606 refactor to remove st->irq and st->id.
>>   staging:iio:adc:ad7606 remove unused chip info elements.
>>   staging:iio:adc:ad7887 stop using IIO_CHAN macro.
>>  drivers/staging/iio/adc/ad7606.h      |   12 +-
>>  drivers/staging/iio/adc/ad7606_core.c |  226 ++++++------
>>  drivers/staging/iio/adc/ad7606_par.c  |    2 +-
>>  drivers/staging/iio/adc/ad7606_ring.c |   44 +--
>>  drivers/staging/iio/adc/ad7606_spi.c  |    2 +-
>>  drivers/staging/iio/adc/ad7887_core.c |   26 +-
>>  drivers/staging/iio/adc/ad799x.h      |    4 +-
>>  drivers/staging/iio/adc/ad799x_core.c |  645 ++++++++++++++++++++-----
>>  -------- drivers/staging/iio/adc/ad799x_ring.c |    4 +- 9 files
>>  changed, 546 insertions(+), 419 deletions(-)
> 
> Greetings,
> Michael
> 
> --
> Analog Devices GmbH      Wilhelm-Wagenfeld-Str. 6      80807 Muenchen
> Sitz der Gesellschaft: Muenchen; Registergericht: Muenchen HRB 40368;
> Geschaeftsfuehrer:Dr.Carsten Suckrow, Thomas Wessel, William A. Martin, Margaret Seif
> 
> 
> 
> 

