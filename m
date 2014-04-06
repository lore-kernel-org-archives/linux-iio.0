Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.15.15]:52943 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754143AbaDFKLO (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Sun, 6 Apr 2014 06:11:14 -0400
Message-ID: <5341283F.6010106@gmx.de>
Date: Sun, 06 Apr 2014 12:11:11 +0200
From: Hartmut Knaack <knaack.h@gmx.de>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
CC: sr@denx.de
Subject: Re: [PATCH 4/6] staging:iio:adc:spear rename device specific state
 structure to _state
References: <1396716315-2465-1-git-send-email-jic23@kernel.org> <1396716315-2465-5-git-send-email-jic23@kernel.org>
In-Reply-To: <1396716315-2465-5-git-send-email-jic23@kernel.org>
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Jonathan Cameron schrieb:
> Also rename instances of it to st.  This brings the driver inline with
> the conventions of IIO and avoids some naming confusion with some IIO
> structures which also use the _info postfix.
>
> Signed-off-by: Jonathan Cameron <jic23@kernel.org>
Acked-by: Hartmut Knaack <knaack.h@gmx.de>
> ---
>  drivers/staging/iio/adc/spear_adc.c | 126 ++++++++++++++++++------------------
>  1 file changed, 63 insertions(+), 63 deletions(-)
>

