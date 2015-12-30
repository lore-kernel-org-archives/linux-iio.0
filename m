Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-qg0-f49.google.com ([209.85.192.49]:36832 "EHLO
	mail-qg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754417AbbL3LHK (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 30 Dec 2015 06:07:10 -0500
Received: by mail-qg0-f49.google.com with SMTP id e32so90535779qgf.3
        for <linux-iio@vger.kernel.org>; Wed, 30 Dec 2015 03:07:10 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1451473319.2316.0@smtp.gmail.com>
References: <1451464368.2262.1@smtp.gmail.com>
	<201512300952.24700.marex@denx.de>
	<1451468582.2348.0@smtp.gmail.com>
	<201512301050.11178.marex@denx.de>
	<CABFtUbTbibudvXYspe8N7cf1UgGVOwtYSPF2JuMZPVmpa680+g@mail.gmail.com>
	<1451473319.2316.0@smtp.gmail.com>
Date: Wed, 30 Dec 2015 12:07:09 +0100
Message-ID: <CABFtUbSfXeXf_+_uOExwoMZJ0ixVve4hiA93gkUuXcVv0PQ0Lw@mail.gmail.com>
Subject: Re: acpi-als on Dell XPS 13 9343
From: Gabriele Mazzotta <gabriele.mzt@gmail.com>
To: Mykola Dvornik <mykola.dvornik@gmail.com>
Cc: Marek Vasut <marex@denx.de>, linux-iio@vger.kernel.org,
	=?UTF-8?Q?Martin_Li=C5=A1ka?= <marxin.liska@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

2015-12-30 12:01 GMT+01:00 Mykola Dvornik <mykola.dvornik@gmail.com>:
> Hi Gabriele,
>
> Thanks for the tip.
>
> The reported status is 0, so the device is disabled and there is no way to
> override it in BIOS.

Not really related to acpi-als, but you could take a look at
libsmbios. I know it can enable the ambient light sensor of
some Dell laptops.

Gabriele

> Anyway thanks guys for all your help.
>
> Happy New Year.
>
> Cheers,
>
> Mykola
