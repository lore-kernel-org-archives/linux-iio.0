Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:59222 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750876AbaLOIov convert rfc822-to-8bit (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 15 Dec 2014 03:44:51 -0500
Received: by mail-wi0-f172.google.com with SMTP id n3so8083217wiv.5
        for <linux-iio@vger.kernel.org>; Mon, 15 Dec 2014 00:44:50 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAHdPZaNB=N-fZHcg5VobAODtC69gS6o4=N9K5M4P7e+dMsz4Dw@mail.gmail.com>
References: <CAHdPZaNB=N-fZHcg5VobAODtC69gS6o4=N9K5M4P7e+dMsz4Dw@mail.gmail.com>
Date: Mon, 15 Dec 2014 10:44:50 +0200
Message-ID: <CAEnQRZDywPD4kPpMtTOv2hjzdtPzkOUGAo2w8K1EMUByqN1Aqw@mail.gmail.com>
Subject: Re: randconfig build warnings in staging/iio/meter/
From: Daniel Baluta <daniel.baluta@gmail.com>
To: "devendra.aaru" <devendra.aaru@gmail.com>,
	Roberta Dobrescu <roberta.dobrescu@gmail.com>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, Dec 15, 2014 at 10:25 AM, devendra.aaru <devendra.aaru@gmail.com> wrote:
> Hello,
>
> With next-20141215, i have got the following build warnings:
>
>
> drivers/staging/iio/meter/ade7754.c:222:6: warning: ‘val’ may be used
> uninitialized in this function [-Wmaybe-uninitialized]
> drivers/staging/iio/meter/ade7754.c:368:6: warning: ‘val’ may be used
> uninitialized in this function [-Wmaybe-uninitialized]
> drivers/staging/iio/meter/ade7759.c:224:6: warning: ‘val’ may be used
> uninitialized in this function [-Wmaybe-uninitialized]
> drivers/staging/iio/meter/ade7759.c:309:6: warning: ‘val’ may be used
> uninitialized in this function [-Wmaybe-uninitialized]
>
> I have attached the randconfig file.
>
> The possible fix for ade7754.c is to check the return value of
> ade7754_spi_read_reg_8 function at line 222, and at line 368.
>
> The possible fix for ade7759.c is to check the return value of
> ade7759_spi_read_reg_16 function at line 224, and at line 309.

Hi,

Thanks for reporting! We are working on IIO cleanup project [1]
and we can take care of fixing this.

thanks,
Daniel.

[1] http://iiobits.wordpress.com/
