Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-io0-f193.google.com ([209.85.223.193]:52833 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751391AbdKMKWh (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 13 Nov 2017 05:22:37 -0500
Received: by mail-io0-f193.google.com with SMTP id u42so2053929ioi.9
        for <linux-iio@vger.kernel.org>; Mon, 13 Nov 2017 02:22:37 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <a21be947-5c1f-eb71-83ad-63222b46c499@infradead.org>
References: <623dca4f-3029-f207-b17a-a0fba0600b8e@infradead.org> <a21be947-5c1f-eb71-83ad-63222b46c499@infradead.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 13 Nov 2017 11:22:36 +0100
Message-ID: <CACRpkdb_101_guBu2dC5c+avJHFnFSw4fc7Ug7+B8tAuqz=UeQ@mail.gmail.com>
Subject: Re: iio/accel/kxsd9_i2c: no license, taints kernel
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sat, Nov 11, 2017 at 8:21 PM, Randy Dunlap <rdunlap@infradead.org> wrote:
> On 11/11/17 10:53, Randy Dunlap wrote:
>> [44583.951806] kxsd9_i2c: module license 'unspecified' taints kernel.
>> [44583.951931] kxsd9_i2c: Unknown symbol __devm_regmap_init_i2c (err 0)
>>
>> __devm_regmap_i2c() is EXPORT_SYMBOL_GPL(), so a non-compatible license
>> cannot use it.
>>
>
>
> and iio/adc/qcom-vadc-common.c:
>
> qcom_vadc_common: module license 'unspecified' taints kernel.

I wrote these, I will send a patch.

Yours,
Linus Walleij
