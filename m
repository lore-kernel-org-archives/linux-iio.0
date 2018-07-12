Return-Path: <SRS0=+dP8=J4=gmail.com=andy.shevchenko@kernel.org>
MIME-Version: 1.0
In-Reply-To: <1531409786-20180-1-git-send-email-stefan.popa@analog.com>
References: <1531409786-20180-1-git-send-email-stefan.popa@analog.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 12 Jul 2018 21:25:51 +0300
Message-ID: <CAHp75Ve+S7UDyLva_PY4s=cjKoSY+aMfWDUEHb6tp4AxGtGsDg@mail.gmail.com>
Subject: Re: [PATCH 4/5] iio:adxl372: Add sampling frequency support
To: Stefan Popa <stefan.popa@analog.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>, Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald <pmeerw@pmeerw.net>, linux-iio <linux-iio@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-iio@vger.kernel.org>

On Thu, Jul 12, 2018 at 6:36 PM, Stefan Popa <stefan.popa@analog.com> wrote:
> This patch adds the option for the user to select the sampling frequency.
> Also, the user can read the available frequencies and read the currently
> set frequency via the read_raw function. The frequency can be set via the
> write_raw function.
>
> When the frequency is set, the bandwidth is also checked and ensured
> that it is constrained to at most half of the sampling frequency.

> +static int adxl372_find_closest_match(const int *array,
> +                                     unsigned int size, int val)
> +{
> +       int i;
> +
> +       for (i = 0; i < size; i++) {
> +               if (val <= array[i])
> +                       return i;
> +       }
> +
> +       return size - 1;
> +}

Perhaps it's time to extend bsearch with something called
bsearch_closest().

-- 
With Best Regards,
Andy Shevchenko
