Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:44798 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751757AbdKKSyB (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 11 Nov 2017 13:54:01 -0500
To: Jonathan Cameron <jic23@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-iio@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>
From: Randy Dunlap <rdunlap@infradead.org>
Subject: iio/accel/kxsd9_i2c: no license, taints kernel
Message-ID: <623dca4f-3029-f207-b17a-a0fba0600b8e@infradead.org>
Date: Sat, 11 Nov 2017 10:53:55 -0800
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

[44583.951806] kxsd9_i2c: module license 'unspecified' taints kernel.
[44583.951931] kxsd9_i2c: Unknown symbol __devm_regmap_init_i2c (err 0)

__devm_regmap_i2c() is EXPORT_SYMBOL_GPL(), so a non-compatible license
cannot use it.

-- 
~Randy
