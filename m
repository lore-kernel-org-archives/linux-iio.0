Return-Path: <SRS0=NJFm=A6=metafoo.de=lars@kernel.org>
Subject: Re: [PATCH v2] iio: dummy: evgen: use irq_sim
To: Bartosz Golaszewski <brgl@bgdev.pl>, Jonathan Cameron <jic23@kernel.org>,
 Hartmut Knaack <knaack.h@gmx.de>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20170928105641.11793-1-brgl@bgdev.pl>
From: Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <40d29879-54ee-f7eb-ce83-bedd066c0fa3@metafoo.de>
Date: Fri, 29 Sep 2017 15:15:36 +0200
MIME-Version: 1.0
In-Reply-To: <20170928105641.11793-1-brgl@bgdev.pl>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-iio@vger.kernel.org>

On 09/28/2017 12:56 PM, Bartosz Golaszewski wrote:
> Switch to using the recently added interrupt simulator for dummy irqs.
> 
> Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>

Reviewed-by: Lars-Peter Clausen <lars@metafoo.de>
Tested-by: Lars-Peter Clausen <lars@metafoo.de>

I've backported irq_sim to v4.9 for testing and got compile errors due to a
missing slab.h include. In upstream this include comes implicit through
irq.h (coincidentally added by you), I wonder if we should still add it to
irq_sim.c since it is explicitly using the allocation API.
