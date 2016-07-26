Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-io0-f194.google.com ([209.85.223.194]:36300 "EHLO
	mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932258AbcGZTIA (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 26 Jul 2016 15:08:00 -0400
Date: Tue, 26 Jul 2016 14:07:58 -0500
From: Rob Herring <robh@kernel.org>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
	Gregor Boirie <gregor.boirie@parrot.com>,
	Sebastian Reichel <sre@kernel.org>,
	Samu Onkalo <samu.onkalo@intel.com>, devicetree@vger.kernel.org
Subject: Re: [PATCH] iio: document bindings for mounting matrixes
Message-ID: <20160726190758.GA31499@rob-hp-laptop>
References: <1469355434-17043-1-git-send-email-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1469355434-17043-1-git-send-email-linus.walleij@linaro.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sun, Jul 24, 2016 at 12:17:14PM +0200, Linus Walleij wrote:
> The mounting matrix for sensors was introduced in
> commit dfc57732ad38 ("iio:core: mounting matrix support")
> 
> However the device tree bindings are very terse and since this is
> a widely applicable property, we need a proper binding for it
> that the other bindings can reference. This will also be useful
> for other operating systems and sensor engineering at large.
> 
> I think all 3D sensors should support it, the current situation
> is probably that the mounting information is confined in magic
> userspace components rather than using the mounting matrix, which
> is not good for portability and reuse.
> 
> Cc: Gregor Boirie <gregor.boirie@parrot.com>
> Cc: Sebastian Reichel <sre@kernel.org>
> Cc: Samu Onkalo <samu.onkalo@intel.com>
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> Please help out to get this right, I think this could be confusing
> to users unless documented properly. I think the doc has some rough
> edges since I'm not the smartest in physics nor english at all times.
> ---

I can at least say I understand how it's supposed to work better now.

Acked-by: Rob Herring <robh@kernel.org>

On the duplication topic, of course I agree that sysfs docs should refer 
to DT and not vice-versa.

Rob
