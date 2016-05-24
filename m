Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-oi0-f42.google.com ([209.85.218.42]:32993 "EHLO
	mail-oi0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755613AbcEXL2J (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 24 May 2016 07:28:09 -0400
Received: by mail-oi0-f42.google.com with SMTP id k23so21045909oih.0
        for <linux-iio@vger.kernel.org>; Tue, 24 May 2016 04:28:08 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <52054a54539759100d9c926c78616858b12a2089.1463164919.git.leonard.crestez@intel.com>
References: <3d90f889782a9c8380c3694e55a135ddd6de9bc4.1463164919.git.leonard.crestez@intel.com>
	<52054a54539759100d9c926c78616858b12a2089.1463164919.git.leonard.crestez@intel.com>
Date: Tue, 24 May 2016 13:28:07 +0200
Message-ID: <CACRpkdaymW6ZQ5at6eXZrZ+kCiw=8Zt8E2xwKBtxQZR67c5sxg@mail.gmail.com>
Subject: Re: [PATCH 2/3] iio: st_sensors: Disable DRDY at init time
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

> This fixes odd behavior after reboot.
>
> The fact that we set the device to powerdown mode is not sufficient to
> prevent DRDY being active because we might still have an unread sample.
>
> Even if powerdown was sufficient keeping DRDY disabled while trigger is
> not active is a good idea.
>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Giuseppe Barba <giuseppe.barba@st.com>
> Cc: Denis Ciocca <denis.ciocca@st.com>
> Signed-off-by: Crestez Dan Leonard <leonard.crestez@intel.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
