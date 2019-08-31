Return-Path: <SRS0=jlLZ=W3=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 434D7C3A59F
	for <linux-iio@archiver.kernel.org>; Sat, 31 Aug 2019 10:20:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2022A22CF7
	for <linux-iio@archiver.kernel.org>; Sat, 31 Aug 2019 10:20:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727501AbfHaKUB (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 31 Aug 2019 06:20:01 -0400
Received: from anchovy2.45ru.net.au ([203.30.46.146]:51394 "EHLO
        anchovy2.45ru.net.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726679AbfHaKUB (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 31 Aug 2019 06:20:01 -0400
Received: (qmail 1545 invoked by uid 5089); 31 Aug 2019 10:19:58 -0000
Received: by simscan 1.2.0 ppid: 1462, pid: 1463, t: 0.0634s
         scanners: regex: 1.2.0 attach: 1.2.0 clamav: 0.88.3/m:40/d:1950
Received: from unknown (HELO ?10.1.1.129?) (preid@electromag.com.au@118.208.174.34)
  by anchovy3.45ru.net.au with ESMTPA; 31 Aug 2019 10:19:58 -0000
Subject: Re: [PATCH 1/2] dt-binding: iio: Add optional label property
To:     Rob Herring <robh@kernel.org>
Cc:     Michal Simek <michal.simek@xilinx.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        devicetree@vger.kernel.org
References: <1566876924-63608-1-git-send-email-preid@electromag.com.au>
 <1566876924-63608-2-git-send-email-preid@electromag.com.au>
 <a30b6dca-c598-135a-0559-1018dd5f5fde@xilinx.com>
 <20190829230207.GA22979@bogus>
 <b50bce2d-8819-67b1-c55c-8c2b8070a4ac@electromag.com.au>
 <CAL_JsqKb8cC=4HR7uVHmKt-zw32U_1u62hG4h-TnbPy=a+QZZg@mail.gmail.com>
From:   Phil Reid <preid@electromag.com.au>
Message-ID: <29f831da-d23a-bc9c-151a-885bd526a785@electromag.com.au>
Date:   Sat, 31 Aug 2019 18:19:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAL_JsqKb8cC=4HR7uVHmKt-zw32U_1u62hG4h-TnbPy=a+QZZg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-AU
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 30/08/2019 20:34, Rob Herring wrote:
> On Thu, Aug 29, 2019 at 8:01 PM Phil Reid <preid@electromag.com.au> wrote:
>>
>> On 30/08/2019 07:02, Rob Herring wrote:
>>> On Wed, Aug 28, 2019 at 08:09:19AM +0200, Michal Simek wrote:
>>>> On 27. 08. 19 5:35, Phil Reid wrote:
>>>>> This optional property defines a symbolic name for the device.
>>>>>
>>>>> Signed-off-by: Phil Reid <preid@electromag.com.au>
>>>>> ---
>>>>>    Documentation/devicetree/bindings/iio/iio-bindings.txt | 5 +++++
>>>>>    1 file changed, 5 insertions(+)
>>>>>
>>>>> diff --git a/Documentation/devicetree/bindings/iio/iio-bindings.txt b/Documentation/devicetree/bindings/iio/iio-bindings.txt
>>>>> index 68d6f8ce063b..ffeae5aad8b5 100644
>>>>> --- a/Documentation/devicetree/bindings/iio/iio-bindings.txt
>>>>> +++ b/Documentation/devicetree/bindings/iio/iio-bindings.txt
>>>>> @@ -18,12 +18,17 @@ Required properties:
>>>>>                 with a single IIO output and 1 for nodes with multiple
>>>>>                 IIO outputs.
>>>>>
>>>>> +Optional properties:
>>>>> +label:                A symbolic name for the device.
>>>>> +
>>>>> +
>>>>>    Example for a simple configuration with no trigger:
>>>>>
>>>>>      adc: voltage-sensor@35 {
>>>>>              compatible = "maxim,max1139";
>>>>>              reg = <0x35>;
>>>>>              #io-channel-cells = <1>;
>>>>> +           label = "adc_voltage_sensor";
>>>>>      };
>>>>>
>>>>>    Example for a configuration with trigger:
>>>>>
>>>>
>>>> Just for the record. This patch has been created based on initial
>>>> discussion about label property. And Rob had not problem with using
>>>> label in connection to ina226. https://lkml.org/lkml/2019/8/27/1213
>>>
>>> I didn't, but based on the name here I'm less convinced. 'label' is
>>> supposed to be for needing to distinguish between more than 1 of
>>> something. A name like 'adc_voltage_sensor' doesn't really.
>>>
>>> Rob
>>>
>>>
>>
>> That's the problem we're try to solve. Having multiple devices and try to
>> determine which device is which.
>> eg: Mutliple adc's.
>> For example I have the same dac chip on multiple boards that do different
>> things, it's difficult to id them.
>>
>> so label examples could be:
>> label = "current_control_group1";
>> label = "voltage_control_group1";
>>
>> Are you totally against this or is it a problem with me not being clear
>> with the problem and the wording of the commit message or the example?
> 
> It's just the example is less than ideal. But it's just an example, so:
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
> 
> Feel free to update the example if you respin.
> 
Thanks Rob,

I'll update the example if the series gets a respin.



-- 
Regards
Phil Reid
