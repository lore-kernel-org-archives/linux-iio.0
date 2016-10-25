Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from www381.your-server.de ([78.46.137.84]:38875 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932711AbcJYTLa (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 25 Oct 2016 15:11:30 -0400
Subject: Re: [PATCH] iio: maxim_thermocouple: return -EINVAL on invalid read
 size
To: Colin King <colin.king@canonical.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        sayli karnik <karniksayli1995@gmail.com>,
        Matt Ranostay <mranostay@gmail.com>,
        Wei Yongjun <weiyongjun1@huawei.com>, linux-iio@vger.kernel.org
References: <20161025190408.5012-1-colin.king@canonical.com>
Cc: linux-kernel@vger.kernel.org
From: Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <ed223a81-32c1-d339-b4e1-16b8fca88b2e@metafoo.de>
Date: Tue, 25 Oct 2016 21:11:21 +0200
MIME-Version: 1.0
In-Reply-To: <20161025190408.5012-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/25/2016 09:04 PM, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> In the case that the read size is not 2 or 4 bytes
> then maxim_thermocouple_read is not initializing ret and
> hence may return early with a bogus error return or
> just through to return with a bogos unread value in *val.
> Fix this by setting ret to -EINVAL for invalid (unhandled)
> read sizes.
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Again, Arnd already took the prize, https://lkml.org/lkml/2016/10/25/518

