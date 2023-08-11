Return-Path: <linux-iio-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06F97C001B0
	for <linux-iio@archiver.kernel.org>; Fri, 11 Aug 2023 15:34:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230163AbjHKPeY (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Fri, 11 Aug 2023 11:34:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234661AbjHKPeU (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 11 Aug 2023 11:34:20 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2D0830DB;
        Fri, 11 Aug 2023 08:34:07 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4RMnmP0fV3z6J7fb;
        Fri, 11 Aug 2023 23:30:13 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Fri, 11 Aug
 2023 16:34:05 +0100
Date:   Fri, 11 Aug 2023 16:34:04 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Andi Shyti <andi.shyti@kernel.org>
Subject: Re: [PATCH 2/2] iio: proximity: isl29501: mark OF related data as
 maybe unused
Message-ID: <20230811163404.00003ba3@Huawei.com>
In-Reply-To: <20230810111933.205619-2-krzysztof.kozlowski@linaro.org>
References: <20230810111933.205619-1-krzysztof.kozlowski@linaro.org>
        <20230810111933.205619-2-krzysztof.kozlowski@linaro.org>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100005.china.huawei.com (7.191.160.25) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 10 Aug 2023 13:19:33 +0200
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:

> When compile tested with W=1 on x86_64 with driver as built-in:
> 
>   isl29501.c:999:34: error: unused variable 'isl29501_i2c_matches' [-Werror,-Wunused-const-variable]
> 
> The if defined(CONFIG_OF) is also not needed in such case.
As in patch 1 I'd rather see it used. Not even an match data to make that more complex
here.

> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  drivers/iio/proximity/isl29501.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/proximity/isl29501.c b/drivers/iio/proximity/isl29501.c
> index bcebacaf3dab..9e34224b5775 100644
> --- a/drivers/iio/proximity/isl29501.c
> +++ b/drivers/iio/proximity/isl29501.c
> @@ -995,13 +995,11 @@ static const struct i2c_device_id isl29501_id[] = {
>  
>  MODULE_DEVICE_TABLE(i2c, isl29501_id);
>  
> -#if defined(CONFIG_OF)
> -static const struct of_device_id isl29501_i2c_matches[] = {
> +static const struct of_device_id isl29501_i2c_matches[] __maybe_unused = {
>  	{ .compatible = "renesas,isl29501" },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(of, isl29501_i2c_matches);
> -#endif
>  
>  static struct i2c_driver isl29501_driver = {
>  	.driver = {

