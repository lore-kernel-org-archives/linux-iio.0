Return-Path: <SRS0=7f4f=3K=linaro.org=linus.walleij@kernel.org>
MIME-Version: 1.0
In-Reply-To: <2bec8c26-f33c-d331-aa97-047871b4cc57@kernel.org>
References: <20170327100646.GA8128@project> <2bec8c26-f33c-d331-aa97-047871b4cc57@kernel.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Sun, 2 Apr 2017 16:56:13 +0200
Message-ID: <CACRpkdb06PcUwC_zRThLXcw=haiDzuqP-gsVjchNnSWkootT0Q@mail.gmail.com>
Subject: Re: [PATCH] IIO: bmp280-core.c: fix error in humidity calculation
To: Jonathan Cameron <jic23@kernel.org>, Matt Ranostay <matt.ranostay@intel.com>
Cc: Andreas Klinger <ak@it-klinger.de>, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald <pmeerw@pmeerw.net>, ddvlad@gmail.com,
	Akinobu Mita <akinobu.mita@gmail.com>, Wei Yongjun <yongjun_wei@trendmicro.com.cn>,
	Aniroop Mathur <a.mathur@samsung.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On Sun, Apr 2, 2017 at 11:32 AM, Jonathan Cameron <jic23@kernel.org> wrote:
> On 27/03/17 11:06, Andreas Klinger wrote:
>> While calculating the compensation of the humidity there are negative
>> values interpreted as unsigned because of unsigned variables used.
>> These values need to be casted to signed as indicated by the documentation
>> of the sensor.
>>
>> Signed-off-by: Andreas Klinger <ak@it-klinger.de>
>
> Looks superficially right to me, but would like an Ack from Linus Walleij.

I didn't work on these calculations, only infrastructure for the driver
but FWIW:
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Matt Ranostay @Intel is the person you probably want to ACK it though,
he added the humidity calculations :)

Yours,
Linus Walleij
