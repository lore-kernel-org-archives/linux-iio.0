Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.187]:52909 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753216AbcHXPlK (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 24 Aug 2016 11:41:10 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Cameron <jic23@cam.ac.uk>,
        Marek Belisko <marek@goldelico.com>,
        "H . Nikolaus Schaller" <hns@goldelico.com>,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH v2] misc: retire the old BMP085 driver
Date: Wed, 24 Aug 2016 17:40:56 +0200
Message-ID: <3297291.KPbN9dOXlf@wuerfel>
In-Reply-To: <1472049532-12196-1-git-send-email-linus.walleij@linaro.org>
References: <1472049532-12196-1-git-send-email-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wednesday, August 24, 2016 4:38:52 PM CEST Linus Walleij wrote:
> Patches merged to the IIO BMP085 driver makes it fully compliant
> with all features found in this old misc driver. Retire this old
> driver in favor of the new one in the proper subsystem.
> 
> Cc: Arnd Bergmann <arnd@arndb.de>
> 

Acked-by: Arnd Bergmann <arnd@arndb.de>
