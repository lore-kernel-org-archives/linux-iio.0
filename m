Return-Path: <linus.walleij@linaro.org>
MIME-Version: 1.0
In-Reply-To: <1468494371-23371-1-git-send-email-weiyj_lk@163.com>
References: <1468487141-20016-1-git-send-email-weiyj_lk@163.com> <1468494371-23371-1-git-send-email-weiyj_lk@163.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 22 Jul 2016 15:10:15 +0200
Message-ID: <CACRpkdYMxn8fPLk_0tSBxA21RbL8A0BN36QtN4P4-OMeCa1GAA@mail.gmail.com>
Subject: Re: [PATCH -next] iio: pressure: bmp280: fix wrong pointer passed to PTR_ERR()
To: weiyj_lk@163.com, Jonathan Cameron <jic23@kernel.org>
Cc: Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Wei Yongjun <yongjun_wei@trendmicro.com.cn>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On Thu, Jul 14, 2016 at 1:06 PM,  <weiyj_lk@163.com> wrote:

> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
>
> PTR_ERR should access the value just tested by IS_ERR, otherwise
> the wrong error code will be returned.
>
> Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

My wrong! Thanks for fixing this.

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linuys Walleij
