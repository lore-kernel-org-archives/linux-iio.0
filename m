Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:41339 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752488AbcHOO6v (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 15 Aug 2016 10:58:51 -0400
Subject: Re: [PATCH] iio: document bindings for mounting matrixes
To: Linus Walleij <linus.walleij@linaro.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
References: <1469355434-17043-1-git-send-email-linus.walleij@linaro.org>
 <CACRpkdY0gCLKD3rmiYuFgWSYOe6dtUaBeRi1ns-UFF=AspntFg@mail.gmail.com>
Cc: Gregor Boirie <gregor.boirie@parrot.com>,
	Sebastian Reichel <sre@kernel.org>,
	Samu Onkalo <samu.onkalo@intel.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <c8e83cf2-f9dc-0bc9-fcde-326b05ee290b@kernel.org>
Date: Mon, 15 Aug 2016 15:58:48 +0100
MIME-Version: 1.0
In-Reply-To: <CACRpkdY0gCLKD3rmiYuFgWSYOe6dtUaBeRi1ns-UFF=AspntFg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 11/08/16 12:33, Linus Walleij wrote:
> On Sun, Jul 24, 2016 at 12:17 PM, Linus Walleij
> <linus.walleij@linaro.org> wrote:
> 
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
> 
> AFAICT there is no comments on this patch per se, just chit chat
> about misc, and we have Rob's ACK.
> 
> Can it be merged?
> 
I failed to actually look at it properly so far...

I'd also like input from Gregor as his usecase is somewhat different
and drove the sysfs docs.  They need to agree and I haven't actually
verified they do as yet!

Also for trivial comments, plural of matrix is matrices.
Isn't English weird sometimes ;)

Jonathan
> Yours,
> Linus Walleij
> 

