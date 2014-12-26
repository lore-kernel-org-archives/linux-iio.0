Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:44927 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751441AbaLZLxI (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 26 Dec 2014 06:53:08 -0500
Message-ID: <549D4C1F.6050907@kernel.org>
Date: Fri, 26 Dec 2014 11:53:03 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Lars-Peter Clausen <lars@metafoo.de>
CC: linux-iio@vger.kernel.org,
	"linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
	Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 3/3] iio: ak8975: Added autodetect feature for ACPI
References: <1418678363-22437-1-git-send-email-srinivas.pandruvada@linux.intel.com>	 <1418678363-22437-4-git-send-email-srinivas.pandruvada@linux.intel.com>	 <549300A5.5080904@metafoo.de>	 <1418921521.740.282.camel@spandruv-desktop.jf.intel.com>	 <54930965.3030008@metafoo.de>	 <1418923812.4459.8.camel@spandruv-desktop.jf.intel.com>	 <549314C4.8090001@metafoo.de> <1418925641.4459.11.camel@spandruv-desktop.jf.intel.com>
In-Reply-To: <1418925641.4459.11.camel@spandruv-desktop.jf.intel.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 18/12/14 18:00, Srinivas Pandruvada wrote:
> On Thu, 2014-12-18 at 18:54 +0100, Lars-Peter Clausen wrote: 
>> On 12/18/2014 06:30 PM, Srinivas Pandruvada wrote:
>>> On Thu, 2014-12-18 at 18:05 +0100, Lars-Peter Clausen wrote:
>>>> On 12/18/2014 05:52 PM, Srinivas Pandruvada wrote:
>>>>> On Thu, 2014-12-18 at 17:28 +0100, Lars-Peter Clausen wrote:
>>>>>> Added I2C to Cc.
>>>>>>
>>>>>> On 12/15/2014 10:19 PM, Srinivas Pandruvada wrote:
>>>>>>> Using i2c auto detect feature and auto device creation feature,
>>>>>>> enumerate ak8975 device, by checking their presence.
>>>>>>> This is needed because when this device sits behind an i2c mux, there
>>>>>>> is no way to define i2c mux in ACPI. This will enable ak8975 on
>>>>>>> windows based tablets/laptops running Linux when connected via a mux.
>>>>>>> Since DT model already can define an i2c mux and devices connected to
>>>>>>> it, this feature is only enabled for ACPI.
>>>>>>>
>>>>>>
>>>>>> This is quite a bit of a hack.
>>>>> Why?
>>>>> Auto detect is standard feature of i2c devices. This is using standard
>>>>> auto detect feature provided by the framework.
>>>>
>>>> Auto detect is ugly, slow and unreliable, it's kind of like the last straw
>>>> if nothing else works.
>>> That is true here. You can't enumerate this device by ACPI. As discussed
>>> before we created i2c mux in inv6050 so that we can use AK8975 in bypass
>>> mode. I added some API to create i2c device on this mux, which Wolfram
>>> didn't like. He wanted to enumerate using existing mechanisms.
>>
>> If there is only a single ACPI ID that says this is a INV6050 with a AK8975 
>> attached then the way to handle this is to have a driver that binds to that id 
>> and creates both devices.
> Which address you will create device also adapter here is i2c mux
> created by inv6050? You don't know i2c address of AK8975. To know AK8975
> i2c address, even ugly hack to parse propriety vendor ACPI data, which
> will change between to manufacturer.
> 
This is odd enough, that I'd like a wider range of views on it.

Wolfram - was this the approach you had in mind?
>>
>> - Lars
>>
> 
> 

