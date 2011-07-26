Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-51.csi.cam.ac.uk ([131.111.8.151]:40664 "EHLO
	ppsw-51.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751142Ab1GZIkv (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 26 Jul 2011 04:40:51 -0400
Message-ID: <4E2E7F70.2030102@cam.ac.uk>
Date: Tue, 26 Jul 2011 09:48:48 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: "Hennerich, Michael" <Michael.Hennerich@analog.com>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"arnd@arndb.de" <arnd@arndb.de>,
	"device-drivers-devel@blackfin.uclinux.org"
	<device-drivers-devel@blackfin.uclinux.org>
Subject: Re: [PATCH 2/7] staging:iio: remove specific chrdev for event reading.
 Get fd from ioctl on buffer.
References: <1311599921-15729-1-git-send-email-jic23@cam.ac.uk> <1311599921-15729-3-git-send-email-jic23@cam.ac.uk> <544AC56F16B56944AEC3BD4E3D5917714300119677@LIMKCMBX1.ad.analog.com>
In-Reply-To: <544AC56F16B56944AEC3BD4E3D5917714300119677@LIMKCMBX1.ad.analog.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 07/26/11 09:36, Hennerich, Michael wrote:
> Jonathan Cameron wrote on 2011-07-25:
>> Change suggested by Arnd Bergmann.
>>
>> No real reason to have two chrdevs per device. This step merges them
>> into one.
>> Currently this means that events will only work on devices with
>> buffers. THat will be remedied shortly.
> 
> Will there be am iio:event instead?
> Or iio:buffer even if no buffer and we need to get the iio:event through the anon fds?
Nope. There is only one and it is called iio:deviceX.  Some stub functions should
(if I have gotten it right) ensure that you can have events and/or buffers.
Note that isn't as you've noticed the case mid way through this set.  Couldn't see
a cleaner way of doing this.  It only all should work after patch 5.
> 
>> V2: set name for event attribute groups.  Otherwise they all sorts of
>> fun occurs on dynamic channel event attribute creation.
>>
>> Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
> Acked-by: Michael Hennerich <michael.hennerich@analog.com>
>> ---
>>  drivers/staging/iio/accel/sca3000_core.c |    1 +
>>  drivers/staging/iio/adc/ad7150.c         |    1 +
>>  drivers/staging/iio/adc/ad7745.c         |    1 +
>>  drivers/staging/iio/adc/ad7816.c         |    1 +
>>  drivers/staging/iio/adc/ad799x_core.c    |    2 +
>>  drivers/staging/iio/adc/adt7310.c        |    2 +
>>  drivers/staging/iio/adc/adt7410.c        |    2 +
>>  drivers/staging/iio/adc/adt75.c          |    1 +
>>  drivers/staging/iio/adc/max1363_core.c   |    4 +-
>>  drivers/staging/iio/addac/adt7316.c      |    2 +
>>  drivers/staging/iio/chrdev.h             |    1 +
>>  drivers/staging/iio/dac/ad5504.c         |    1 +
>>  drivers/staging/iio/iio.h                |    1 +
>>  drivers/staging/iio/industrialio-core.c  |  174
>> ++++++++++------------
>> --------
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
> 

