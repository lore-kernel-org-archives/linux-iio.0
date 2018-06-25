Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from www381.your-server.de ([78.46.137.84]:39019 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752485AbeFYHf7 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 25 Jun 2018 03:35:59 -0400
Subject: Re: [PATCH] iio: ad9523: replace core mlock with local lock
To: Alexandru Ardelean <alexandru.ardelean@analog.com>,
        linux-iio@vger.kernel.org, Michael.Hennerich@analog.com,
        jic23@kernel.org
References: <20180625072808.8796-1-alexandru.ardelean@analog.com>
From: Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <d177617b-7d83-8243-27e5-de77a571275b@metafoo.de>
Date: Mon, 25 Jun 2018 09:35:56 +0200
MIME-Version: 1.0
In-Reply-To: <20180625072808.8796-1-alexandru.ardelean@analog.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 06/25/2018 09:28 AM, Alexandru Ardelean wrote:
> From: Lars-Peter Clausen <lars@metafoo.de>
> 
> This is part of a long term effort to make the use of mlock opaque and
> single purpose.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>

When you send a patch you need to sign off on it.
