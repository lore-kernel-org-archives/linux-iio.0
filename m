Return-Path: <linus.walleij@linaro.org>
MIME-Version: 1.0
In-Reply-To: <c8e83cf2-f9dc-0bc9-fcde-326b05ee290b@kernel.org>
References: <1469355434-17043-1-git-send-email-linus.walleij@linaro.org>
 <CACRpkdY0gCLKD3rmiYuFgWSYOe6dtUaBeRi1ns-UFF=AspntFg@mail.gmail.com> <c8e83cf2-f9dc-0bc9-fcde-326b05ee290b@kernel.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 15 Aug 2016 20:47:31 +0200
Message-ID: <CACRpkdZ2bpy2cLo2y8i1x9y+8PfJWcG=_A8D=gPZ1usz+=6a2A@mail.gmail.com>
Subject: Re: [PATCH] iio: document bindings for mounting matrixes
To: Jonathan Cameron <jic23@kernel.org>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, Gregor Boirie <gregor.boirie@parrot.com>,
	Sebastian Reichel <sre@kernel.org>, Samu Onkalo <samu.onkalo@intel.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On Mon, Aug 15, 2016 at 4:58 PM, Jonathan Cameron <jic23@kernel.org> wrote:

> I'd also like input from Gregor as his usecase is somewhat different
> and drove the sysfs docs.  They need to agree and I haven't actually
> verified they do as yet!

OK I actually copy-pasted from the sysfs docs for the compass,
but it's good to have him look at it first indeed.

I hope it's OK if I refer to this doc in other patches assuming we
will merge something like it.

> Also for trivial comments, plural of matrix is matrices.
> Isn't English weird sometimes ;)

Aha another irregularity... OK I will fix up when collecting the
feedback.

Yours,
Linus Walleij
