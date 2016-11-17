Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-db5eur01on0105.outbound.protection.outlook.com ([104.47.2.105]:7330
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751520AbcKQKGR (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 17 Nov 2016 05:06:17 -0500
Subject: Re: [RFC PATCH 0/7] mux controller astraction and iio/i2c muxes
To: <linux-kernel@vger.kernel.org>
References: <1479340111-1259-1-git-send-email-peda@axentia.se>
CC: Wolfram Sang <wsa@the-dreams.de>, Rob Herring <robh+dt@kernel.org>,
        "Mark Rutland" <mark.rutland@arm.com>,
        Jonathan Cameron <jic23@kernel.org>,
        "Hartmut Knaack" <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "Peter Meerwald-Stadler" <pmeerw@pmeerw.net>,
        Arnd Bergmann <arnd@arndb.de>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        <linux-i2c@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-iio@vger.kernel.org>
From: Peter Rosin <peda@axentia.se>
Message-ID: <ac015742-fe68-cdc1-443c-c774e42e28ea@axentia.se>
Date: Thu, 17 Nov 2016 10:33:02 +0100
MIME-Version: 1.0
In-Reply-To: <1479340111-1259-1-git-send-email-peda@axentia.se>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 2016-11-17 00:48, Peter Rosin wrote:
> Hi!
> 
> This is work in progress, I'm asking for early feedback.

Forgot to mention, sorry, but this series depends on some
stuff not in mainline yet (the _available work in iio [1]),
but it is in linux-next.

Cheers,
Peter

[1] Specifically these patches:
51239600074b "iio:core: add a callback to allow drivers to provide _available attributes"
00c5f80c2fad "iio: inkern: add helpers to query available values from channels"
