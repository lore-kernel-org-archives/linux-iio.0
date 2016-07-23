Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:53956 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751304AbcGWKzz (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 23 Jul 2016 06:55:55 -0400
Subject: Re: [PATCH -next] iio: pressure: bmp280: fix wrong pointer passed to
 PTR_ERR()
To: Linus Walleij <linus.walleij@linaro.org>, weiyj_lk@163.com
References: <1468487141-20016-1-git-send-email-weiyj_lk@163.com>
 <1468494371-23371-1-git-send-email-weiyj_lk@163.com>
 <CACRpkdYMxn8fPLk_0tSBxA21RbL8A0BN36QtN4P4-OMeCa1GAA@mail.gmail.com>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Wei Yongjun <yongjun_wei@trendmicro.com.cn>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <44a8f5c9-d95a-02cb-9299-cd8b032d31de@kernel.org>
Date: Sat, 23 Jul 2016 08:45:40 +0200
MIME-Version: 1.0
In-Reply-To: <CACRpkdYMxn8fPLk_0tSBxA21RbL8A0BN36QtN4P4-OMeCa1GAA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 22/07/16 15:10, Linus Walleij wrote:
> On Thu, Jul 14, 2016 at 1:06 PM,  <weiyj_lk@163.com> wrote:
> 
>> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
>>
>> PTR_ERR should access the value just tested by IS_ERR, otherwise
>> the wrong error code will be returned.
>>
>> Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> 
> My wrong! Thanks for fixing this.
> 
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
I've created a temporary branch fixes-togreg-post-rc1 and
will as the name suggests send this upstream once the merge
window closes.

Thanks,

Jonathan
> 
> Yours,
> Linuys Walleij
> 

