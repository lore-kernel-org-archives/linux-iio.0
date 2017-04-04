Return-Path: <SRS0=sTku=3M=konsulko.com=matt.ranostay@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20170402172949.GA1479@project>
References: <20170327100646.GA8128@project> <2bec8c26-f33c-d331-aa97-047871b4cc57@kernel.org>
 <CACRpkdb06PcUwC_zRThLXcw=haiDzuqP-gsVjchNnSWkootT0Q@mail.gmail.com> <20170402172949.GA1479@project>
From: Matt Ranostay <matt.ranostay@konsulko.com>
Date: Mon, 3 Apr 2017 23:16:37 -0700
Message-ID: <CAJCx=g=E-4i=S+a0euYa8zJd=A2+zH8DgvngQPCF5vydzs+Cww@mail.gmail.com>
Subject: Re: [PATCH] IIO: bmp280-core.c: fix error in humidity calculation
To: Andreas Klinger <ak@it-klinger.de>
Cc: Linus Walleij <linus.walleij@linaro.org>, Jonathan Cameron <jic23@kernel.org>,
	Matt Ranostay <matt.ranostay@intel.com>, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald <pmeerw@pmeerw.net>, ddvlad@gmail.com,
	Akinobu Mita <akinobu.mita@gmail.com>, Wei Yongjun <yongjun_wei@trendmicro.com.cn>,
	Aniroop Mathur <a.mathur@samsung.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On Sun, Apr 2, 2017 at 10:29 AM, Andreas Klinger <ak@it-klinger.de> wrote:
> Linus Walleij <linus.walleij@linaro.org> schrieb am Sun, 02. Apr 16:56:
>> On Sun, Apr 2, 2017 at 11:32 AM, Jonathan Cameron <jic23@kernel.org> wrote:
>> > On 27/03/17 11:06, Andreas Klinger wrote:
>> >> While calculating the compensation of the humidity there are negative
>> >> values interpreted as unsigned because of unsigned variables used.
>> >> These values need to be casted to signed as indicated by the documentation
>> >> of the sensor.
>> >>
>> >> Signed-off-by: Andreas Klinger <ak@it-klinger.de>
>> >
>> > Looks superficially right to me, but would like an Ack from Linus Walleij.
>>
>> I didn't work on these calculations, only infrastructure for the driver
>> but FWIW:
>> Acked-by: Linus Walleij <linus.walleij@linaro.org>
>>
>> Matt Ranostay @Intel is the person you probably want to ACK it though,
>> he added the humidity calculations :)
>
> It just turned out that there must be another error in the calculation. I'll fix
> and test it first.
>
> When i'm done i'll send a new version of the patch.
>

Ok will hold off till review till the next patchset... BTW this
datasheet's calculations made my eyes bleed so it is quiet likely it
has bugs...

Thanks,

Matt

> Andreas
>
>>
>> Yours,
>> Linus Walleij
>
> --
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
