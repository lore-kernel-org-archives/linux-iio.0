Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-41.csi.cam.ac.uk ([131.111.8.141]:38373 "EHLO
	ppsw-41.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753223Ab1JEIaX (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 5 Oct 2011 04:30:23 -0400
Message-ID: <4E8C1798.2070003@cam.ac.uk>
Date: Wed, 05 Oct 2011 09:38:48 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: "Hennerich, Michael" <Michael.Hennerich@analog.com>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"Device-drivers-devel@blackfin.uclinux.org"
	<Device-drivers-devel@blackfin.uclinux.org>,
	"manuel.stahl@iis.fraunhofer.de" <manuel.stahl@iis.fraunhofer.de>
Subject: Re: [RFC PATCH 0/2] IIO: Filtering - how to handle.
References: <1317377879-9264-1-git-send-email-jic23@cam.ac.uk> <544AC56F16B56944AEC3BD4E3D59177146E73435B5@LIMKCMBX1.ad.analog.com>
In-Reply-To: <544AC56F16B56944AEC3BD4E3D59177146E73435B5@LIMKCMBX1.ad.analog.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/05/11 07:55, Hennerich, Michael wrote:
> Jonathan Cameron wrote on 2011-09-30:
>> Hi All,
>>
>> One big area we have pretty much glossed over so far is devices with
>> controllable hardware filters.  This RFC proposes one option for
>> how to handle this. For low pass filters at least, the 3db point
>> seems the obvious choice as it allows us to gloss over exactly
>> what type of filter it is whilst still capturing it's basic
>> property of what it lets through.
>>
>> What do people think?
> 
> Looks good. The 3dB cutoff or corner frequency is typically used to describe
> various types of filters: low, high or band (pass/stop).
> 
> Documentation?
Indeed. Naughty me ;)  Will add for new version.
> 
> 
>>
>> Jonathan
>>
>> Jonathan Cameron (2):
>>   staging:iio: filter description - low pass 3db frequency.
>>   staging:iio:imu:adis16400 add control of data filtering.
>>  drivers/staging/iio/iio.h                |    2 +
>>  drivers/staging/iio/imu/adis16400.h      |    2 +
>>  drivers/staging/iio/imu/adis16400_core.c |  177
>>  +++++++++++++++++++++++------ drivers/staging/iio/industrialio-core.c
>>  |    2 + 4 files changed, 146 insertions(+), 37 deletions(-)
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

