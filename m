Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:39904 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750999AbcJIKta (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 9 Oct 2016 06:49:30 -0400
Subject: Re: [PATCH] staging:iio:dac:max517 dac documentation.
To: linux-iio@vger.kernel.org
References: <20161009104831.9396-1-jic23@kernel.org>
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <1c533ec3-645a-a43b-ace8-106316c3c0a8@kernel.org>
Date: Sun, 9 Oct 2016 11:49:26 +0100
MIME-Version: 1.0
In-Reply-To: <20161009104831.9396-1-jic23@kernel.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 09/10/16 11:48, Jonathan Cameron wrote:
> The driver graduated a while back, btu this documentation file (which
> mostly gives background info on the chips supported) got left behind.
> 
> I can't see any reason not to just move it out of staging.
> 
> Signed-off-by: Jonathan Cameron <jic23@kernel.org>
I'll fix up the somewhat uninformative patch title when applying if
no one objects!  Ooops.  Jonathan
> ---
>  {drivers/staging/iio/Documentation => Documentation/iio}/dac/max517 | 0
>  1 file changed, 0 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/staging/iio/Documentation/dac/max517 b/Documentation/iio/dac/max517
> similarity index 100%
> rename from drivers/staging/iio/Documentation/dac/max517
> rename to Documentation/iio/dac/max517
> 

