Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:53027 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754118Ab3IOPfv (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 15 Sep 2013 11:35:51 -0400
Message-ID: <5235E1F4.10805@kernel.org>
Date: Sun, 15 Sep 2013 17:36:04 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio:buffer: Simplify iio_buffer_is_active()
References: <1379259066-22475-1-git-send-email-lars@metafoo.de>
In-Reply-To: <1379259066-22475-1-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 09/15/13 16:31, Lars-Peter Clausen wrote:
> We can skip having to loop through all the device's buffers to see if a certain
> buffer is active, if we let the buffer's list head point to itself when the
> buffer is inactive.
Neat - didn't think of that.
>
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Applied to the togreg branch of iio.git

Thanks.

Jonathan
