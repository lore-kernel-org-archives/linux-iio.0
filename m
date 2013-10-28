Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-028.synserver.de ([212.40.185.28]:1043 "EHLO
	smtp-out-028.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753542Ab3J1Jbn (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 28 Oct 2013 05:31:43 -0400
Message-ID: <526E2EF8.9090005@metafoo.de>
Date: Mon, 28 Oct 2013 10:31:36 +0100
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Sachin Kamat <sachin.kamat@linaro.org>
CC: linux-iio@vger.kernel.org, jic23@kernel.org
Subject: Re: [PATCH v2 1/1] iio: core: Implement devm_iio_device_{register,unregister}
References: <1380256624-12588-1-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1380256624-12588-1-git-send-email-sachin.kamat@linaro.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 09/27/2013 06:37 AM, Sachin Kamat wrote:
> Add device managed devm_iio_device_{register,unregister}()
> to automatically unregister IIO drivers thus leading to
> simplified IIO driver code.
> 
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> Cc: Lars-Peter Clausen <lars@metafoo.de>

Tested-by: Lars-Peter Clausen <lars@metafoo.de>
Reviewed-by: Lars-Peter Clausen <lars@metafoo.de>
