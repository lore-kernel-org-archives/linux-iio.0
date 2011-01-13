Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-52.csi.cam.ac.uk ([131.111.8.152]:39249 "EHLO
	ppsw-52.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756190Ab1AMKzz (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 13 Jan 2011 05:55:55 -0500
Message-ID: <4D2EDBF2.4050800@cam.ac.uk>
Date: Thu, 13 Jan 2011 11:03:14 +0000
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: Roland Stigge <stigge@antcom.de>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: Documentation update for outputs / dac
References: <4D2D8516.1040602@antcom.de> <4D2D995E.6090505@cam.ac.uk> <4D2DF5C0.6030405@antcom.de>
In-Reply-To: <4D2DF5C0.6030405@antcom.de>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 01/12/11 18:41, Roland Stigge wrote:
> Hi,
> 
> On 01/12/2011 01:06 PM, Jonathan Cameron wrote:
>> Any chance at all you can get git-send-email to work for you?
>> Saves me the step of pasting the attachment back into the email
>> every time!
> 
> Thanks for the hint. Will test with another patch. :-)
> 
>>> +What:		/sys/bus/iio/devices/deviceX/outY_raw
>>> +KernelVersion:	2.6.37
>>> +Contact:	linux-iio@vger.kernel.org
>>> +Description:
>>> +		Raw (unscaled, no bias etc.) output voltage for
>>> +		channel Y. 
>>
>> Get rid of this bit about named output. I'm not sure it makes sense to allow
>> this and I don't think we currently have an examples in tree.
> 
> Do you mean we shouldn't document /sys/bus/iio/devices/deviceX/outY_raw
> (which is quite analogous to inY_raw) but
> /sys/bus/iio/devices/deviceX/outY_scale and
> /sys/bus/iio/devices/deviceX/outY&Z_raw?
> 
No, the named bit for inputs is todo with inY_supply_raw etc
rather than the scale and compound versions both of which should
indeed be documented. I just mean remove the bit in the description
of outY_raw which refers to 'names'.  Basically get rid of 
' In special cases where the channel does not
  correspond to externally available output one of the named
  versions may be used.' as it doesn't apply to outputs. '

Any internal only output would be a somewhat odd beast.

Thanks,

Jonathan

