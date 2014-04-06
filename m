Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.15.15]:51707 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754143AbaDFKLM (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Sun, 6 Apr 2014 06:11:12 -0400
Message-ID: <5341283A.5030202@gmx.de>
Date: Sun, 06 Apr 2014 12:11:06 +0200
From: Hartmut Knaack <knaack.h@gmx.de>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
CC: sr@denx.de
Subject: Re: [PATCH 3/6] staging:iio:adc:spear_adc use info_mask_shared_by_all
 for samp freq
References: <1396716315-2465-1-git-send-email-jic23@kernel.org> <1396716315-2465-4-git-send-email-jic23@kernel.org>
In-Reply-To: <1396716315-2465-4-git-send-email-jic23@kernel.org>
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Jonathan Cameron schrieb:
> Using the core support makes this element available to in kernel users as
> well as to userspace under exactly the same interface as before.  The
> intent is to move all sampling frequency control to this approach
> throughout IIO.
>
> Drop unused clk_high and clk_low whilst we are at it.
>
> Signed-off-by: Jonathan Cameron <jic23@kernel.org>
> Acked-by: Stefan Roese <sr@denx.de>
Acked-by: Hartmut Knaack <knaack.h@gmx.de>
> ---
>  drivers/staging/iio/adc/spear_adc.c | 92 +++++++++++++------------------------
>  1 file changed, 33 insertions(+), 59 deletions(-)
>

