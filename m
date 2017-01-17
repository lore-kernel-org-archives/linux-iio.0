Return-Path: <SRS0=xjqT=Y7=gmail.com=marek.vasut@kernel.org>
Subject: Re: [PATCH v2 1/2] devicetree: add Garmin vendor prefix
To: Matt Ranostay <matt@ranostay.consulting>
References: <20161229051306.28547-1-matt@ranostay.consulting>
 <06f2cde2-ac7e-d0e5-5e35-a4946d0398f8@gmail.com>
 <CAJ_EiSQ+kfNnoDsed67v_1CLui7Fp2qMsx67bYMvQ0Y98jO+Aw@mail.gmail.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>
From: Marek Vasut <marek.vasut@gmail.com>
Message-ID: <70a7c21f-cfe8-bada-fb33-a1d0111c02a9@gmail.com>
Date: Tue, 17 Jan 2017 02:52:22 +0100
MIME-Version: 1.0
In-Reply-To: <CAJ_EiSQ+kfNnoDsed67v_1CLui7Fp2qMsx67bYMvQ0Y98jO+Aw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-iio@vger.kernel.org>

On 01/17/2017 02:50 AM, Matt Ranostay wrote:
> On Mon, Jan 16, 2017 at 5:07 PM, Marek Vasut <marek.vasut@gmail.com> wrote:
>> On 12/29/2016 06:13 AM, Matt Ranostay wrote:
>>
>> Some commit message / description of the company would be useful.
>>
>>> Cc: Rob Herring <robh@kernel.org>
>>> Signed-off-by: Matt Ranostay <matt@ranostay.consulting>
>>> ---
>>> Changes from v1:
>>> * switch to stock ticker for Garmin Limited
>>>
>>>  Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
>>>  1 file changed, 1 insertion(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
>>> index 16d3b5e7f5d1..5749bfc5fc5b 100644
>>> --- a/Documentation/devicetree/bindings/vendor-prefixes.txt
>>> +++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
>>> @@ -107,6 +107,7 @@ firefly   Firefly
>>>  focaltech    FocalTech Systems Co.,Ltd
>>>  friendlyarm  Guangzhou FriendlyARM Computer Tech Co., Ltd
>>>  fsl  Freescale Semiconductor
>>> +grmn Garmin Limited
>>
>> Why grmn ? Why not 'garmin' ? Also, the rest uses Ltd. , so make it
>> consistent ?
>>
> 
> As already stated GRMN is the US stock ticker...  and is the "correct way" :)

So we should use the US stock tickers for DT vendor prefixes now ?

>>>  ge   General Electric Company
>>>  geekbuying   GeekBuying
>>>  gef  GE Fanuc Intelligent Platforms Embedded Systems, Inc.
>>>
>>
>>
>> --
>> Best regards,
>> Marek Vasut


-- 
Best regards,
Marek Vasut
