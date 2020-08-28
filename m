Return-Path: <SRS0=ngxN=CG=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8717C433E6
	for <linux-iio@archiver.kernel.org>; Fri, 28 Aug 2020 17:52:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C177A20776
	for <linux-iio@archiver.kernel.org>; Fri, 28 Aug 2020 17:52:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727020AbgH1RwD (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Fri, 28 Aug 2020 13:52:03 -0400
Received: from smtprelay0127.hostedemail.com ([216.40.44.127]:49450 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726794AbgH1RwC (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 28 Aug 2020 13:52:02 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id 9C5C8100E7B4C;
        Fri, 28 Aug 2020 17:52:00 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: edge90_0e065aa27077
X-Filterd-Recvd-Size: 3579
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf05.hostedemail.com (Postfix) with ESMTPA;
        Fri, 28 Aug 2020 17:51:56 +0000 (UTC)
Message-ID: <d8dce79d93363e19ea132ba8237a607a1ff28f09.camel@perches.com>
Subject: Re: [PATCH v2 09/18] iio: afe: iio-rescale: Simplify with
 dev_err_probe()
From:   Joe Perches <joe@perches.com>
To:     Peter Rosin <peda@axentia.se>,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Kukjin Kim <kgene@kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Beniamin Bia <beniamin.bia@analog.com>,
        Tomasz Duszynski <tomasz.duszynski@octakon.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-iio@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        linux-amlogic@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com
Date:   Fri, 28 Aug 2020 10:51:55 -0700
In-Reply-To: <b7a5a441-cda1-ad02-b723-255231f2bd94@axentia.se>
References: <20200827192642.1725-1-krzk@kernel.org>
         <20200827192642.1725-9-krzk@kernel.org>
         <f4a5777e-fe85-9f3f-4818-f7539f223adc@axentia.se>
         <20200828062443.GA17343@pi3>
         <3a5cb59b-454e-2c3f-9f31-43147e843c66@axentia.se>
         <CAJKOXPcqNE5U82UThzBTPCvucCf2LsCVSfAHE1vnecJGCKCaig@mail.gmail.com>
         <b7a5a441-cda1-ad02-b723-255231f2bd94@axentia.se>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 2020-08-28 at 11:39 +0200, Peter Rosin wrote:
> On 2020-08-28 09:03, Krzysztof Kozlowski wrote:
> > > > If there is no consensus among discussing people, I find this 100 line
> > > > more readable, already got review, checkpatch accepts it so if subsystem
> > > > maintainer likes it, I prefer to leave it like this.
> > > 
> > > I'm not impressed by that argument. For the files I have mentioned, it
> > > does not matter very much to me if you and some random person think that
> > > 100 columns might *slightly* improve readability.
> > > 
> > > Quoting coding-style
> > > 
> > >   Statements longer than 80 columns should be broken into sensible chunks,
> > >   unless exceeding 80 columns significantly increases readability and does
> > >   not hide information.
> > > 
> > > Notice that word? *significantly*
> > 
> > Notice also checkpatch change...
> 
> How is that relevant? checkpatch has *never* had the final say and its
> heuristics can never be perfect. Meanwhile, coding style is talking about
> exactly the case under discussion, and agrees with me perfectly.

As the checkpatch maintainer, checkpatch is stupid.
Using it as a primary argument should never be acceptable.

But line lengths from 81 to 100 columns should be exceptions
rather than
standard use.

Any named maintainer of actual code determines the style for
that code.

Style consistency and use of kernel standard mechanisms
should be the primary goals here.


