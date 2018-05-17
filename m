Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from www381.your-server.de ([78.46.137.84]:52580 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751798AbeEQLCW (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 17 May 2018 07:02:22 -0400
Subject: Re: [PATCH] iio: dac: fix missing of_match_table assignment in
 LTC2632 device
To: Silvan Murer <silvan.murer@gmail.com>
Cc: linux-iio@vger.kernel.org, jic23@kernel.org
References: <1526394782.32235.3.camel@gmail.com>
From: Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <82b2883f-0d8b-7c69-0f0f-e47ee4c15499@metafoo.de>
Date: Thu, 17 May 2018 13:02:21 +0200
MIME-Version: 1.0
In-Reply-To: <1526394782.32235.3.camel@gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 05/15/2018 04:33 PM, Silvan Murer wrote:
> This patch fix a missing og_match_table assignment in the LTC2632 device
> 
> Signed-off-by: Silvan Murer <silvan.murer@gmail.com>

Reviewed-by: Lars-Peter Clausen <lars@metafoo.de>

Thanks.
