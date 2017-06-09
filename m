Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-io0-f171.google.com ([209.85.223.171]:34101 "EHLO
        mail-io0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751672AbdFIJRi (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 9 Jun 2017 05:17:38 -0400
Received: by mail-io0-f171.google.com with SMTP id i7so30648432ioe.1
        for <linux-iio@vger.kernel.org>; Fri, 09 Jun 2017 02:17:37 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <b47aa21c-925d-7a83-7bd0-0d9d73f79017@cogentembedded.com>
References: <20170523080830.20571-1-nikita.yoush@cogentembedded.com>
 <20170524202735.3cf4e14e@kernel.org> <2e6019f5-94fc-bb13-f616-0c1cfe81a7db@cogentembedded.com>
 <20170528164846.3fa3d4d8@kernel.org> <b47aa21c-925d-7a83-7bd0-0d9d73f79017@cogentembedded.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 9 Jun 2017 11:17:36 +0200
Message-ID: <CACRpkdZB3GgM8b9JSTMD6pKRO3wejOqDHjuLOEZw8Ugknx7NaQ@mail.gmail.com>
Subject: Re: [PATCH/RFC] iio: hi8435: do not enable all events by default
To: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Sanchayan Maity <maitysanchayan@gmail.com>,
        Gregor Boirie <gregor.boirie@parrot.com>,
        Matt Ranostay <mranostay@gmail.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Chris Healy <Chris.Healy@zii.aero>,
        Jeff White <Jeff.White@zii.aero>,
        Vladimir Barinov <vladimir.barinov@cogentembedded.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, May 29, 2017 at 7:40 AM, Nikita Yushchenko
<nikita.yoush@cogentembedded.com> wrote:

> They originally wanted gpio-style access to use with userspace
> polling, and were not pleased with entire IIO thing.

The GPIO userspace ABI supports events with timestamps.
tools/gpio/gpio-event-mon.c

Yours,
Linus Walleij
