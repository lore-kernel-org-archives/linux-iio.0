Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-ob0-f180.google.com ([209.85.214.180]:33743 "EHLO
	mail-ob0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753176AbcFTNuY (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 20 Jun 2016 09:50:24 -0400
Received: by mail-ob0-f180.google.com with SMTP id wj2so1136286obc.0
        for <linux-iio@vger.kernel.org>; Mon, 20 Jun 2016 06:50:17 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <6c5cc47895ca35fce84b6b01a3ecf7df928aa197.1463164919.git.leonard.crestez@intel.com>
References: <3d90f889782a9c8380c3694e55a135ddd6de9bc4.1463164919.git.leonard.crestez@intel.com>
 <6c5cc47895ca35fce84b6b01a3ecf7df928aa197.1463164919.git.leonard.crestez@intel.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 20 Jun 2016 15:26:47 +0200
Message-ID: <CACRpkda-WWO3qcyOWUNkjnheGnJA=Op4SsmorDjJmvF3=9CLcg@mail.gmail.com>
Subject: Re: [PATCH 3/3] iio: st_sensors: Use level interrupts
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

> As far as I can tell DRDY for ST sensors behaves as a level rather than
> edge interrupt. Registering for IRQF_TRIGGER_RISING instead of
> IRQF_TRIGGER_HIGH mostly works except when the sampling frequency is
> high enough that new samples come before the new ones are read
> completely. In that case the interrupt line remains high, no more rising
> edges occur and the iio buffer stalls.
>
> Configuring the interrupt as IRQF_TRIGGER_HIGH makes it work as
> expected. This patch makes it so that st_sensors_trigger interrupt
> request code doesn't mangle the request flags into IRQF_TRIGGER_RISING.
>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Giuseppe Barba <giuseppe.barba@st.com>
> Cc: Denis Ciocca <denis.ciocca@st.com>
> Signed-off-by: Crestez Dan Leonard <leonard.crestez@intel.com>
> ---
> This is an alternative fix to this patch:
>         https://www.spinics.net/lists/linux-iio/msg24722.html
> [PATCH 2/2 v6] iio: st_sensors: read surplus samples in trigger.

I have incorporated this approach into my patch now: please give
it a spin!

Yours,
Linus Walleij
