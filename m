Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-31.csi.cam.ac.uk ([131.111.8.131]:50514 "EHLO
	ppsw-31.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751350Ab0IBKKl (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 2 Sep 2010 06:10:41 -0400
Date: 02 Sep 2010 11:10:39 +0100
From: "J.I. Cameron" <jic23@cam.ac.uk>
To: Manuel Stahl <manuel.stahl@iis.fraunhofer.de>
Cc: Rhyland Klein <rklein@nvidia.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: question about hwo to fit in an ALS driver
Message-ID: <Prayer.1.3.3.1009021110390.3349@hermes-1.csi.cam.ac.uk>
In-Reply-To: <4C7F52EC.3000006@iis.fraunhofer.de>
References: <E88A1D35AF5437468E5B14C7C4BA61C702CF4B627B@HQMAIL01.nvidia.com>
 <4C7F52EC.3000006@iis.fraunhofer.de>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sep 2 2010, Manuel Stahl wrote:

>Am 02.09.2010 00:52, schrieb Rhyland Klein:
>> I am looking into submitting a sensor driver for the isl29018 ambient
>> light sensor (als). I noticed there is an old isl als driver for a
>> different part (isl29003) in drivers/misc but I also see the light
>> sensor driver for tsl2653 in the drivers/staging/iio/light directory
>> which seems much more like the correct place for this type of sensor
>> driver to reside.
>>
>> Is this subsystem designed for ALS drivers or a different type of
>> light sensor?
>
>It's designed for all kind of sensors. Of course not all are supported 
>properly yet.
>
>> If it should support ALS drivers, I don't know how the
>> IIO_DEV* attributes should map for this. I suppose it would just use
>> the IIO_DEV_ATTR_LIGHT_VISIBLE for the lux, which could work, except
>> that the isl29018 also functions as a proximity sensor, and the
>> driver will support both modes.  What is the proper way to fit a
>> driver like this into the iio subsystem?
>
> > One thing to note is that there are additional properties other than
> > just reporting the lux that will need to be supported including
> > changing the mode and setting the range, and I am not sure how these
> > should fit into the device attribute framework exposed via light.h.
>
>When you have attributes that fit into the current scheme, use these.
>When you have additional attributes that might be useful for other 
>sensors, make a name proposal.
>When you have attributes, like mode, that are device specific, use 
>IIO_DEVICE_ATTR(_name, _mode, _show, _store, _addr) and put in a proper 
>name.
Best bet is propose as an RFC the attributes you want to provide with a 
clear description of the format etc. Do this before submitting the code as 
that'll save everyone time ;)

Jonathan
