Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pa0-f48.google.com ([209.85.220.48]:47445 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754448Ab3BDVmb (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 4 Feb 2013 16:42:31 -0500
Received: by mail-pa0-f48.google.com with SMTP id hz10so687559pad.7
        for <linux-iio@vger.kernel.org>; Mon, 04 Feb 2013 13:42:30 -0800 (PST)
Date: Mon, 4 Feb 2013 13:38:48 -0800
From: Anton Vorontsov <anton@enomsg.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
	devicetree-discuss@lists.ozlabs.org,
	Naveen Krishna Chatradhi <ch.naveen@samsung.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Doug Anderson <dianders@chromium.org>,
	Tomasz Figa <tomasz.figa@gmail.com>,
	Grant Likely <grant.likely@secretlab.ca>,
	Rob Herring <rob.herring@calxeda.com>,
	MyungJoo Ham <myungjoo.ham@samsung.com>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH 1/2] iio: Update iio_channel_get API to use consumer
 device pointer as argument
Message-ID: <20130204213848.GA2358@lizard.fhda.edu>
References: <1360009566-26347-1-git-send-email-linux@roeck-us.net>
 <1360009566-26347-2-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1360009566-26347-2-git-send-email-linux@roeck-us.net>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, Feb 04, 2013 at 12:26:05PM -0800, Guenter Roeck wrote:
> For iio_channel_get to work with OF based configurations, it needs the
> consumer device pointer instead of the consumer device name as argument.
> 
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  drivers/extcon/extcon-adc-jack.c    |    3 +--
>  drivers/iio/inkern.c                |   11 ++++++++++-
>  drivers/power/generic-adc-battery.c |    4 ++--
>  drivers/power/lp8788-charger.c      |    8 ++++----
>  include/linux/iio/consumer.h        |    5 +++--
>  5 files changed, 20 insertions(+), 11 deletions(-)

Looks OK to me, Ack for drivers/power part.

Thanks.
Anton
