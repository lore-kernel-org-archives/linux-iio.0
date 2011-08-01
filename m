Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-52.csi.cam.ac.uk ([131.111.8.152]:39277 "EHLO
	ppsw-52.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751706Ab1HAJGE (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 1 Aug 2011 05:06:04 -0400
Message-ID: <4E366E5B.30707@cam.ac.uk>
Date: Mon, 01 Aug 2011 10:14:03 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: michael.hennerich@analog.com
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"device-drivers-devel@blackfin.uclinux.org"
	<device-drivers-devel@blackfin.uclinux.org>,
	Drivers <Drivers@analog.com>
Subject: Re: [PATCH] iio: impedance-analyzer: New driver for AD5933/4 Impedance
 Converter, Network Analyzer
References: <1311852772-17988-1-git-send-email-michael.hennerich@analog.com> <4E316C4C.5080008@cam.ac.uk> <4E317DEF.5000104@analog.com> <4E31862D.2060802@cam.ac.uk> <4E366A57.1050808@analog.com>
In-Reply-To: <4E366A57.1050808@analog.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 08/01/11 09:56, Michael Hennerich wrote:
> On 07/28/2011 05:54 PM, Jonathan Cameron wrote:
>> On 07/28/11 16:19, Michael Hennerich wrote:
>>> On 07/28/2011 04:03 PM, Jonathan Cameron wrote:
>>>> On 07/28/11 12:32, michael.hennerich@analog.com wrote:
>>>>> From: Michael Hennerich<michael.hennerich@analog.com>
>>>>>
>>>>> The AD5933 is a high precision impedance converter system solution
>>>>> that combines an on-board frequency generator with a 12-bit, 1 MSPS,
>>>>> analog-to-digital converter (ADC). The frequency generator allows an
>>>>> external complex impedance to be excited with a known frequency.
>>>>>
>>>>> The response signal from the impedance is sampled by the on-board ADC
>>>>> and a discrete Fourier transform (DFT) is processed by an on-chip DSP engine.
>>>>> The DFT algorithm returns a real (R) and imaginary (I) data-word at each
>>>>> output frequency.
>>>>>
>>>> Mostly looks good. Couple of nitpicks / queries in line.  I'm particularly
>>>> bothered about the SCALE info elements in chan_spec that aren't matched
>>>> in the read_raw (or a write_raw if relevant).
>>> in0_real_raw and in0_imag_raw only exist as scan elements.
>>> They aren't present in indio_dev->channels. I therefore couldn't use
>>> scale info elements from channel spec.
>> Ah. I hadn't noticed that (obviously).  Why is this the case?  Does it just
>> not make sense to read them directly?
> Hi Jonathan,
> 
> It typically doesn't make sense. One use case I could think of is the
> single-point gain factor calculation/calibration.
> we could add in0_(real|imag) however it still doesn't help us for the out0_scale.
> 
>>    If so, set their channel number to -1
>> and they won't appear.  Hmm.  Perhaps we need to make that test a little
>> more refined to make this work.  iio_device_add_channel_sysfs drops the channel
>> immediately if it's number is negative.   Maybe move the magic value into channel2?
>>
>> That way the only uggliness will come if we have a differential channel that only exists
>> for scans.  Or use a negative index (rather than just -1).  That's probably the cleanest
>> option, but will require a few abs() insertions in the code and some testing
>> to make sure we got them all.
>>
> This should do the trick - I'll have a try.
> Regarding adding _available to channel spec.
> We probably need to do it for each and every item listed in iio_chan_info_enum.
> The question is do we want to return a string?
String is rather ugly and kind of defeats all our attempts to avoid the drivers dealing with
strings at all.  Perhaps value pairs (and hence IIO_INT_PLUS_X type). The core can then format
the up appropriately.  Perhaps do this via a second mask (as it clearly aligns with the first existing
enum elements)? Bloat the channel struct a little, but not too badly.

Shall we leave this for another day and just poke them in separately as you have done here
for now? I'll put together a prototype of how to do this and see how difficult it actually is.

Jonathan
