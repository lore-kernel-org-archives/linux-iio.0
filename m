Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:42724 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751069AbbFUJjr (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 21 Jun 2015 05:39:47 -0400
Message-ID: <5586865F.9080804@kernel.org>
Date: Sun, 21 Jun 2015 10:39:43 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org
Subject: Re: [PATCH 3/3] tools: iio: Set CC using $(CROSS_COMPILE)
References: <1434837152-30830-1-git-send-email-pmeerw@pmeerw.net> <1434837152-30830-3-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1434837152-30830-3-git-send-email-pmeerw@pmeerw.net>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 20/06/15 22:52, Peter Meerwald wrote:
> Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
> ---
Hi Peter,

This one has been there since 
54628687fa2df2d3755912954afa67665ed122cc
iio: make tools more cross-compilation friendly
from Linus Walleij

J
>  tools/iio/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/iio/Makefile b/tools/iio/Makefile
> index bf7ae6d..7d0950d 100644
> --- a/tools/iio/Makefile
> +++ b/tools/iio/Makefile
> @@ -1,4 +1,4 @@
> -CC = gcc
> +CC = $(CROSS_COMPILE)gcc
>  CFLAGS = -Wall -g -D_GNU_SOURCE
>  
>  all: iio_event_monitor lsiio generic_buffer
> 

--
To unsubscribe from this list: send the line "unsubscribe linux-iio" in
