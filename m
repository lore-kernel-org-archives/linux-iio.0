Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-oa0-f43.google.com ([209.85.219.43]:48403 "EHLO
	mail-oa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753461Ab3JBQyZ (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 2 Oct 2013 12:54:25 -0400
Received: by mail-oa0-f43.google.com with SMTP id f4so1072570oah.30
        for <linux-iio@vger.kernel.org>; Wed, 02 Oct 2013 09:54:24 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1380256624-12588-1-git-send-email-sachin.kamat@linaro.org>
References: <1380256624-12588-1-git-send-email-sachin.kamat@linaro.org>
Date: Wed, 2 Oct 2013 22:24:24 +0530
Message-ID: <CAK9yfHx2dK1KSTQXoCtbhPaA9jYkyoC3_3NggAMio1TpPiY+9A@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] iio: core: Implement devm_iio_device_{register,unregister}
From: Sachin Kamat <sachin.kamat@linaro.org>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Sachin Kamat <sachin.kamat@linaro.org>,
	Lars-Peter Clausen <lars@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi,

On 27 September 2013 10:07, Sachin Kamat <sachin.kamat@linaro.org> wrote:
> Add device managed devm_iio_device_{register,unregister}()
> to automatically unregister IIO drivers thus leading to
> simplified IIO driver code.
>
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> Cc: Lars-Peter Clausen <lars@metafoo.de>
> ---
> Changes since v1:
> Incorporated review comments from Lars-Peter Clausen
> * Renamed variables
> * Fixed the broken implementation
> * Moved kernel doc from .h to .c file
> ---

Does this look good now?

-- 
With warm regards,
Sachin
