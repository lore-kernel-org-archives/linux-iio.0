Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:55967 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752023Ab3HURMM (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 21 Aug 2013 13:12:12 -0400
Message-ID: <5214F4E7.6040306@wwwdotorg.org>
Date: Wed, 21 Aug 2013 11:12:07 -0600
From: Stephen Warren <swarren@wwwdotorg.org>
MIME-Version: 1.0
To: Jacek Anaszewski <j.anaszewski@samsung.com>
CC: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	Kyungmin Park <kyungmin.park@samsung.com>,
	s.nawrocki@samsung.com, rob.herring@calxeda.com,
	pawel.moll@arm.com, mark.rutland@arm.com, ian.campbell@citrix.com
Subject: Re: [PATCH/RFC v4 3/3] DT: Add documentation for gp2ap020a00f sensor
References: <1376658760-3459-1-git-send-email-j.anaszewski@samsung.com> <52128E21.6020303@wwwdotorg.org> <4937193b-53b6-4721-a7a0-c5f5d6133699@email.android.com> <52139745.3080305@wwwdotorg.org> <52147A7F.7030607@samsung.com>
In-Reply-To: <52147A7F.7030607@samsung.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 08/21/2013 02:29 AM, Jacek Anaszewski wrote:
> On 08/20/2013 06:20 PM, Stephen Warren wrote:
>> On 08/19/2013 11:54 PM, Jonathan Cameron wrote:
>>> Stephen Warren<swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>  wrote:
>>>> On 08/16/2013 07:12 AM, Jacek Anaszewski wrote:
>>>>> This patch adds device tree binding documentation
>>>>> for the gp2ap020a00f proximity/als sensor.
>>>>
>>>>> diff --git
>>>>> a/Documentation/devicetree/bindings/iio/light/gp2ap020a00f.txt
>>>>> +* Sharp GP2AP020A00F I2C Proximity/ALS sensor
>>>>> +
>>>>> +Required properties:
>>>>> +
>>>>> +  - compatible : should be "sharp,gp2ap020a00f"
>>>>> +  - reg : the I2C address of the light sensor
>>>>> +  - interrupt-parent : phandle to the parent interrupt controller
>>>>> +  - interrupts : should be INT interrupt pin
>>>>> +  - vled-supply : VLED power supply, as covered
>>>>> +          in
>>>>> Documentation/devicetree/bindings/regulator/regulator.txt
>>>>
>>>> If this is a sensor for proximity and light, why does it need a
>>>> regulator for an LED?
>>>
>>> This type of proximity sensor uses reflected light from an led right
>>> next to it to detect something is nearby. The devices typically
>>> either integrate the led directly or control an external led.
>>
>> OK, that makes sense. It might make sense to briefly describe this
>> aspect of the HW at the top of the binding file. Perhaps something like:
>>
>> ----------
>> * Sharp GP2AP020A00F I2C Proximity/ALS sensor
>>
>> The proximity detector sensor requires an associated LED for its
>> operation. The power supply to this LED is also defined by this binding.
>> ----------
>>
>> ?
> 
> Actually the LED is built-in into the chip, and its anode is exposed
> on the LEDA pin. On the board I have for my disposal the presence of
> this voltage is driven by some circuit. It doesn't have to be the
> case for all boards, as the presence of the voltage alone doesn't
> drive the state of the diode - the relevant device register has to
> be set to activate/deactivate it. Having this in mind we must prepare
> for the cases where the voltage will be attached directly to the
> LEDA pin without any intermediary driving circuit.
> 
> To handle this situation an empty regulator node should be assigned
> to the vled-supply property. I am not sure whether this case should
> be mentioned in the description. I will assume that it is obvious.

Historically, all regulator supplies have been mandatory; in other
words, if a device might ever need a voltage regulator, then the DT
property to define it was mandatory, and it could be implemented either
by a "real" regulator or a non-switchable fixed regulator.

More recently, there's been some work to support optional regulators,
such that the DT supply property can either point at a "real" regulator,
or simply be missing.

I'm not sure what the state of that change is in the regulator tree
though, although in terms of the DT binding, I guess you should be able
to make the property optional now if you want.

> In view of the above I would change the description to:
> 
> ----------
> * Sharp GP2AP020A00F I2C Proximity/ALS sensor
> 
> The proximity detector sensor requires power supply for its
> built-in LED. It is also defined by this binding.
> 
> ----------
> 
> What is your opinion?

That sounds good.

