Return-Path: <SRS0=vXGt=GJ=gmail.com=matthias.bgg@kernel.org>
Subject: Re: [PATCH 3/3] arm64: dts: mt2712: Add auxadc device node.
From: Matthias Brugger <matthias.bgg@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
 Zhiyong Tao <zhiyong.tao@mediatek.com>
Cc: robh+dt@kernel.org, knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
 srv_heupstream@mediatek.com, liguo.zhang@mediatek.com,
 yingjoe.chen@mediatek.com, sean.wang@mediatek.com, yt.shen@mediatek.com,
 s.hauer@pengutronix.de, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-iio@vger.kernel.org, linux-mediatek@lists.infradead.org
References: <1505957212-13402-1-git-send-email-zhiyong.tao@mediatek.com>
 <1505957212-13402-4-git-send-email-zhiyong.tao@mediatek.com>
 <20170924164705.78cbb856@archlinux>
 <0e1bac27-18ca-121c-f1d7-8063af177a8b@gmail.com>
 <6680d15a-625a-cc16-830f-9831f5f52ad3@gmail.com>
Message-ID: <f1c8f79f-8536-f3cc-22be-31466a1390ad@gmail.com>
Date: Mon, 19 Mar 2018 02:51:58 +0100
MIME-Version: 1.0
In-Reply-To: <6680d15a-625a-cc16-830f-9831f5f52ad3@gmail.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-iio@vger.kernel.org>



On 10/16/2017 05:09 PM, Matthias Brugger wrote:
> 
> 
> On 10/13/2017 05:11 PM, Matthias Brugger wrote:
>>
>>
>> On 09/24/2017 05:47 PM, Jonathan Cameron wrote:
>>> On Thu, 21 Sep 2017 09:26:52 +0800
>>> Zhiyong Tao <zhiyong.tao@mediatek.com> wrote:
>>>
>>>> Add auxadc device node for MT2712.
>>>>
>>>> Signed-off-by: Zhiyong Tao <zhiyong.tao@mediatek.com>
>>>
>>> I've applied the IIO patches to make this work, so assume this will get
>>> picked up in due course.
>>>
>>
>> pushed now to v4.14-next/dts64
>> Thanks.
>>
> 
> I realized that this needs the mt2712 clock patches to actually work.
> Dropped for now. Please resubmit as soon as mt2712 clock patches got [1]
> accepted upstream.
> 

I think you actually never resubmitted. Anyway I pushed it now to v4.16-next/dts64

Thanks.

> Thanks,
> Matthias
> 
> [1] https://lkml.org/lkml/2017/9/19/9
