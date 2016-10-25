Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from www381.your-server.de ([78.46.137.84]:36595 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752744AbcJYSvl (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 25 Oct 2016 14:51:41 -0400
Subject: Re: [PATCH] staging: iio: cdc: ad7746: set ret on IIO_VOLTAGE case
To: Colin King <colin.king@canonical.com>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org
References: <20161025184440.4274-1-colin.king@canonical.com>
Cc: linux-kernel@vger.kernel.org
From: Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <7e125a97-144d-2127-f9a0-753c69cb6dab@metafoo.de>
Date: Tue, 25 Oct 2016 20:51:30 +0200
MIME-Version: 1.0
In-Reply-To: <20161025184440.4274-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/25/2016 08:44 PM, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> For a IIO_VOLTAGE case, ret is not being set causing an
> uninitialized value being returned by ad7746_read_raw. Fix
> this by setting ret to IIO_VAL_INT for this specific case.
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Arnd did beat you by a few hours, https://lkml.org/lkml/2016/10/25/485
