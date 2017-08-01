Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from eddie.linux-mips.org ([148.251.95.138]:56270 "EHLO
        cvs.linux-mips.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751368AbdHAJ7c (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 1 Aug 2017 05:59:32 -0400
Received: (from localhost user: 'ladis' uid#1021 fake: STDIN
        (ladis@eddie.linux-mips.org)) by eddie.linux-mips.org
        id S23994066AbdHAJ7aZuOQ2 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 1 Aug 2017 11:59:30 +0200
Date: Tue, 1 Aug 2017 11:59:29 +0200
From: Ladislav Michl <ladis@linux-mips.org>
To: Daniel Baluta <daniel.baluta@gmail.com>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH 1/2] iio: adc: ti-ads1015: fix conversion time
Message-ID: <20170801095929.avlqhcqv6eq2zll6@lenoch>
References: <20170801082521.namcrs4wyufwqyuh@lenoch>
 <20170801082605.kxzqtnrbt6glplmu@lenoch>
 <CAEnQRZDKd1aWyX+2WvZ=acQGqDOMt22xWp0VCyVPfufFut86vg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAEnQRZDKd1aWyX+2WvZ=acQGqDOMt22xWp0VCyVPfufFut86vg@mail.gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, Aug 01, 2017 at 12:09:34PM +0300, Daniel Baluta wrote:
> On Tue, Aug 1, 2017 at 11:26 AM, Ladislav Michl <ladis@linux-mips.org> wrote:
> > When reading diffrent channel value than device is currently processing
> > wait time of conversion period is applied, which is not enough as device
> > might be already in the middle of conversion and therefore previously
> > converted value is returned - the one belonging to another channel.
> > Fix it by waiting for two sampling periods.
> >
> > Signed-off-by: Ladislav Michl <ladis@linux-mips.org>
> 
> Did you actually experienced this in practice? I guess you are right,
> if you change the channel during a conversion, this change will be applied
> to the next conversion *but* reading will still return old value because the
> current conversion hasn't finished yet.

Yes, that's what actually happens without patch and could be easily
demonstrated from command line:

$ cat in_voltage0_raw
847
$ cat in_voltage1_raw
846
$ cat in_voltage1_raw
195
$ cat in_voltage0_raw
196
$ cat in_voltage0_raw
846

Btw, driver is using continuous conversion mode, but I was unable to
make iio_generic_buffer work with it. And for reading values one by
one single shot mode is enough. Any hints?

Thank you,
	ladis

> So,
> 
> Acked-by: Daniel Baluta <daniel.baluta@gmail.com>

