Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-he1eur01on0122.outbound.protection.outlook.com ([104.47.0.122]:60960
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752578AbeDPHRM (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 16 Apr 2018 03:17:12 -0400
Subject: Re: [PATCH 2/2] iio: afe: unit-converter: add support for adi,lt6106
To: "Andrew F. Davis" <afd@ti.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-kernel@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Fabio Estevam <festevam@gmail.com>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20180410152802.30958-1-peda@axentia.se>
 <20180411141555.15044-1-peda@axentia.se>
 <20180411141555.15044-3-peda@axentia.se>
 <a70e8467-d0da-2b37-5dfa-7e14b388634c@ti.com>
 <5d9421cc-5c7b-fcdf-a11f-e97127a3d5bd@metafoo.de>
 <19aeb920-ce5a-4e81-1264-9005e220c237@ti.com>
 <4aac6870-9159-18ba-0aa8-da227c426f38@axentia.se>
 <c2923ac0-5e28-eef0-e32a-1e25ce550a82@ti.com>
 <36e0c96b-89ec-2372-825a-71ead1a43473@axentia.se>
 <d59697bb-60bf-deee-65b5-c552c59e8d5a@ti.com>
From: Peter Rosin <peda@axentia.se>
Message-ID: <30bf0000-acc0-7d06-2870-74b3c559c707@axentia.se>
Date: Mon, 16 Apr 2018 09:17:04 +0200
MIME-Version: 1.0
In-Reply-To: <d59697bb-60bf-deee-65b5-c552c59e8d5a@ti.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 2018-04-13 16:47, Andrew F. Davis wrote:
> On 04/12/2018 05:31 PM, Peter Rosin wrote:
>> On 2018-04-12 17:35, Andrew F. Davis wrote:
>>> True, how about "current-sense-from-voltage" ?
>>
>> Doesn't cover "voltage-divider" (and we don't need separate drivers
>> doing the exact same calculations, that's a maintenance nightmare).
> 
> The driver name doesn't have to cover every use, just more than the
> other name.

I also find current-sense-from-voltage unwieldy. It's simply too long.

Cheers,
Peter
