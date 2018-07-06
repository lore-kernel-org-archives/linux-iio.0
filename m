Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from szxga04-in.huawei.com ([45.249.212.190]:9163 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933561AbeGFRC0 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 6 Jul 2018 13:02:26 -0400
Date: Fri, 6 Jul 2018 18:02:01 +0100
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Stefan Wahren <stefan.wahren@i2se.com>
CC: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>,
        Denis Ciocca <denis.ciocca@st.com>,
        Jonathan Cameron <jic23@kernel.org>,
        <linux-iio@vger.kernel.org>
Subject: Re: st_accel: iis328dq support?
Message-ID: <20180706180201.000024a8@huawei.com>
In-Reply-To: <2bac9ecf-9d2e-967e-9020-1c950487d781@i2se.com>
References: <2bac9ecf-9d2e-967e-9020-1c950487d781@i2se.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, 6 Jul 2018 09:18:53 +0200
Stefan Wahren <stefan.wahren@i2se.com> wrote:

> Hi,
> i want to use the ST IIS328DQ [1] on a ARM board with Linux. The iio 
> subsystem has this st_accel driver. But i didn't find any reference to 
> the IIS328DQ, so i started comparing the datasheets and found the ST 
> LIS331DLH [2].

Given it reports the same WHO_AM_I of 0x32 it better be compatible
or they are being very unhelpful!

> 
> Since i didn't have the hardware yet, i've the following questions:
> 
> Does the st_accel driver support the IIS328DQ?

Not if it's not listed - though it might work.

> Should i choose the st,lis331dlh compatible for devicetree?

Ideal is to add the addition compatible string and device name etc
to the driver to support the part under this part number.

It's always nicer if a DT matches the part number on the part you
can see on the board!

Jonathan

p.s. If you don't fancy writing the patch, but will happily test
it really is compatible, let us know and I'm sure someone else
will pick it up if I don't.

> 
> Thanks in advance
> Stefan
> 
> [1] - https://www.st.com/resource/en/datasheet/iis328dq.pdf
> [2] - https://www.st.com/resource/en/datasheet/cd00213470.pdf
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


