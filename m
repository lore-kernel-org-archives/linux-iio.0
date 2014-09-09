Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wi0-f179.google.com ([209.85.212.179]:38286 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751290AbaIISxW (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 9 Sep 2014 14:53:22 -0400
Received: by mail-wi0-f179.google.com with SMTP id q5so5012889wiv.12
        for <linux-iio@vger.kernel.org>; Tue, 09 Sep 2014 11:53:20 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1410283148.4077.16.camel@hadess.net>
References: <1410283148.4077.16.camel@hadess.net>
Date: Tue, 9 Sep 2014 21:53:20 +0300
Message-ID: <CAEnQRZD+cTqhBSfE2qeTHFh6zJ1a6L6Zrqt9YmTeGkQ9fAqbqg@mail.gmail.com>
Subject: Re: [PATCH] iio:kxcjk-1013: Add support for SMO8500 device
From: Daniel Baluta <daniel.baluta@intel.com>
To: Bastien Nocera <hadess@hadess.net>
Cc: linux-iio@vger.kernel.org, Daniel Baluta <daniel.baluta@intel.com>,
	Jonathan Cameron <jic23@kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Bastien,

On Tue, Sep 9, 2014 at 8:19 PM, Bastien Nocera <hadess@hadess.net> wrote:
> The Onda v975w tablet contains an accelerometer that's advertised over
> ACPI as SMO8500. This device is however a KXCJ9 accelerometer as
> can be seen in the Windows driver's INF file.

>
> ---
>
> I tested the patch, and it works correctly in my testing. However,
> there's no GPIO pin for the "data ready" interrupt, and this throws an
> error that looks fatal in the logs (could this be downgraded?), and
> the name of the device doesn't match the hid-sensor-hub ones, making it
> hard for user-space to discover them.
> (https://github.com/hadess/iio-sensor-proxy is my attempt at something
>  that integrates with user-space and the IIO sensors)
>

How does your ACPI .dsl file looks like?

> It will also conflict with Daniel's patch here:
> http://www.spinics.net/lists/linux-iio/msg14438.html

It shouldn't. The patch is already in togreg branch of Jonathan's tree
[1]. Anyhow,
it will conflict with this one [2].

thanks,
Daniel.

[1] https://git.kernel.org/cgit/linux/kernel/git/jic23/iio.git/commit/?h=togreg&id=ca801795b17b13a105b5209cf451abac3a6529ff
[2] https://lkml.org/lkml/2014/9/3/71
