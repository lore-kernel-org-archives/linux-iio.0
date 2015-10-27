Return-Path: <linus.walleij@linaro.org>
MIME-Version: 1.0
In-Reply-To: <CACRpkdatEhs34y3D5evo-_rmG=pPb9LcdNWE+3zgnGqbZFh9hQ@mail.gmail.com>
References: <1444729080-9937-1-git-send-email-paul.cercueil@analog.com>
	<562CD9BD.6030206@kernel.org>
	<CACRpkdatEhs34y3D5evo-_rmG=pPb9LcdNWE+3zgnGqbZFh9hQ@mail.gmail.com>
Date: Tue, 27 Oct 2015 17:15:56 +0100
Message-ID: <CACRpkdZgjp_scGX=VA-qSiQMGH_ib2ZOo-5HgZCbQWOXfw=7eQ@mail.gmail.com>
Subject: Re: [PATCHv2 1/2] Documentation: ad5592r: Added devicetree bindings documentation
From: Linus Walleij <linus.walleij@linaro.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Paul Cercueil <paul.cercueil@analog.com>, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald <pmeerw@pmeerw.net>,
	Michael Hennerich <Michael.Hennerich@analog.com>, Antonio Fiol <antonio@fiol.es>,
	Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On Tue, Oct 27, 2015 at 5:13 PM, Linus Walleij <linus.walleij@linaro.org> wrote:

> There are other problems though, but I comment on these
> separately.

Was wrong about that. I think this can go in like this.

Later, this device may fork off a GPIO chip as well, but
we will deal with that whenever we run into it.

Yours,
Linus Walleij
