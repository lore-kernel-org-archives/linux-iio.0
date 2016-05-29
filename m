Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:34370 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932315AbcE2T20 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 29 May 2016 15:28:26 -0400
Subject: Re: [PATCH 2/3] iio: st_sensors: Disable DRDY at init time
To: Linus Walleij <linus.walleij@linaro.org>,
	Crestez Dan Leonard <leonard.crestez@intel.com>
References: <3d90f889782a9c8380c3694e55a135ddd6de9bc4.1463164919.git.leonard.crestez@intel.com>
 <52054a54539759100d9c926c78616858b12a2089.1463164919.git.leonard.crestez@intel.com>
 <CACRpkdaymW6ZQ5at6eXZrZ+kCiw=8Zt8E2xwKBtxQZR67c5sxg@mail.gmail.com>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Daniel Baluta <daniel.baluta@intel.com>,
	Giuseppe Barba <giuseppe.barba@st.com>,
	Denis Ciocca <denis.ciocca@st.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <d53c6b5c-5c04-1d81-0caa-58440500a9a4@kernel.org>
Date: Sun, 29 May 2016 20:28:24 +0100
MIME-Version: 1.0
In-Reply-To: <CACRpkdaymW6ZQ5at6eXZrZ+kCiw=8Zt8E2xwKBtxQZR67c5sxg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 24/05/16 12:28, Linus Walleij wrote:
> On Fri, May 13, 2016 at 8:43 PM, Crestez Dan Leonard
> <leonard.crestez@intel.com> wrote:
> 
>> This fixes odd behavior after reboot.
>>
>> The fact that we set the device to powerdown mode is not sufficient to
>> prevent DRDY being active because we might still have an unread sample.
>>
>> Even if powerdown was sufficient keeping DRDY disabled while trigger is
>> not active is a good idea.
>>
>> Cc: Linus Walleij <linus.walleij@linaro.org>
>> Cc: Giuseppe Barba <giuseppe.barba@st.com>
>> Cc: Denis Ciocca <denis.ciocca@st.com>
>> Signed-off-by: Crestez Dan Leonard <leonard.crestez@intel.com>
> 
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Applied to the fixes-togreg-post-rc1 branch of iio.git.

Note I'm taking these without Denis ack as he is snowed under right now and
this set aren't terribly 'exciting' (hopefully)

Jonathan
> 
> Yours,
> Linus Walleij
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

