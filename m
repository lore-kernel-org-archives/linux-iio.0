Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-52.csi.cam.ac.uk ([131.111.8.152]:37689 "EHLO
	ppsw-52.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750767Ab1EaHPW (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 31 May 2011 03:15:22 -0400
Message-ID: <4DE49768.6050603@cam.ac.uk>
Date: Tue, 31 May 2011 08:23:20 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: "Hennerich, Michael" <Michael.Hennerich@analog.com>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"device-drivers-devel@blackfin.uclinux.org"
	<device-drivers-devel@blackfin.uclinux.org>,
	Drivers <Drivers@analog.com>
Subject: Re: [PATCH] IIO: ADC: New driver for AD7792/AD7793 3 Channel SPI
 ADC
References: <1306335750-428-1-git-send-email-michael.hennerich@analog.com> <4DDE28F4.5040705@cam.ac.uk> <4DDE63B1.2060301@analog.com> <4DDE6A8D.5000007@cam.ac.uk> <544AC56F16B56944AEC3BD4E3D5917713AAF2F450F@LIMKCMBX1.ad.analog.com>
In-Reply-To: <544AC56F16B56944AEC3BD4E3D5917713AAF2F450F@LIMKCMBX1.ad.analog.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 05/27/11 15:46, Hennerich, Michael wrote:
> Jonathan Cameron wrote on 2011-05-26:
>>
>> ...
>>>> What would happen if this driver used any other trigger?  Would
>> everything work?
>>> No. But other drivers can you the trigger. It's not really an
>>> trigger
>> it's a data ready.
>> Most are.  As you say, it is useful to trigger other reads from this,
>> but not to trigger this to read from other sources...
>>>> I think it would do an immediate read which is going to be a problem.
>>>> Perhaps we need a way of restricting triggers.  This one can be used
>>>> by anyone, but the part can only use it's own trigger (I think).
>>> Having the ability to reject alien triggers are nice to have.
>> True enough.  I guess the easiest is some sort of 'filter' callback on
>> trigger connect.
>> Then drivers that care, can reject devices that don't match what they
>> need.  Would probably want one in each direction.  Trigggers can
>> reject devices and devices can reject triggers.
> 
> Are you going to put this in place?
> Or do you want me to look at it?
don't mind either way.  Give me a yell if you start work on it and I'll
do the same.  Whoever gets their first can do it.
> 
> BTW - I'm out next week...
Me too (for most of it anyway!)
 
> Greetings,
> Michael
> 
> --
> Analog Devices GmbH      Wilhelm-Wagenfeld-Str. 6      80807 Muenchen
> Sitz der Gesellschaft: Muenchen; Registergericht: Muenchen HRB 40368; Geschaeftsfuehrer:Dr.Carsten Suckrow, Thomas Wessel, William A. Martin, Margaret Seif
> 
> 
> 

