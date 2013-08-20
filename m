Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:47503 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751587Ab3HTQUZ (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 20 Aug 2013 12:20:25 -0400
Message-ID: <52139745.3080305@wwwdotorg.org>
Date: Tue, 20 Aug 2013 10:20:21 -0600
From: Stephen Warren <swarren@wwwdotorg.org>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@kernel.org>
CC: Jacek Anaszewski <j.anaszewski@samsung.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	kyungmin.park@samsung.com, s.nawrocki@samsung.com,
	rob.herring@calxeda.com, pawel.moll@arm.com, mark.rutland@arm.com,
	ian.campbell@citrix.com
Subject: Re: [PATCH/RFC v4 3/3] DT: Add documentation for gp2ap020a00f sensor
References: <1376658760-3459-1-git-send-email-j.anaszewski@samsung.com> <52128E21.6020303@wwwdotorg.org> <4937193b-53b6-4721-a7a0-c5f5d6133699@email.android.com>
In-Reply-To: <4937193b-53b6-4721-a7a0-c5f5d6133699@email.android.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 08/19/2013 11:54 PM, Jonathan Cameron wrote:
> Stephen Warren <swarren@wwwdotorg.org> wrote:
>> On 08/16/2013 07:12 AM, Jacek Anaszewski wrote:
>>> This patch adds device tree binding documentation
>>> for the gp2ap020a00f proximity/als sensor.
>>
>>> diff --git a/Documentation/devicetree/bindings/iio/light/gp2ap020a00f.txt
>>> +* Sharp GP2AP020A00F I2C Proximity/ALS sensor
>>> +
>>> +Required properties:
>>> +
>>> +  - compatible : should be "sharp,gp2ap020a00f"
>>> +  - reg : the I2C address of the light sensor
>>> +  - interrupt-parent : phandle to the parent interrupt controller
>>> +  - interrupts : should be INT interrupt pin
>>> +  - vled-supply : VLED power supply, as covered
>>> +		  in Documentation/devicetree/bindings/regulator/regulator.txt
>>
>> If this is a sensor for proximity and light, why does it need a
>> regulator for an LED?
>
> This type of proximity sensor uses reflected light from an led right next to it to detect something is nearby. The devices typically either integrate the led directly or control an external led. 

OK, that makes sense. It might make sense to briefly describe this
aspect of the HW at the top of the binding file. Perhaps something like:

----------
* Sharp GP2AP020A00F I2C Proximity/ALS sensor

The proximity detector sensor requires an associated LED for its
operation. The power supply to this LED is also defined by this binding.
----------

?

