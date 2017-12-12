Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wr0-f177.google.com ([209.85.128.177]:39330 "EHLO
        mail-wr0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752434AbdLLUiQ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 12 Dec 2017 15:38:16 -0500
Received: by mail-wr0-f177.google.com with SMTP id a41so143825wra.6
        for <linux-iio@vger.kernel.org>; Tue, 12 Dec 2017 12:38:15 -0800 (PST)
Message-ID: <1513111092.3478.18.camel@gmail.com>
Subject: Re: [PATCH v2] iio/bmp280-core.c: Read calibration data in probe
From: Stefan Tatschner <stefan.tatschner@gmail.com>
To: Andreas Klinger <ak@it-klinger.de>
Cc: Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
Date: Tue, 12 Dec 2017 21:38:12 +0100
In-Reply-To: <20171212203537.8204-1-stefan.tatschner@gmail.com>
References: <20171212180610.GF2590@arbeit>
         <20171212203537.8204-1-stefan.tatschner@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, 2017-12-12 at 21:35 +0100, Stefan Tatschner wrote:
>     - readded the type casts in temperature calibration values

Oops, sorry. I mean the humidity calibration values.

Stefan
