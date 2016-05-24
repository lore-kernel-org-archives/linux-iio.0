Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-oi0-f48.google.com ([209.85.218.48]:33327 "EHLO
	mail-oi0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755882AbcEXL1H (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 24 May 2016 07:27:07 -0400
Received: by mail-oi0-f48.google.com with SMTP id k23so21011286oih.0
        for <linux-iio@vger.kernel.org>; Tue, 24 May 2016 04:27:06 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <3d90f889782a9c8380c3694e55a135ddd6de9bc4.1463164919.git.leonard.crestez@intel.com>
References: <3d90f889782a9c8380c3694e55a135ddd6de9bc4.1463164919.git.leonard.crestez@intel.com>
Date: Tue, 24 May 2016 13:27:06 +0200
Message-ID: <CACRpkdYV3nBbOh++bca7+5uhKt5Ct7ev5M8ZuvQ8OrPP+JPrdQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] iio: st_sensors: Init trigger before irq request
From: Linus Walleij <linus.walleij@linaro.org>
To: Crestez Dan Leonard <leonard.crestez@intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Daniel Baluta <daniel.baluta@intel.com>,
	Giuseppe Barba <giuseppe.barba@st.com>,
	Denis Ciocca <denis.ciocca@st.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, May 13, 2016 at 8:43 PM, Crestez Dan Leonard
<leonard.crestez@intel.com> wrote:

> This fixes a possible race where an interrupt arrives before complete
> initialization and crashes because iio_trigger_get_drvdata returns NULL.
>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Giuseppe Barba <giuseppe.barba@st.com>
> Cc: Denis Ciocca <denis.ciocca@st.com>
> Signed-off-by: Crestez Dan Leonard <leonard.crestez@intel.com>
> ---
> I ran into this while breaking the driver. But since the interrupt line can be
> shared the handler should always be able to accept and ignore a call.

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

However I think my patch fixing the thread issue will collide
by being close in context to this so it'd be great if you
could resend it on top of
"iio: st_sensors: switch to a threaded interrupt"?

Yours,
Linus Walleij
