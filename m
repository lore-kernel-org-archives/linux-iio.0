Return-Path: <m.othacehe@gmail.com>
References: <1530196286-18891-1-git-send-email-m.othacehe@gmail.com> <1530196286-18891-3-git-send-email-m.othacehe@gmail.com> <20180630173044.3eac53d2@archlinux>
From: Mathieu Othacehe <m.othacehe@gmail.com>
To: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
Cc: linux-iio@vger.kernel.org, jonathan.cameron@huawei.com, pmeerw@pmeerw.net, pierre-moana.levesque@parrot.com
Subject: Re: [PATCH v4 2/2] iio: light: isl29501: Add support for the ISL29501 ToF sensor.
In-reply-to: <20180630173044.3eac53d2@archlinux>
Date: Mon, 02 Jul 2018 10:59:01 +0200
Message-ID: <87in5yt3my.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>


Hi Jonathan,

> A few minors + some missing docs / possible changes in the use
> of extended_name which is in the category of 'only use this in unusual
> circumstances' as it breaks being able to use generic userspace code.

I'll use the IIO_MOD_LIGHT_CLEAR on IIO_INTENSITY to avoid those
extended_name in v5.

>
> Are we stalled on the floating point support question, or is the
> driver just 'limited' but still useful before we have that resolved?

No I guess the driver is ready to go, the user will just lack the
possibility of displaying/setting intensity values for crosstalk
calibration through the driver.

Thanks for your review,

Mathieu
