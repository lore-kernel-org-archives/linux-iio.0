Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-228.synserver.de ([212.40.185.228]:1057 "EHLO
	smtp-out-228.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752899Ab3FXQqm (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 24 Jun 2013 12:46:42 -0400
Message-ID: <51C87806.5000700@metafoo.de>
Date: Mon, 24 Jun 2013 18:47:02 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Peter Meerwald <pmeerw@pmeerw.net>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: add ds1077 programmable oscillator driver
References: <1371938043-3865-1-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1371938043-3865-1-git-send-email-pmeerw@pmeerw.net>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 06/22/2013 11:54 PM, Peter Meerwald wrote:
> Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>

Hm, I wonder where we should draw the line between what should be
implemented as a IIO driver and what should be implemented as a clk API
driver. This one looks like it actually belongs into the clk framework.

> ---
>  drivers/iio/frequency/Kconfig        |  10 +
>  drivers/iio/frequency/Makefile       |   1 +
>  drivers/iio/frequency/ds1077.c       | 425 +++++++++++++++++++++++++++++++++++
>  include/linux/iio/frequency/ds1077.h |  22 ++
>  4 files changed, 458 insertions(+)
>  create mode 100644 drivers/iio/frequency/ds1077.c
>  create mode 100644 include/linux/iio/frequency/ds1077.h
> 
[...}
