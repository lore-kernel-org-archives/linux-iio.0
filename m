Return-Path: <daniel.baluta@gmail.com>
MIME-Version: 1.0
In-Reply-To: <1459938668-9180-1-git-send-email-ldewangan@nvidia.com>
References: <1459938668-9180-1-git-send-email-ldewangan@nvidia.com>
Date: Wed, 6 Apr 2016 16:49:23 +0300
Message-ID: <CAEnQRZBtqDQjydDKywYy9oLecFtjntfWhgOtd2xekVyFrYkH3w@mail.gmail.com>
Subject: Re: [PATCH 1/3] iio: core: Add devm_ APIs for iio_channel_{get,release}
From: Daniel Baluta <daniel.baluta@gmail.com>
To: Laxman Dewangan <ldewangan@nvidia.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>, linux-doc@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On Wed, Apr 6, 2016 at 1:31 PM, Laxman Dewangan <ldewangan@nvidia.com> wrote:
> Some of kernel driver uses the IIO framework to get the sensor
> value via ADC or IIO HW driver. The client driver get iio channel
> by iio_channel_get() and release it by calling iio_channel_release().
>
> Add resource managed version (devm_*) of these APIs so that if client
> calls the devm_iio_channel_get() then it need not to release it explicitly,
> it can be done by managed device framework when driver get un-binded.
>
> This reduces the code in error path and also need of .remove callback in
> some cases.
>

Please provide at least one example of code that uses this API.
