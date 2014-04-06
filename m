Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.17.21]:64541 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754143AbaDFKLS (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Sun, 6 Apr 2014 06:11:18 -0400
Message-ID: <53412843.3020901@gmx.de>
Date: Sun, 06 Apr 2014 12:11:15 +0200
From: Hartmut Knaack <knaack.h@gmx.de>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
CC: sr@denx.de
Subject: Re: [PATCH 5/6] staging:iio:adc:spear rename iodev -> indio_dev to
 fit with current convention
References: <1396716315-2465-1-git-send-email-jic23@kernel.org> <1396716315-2465-6-git-send-email-jic23@kernel.org>
In-Reply-To: <1396716315-2465-6-git-send-email-jic23@kernel.org>
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Jonathan Cameron schrieb:
> How we ended up with indio_dev is a mystery, but we have so in the interests
> of consistency, move this driver over to that convention.
>
> Signed-off-by: Jonathan Cameron <jic23@kernel.org>
Acked-by: Hartmut Knaack <knaack.h@gmx.de>
> ---
>  drivers/staging/iio/adc/spear_adc.c | 30 +++++++++++++++---------------
>  1 file changed, 15 insertions(+), 15 deletions(-)
>

