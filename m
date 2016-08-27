Return-Path: <linus.walleij@linaro.org>
MIME-Version: 1.0
In-Reply-To: <1472279190-23169-1-git-send-email-baoyou.xie@linaro.org>
References: <1472279190-23169-1-git-send-email-baoyou.xie@linaro.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Sat, 27 Aug 2016 10:44:59 +0200
Message-ID: <CACRpkdZgXX9v9AZcjb955rf8U2jNNM2J6X_jboDDKGS0z0CQsA@mail.gmail.com>
Subject: Re: [PATCH] fix:iio:common:st_sensors:st_sensors_trigger:mark symbols
 static where possible
To: Baoyou Xie <baoyou.xie@linaro.org>
Cc: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>, rob@kernel.org, maitysanchayan@gmail.com,
	Crestez Dan Leonard <leonard.crestez@intel.com>, Gregor Boirie <gregor.boirie@parrot.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@linaro.org>, xie.baoyou@zte.com.cn
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On Sat, Aug 27, 2016 at 8:26 AM, Baoyou Xie <baoyou.xie@linaro.org> wrote:

> We get 2 warnings when biuld kernel with W=1:
> drivers/iio/common/st_sensors/st_sensors_trigger.c:69:13: warning: no previous prototype
> for 'st_sensors_irq_handler' [-Wmissing-prototypes]
> drivers/iio/common/st_sensors/st_sensors_trigger.c:85:13: warning: no previous prototype
> for 'st_sensors_irq_thread' [-Wmissing-prototypes]
>
> In fact, these functions are only used in the file in which they are
> declared and don't need a declaration, but can be made static.
> so this patch marks these functions with 'static'.
>
> Signed-off-by: Baoyou Xie <baoyou.xie@linaro.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
