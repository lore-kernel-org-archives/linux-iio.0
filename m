Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:53993 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751065AbaLENZg (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 5 Dec 2014 08:25:36 -0500
Message-ID: <5481B24B.4020507@kernel.org>
Date: Fri, 05 Dec 2014 13:25:31 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Ezequiel Garcia <ezequiel.garcia@imgtec.com>,
	James Hartley <james.hartley@imgtec.com>,
	Andrew Bresticker <abrestic@chromium.org>
CC: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	robh+dt@kernel.org, Pawel.Moll@arm.com, Mark.Rutland@arm.com,
	ijc+devicetree@hellion.org.uk, galak@codeaurora.org
Subject: Re: [PATCH v5 0/3] iio: Add Cosmic Circuits ADC support
References: <1417102762-5123-1-git-send-email-ezequiel.garcia@imgtec.com> <54819D3C.7000209@imgtec.com> <4C4CBD60-74E1-4A17-9D93-EDDE8AF33841@kernel.org>
In-Reply-To: <4C4CBD60-74E1-4A17-9D93-EDDE8AF33841@kernel.org>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 05/12/14 13:12, Jonathan Cameron wrote:
> 
> 
> On December 5, 2014 11:55:40 AM GMT+00:00, Ezequiel Garcia <ezequiel.garcia@imgtec.com> wrote:
>> Hi Jonathan,
>>
>> On 11/27/2014 12:39 PM, Ezequiel Garcia wrote:
>>> Changes from v4:
>>>
>>>   * Added a compile-time dependency on REGULATOR and HAVE_CLK.
>>>
>>>   * Replaced the silly XOR operation for a proper mask out of the
>>>     available channels.
>>>
>>> Changes from v3:
>>>
>>>   * Fixed a few style nitpicks as per Hartmut's feedback.
>>>
>>>   * Used GENMASK() to build the channel mask, which fixes a very
>> nasty
>>>     bug. Also found by Hartmut.
>>>
>>> Changes from v2:
>>>
>>>   * Changed a devicetree property from adc-available-channels to
>>>     adc-reserved-channels, so it can be made optional.
>>>
>>>   * Renamed the driver from cc_10001_xxx to cc10001_xxx so it's
>> consistent
>>>     with the rest of the kernel style.
>>>
>>>   * Some more minor cosmetic fixes.
>>>
>>> Changes from v1:
>>>
>>>   * Removed unneeded header includes.
>>>
>>>   * Changed all the names and macros prefix: s/CC_10001_/CC10001_.
>>>
>>>   * Used .update_scan_mode callback to preallocate the buffer.
>>>
>>>   * Used indio_dev for the struct iio_dev.
>>>
>>>   * Only read the regulator voltage when needed.
>>>
>>>   * Fixed probe() error handling.
>>>
>>>   * Used for_each_set_bit() instead of open-coding it.
>>>
>>>   * Name the power-down register as _POWER_UP, to make the code
>>>     less silly.
>>>
>>>   * Error out when no valid sample can be read (i.e. when
>> end-of-conversion
>>>     poll times out).
>>>
>>>   * ... plus some assorted code cleaning based on the feedback.
>>>
>>>
>>> Ezequiel Garcia (1):
>>>   DT: Add a vendor prefix for Cosmic Circuits
>>>
>>> Phani Movva (2):
>>>   iio: adc: Cosmic Circuits 10001 ADC driver
>>>   DT: iio: adc: Add CC_10001 binding documentation
>>>
>>
>> Unless there are any outstanding issues with this series, it'd be great
>> to merge it for v3.19.
>>
>> Thanks!
> Sorry too late unfortunately. Merge window opens on Sunday and stuff needs to have
>  been in Greg KH's tree for a week before that. Going to be 3.20 now.
> 
Also, the DT patch could really do with an Ack from Rob.  If Hartmut/Lars
want to give a reviewed-by that would be good given they done the legwork
on reviewing your driver.

Looks good to me btw.  Just taken a quick look, but little gets past those
guys anyway :)

Jonathan
