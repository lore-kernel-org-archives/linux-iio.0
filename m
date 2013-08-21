Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mailout3.w1.samsung.com ([210.118.77.13]:56959 "EHLO
	mailout3.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751422Ab3HUI3x (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 21 Aug 2013 04:29:53 -0400
Message-id: <52147A7F.7030607@samsung.com>
Date: Wed, 21 Aug 2013 10:29:51 +0200
From: Jacek Anaszewski <j.anaszewski@samsung.com>
MIME-version: 1.0
To: swarren@wwwdotorg.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Jacek Anaszewski <j.anaszewski@samsung.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	Kyungmin Park <kyungmin.park@samsung.com>,
	s.nawrocki@samsung.com, rob.herring@calxeda.com,
	pawel.moll@arm.com, mark.rutland@arm.com, ian.campbell@citrix.com
Subject: Re: [PATCH/RFC v4 3/3] DT: Add documentation for gp2ap020a00f sensor
References: <1376658760-3459-1-git-send-email-j.anaszewski@samsung.com>
 <52128E21.6020303@wwwdotorg.org>
 <4937193b-53b6-4721-a7a0-c5f5d6133699@email.android.com>
 <52139745.3080305@wwwdotorg.org>
In-reply-to: <52139745.3080305@wwwdotorg.org>
Content-type: text/plain; charset=UTF-8; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 08/20/2013 06:20 PM, Stephen Warren wrote:
> On 08/19/2013 11:54 PM, Jonathan Cameron wrote:
>> Stephen Warren<swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>  wrote:
>>> On 08/16/2013 07:12 AM, Jacek Anaszewski wrote:
>>>> This patch adds device tree binding documentation
>>>> for the gp2ap020a00f proximity/als sensor.
>>>
>>>> diff --git a/Documentation/devicetree/bindings/iio/light/gp2ap020a00f.txt
>>>> +* Sharp GP2AP020A00F I2C Proximity/ALS sensor
>>>> +
>>>> +Required properties:
>>>> +
>>>> +  - compatible : should be "sharp,gp2ap020a00f"
>>>> +  - reg : the I2C address of the light sensor
>>>> +  - interrupt-parent : phandle to the parent interrupt controller
>>>> +  - interrupts : should be INT interrupt pin
>>>> +  - vled-supply : VLED power supply, as covered
>>>> +		  in Documentation/devicetree/bindings/regulator/regulator.txt
>>>
>>> If this is a sensor for proximity and light, why does it need a
>>> regulator for an LED?
>>
>> This type of proximity sensor uses reflected light from an led right next to it to detect something is nearby. The devices typically either integrate the led directly or control an external led.
>
> OK, that makes sense. It might make sense to briefly describe this
> aspect of the HW at the top of the binding file. Perhaps something like:
>
> ----------
> * Sharp GP2AP020A00F I2C Proximity/ALS sensor
>
> The proximity detector sensor requires an associated LED for its
> operation. The power supply to this LED is also defined by this binding.
> ----------
>
> ?

Actually the LED is built-in into the chip, and its anode is exposed
on the LEDA pin. On the board I have for my disposal the presence of
this voltage is driven by some circuit. It doesn't have to be the
case for all boards, as the presence of the voltage alone doesn't
drive the state of the diode - the relevant device register has to
be set to activate/deactivate it. Having this in mind we must prepare
for the cases where the voltage will be attached directly to the
LEDA pin without any intermediary driving circuit.

To handle this situation an empty regulator node should be assigned
to the vled-supply property. I am not sure whether this case should
be mentioned in the description. I will assume that it is obvious.

In view of the above I would change the description to:

----------
* Sharp GP2AP020A00F I2C Proximity/ALS sensor

The proximity detector sensor requires power supply for its
built-in LED. It is also defined by this binding.

----------

What is your opinion?

Thanks,
Jacek
