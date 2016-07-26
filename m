Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:43618 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757179AbcGZVBV (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 26 Jul 2016 17:01:21 -0400
Subject: Re: [PATCH] iio: document bindings for mounting matrixes
To: Rob Herring <robh@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>
References: <1469355434-17043-1-git-send-email-linus.walleij@linaro.org>
 <20160726190758.GA31499@rob-hp-laptop>
Cc: linux-iio@vger.kernel.org,
	Gregor Boirie <gregor.boirie@parrot.com>,
	Sebastian Reichel <sre@kernel.org>,
	Samu Onkalo <samu.onkalo@intel.com>, devicetree@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <1689ff64-e51d-c23f-fa09-b38ced420bfb@kernel.org>
Date: Tue, 26 Jul 2016 22:01:15 +0100
MIME-Version: 1.0
In-Reply-To: <20160726190758.GA31499@rob-hp-laptop>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 26/07/16 20:07, Rob Herring wrote:
> On Sun, Jul 24, 2016 at 12:17:14PM +0200, Linus Walleij wrote:
>> The mounting matrix for sensors was introduced in
>> commit dfc57732ad38 ("iio:core: mounting matrix support")
>>
>> However the device tree bindings are very terse and since this is
>> a widely applicable property, we need a proper binding for it
>> that the other bindings can reference. This will also be useful
>> for other operating systems and sensor engineering at large.
>>
>> I think all 3D sensors should support it, the current situation
>> is probably that the mounting information is confined in magic
>> userspace components rather than using the mounting matrix, which
>> is not good for portability and reuse.
>>
>> Cc: Gregor Boirie <gregor.boirie@parrot.com>
>> Cc: Sebastian Reichel <sre@kernel.org>
>> Cc: Samu Onkalo <samu.onkalo@intel.com>
>> Cc: devicetree@vger.kernel.org
>> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
>> ---
>> Please help out to get this right, I think this could be confusing
>> to users unless documented properly. I think the doc has some rough
>> edges since I'm not the smartest in physics nor english at all times.
>> ---
> 
> I can at least say I understand how it's supposed to work better now.
> 
> Acked-by: Rob Herring <robh@kernel.org>
> 
> On the duplication topic, of course I agree that sysfs docs should refer 
> to DT and not vice-versa.
I'd be tempted to keep a 'full' documentation of all the relevant aspects
in each place, but make sure there is a cross reference from the sysfs
ABI docs to the device tree ones as has been suggested.
(rather than converting the sysfs docs just a cross reference + note
on how the bindings and attribute are related).
> 
> Rob
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

