Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:59069 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751941Ab3HTFyM (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 20 Aug 2013 01:54:12 -0400
In-Reply-To: <52128E21.6020303@wwwdotorg.org>
References: <1376658760-3459-1-git-send-email-j.anaszewski@samsung.com> <52128E21.6020303@wwwdotorg.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Subject: Re: [PATCH/RFC v4 3/3] DT: Add documentation for gp2ap020a00f sensor
From: Jonathan Cameron <jic23@kernel.org>
Date: Tue, 20 Aug 2013 06:54:05 +0100
To: Stephen Warren <swarren@wwwdotorg.org>,
	Jacek Anaszewski <j.anaszewski@samsung.com>
CC: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	kyungmin.park@samsung.com, s.nawrocki@samsung.com,
	rob.herring@calxeda.com, pawel.moll@arm.com, mark.rutland@arm.com,
	ian.campbell@citrix.com
Message-ID: <4937193b-53b6-4721-a7a0-c5f5d6133699@email.android.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org



Stephen Warren <swarren@wwwdotorg.org> wrote:
>On 08/16/2013 07:12 AM, Jacek Anaszewski wrote:
>> This patch adds device tree binding documentation
>> for the gp2ap020a00f proximity/als sensor.
>
>> diff --git
>a/Documentation/devicetree/bindings/iio/light/gp2ap020a00f.txt
>b/Documentation/devicetree/bindings/iio/light/gp2ap020a00f.txt
>> new file mode 100644
>> index 0000000..e4f377d
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/iio/light/gp2ap020a00f.txt
>> @@ -0,0 +1,20 @@
>> +* Sharp GP2AP020A00F I2C Proximity/ALS sensor
>> +
>> +Required properties:
>> +
>> +  - compatible : should be "sharp,gp2ap020a00f"
>> +  - reg : the I2C address of the light sensor
>> +  - interrupt-parent : phandle to the parent interrupt controller
>> +  - interrupts : should be INT interrupt pin
>> +  - vled-supply : VLED power supply, as covered
>> +		  in Documentation/devicetree/bindings/regulator/regulator.txt
>
>If this is a sensor for proximity and light, why does it need a
>regulator for an LED?
This type of proximity sensor uses reflected light from an led right next to it to detect something is nearby. The devices typically either integrate the led directly or control an external led. 

-- 
Sent from my Android phone with K-9 Mail. Please excuse my brevity.
