Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-41.csi.cam.ac.uk ([131.111.8.141]:59801 "EHLO
	ppsw-41.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750975Ab1IZIXg (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 26 Sep 2011 04:23:36 -0400
Message-ID: <4E80387C.103@cam.ac.uk>
Date: Mon, 26 Sep 2011 09:31:56 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: "Hennerich, Michael" <Michael.Hennerich@analog.com>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"Device-drivers-devel@blackfin.uclinux.org"
	<Device-drivers-devel@blackfin.uclinux.org>
Subject: Re: [PATCH 03/16] staging:iio:adc:ad799x fix incorrect setting of
 configuration register on single channel read.
References: <1316779302-12357-1-git-send-email-jic23@cam.ac.uk> <1316779302-12357-4-git-send-email-jic23@cam.ac.uk> <544AC56F16B56944AEC3BD4E3D59177146E7272ABE@LIMKCMBX1.ad.analog.com>
In-Reply-To: <544AC56F16B56944AEC3BD4E3D59177146E7272ABE@LIMKCMBX1.ad.analog.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 09/26/11 08:24, Hennerich, Michael wrote:
> Jonathan Cameron wrote on 2011-09-23:
>> It is a bit mask whereas current code treats it as a straight value.
> 
> That's a NAK.
> See MODE 2 - COMMAND MODE: Table 26. Address Pointer Byte.
> 
> On the AD7998 and AD7997 the channel is a straight value and not a mask.
Ah, my mistake, I thought we were using the configuration register to setup
the scan. Didn't notice you could tell the chip to ignore that and do a read
of a single channel.

Obviously, will drop this one.
> 
>>
>> Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
>> ---
>>  drivers/staging/iio/adc/ad799x_core.c |    3 ++-
>>  1 files changed, 2 insertions(+), 1 deletions(-)
>> diff --git a/drivers/staging/iio/adc/ad799x_core.c
>> b/drivers/staging/iio/adc/ad799x_core.c index 975a3f7..3b5f8be 100644
>> --- a/drivers/staging/iio/adc/ad799x_core.c +++
>> b/drivers/staging/iio/adc/ad799x_core.c @@ -123,7 +123,8 @@ static int
>> ad799x_scan_direct(struct ad799x_state *st, unsigned ch)
>>               break;
>>       case ad7997:
>>       case ad7998:
>> -             cmd = (ch << AD799X_CHANNEL_SHIFT) | AD7997_8_READ_SINGLE;
>> +             cmd = ((1 << ch) << AD799X_CHANNEL_SHIFT) |
>> +                     AD7997_8_READ_SINGLE;
>>               break;
>>       default:
>>               return -EINVAL;
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

