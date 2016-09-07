Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from www381.your-server.de ([78.46.137.84]:59144 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935727AbcIGSyr (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 7 Sep 2016 14:54:47 -0400
Subject: Re: [PATCH v1 1/1] iio:core: fix IIO_VAL_FRACTIONAL sign handling
To: Gregor Boirie <gregor.boirie@parrot.com>,
        Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
References: <e66c33d8d00c51878039a967f2650f7bc1866e90.1472840709.git.gregor.boirie@parrot.com>
 <e20dc6d8-7bd0-0feb-6464-a8af61b880a9@kernel.org>
 <32c015f4-bbd7-e2f4-3b4c-f7799ea95360@metafoo.de>
 <419daee6-1e68-dba4-3e04-3c13d58eea44@kernel.org>
 <57D0584E.2000709@parrot.com>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
From: Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <1fee492b-55f1-cffa-4bef-9e5ed421551d@metafoo.de>
Date: Wed, 7 Sep 2016 20:54:43 +0200
MIME-Version: 1.0
In-Reply-To: <57D0584E.2000709@parrot.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 09/07/2016 08:11 PM, Gregor Boirie wrote:
> Just to mention that a somewhat similar patch might be needed to handle
> negative
> IIO_VAL_FRACTIONAL_LOG2 values.

Hm, right, Michael's patch handled that. Do you want to send a patch, or do
you prefer that somebody else sends it?

Thanks,
- Lars
