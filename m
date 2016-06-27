Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from www381.your-server.de ([78.46.137.84]:35198 "EHLO
	www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750870AbcF0H3x (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 27 Jun 2016 03:29:53 -0400
Subject: Re: [PATCH 1/1] iio: buffer-dma: Use ARRAY_SIZE in for loop range
To: Phil Reid <preid@electromag.com.au>, jic23@kernel.org,
	knaack.h@gmx.de, pmeerw@pmeerw.net, linux-iio@vger.kernel.org
References: <1466997476-36746-1-git-send-email-preid@electromag.com.au>
From: Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <5770D5DD.5070505@metafoo.de>
Date: Mon, 27 Jun 2016 09:29:33 +0200
MIME-Version: 1.0
In-Reply-To: <1466997476-36746-1-git-send-email-preid@electromag.com.au>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 06/27/2016 05:17 AM, Phil Reid wrote:
> Use the ARRAY_SIZE macro in the for loops that access queue->fileio.blocks.
> Macro is already used in a couple of places where this access occurs,
> but range was hardcoded in these locations.
> 
> Signed-off-by: Phil Reid <preid@electromag.com.au>

Looks good, thanks.

Acked-by: Lars-Peter Clausen <lars@metafoo.de>
