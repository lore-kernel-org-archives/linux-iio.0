Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-it0-f51.google.com ([209.85.214.51]:35362 "EHLO
        mail-it0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750906AbdAaJaD (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 31 Jan 2017 04:30:03 -0500
Received: by mail-it0-f51.google.com with SMTP id 203so212831357ith.0
        for <linux-iio@vger.kernel.org>; Tue, 31 Jan 2017 01:30:02 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170131081433.GB8311@dtor-ws>
References: <20170110083141.4103-1-linus.walleij@linaro.org>
 <20170110104333.GB18258@kuha.fi.intel.com> <20170131081433.GB8311@dtor-ws>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 31 Jan 2017 10:30:01 +0100
Message-ID: <CACRpkda_VP=PKDxHyq_v7q2k3Q4XhGV34bgD1ez5Rdg2O1f5cQ@mail.gmail.com>
Subject: Re: [PATCH] input: misc: delete MPU3050 driver
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        Bastien Nocera <hadess@hadess.net>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Linux Input <linux-input@vger.kernel.org>,
        Joseph Lai <joseph_lai@wistron.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, Jan 31, 2017 at 9:14 AM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:

> OK, since nobody yelled that they need it I applied the patch.

Thanks!

We need to think about the future of these misc input drivers:

misc/bma150.c
misc/cma3000*
misc/mma8450.c

The first has a partial (or maybe complete) support in
iio/accel/bma180.c and the last seems to be possible to be
supported by iio/accel/mma8452.c with some slight adjustments.

It's not only because I have OCD and want to sort every driver
in the right pigeon-hole... the iio-sensor-proxy GNOME daemon
bugzilla/github has been spamming me with complaints about
problems caused by the accelerometer-as-input drivers.
It would be nice to at least compartmentalize the problems
into one subsystem. Terminating misc/bma150.c has been
mentioned.

Yours,
Linus Walleij
