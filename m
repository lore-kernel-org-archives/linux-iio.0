Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-51.csi.cam.ac.uk ([131.111.8.151]:39204 "EHLO
	ppsw-51.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757897Ab1DAPdY (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 1 Apr 2011 11:33:24 -0400
Message-ID: <4D95F09E.7060907@cam.ac.uk>
Date: Fri, 01 Apr 2011 16:34:54 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: "Hennerich, Michael" <Michael.Hennerich@analog.com>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Drivers <Drivers@analog.com>,
	"device-drivers-devel@blackfin.uclinux.org"
	<device-drivers-devel@blackfin.uclinux.org>
Subject: Re: [PATCH 2/2] IIO: DAC: New driver for the AD5504 and AD55041 High
 Voltage DACs
References: <1301666852-11078-1-git-send-email-michael.hennerich@analog.com> <1301666852-11078-2-git-send-email-michael.hennerich@analog.com> <4D95E3AC.8020507@cam.ac.uk> <544AC56F16B56944AEC3BD4E3D59177137545F0B3D@LIMKCMBX1.ad.analog.com>
In-Reply-To: <544AC56F16B56944AEC3BD4E3D59177137545F0B3D@LIMKCMBX1.ad.analog.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 04/01/11 16:00, Hennerich, Michael wrote:
> Jonathan Cameron wrote on 2011-04-01:
>> On 04/01/11 15:07, michael.hennerich@analog.com wrote:
>>> From: Michael Hennerich <michael.hennerich@analog.com>
>>>
>>> Changes since V1:
>>>
>>> IIO: DAC: Apply review feedback from Jonathan
>>>
>>> Fix array size and declare const.
>>> Fix reversed dacY_powerdown read back.
>>> Use individual attribute groups instead of is_visible.
>>> Fix event naming and add the _en file.
>> The event code is wrong. It's a temperature event and the code should
>> reflect that.
>>
>> Which removes the purpose of the previous patch.
> 
> That's what I was trying to ask you before.
> So it should be IIO_EV_CLASS_TEMP?
Ah sorry, I got confused.

Yes, the event should definitely IIO_EV_CLASS_TEMP
