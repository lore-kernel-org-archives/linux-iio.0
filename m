Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtprelay0185.hostedemail.com ([216.40.44.185]:59829 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1753199AbeADPQV (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 4 Jan 2018 10:16:21 -0500
Message-ID: <1515078975.13693.43.camel@perches.com>
Subject: Re: [PATCH 0/5] iio: use permission specific variants of DEVICE_ATTR
From: Joe Perches <joe@perches.com>
To: Aishwarya Pant <aishpant@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Julia Lawall <julia.lawall@lip6.fr>
Date: Thu, 04 Jan 2018 07:16:15 -0800
In-Reply-To: <cover.1515076155.git.aishpant@gmail.com>
References: <cover.1515076155.git.aishpant@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
Mime-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, 2018-01-04 at 20:06 +0530, Aishwarya Pant wrote:
> Series of clean-up patches which replace all DEVICE_ATTR macros with the
> permission specific variants DEVICE_ATTR_{RO/WO/RW}.
> 
> Patches were created using coccinelle. The following script is for conversion to
> the DEVICE_ATTR_RO macro and the other conversions are similar. The script may
> require some manual intervention when multiple attributes share the show or
> store function.

I do think the perl scripts are a bit better here
as they can verify the show/store functions are
static, used once, the new functions names are
unused and so can be renamed without conflict.

Maybe the python bits can be extended to copy
these perl checks and avoid the possible manual
inspection and verification requirements.

https://lkml.org/lkml/2017/12/22/844

