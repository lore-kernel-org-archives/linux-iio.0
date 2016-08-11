Return-Path: <linus.walleij@linaro.org>
MIME-Version: 1.0
In-Reply-To: <1469355434-17043-1-git-send-email-linus.walleij@linaro.org>
References: <1469355434-17043-1-git-send-email-linus.walleij@linaro.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 11 Aug 2016 13:33:29 +0200
Message-ID: <CACRpkdY0gCLKD3rmiYuFgWSYOe6dtUaBeRi1ns-UFF=AspntFg@mail.gmail.com>
Subject: Re: [PATCH] iio: document bindings for mounting matrixes
To: Jonathan Cameron <jic23@kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Cc: Linus Walleij <linus.walleij@linaro.org>, Gregor Boirie <gregor.boirie@parrot.com>,
	Sebastian Reichel <sre@kernel.org>, Samu Onkalo <samu.onkalo@intel.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On Sun, Jul 24, 2016 at 12:17 PM, Linus Walleij
<linus.walleij@linaro.org> wrote:

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

AFAICT there is no comments on this patch per se, just chit chat
about misc, and we have Rob's ACK.

Can it be merged?

Yours,
Linus Walleij
