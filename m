Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:44787 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752998AbcICPJ6 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 3 Sep 2016 11:09:58 -0400
Subject: Re: [PATCH v2] iio: adc: ltc2485: add support for Linear Technology
 LTC2485 ADC
To: Alison Schofield <amsfield22@gmail.com>
References: <20160825054829.GA15341@d830.WORKGROUP>
 <9e95a885-8078-fc00-6104-ead4684d9d4b@kernel.org>
 <20160902191513.GA13014@d830.WORKGROUP>
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <122c6464-6e5f-5c17-fbb7-beb4a4cd4eb7@kernel.org>
Date: Sat, 3 Sep 2016 16:07:37 +0100
MIME-Version: 1.0
In-Reply-To: <20160902191513.GA13014@d830.WORKGROUP>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 02/09/16 20:15, Alison Schofield wrote:
> On Mon, Aug 29, 2016 at 05:01:14PM +0100, Jonathan Cameron wrote:
>> On 25/08/16 06:48, Alison Schofield wrote:
>>> Adds basic support for the LTC2485 ADC - a delta-sigma analog-to-digital
>>> converter with an I2C interface that operates in single shot conversion
>>> mode.
>>>
>>> The driver supports an on board 5V reference and the power-on default
>>> configuration which rejects both 50hz & 60hz line frequencies and
>>> operates in 1x speed mode.
>>>
>>> Signed-off-by: Alison Schofield <amsfield22@gmail.com>
>>> Cc: Daniel Baluta <daniel.baluta@gmail.com>
>>> ---
>>> Changes in v2:
>>>   - changed the wait conversion time function to use monotonic rather than
>>>     real time and to use milliseconds rather than nanoseconds.  
>>>   - made conv time a constant int.
>>>
>>> Same notes as in v1:
>>> Reviewers: In addition to commenting on what is present, please comment
>>> on what is absent and the priority in which you would like to see
>>> additional features added to this driver, or needed in this first submittal.
>> None of the below are needed for initially submital.
>> All 'value' add features at the end of the day. Job one: get reading from
>> ADC done :)
>>
>> I made a few really small white space changes and applied this to the
>> togreg branch of iio.git.  Will be initially pushed out as testing
>> in a few minutes time to check the autobuilders can't find anything.
>>
>> Thanks,
>>
>> Jonathan
>>
>>>
>>> Not supported: 
>>> 1. External Vref
>>> 2. Additional Configuration Modes
>>>         Temperature Sensor Mode: report temp data (not voltage).
>>>
>>>         Line Frequency Rejection Mode: select to reject 50Hz or 60Hz
>>> 	or both. (both is default)
>> This is interesting... Will need some new ABI.  It's a filter so we probably
>> want to try and fit it in with the existing filter ABI.  
>>>
>>>         Speed Mode: Default speed mode (1x) performs two conversions each
>>> 	cycle and combines the results.  2x speed mode only does one
>>> 	conversion each cycle.
>> Really simple case of oversampling.  So this one is easy ;)
>>
>>> 3. Power management
>>> 4. DT Bindings
>>> 5. Triggered buffers
>> Device is really slow, so no real rush on this one.  Nice to have for
>> the convenience of using standard interfaces in libiio etc, but
>> at 7sps reading sysfs will work fine for all usecases!
>>
>>> 6. What else?
>> Other power supply regulators..
>> (allows complete power disabling if there is an appropriate controllable
>> regulator on the board).
>>
> Thanks Jonathan!  
> I need more direction on the power supply regulators. 
> 
> When you say power supply regulator, is that the same as reference
> voltage?
> 
> The driver uses onboard vref now.  I see how I can add support for an
> external vref.  But, it seems like maybe you are commenting that we can
> have both, an external vref with an onboard vref as a fallback?  
Usual trick here is that if the external vref is wired, then it makes sense
to use it (or why would the hardware designer have put the source device
on the board!).  Hence we use regulator_get_optional call and handle the
not present response which would indicate that the optional devicetree
parameter or similar was not supplied - implying no hardware present.

So if it's not there we use the internal reference as currently doing.

Actually when I brought this up I meant the main power supply to
the chip.  On a lot of boards it makes sense to power down the regulators
when going to sleep etc and sometimes even during runtime.  To do that
we have to make the device aware of its regulators (including the
reference one if present).

Linus Waleij is someone who does this stuff right in his drivers, so
take a look at one of those.

Personally I've always counted this as a feature. If it's not there
then on boards where that powersupply is turned off the device won't
work, but there are plenty of boards with out fined grained enough
control where it doesn't matter.  If it's initially on adding this
support improves power saving.  Nice to have again, but not a requirement
for a driver to 'work'.

Jonathan
> 
> Thanks,
> alisons
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

