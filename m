Return-Path: <linus.walleij@linaro.org>
MIME-Version: 1.0
In-Reply-To: <57960AAF.1060103@parrot.com>
References: <1469355434-17043-1-git-send-email-linus.walleij@linaro.org>
 <06168d06-b609-a0ec-945e-aa36a4dbe795@kernel.org> <57960AAF.1060103@parrot.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 25 Jul 2016 15:57:24 +0200
Message-ID: <CACRpkdbUorArtpy5KH46TmaLHphj3EerQ6cJDfDu5YWZkGFi=w@mail.gmail.com>
Subject: Re: [PATCH] iio: document bindings for mounting matrixes
To: Gregor Boirie <gregor.boirie@parrot.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, Sebastian Reichel <sre@kernel.org>,
	Samu Onkalo <samu.onkalo@intel.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On Mon, Jul 25, 2016 at 2:48 PM, Gregor Boirie <gregor.boirie@parrot.com> wrote:

> I'm wondering how to ensure consistent documentation between sysfs
> iio ABI and DT binding since there will be duplicates at some point.
> Cross-refering Documentation/devicetree/bindings/iio/mount-matrix.txt within
> Documentation/ABI/testing/sysfs-bus-iio might be an option since "DT
> bindings
> are (in theory, mind you) a standards document used by other" as Linus said.

That's my position on the issue, if the documents should refer each other
in any direction the sysfs should reference the DT bindings.

(Maybe someone will slap me for this...)

Yours.
Linus Walleij
