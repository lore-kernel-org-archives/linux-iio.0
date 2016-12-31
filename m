Return-Path: <SRS0=SjnK=YO=ranostay.consulting=matt@kernel.org>
MIME-Version: 1.0
In-Reply-To: <144bd616-1b5a-970a-edcb-13ebf67178f1@kernel.org>
References: <20161229051306.28547-1-matt@ranostay.consulting> <144bd616-1b5a-970a-edcb-13ebf67178f1@kernel.org>
From: Matt Ranostay <matt@ranostay.consulting>
Date: Fri, 30 Dec 2016 21:55:35 -0800
Message-ID: <CAJ_EiSTQ6naDiRP6o1UOr33UyKDtXaan2j4UPFNMTRKReuR-PQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] devicetree: add Garmin vendor prefix
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	Rob Herring <robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On Fri, Dec 30, 2016 at 12:26 PM, Jonathan Cameron <jic23@kernel.org> wrote:
> On 29/12/16 05:13, Matt Ranostay wrote:
>> Cc: Rob Herring <robh@kernel.org>
>> Signed-off-by: Matt Ranostay <matt@ranostay.consulting>
> Rob, just to check - is this the right way to go with prefixes?
> It's awfully ugly in this case ;)

Rob said the stock ticker (likely the US exchanges) is the way to go :)

>
> Jonathan
>> ---
>> Changes from v1:
>> * switch to stock ticker for Garmin Limited
>>
>>  Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
>> index 16d3b5e7f5d1..5749bfc5fc5b 100644
>> --- a/Documentation/devicetree/bindings/vendor-prefixes.txt
>> +++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
>> @@ -107,6 +107,7 @@ firefly   Firefly
>>  focaltech    FocalTech Systems Co.,Ltd
>>  friendlyarm  Guangzhou FriendlyARM Computer Tech Co., Ltd
>>  fsl  Freescale Semiconductor
>> +grmn Garmin Limited
>>  ge   General Electric Company
>>  geekbuying   GeekBuying
>>  gef  GE Fanuc Intelligent Platforms Embedded Systems, Inc.
>>
>
