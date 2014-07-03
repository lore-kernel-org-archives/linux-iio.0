Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-164.synserver.de ([212.40.185.164]:1046 "EHLO
	smtp-out-164.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932085AbaGCHYL (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 3 Jul 2014 03:24:11 -0400
Message-ID: <53B50519.5030903@metafoo.de>
Date: Thu, 03 Jul 2014 09:24:09 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Sachin Kamat <sachin.kamat@samsung.com>, linux-iio@vger.kernel.org
CC: jic23@kernel.org, spk.linux@gmail.com,
	Barry Song <21cnbao@gmail.com>
Subject: Re: [PATCH 2/5] iio: ad5624r_spi: Remove redundant variable
References: <1404369485-1903-1-git-send-email-sachin.kamat@samsung.com> <1404369485-1903-2-git-send-email-sachin.kamat@samsung.com>
In-Reply-To: <1404369485-1903-2-git-send-email-sachin.kamat@samsung.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 07/03/2014 08:38 AM, Sachin Kamat wrote:
> By re-arranging the code, 'ret' can be removed from this
> function.
>
> Signed-off-by: Sachin Kamat <sachin.kamat@samsung.com>
> Cc: Barry Song <21cnbao@gmail.com>

Acked-by: Lars-Peter Clausen <lars@metafoo.de>

Thanks.
