Return-Path: <SRS0=4Ny8=CJ=infradead.org=rdunlap@kernel.org>
Subject: Re: iio/accel/kxsd9_i2c: no license, taints kernel
From: Randy Dunlap <rdunlap@infradead.org>
To: Jonathan Cameron <jic23@kernel.org>,
 Linus Walleij <linus.walleij@linaro.org>, linux-iio@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>
References: <623dca4f-3029-f207-b17a-a0fba0600b8e@infradead.org>
Message-ID: <a21be947-5c1f-eb71-83ad-63222b46c499@infradead.org>
Date: Sat, 11 Nov 2017 11:21:32 -0800
MIME-Version: 1.0
In-Reply-To: <623dca4f-3029-f207-b17a-a0fba0600b8e@infradead.org>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-iio@vger.kernel.org>

On 11/11/17 10:53, Randy Dunlap wrote:
> [44583.951806] kxsd9_i2c: module license 'unspecified' taints kernel.
> [44583.951931] kxsd9_i2c: Unknown symbol __devm_regmap_init_i2c (err 0)
> 
> __devm_regmap_i2c() is EXPORT_SYMBOL_GPL(), so a non-compatible license
> cannot use it.
> 


and iio/adc/qcom-vadc-common.c:

qcom_vadc_common: module license 'unspecified' taints kernel.


-- 
~Randy
