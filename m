Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:33391 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752240AbaGVXPG (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Tue, 22 Jul 2014 19:15:06 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glki-linux-iio@m.gmane.org>)
	id 1X9jGx-0004Bh-Ud
	for linux-iio@vger.kernel.org; Wed, 23 Jul 2014 01:15:04 +0200
Received: from 5520-maca-inet1-outside.broadcom.com ([216.31.211.11])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-iio@vger.kernel.org>; Wed, 23 Jul 2014 01:15:03 +0200
Received: from gregory.0xf0 by 5520-maca-inet1-outside.broadcom.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-iio@vger.kernel.org>; Wed, 23 Jul 2014 01:15:03 +0200
To: linux-iio@vger.kernel.org
From: Gregory Fong <gregory.0xf0@gmail.com>
Subject: Re: [PATCH 1/3] iio: ad5064: Explicitly configure whether to use external supply
Date: Tue, 22 Jul 2014 23:06:11 +0000 (UTC)
Message-ID: <loom.20140723T010217-267@post.gmane.org>
References: <1392206518-1457-1-git-send-email-paul.cercueil@analog.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Paul,

Paul Cercueil <paul.cercueil@...> writes:
> 
> [snip]
> - if CONFIG_REGULATOR is disabled, regulator_get() will always
>   return a dummy regulator, which caused a device to always use
>   the external vref mode, even though there is none.

I noticed that this is still a problem in the current driver in the iio
staging tree, are you planning to resubmit the fix for this part?

Best regards,
Gregory



