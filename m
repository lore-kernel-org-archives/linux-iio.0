Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wi0-f177.google.com ([209.85.212.177]:33689 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750917AbaLOIuN (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 15 Dec 2014 03:50:13 -0500
Received: by mail-wi0-f177.google.com with SMTP id l15so8178083wiw.16
        for <linux-iio@vger.kernel.org>; Mon, 15 Dec 2014 00:50:11 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAHdPZaP-B+BegMKCbWTE2dk5rSNQheZbnS+XyHy+G--m2_N72w@mail.gmail.com>
References: <CAHdPZaNB=N-fZHcg5VobAODtC69gS6o4=N9K5M4P7e+dMsz4Dw@mail.gmail.com>
	<CAEnQRZDywPD4kPpMtTOv2hjzdtPzkOUGAo2w8K1EMUByqN1Aqw@mail.gmail.com>
	<CAHdPZaP-B+BegMKCbWTE2dk5rSNQheZbnS+XyHy+G--m2_N72w@mail.gmail.com>
Date: Mon, 15 Dec 2014 10:50:06 +0200
Message-ID: <CAEnQRZAoQFN63XZhZCDRgP=wEmB+JP=1bJGQTZKppmvemzQvJg@mail.gmail.com>
Subject: Re: randconfig build warnings in staging/iio/meter/
From: Daniel Baluta <daniel.baluta@gmail.com>
To: "devendra.aaru" <devendra.aaru@gmail.com>
Cc: Roberta Dobrescu <roberta.dobrescu@gmail.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
	Greg Kroah-Hartman <greg@kroah.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, Dec 15, 2014 at 10:48 AM, devendra.aaru <devendra.aaru@gmail.com> wrote:
>> Hi,
>>
>> Thanks for reporting! We are working on IIO cleanup project [1]
>> and we can take care of fixing this.
>>
>
> Thanks for a very quick response. I did fix those warnings. Let me
> know if i need to send patches to iio ml.

All right. Send them to Greg (CCed) + linux-iio for review.

thanks,
Daniel.
