Return-Path: <festevam@gmail.com>
MIME-Version: 1.0
In-Reply-To: <554A923F.2040205@ispras.ru>
References: <1430948924-4756-1-git-send-email-khoroshilov@ispras.ru>
	<CAOMZO5AC=SUdXh6+np_2c3vqaKjpk-rZcR_baJ3-e+qt=dxx9w@mail.gmail.com>
	<554A923F.2040205@ispras.ru>
Date: Wed, 6 May 2015 19:32:42 -0300
Message-ID: <CAOMZO5C-Hv=oE4gb32OssGhH-5S4mwOLnwL1HEjCEZ82akSeRg@mail.gmail.com>
Subject: Re: [PATCH] iio: hid-sensors: Fix memory leak on failure path in hid_prox_probe()
From: Fabio Estevam <festevam@gmail.com>
To: Alexey Khoroshilov <khoroshilov@ispras.ru>
Cc: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org,
	linux-kernel <linux-kernel@vger.kernel.org>, ldv-project@linuxtesting.org
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On Wed, May 6, 2015 at 7:14 PM, Alexey Khoroshilov
<khoroshilov@ispras.ru> wrote:

> Not exactly. Other calls are after
>   indio_dev->channels = channels;
> So,
> error_free_dev_mem:
>         kfree(indio_dev->channels);
> works for them well.

indio_dev is allocated using devm_ , so you don't need to free it.

Your patch is not correct because you only  kfree(channels) in the
prox_parse_report() error case, but you missed the other subsequent
functions.
