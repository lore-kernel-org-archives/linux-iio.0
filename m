Return-Path: <SRS0=qV/9=CS=gmail.com=joel.stan@kernel.org>
MIME-Version: 1.0
Sender: joel.stan@gmail.com
In-Reply-To: <20171119160318.41d7e85a@archlinux>
References: <20171031021203.18248-1-joel@jms.id.au> <CA+gwMcdVpq1P5kWAWzkg2A+Ah-fKyTk0adhGdg4465gkOY3EKA@mail.gmail.com>
 <CACPK8Xc1d89MXBjSJw7Jz0oqkCcoxKbymaVDmJq-kHFK6qG0Sw@mail.gmail.com>
 <20171102144932.00001e17@huawei.com> <20171119160318.41d7e85a@archlinux>
From: Joel Stanley <joel@jms.id.au>
Date: Mon, 20 Nov 2017 15:22:38 +1030
Message-ID: <CACPK8XdwpKOLydSvdfNY0D049ysCc526Vj8E1Om3VVkWbVuhdg@mail.gmail.com>
Subject: Re: [PATCH v2] iio: adc: aspeed: Deassert reset in probe
To: Jonathan Cameron <jic23@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Philipp Zabel <philipp.zabel@gmail.com>,
	Rick Altherr <raltherr@google.com>, Rob Herring <robh+dt@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org,
	devicetree <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-iio@vger.kernel.org>

On Mon, Nov 20, 2017 at 2:33 AM, Jonathan Cameron <jic23@kernel.org> wrote:
> On Thu, 2 Nov 2017 14:49:32 +0000
> Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:
>> IIO is closed for this cycle anyway now.
>> Otherwise, series looks good.
>>
>> Will pick up when back with my main PC as traveling for this week and
>> next.
>
> Forgot to ask, do you want me to pick this up as a fix?
> Also does it make sense to tag it for stable?
>
> If not I can pick it up for the coming cycle. Given the code changes
> are small and well isolated I'm happy to do any of the 3 options,
> it really depends on whether the rest of the platform works well enough
> to be worth rushing these through?

Without the clock driver upstream there's no rush to merge this. I'm
still waiting on review from the clock guys.

Please queue them for 4.16. Thanks!

Cheers,

Joel
