Return-Path: <linus.walleij@linaro.org>
MIME-Version: 1.0
In-Reply-To: <058533b8-a0a7-b7fa-9745-d72eb2a2db21@kernel.org>
References: <1466176341-17442-1-git-send-email-linus.walleij@linaro.org>
 <20160620164645.GA3191@rob-hp-laptop> <058533b8-a0a7-b7fa-9745-d72eb2a2db21@kernel.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 27 Jun 2016 10:52:26 +0200
Message-ID: <CACRpkdap7oMnzP6u7dz3-hvbMAFfMf1iSp7v=czq1VBwMj51cA@mail.gmail.com>
Subject: Re: [PATCH 1/4] iio: pressure: bmp280: augment DT bindings
To: Jonathan Cameron <jic23@kernel.org>
Cc: Rob Herring <robh@kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, Akinobu Mita <akinobu.mita@gmail.com>,
	Irina Tirdea <irina.tirdea@intel.com>, Hartmut Knaack <knaack.h@gmx.de>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On Sun, Jun 26, 2016 at 6:47 PM, Jonathan Cameron <jic23@kernel.org> wrote:
> On 20/06/16 17:46, Rob Herring wrote:
>> On Fri, Jun 17, 2016 at 05:12:18PM +0200, Linus Walleij wrote:

>>>  Required properties:
>>> -- compatible: bosch,bmp085
>>> +- compatible: "bosch,bmp085" or "bosch,bmp180" or "bosch,bmp280"
>>
>> One per line is preferred, but I wouldn't respin just for that.
>>
>> Acked-by: Rob Herring <robh@kernel.org>
>>
> Applied to the togreg branch of iio.git - initially pushed out
> as testing.

Actually I did fix Rob's minor comments and sent out as v2,
but no big deal.

Yours,
Linus Walleij
