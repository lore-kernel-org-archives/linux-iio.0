Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from www381.your-server.de ([78.46.137.84]:38468 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752580AbeEGQp5 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 7 May 2018 12:45:57 -0400
Subject: Re: [PATCH] iio: potentiometer: add driver for Maxim Integrated
 DS1807
To: Michael Trimarchi <michael@amarulasolutions.com>,
        Jonathan Cameron <jic23@kernel.org>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
References: <1525613447-32734-1-git-send-email-michael@amarulasolutions.com>
From: Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <e7e700a5-774e-c32c-929d-88bc4bc7a2ed@metafoo.de>
Date: Mon, 7 May 2018 18:45:54 +0200
MIME-Version: 1.0
In-Reply-To: <1525613447-32734-1-git-send-email-michael@amarulasolutions.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 05/06/2018 03:30 PM, Michael Trimarchi wrote:

> +#define DS1807_CHANNEL(ch) {					\
> +	.type = IIO_CHAN_INFO_HARDWAREGAIN,			\

I don't think this is a channel type.

> +	.indexed = 1,						\
> +	.output = 1,						\
> +	.channel = (ch),					\
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_HARDWAREGAIN),	\
> +}
