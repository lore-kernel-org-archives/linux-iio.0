Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-030.synserver.de ([212.40.185.30]:1042 "EHLO
	smtp-out-030.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752085AbbHTPtz (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 20 Aug 2015 11:49:55 -0400
Message-ID: <55D5F707.40703@metafoo.de>
Date: Thu, 20 Aug 2015 17:49:27 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Javier Martinez Canillas <javier@osg.samsung.com>,
	linux-kernel@vger.kernel.org
CC: Michael Hennerich <Michael.Hennerich@analog.com>,
	linux-iio@vger.kernel.org, Peter Meerwald <pmeerw@pmeerw.net>,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>
Subject: Re: [PATCH 10/18] iio: dac: ad7303: Add OF match table
References: <1440054451-1223-1-git-send-email-javier@osg.samsung.com> <1440054451-1223-11-git-send-email-javier@osg.samsung.com>
In-Reply-To: <1440054451-1223-11-git-send-email-javier@osg.samsung.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 08/20/2015 09:07 AM, Javier Martinez Canillas wrote:
> The Documentation/devicetree/bindings/iio/dac/ad7303.txt DT binding doc
> lists "adi,ad7303" as a compatible string but the corresponding driver
> does not have an OF match table. Add the table to the driver so the SPI
> core can do an OF style match.
> 
> Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>


Acked-by: Lars-Peter Clausen <lars@metafoo.de>

Thanks.
