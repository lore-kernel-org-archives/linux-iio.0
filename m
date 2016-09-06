Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from www381.your-server.de ([78.46.137.84]:59477 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755850AbcIFKbr (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 6 Sep 2016 06:31:47 -0400
Subject: Re: [PATCH] iio: light: acpi-als: Add a tuning parameter interface.
To: Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Jonathan Cameron <jic23@kernel.org>
References: <1473157554-4990-1-git-send-email-enric.balletbo@collabora.com>
Cc: Bryan Freed <bfreed@chromium.org>
From: Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <6b262774-fb80-7212-5426-dfc055689865@metafoo.de>
Date: Tue, 6 Sep 2016 12:31:41 +0200
MIME-Version: 1.0
In-Reply-To: <1473157554-4990-1-git-send-email-enric.balletbo@collabora.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 09/06/2016 12:25 PM, Enric Balletbo i Serra wrote:
> From: Bryan Freed <bfreed@chromium.org>
> 
> Add IIO_CHAN_INFO_CALIBSCALE to the channel to scale up or down
> the raw measurements through the IIO framework.
> 
> Add IIO_CHAN_INFO_PROCESSED to provide the interface to read the
> scaled measurements through the in_illuminance_input file.

What is the use-case for this, how is this interface supposed to be used?
