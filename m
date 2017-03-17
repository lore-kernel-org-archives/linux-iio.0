Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-it0-f65.google.com ([209.85.214.65]:34200 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751182AbdCQCGJ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 16 Mar 2017 22:06:09 -0400
Received: by mail-it0-f65.google.com with SMTP id r141so1600081ita.1
        for <linux-iio@vger.kernel.org>; Thu, 16 Mar 2017 19:06:08 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <39a0f2ff-5771-b287-60ca-b62ba330f31b@kernel.org>
References: <58c81906.42d5620a.3e22a.7a2b@mx.google.com> <39a0f2ff-5771-b287-60ca-b62ba330f31b@kernel.org>
From: Varsha Rao <rvarsha016@gmail.com>
Date: Fri, 17 Mar 2017 07:27:03 +0530
Message-ID: <CAAFX7JRUMKQU1MvuO0nQb7DyoEG7pnGXy27RYv1_9wZbP_75Jg@mail.gmail.com>
Subject: Re: [PATCH v2] staging: iio: adis16240: Remove mutex_lock() and
 mutex_unlock() function call.
To: Jonathan Cameron <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Barry Song <21cnbao@gmail.com>,
        outreachy-kernel <outreachy-kernel@googlegroups.com>,
        linux-iio@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hello,

> It's a bit obscure, but isn't there the potential to get the check_status
> call spitting out text for the wrong read, or potentially miss a status
> value entirely?

adis_read_reg()  function calls spi_sync(), which is inside mutex block,
then how will it misread wrong value?
Will not spi_sync() help, which also has mutex block in its definition?
Otherwise are changes to be made to if condition
(val & ADIS16240_ERROR_ACTIVE)?, which depends on the value of val.

I understand that we cannot use txrx_lock private lock in
adis16240_read_12bit_signed.
If the txrx_lock value is set, then it would cause deadlock as in
adis_read_reg again,
it will try to lock txrx_lock variable.

> (kind of more for Lars really, but feel free to comment Varsha!)
>
> The various faults look like this wouldn't be an issue, but I'm not
> totally sure about the SPI failure and whether a following good read
> at exactly the wrong time might result in the error not being reported...

  Was this case eliminated when mutex lock was used before
  adis16240_spi_read_signed() function call?

  Thanks,
  Varsha
