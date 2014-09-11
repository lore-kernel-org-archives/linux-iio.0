Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:57380 "EHLO
	relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754433AbaIKSS4 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 11 Sep 2014 14:18:56 -0400
Message-ID: <1410459518.32328.24.camel@hadess.net>
Subject: Re: [PATCH] iio:kxcjk-1013: Add support for SMO8500 device
From: Bastien Nocera <hadess@hadess.net>
To: Daniel Baluta <daniel.baluta@intel.com>
Cc: linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>
Date: Thu, 11 Sep 2014 20:18:38 +0200
In-Reply-To: <CAEnQRZD+cTqhBSfE2qeTHFh6zJ1a6L6Zrqt9YmTeGkQ9fAqbqg@mail.gmail.com>
References: <1410283148.4077.16.camel@hadess.net>
	 <CAEnQRZD+cTqhBSfE2qeTHFh6zJ1a6L6Zrqt9YmTeGkQ9fAqbqg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, 2014-09-09 at 21:53 +0300, Daniel Baluta wrote:
> Hi Bastien,
> 
> On Tue, Sep 9, 2014 at 8:19 PM, Bastien Nocera <hadess@hadess.net> wrote:
> > The Onda v975w tablet contains an accelerometer that's advertised over
> > ACPI as SMO8500. This device is however a KXCJ9 accelerometer as
> > can be seen in the Windows driver's INF file.
> 
> >
> > ---
> >
> > I tested the patch, and it works correctly in my testing. However,
> > there's no GPIO pin for the "data ready" interrupt, and this throws an
> > error that looks fatal in the logs (could this be downgraded?), and
> > the name of the device doesn't match the hid-sensor-hub ones, making it
> > hard for user-space to discover them.
> > (https://github.com/hadess/iio-sensor-proxy is my attempt at something
> >  that integrates with user-space and the IIO sensors)
> >
> 
> How does your ACPI .dsl file looks like?
> 
> > It will also conflict with Daniel's patch here:
> > http://www.spinics.net/lists/linux-iio/msg14438.html
> 
> It shouldn't. The patch is already in togreg branch of Jonathan's tree
> [1]. Anyhow,
> it will conflict with this one [2].

Do you want me to rebase the patch on a particular tree? Do you need any
particular changes done in my commit message or patch to get this
merged?

Cheers

