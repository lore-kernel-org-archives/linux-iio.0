Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wi0-f179.google.com ([209.85.212.179]:38533 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751803AbbCES1o (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 5 Mar 2015 13:27:44 -0500
Received: by wiwh11 with SMTP id h11so40816123wiw.3
        for <linux-iio@vger.kernel.org>; Thu, 05 Mar 2015 10:27:43 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CANPzvBBbRmDZKFQG=96=9HM3bY18j5MZvd6heQu4Rjf5Sefvvg@mail.gmail.com>
References: <CANPzvBBbRmDZKFQG=96=9HM3bY18j5MZvd6heQu4Rjf5Sefvvg@mail.gmail.com>
Date: Thu, 5 Mar 2015 20:27:43 +0200
Message-ID: <CAEnQRZDMsWOfZHn0-Sg3y9dBj3hjxVTNnwpnFsA22VeK1=+JwQ@mail.gmail.com>
Subject: Re: Regarding IIO dummy driver project
From: Daniel Baluta <daniel.baluta@gmail.com>
To: Somya Anand <somyaanand214@gmail.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, Mar 5, 2015 at 5:28 PM, Somya Anand <somyaanand214@gmail.com> wrote:
> Hello Daniel,
>
> I have started reading about IIO drivers and I have a doubt in
> adis16220_read_16bit(...) function in the file iio/accel/adis16220_core.c.
>
> In this function what is the use of declaring 'val' as s16? and then
> typecasting it later for the function adis_read_reg_16().
>
> Instead, we can simply use u16 as data type for this. Is there any
> significance of using 's16' ?

Hi Somya,

I am not sure about this. It looks like we can directly use u16 for val.

Perhaps, someone from linux-iio could shed some light on this.

thanks,
Daniel.
