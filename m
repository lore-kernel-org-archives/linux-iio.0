Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-qk1-f196.google.com ([209.85.222.196]:33635 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727603AbeKDBLE (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 3 Nov 2018 21:11:04 -0400
From: Renato Lui Geh <renatogeh@gmail.com>
Date: Sat, 3 Nov 2018 12:59:16 -0300
To: Jonathan Cameron <jic23@kernel.org>
Cc: "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "renatogeh@gmail.com" <renatogeh@gmail.com>,
        "giuliano.belinassi@usp.br" <giuliano.belinassi@usp.br>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        "kernel-usp@googlegroups.com" <kernel-usp@googlegroups.com>
Subject: Re: [PATCH v3 1/3] staging: iio: ad7780: fix offset read value
Message-ID: <20181103155915.32wgi6ybkvhr5qzb@renatolg>
References: <cover.1541082656.git.renatogeh@gmail.com>
 <2191be4d531651db39682178ec0660eeb5697439.1541082656.git.renatogeh@gmail.com>
 <17254fcab5fb927e31ba6eac2194b0aeb9456cf0.camel@analog.com>
 <20181103130721.53a806a5@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
In-Reply-To: <20181103130721.53a806a5@archlinux>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi,

>On Thu, 1 Nov 2018 15:02:32 +0000
>"Ardelean, Alexandru" <alexandru.Ardelean@analog.com> wrote:
>
>> Good catch.

That was actually Jonathan's catch. :)

>> Acked-by: Alexandru Ardelean <alexandru.ardelean@analog.com>

I read up on Acked-by on the kernel docs, as I didn't know exactly what
it meant, but I'm not so sure on how to proceed once the patch has been
acked.  For future patches, do I add this Acked-by line on the patch's
message body? Or is this just an informal way of approval?

>On the basis this has been broken for a long time, and you are clearly
>doing other nearby not fix work, I'm going to take this through the togreg
>tree rather than via the quicker fix path.  It makes my life
>easier :)
>
>Applied to the togreg branch of iio.git and pushed out as testing for
>the autobuilders to play with it.

So this means I should skip this patch on v4, right?

Thanks,
Renato
