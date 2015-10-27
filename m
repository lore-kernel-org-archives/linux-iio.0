Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-ob0-f180.google.com ([209.85.214.180]:34210 "EHLO
	mail-ob0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964811AbbJ0QNS (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 27 Oct 2015 12:13:18 -0400
Received: by obbza9 with SMTP id za9so56914753obb.1
        for <linux-iio@vger.kernel.org>; Tue, 27 Oct 2015 09:13:18 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <562CD9BD.6030206@kernel.org>
References: <1444729080-9937-1-git-send-email-paul.cercueil@analog.com>
	<562CD9BD.6030206@kernel.org>
Date: Tue, 27 Oct 2015 17:13:17 +0100
Message-ID: <CACRpkdatEhs34y3D5evo-_rmG=pPb9LcdNWE+3zgnGqbZFh9hQ@mail.gmail.com>
Subject: Re: [PATCHv2 1/2] Documentation: ad5592r: Added devicetree bindings documentation
From: Linus Walleij <linus.walleij@linaro.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Paul Cercueil <paul.cercueil@analog.com>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Antonio Fiol <antonio@fiol.es>,
	Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sun, Oct 25, 2015 at 2:31 PM, Jonathan Cameron <jic23@kernel.org> wrote:
> On 13/10/15 10:37, Paul Cercueil wrote:
>> Signed-off-by: Paul Cercueil <paul.cercueil@analog.com>
> Looks good to me, but as it is a little bit 'different' and we are
> defining entirely new generic bindings (the channel modes stuff)
> I would like some more input.  It might be overkill but we do
> of course have the pinctl framework which covers this sort of
> thing... Might be worth considering if using that to get the unified
> bindings might make sense here...
>
> cc'd Linus in case he wants to comment on this.
>
> It would obviously be a very heavy weight solution to the problem
> so I'm far from convinced it makes sense - or even fits the usecase
> terrible well.  Just thought I'd mention the possibility.

There is something of a grey area between "definately pin control"
and "some extra pin hardware duct-taped to something else".

I guess that is natural, life is full of grey areas...

Basically if there are plenty of pins and functions, local solutions
to the problem will not scale. Then it is necessary to go ahead
and implement full pin control. Especially for say a big BGA
package or so with lots and lots of pins.

It is is a few pins or they just alter between similar functionality
(like different graphic modes) I think local solutions are OK.

There are other problems though, but I comment on these
separately.

Yours,
Linus Walleij
