Return-Path: <lars@metafoo.de>
Message-ID: <52370B08.3030709@metafoo.de>
Date: Mon, 16 Sep 2013 15:43:36 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Lee Jones <lee.jones@linaro.org>
CC: Jonathan Cameron <jic23@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 jic23@cam.ac.uk, arnd@arndb.de, linus.walleij@linaro.org,
 denis.ciocca@st.com, linux-iio@vger.kernel.org
Subject: Re: [PATCH 14/38] iio: accel: st: Append _accel to accelerator sensor
 device names
References: <1378817379-8238-1-git-send-email-lee.jones@linaro.org> <1378817379-8238-15-git-send-email-lee.jones@linaro.org> <52345330.4050707@kernel.org> <20130916133106.GI16984@lee--X1>
In-Reply-To: <20130916133106.GI16984@lee--X1>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On 09/16/2013 03:31 PM, Lee Jones wrote:
>> Honestly I don't care either way on these, but consistency would definitely
>> be good so applied to the togreg branch of iio.git
> 
> For clarification, is togreg due for the v3.12 merge window or will be
> get a settling period in -next?
> 

Well everything up to the 'iio-for-3.12c' tag will be in v3.12, everything
else not.

- Lars
