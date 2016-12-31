Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:57294 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754612AbcLaPTS (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 31 Dec 2016 10:19:18 -0500
Subject: Re: [PATCH v2 1/2] devicetree: add Garmin vendor prefix
To: Matt Ranostay <matt@ranostay.consulting>
References: <20161229051306.28547-1-matt@ranostay.consulting>
 <144bd616-1b5a-970a-edcb-13ebf67178f1@kernel.org>
 <CAJ_EiSTQ6naDiRP6o1UOr33UyKDtXaan2j4UPFNMTRKReuR-PQ@mail.gmail.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        Rob Herring <robh@kernel.org>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <6b4e2c4d-720a-a8c1-d45a-5b96abd37454@kernel.org>
Date: Sat, 31 Dec 2016 15:19:13 +0000
MIME-Version: 1.0
In-Reply-To: <CAJ_EiSTQ6naDiRP6o1UOr33UyKDtXaan2j4UPFNMTRKReuR-PQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 31/12/16 05:55, Matt Ranostay wrote:
> On Fri, Dec 30, 2016 at 12:26 PM, Jonathan Cameron <jic23@kernel.org> wrote:
>> On 29/12/16 05:13, Matt Ranostay wrote:
>>> Cc: Rob Herring <robh@kernel.org>
>>> Signed-off-by: Matt Ranostay <matt@ranostay.consulting>
>> Rob, just to check - is this the right way to go with prefixes?
>> It's awfully ugly in this case ;)
> 
> Rob said the stock ticker (likely the US exchanges) is the way to go :)
Fair enough.  Both applied to the togreg branch of iio.git and pushed
out as testing.

Thanks,

Jonathan
> 
>>
>> Jonathan
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
>>>  ge   General Electric Company
>>>  geekbuying   GeekBuying
>>>  gef  GE Fanuc Intelligent Platforms Embedded Systems, Inc.
>>>
>>

