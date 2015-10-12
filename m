Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-068.synserver.de ([212.40.185.68]:1636 "EHLO
	smtp-out-070.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751415AbbJLK2n (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 12 Oct 2015 06:28:43 -0400
Message-ID: <561B8AE1.9040408@metafoo.de>
Date: Mon, 12 Oct 2015 12:26:41 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Marc Andre <marc.andre@netline.ch>, jic23@kernel.org
CC: knaack.h@gmx.de, pmeerw@pmeerw.net, linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: Add support for LTC26xx I2C DAC
References: <1444639977-42834-1-git-send-email-marc.andre@netline.ch>
In-Reply-To: <1444639977-42834-1-git-send-email-marc.andre@netline.ch>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/12/2015 10:52 AM, Marc Andre wrote:
> This driver adds support for the Linear LTC26x6, LTC26x7 and LTC26x9 I2C
> DAC chips.

Those look like they are very much register map compatible to what is
supported by the AD5064 driver.	It makes sense to add support for them there
instead of having a separate driver.

