Return-Path: <SRS0=w8w5=X5=csie.org=wens@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20161214135525.16477-1-hdegoede@redhat.com>
References: <20161214135525.16477-1-hdegoede@redhat.com>
From: Chen-Yu Tsai <wens@csie.org>
Date: Wed, 14 Dec 2016 23:00:07 +0800
Message-ID: <CAGb2v66GwmLHL3HKteyhiWX7e+SAHDS9KFku8iJaQ5B0Lrk98A@mail.gmail.com>
Subject: Re: [PATCH] iio: adc: axp288: Drop bogus AXP288_ADC_TS_PIN_CTRL
 register modifications
To: Hans de Goede <hdegoede@redhat.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	"russianneuromancer @ ya . ru" <russianneuromancer@ya.ru>, linux-iio@vger.kernel.org,
	linux-i2c@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On Wed, Dec 14, 2016 at 9:55 PM, Hans de Goede <hdegoede@redhat.com> wrote:
> For some reason the axp288_adc driver was modifying the
> AXP288_ADC_TS_PIN_CTRL register, changing bits 0-1 depending on
> whether the GP_ADC channel or another channel was written.
>
> These bits control when a bias current is send to the TS_PIN, the
> GP_ADC has its own pin and a separate bit in another register to
> control the bias current.
>
> Not only does changing when to enable the TS_PIN bias current
> (always or only when sampling) when reading the GP_ADC make no sense
> at all, the code is modifying these bits is writing the entire register,
> assuming that all the other bits have their default value.
>
> So if the firmware has configured a different bias-current for either
> pin, then that change gets clobbered by the write, likewise if the
> firmware has set bit 2 to indicate that the battery has no thermal sensor,
> this will get clobbered by the write.
>
> This commit fixes all this, by simply removing all writes to the
> AXP288_ADC_TS_PIN_CTRL register, they are not needed to read the
> GP_ADC pin, and can actually be harmful.
>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Acked-by: Chen-Yu Tsai <wens@csie.org>

Note that I do not have hardware to test this.
