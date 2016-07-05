Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-oi0-f49.google.com ([209.85.218.49]:36417 "EHLO
	mail-oi0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752264AbcGEMsc (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 5 Jul 2016 08:48:32 -0400
Received: by mail-oi0-f49.google.com with SMTP id f189so227533918oig.3
        for <linux-iio@vger.kernel.org>; Tue, 05 Jul 2016 05:48:31 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <15b73696-3970-3dfd-95bb-f654f2b32964@kernel.org>
References: <cover.1467023672.git.gregor.boirie@parrot.com>
 <e00825cd4d3ebfcfe97efa4f66822dc0e276e193.1467023672.git.gregor.boirie@parrot.com>
 <15b73696-3970-3dfd-95bb-f654f2b32964@kernel.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 5 Jul 2016 14:48:30 +0200
Message-ID: <CACRpkda2LQdKCrqk4gG2NouE+ZCYeQ55SmZqyfe+BQLMGeMtbA@mail.gmail.com>
Subject: Re: [PATCH v2 7/7] iio:st_pressure: clean useless static channel initializers
To: Jonathan Cameron <jic23@kernel.org>
Cc: Gregor Boirie <gregor.boirie@parrot.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Denis Ciocca <denis.ciocca@st.com>,
	Giuseppe Barba <giuseppe.barba@st.com>,
	Crestez Dan Leonard <leonard.crestez@intel.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, Jul 4, 2016 at 7:17 PM, Jonathan Cameron <jic23@kernel.org> wrote:
> On 27/06/16 11:38, Gregor Boirie wrote:
>> Some static channels are explicitly initialized with default values.
>> Remove them to enhance readability.
>>
>> Signed-off-by: Gregor Boirie <gregor.boirie@parrot.com>
> Applied to the togreg branch of iio.git - initially pushed out as
> testing for the autobuilders to play with it.
>
> I perhaps got a little carried away with Linus' tested by tag and added
> it even to those patches with only docs in them. Ah well - I'm sure he
> tested them by reading the docs :)

Haha who cares :)

I'm happy these patches are in, they are working like a charm
here.

Yours,
Linus Walleij
