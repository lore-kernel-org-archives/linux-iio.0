Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:52910 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935471AbcJVO1u (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 22 Oct 2016 10:27:50 -0400
Subject: Re: [PATCH 0/4] IIO wrapper drivers, dpot-dac and envelope-detector
To: Lars-Peter Clausen <lars@metafoo.de>,
        Peter Rosin <peda@axentia.se>, linux-kernel@vger.kernel.org
References: <1476955562-13673-1-git-send-email-peda@axentia.se>
 <9b8c0789-566d-67a3-b4f5-dbe4c69f6932@metafoo.de>
 <7472292a-a509-c791-4eff-5a5037ead837@axentia.se>
 <30a4b562-f553-2620-e961-c2904bce9c51@metafoo.de>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <923bbaf8-f065-bc05-1f9a-ed703d6746f3@kernel.org>
Date: Sat, 22 Oct 2016 15:27:47 +0100
MIME-Version: 1.0
In-Reply-To: <30a4b562-f553-2620-e961-c2904bce9c51@metafoo.de>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 20/10/16 16:29, Lars-Peter Clausen wrote:
> On 10/20/2016 04:53 PM, Peter Rosin wrote:
> [...]
>> Good idea! Then the "envelope-detector,inverted" bool can go, and be
>> implied by the compatible string. If some way to rebind the irq trigger
>> is later discovered that can be added as a channel attr without
>> deprecating any dt bindings stuff. While at it, the other properties
>> ("envelope-detector,dac-max" and "envelope-detector,comp-interval-ms")
>> could also be implied from the compatible string. Would that be better?
>> I think so.
>>
>> But, the compatible string is one thing and the driver name is another.
>> "axentia,tse850-envelope-detector" doesn't seem like the best of driver
>> names...
> 
> The driver name is not that important we can still change that later if we
> have to, the DT compatible string on the other hand is fixed.
> 
>>
>> Are there any existing examples of drivers for (generic) things built
>> with discrete components like this that could perhaps provide guidance?
> 
> Not that I'm aware of.
> 
Me neither.  Always interesting to break new ground ;)

J
