Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-qt0-f175.google.com ([209.85.216.175]:35587 "EHLO
        mail-qt0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750893AbdAQBuw (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 16 Jan 2017 20:50:52 -0500
Received: by mail-qt0-f175.google.com with SMTP id x49so131746652qtc.2
        for <linux-iio@vger.kernel.org>; Mon, 16 Jan 2017 17:50:51 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <06f2cde2-ac7e-d0e5-5e35-a4946d0398f8@gmail.com>
References: <20161229051306.28547-1-matt@ranostay.consulting> <06f2cde2-ac7e-d0e5-5e35-a4946d0398f8@gmail.com>
From: Matt Ranostay <matt@ranostay.consulting>
Date: Mon, 16 Jan 2017 17:50:51 -0800
Message-ID: <CAJ_EiSQ+kfNnoDsed67v_1CLui7Fp2qMsx67bYMvQ0Y98jO+Aw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] devicetree: add Garmin vendor prefix
To: Marek Vasut <marek.vasut@gmail.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, Jan 16, 2017 at 5:07 PM, Marek Vasut <marek.vasut@gmail.com> wrote:
> On 12/29/2016 06:13 AM, Matt Ranostay wrote:
>
> Some commit message / description of the company would be useful.
>
>> Cc: Rob Herring <robh@kernel.org>
>> Signed-off-by: Matt Ranostay <matt@ranostay.consulting>
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
>
> Why grmn ? Why not 'garmin' ? Also, the rest uses Ltd. , so make it
> consistent ?
>

As already stated GRMN is the US stock ticker...  and is the "correct way" :)

>>  ge   General Electric Company
>>  geekbuying   GeekBuying
>>  gef  GE Fanuc Intelligent Platforms Embedded Systems, Inc.
>>
>
>
> --
> Best regards,
> Marek Vasut
