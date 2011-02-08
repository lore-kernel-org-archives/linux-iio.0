Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-50.csi.cam.ac.uk ([131.111.8.150]:47383 "EHLO
	ppsw-50.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755661Ab1BHUHt (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 8 Feb 2011 15:07:49 -0500
Message-ID: <4D51A298.6020903@cam.ac.uk>
Date: Tue, 08 Feb 2011 20:07:52 +0000
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: "Hennerich, Michael" <Michael.Hennerich@analog.com>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"device-drivers-devel@blackfin.uclinux.org"
	<device-drivers-devel@blackfin.uclinux.org>
Subject: Re: [PATCH 0/4] staging:iio:meter clean up and dead code removal.
References: <1296934459-15760-1-git-send-email-jic23@cam.ac.uk> <544AC56F16B56944AEC3BD4E3D591771324C1BAA0D@LIMKCMBX1.ad.analog.com> <4D5017D6.90009@cam.ac.uk> <544AC56F16B56944AEC3BD4E3D591771324C1BAC05@LIMKCMBX1.ad.analog.com>
In-Reply-To: <544AC56F16B56944AEC3BD4E3D591771324C1BAC05@LIMKCMBX1.ad.analog.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 02/08/11 09:32, Hennerich, Michael wrote:
> Jonathan Cameron wrote on 2011-02-07:
>> On 02/07/11 15:34, Hennerich, Michael wrote:
>>> Jonathan Cameron wrote on 2011-02-05:
>>>> This is very much the starting point for bashing the meter drivers
>>>> into shape.  For now I've just removed most of the unused code and
>> stubs.
>>>
>>> Instead of removing the stubs - I would rather prefer implementing
>> them.
>> I agree in the ideal case.  But even then, it is much easier to review
>> a patch that adds this functionality from scratch than it is to review
>> one that relies on large amounts of existing dead code.
>>> But I think you're right this dead code is not going to be useful
>>> either.
>>>
>>>> I have also cleaned up spi bus handling.  I may well have gotten that
>>>> bit wrong so please do take a look.  In some cases this involved
>>>> turning one transfer into two so as to clarify what the code was
>>>> doing. This may cause issues if the spi bus drivers don't play the
>>>> game properly or as if I got the conversion wrong.
>>>
>>> Looks right - but I had to double check with the datasheet. The SPI
>>> write then read behavior is a bit undefined. In particular, what is
>>> shifted out on the MOSI pin during the receive part.
>>>
>>> Some implementations send zero/one or repeat the last word in the shift
>>> register, while others tristate MOSI. If the target slave device in
>>> questions also listens on MOSI while it drives MISO, unpredicted
>>> behavior my result.
>> Strange, I thought this was defined as always sending zero if not
>> provided.  If not then I would suggest we point this inconsistency out
>> to the spi guys and fix it up in those implementations that don't
>> conform.  Otherwise as you say, one needs to always specify the other
>> direction just to make sure nothing weird happens.
>> All my testing is on ancient pxa boards, so I know that they always
>> send zeros and dump whatever is recieved.
> 
> This behavior is implemented in the SPI Master Controller Drivers, and not in the SPI Bus Core.
> I know in the past some machine dependant implementations did it wrong.
> However looking at the drivers today they all (at least the ones I looked at)
> send zero in case tx_buf is NULL.
Good. In that case shall I send this set on to Greg? Might as well get the
easy cleanups in place asap.

....
