Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.15.19]:52069 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754143AbaDFKLX (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Sun, 6 Apr 2014 06:11:23 -0400
Message-ID: <53412847.3030700@gmx.de>
Date: Sun, 06 Apr 2014 12:11:19 +0200
From: Hartmut Knaack <knaack.h@gmx.de>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
CC: sr@denx.de
Subject: Re: [PATCH 6/6] staging:iio:adc:spear rename spear_read_raw to spear_adc_read_raw
References: <1396716315-2465-1-git-send-email-jic23@kernel.org> <1396716315-2465-7-git-send-email-jic23@kernel.org>
In-Reply-To: <1396716315-2465-7-git-send-email-jic23@kernel.org>
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Jonathan Cameron schrieb:
> This brings it inline with all the other prefix usage in the driver.
>
> Signed-off-by: Jonathan Cameron <jic23@kernel.org>
Acked-by: Hartmut Knaack <knaack.h@gmx.de>
> ---
>  drivers/staging/iio/adc/spear_adc.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>

