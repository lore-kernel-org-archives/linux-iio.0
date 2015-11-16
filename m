Return-Path: <linus.walleij@linaro.org>
MIME-Version: 1.0
In-Reply-To: <2335214.a0CysdFUxX@hp-zbook-15-g2>
References: <1447445896-12655-1-git-send-email-linus.walleij@linaro.org>
	<2335214.a0CysdFUxX@hp-zbook-15-g2>
Date: Mon, 16 Nov 2015 09:29:01 +0100
Message-ID: <CACRpkdbf-w=ccp8mRH9g9DdHbcCGmtDmP+9duwNnK7fiQ0=xNA@mail.gmail.com>
Subject: Re: [PATCH 1/2] iio: st_sensors: support active-low interrupts
From: Linus Walleij <linus.walleij@linaro.org>
To: Denis Ciocca <denis.ciocca@st.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, Giuseppe BARBA <giuseppe.barba@st.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On Mon, Nov 16, 2015 at 7:02 AM, Denis Ciocca <denis.ciocca@st.com> wrote:

>> -static int st_sensors_write_data_with_mask(struct iio_dev *indio_dev,
>> -                                               u8 reg_addr, u8 mask, u8
>> data) +int st_sensors_write_data_with_mask(struct iio_dev *indio_dev,
>> +                                   u8 reg_addr, u8 mask, u8 data)
>>  {
>>         int err;
>>         u8 new_data;
>
> This function should include EXPORT_SYMBOL() if drivers are used as modules.

Not a problem:
st_sensors-y := st_sensors_core.o
st_sensors-$(CONFIG_IIO_BUFFER) += st_sensors_buffer.o
st_sensors-$(CONFIG_IIO_TRIGGER) += st_sensors_trigger.o

And CONFIG_IIO_TRIGGER is a bool.

So if it is used, it is always baked into st_sensors_core.o.
(And that is why I chose to create a local header for it.)

Fixing the rest of the problems, thanks Denis!

Yours,
Linus Walleij
