Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:40347 "EHLO
	aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751666AbbLMN47 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 13 Dec 2015 08:56:59 -0500
Date: Sun, 13 Dec 2015 16:56:45 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Bhaktipriya Shridhar <bhaktipriya96@gmail.com>
Cc: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
	pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
	ciorneiioana@gmail.com, cristina.moraru09@gmail.com,
	josselin.costanzi@mobile-devices.fr, linux-iio@vger.kernel.org,
	devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] Staging: iio: accel: Fixed NULL comparison style
Message-ID: <20151213135645.GR5284@mwanda>
References: <20151213134223.GA3495@Karyakshetra>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20151213134223.GA3495@Karyakshetra>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

You have to resend it to apply on the original code, we are not going to
apply the first version of this patch.  In other words it is:

-	if (*rx_p == NULL) {
+	if (!*rxp) {

regards,
dan carpenter

