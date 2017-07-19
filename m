Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:51762 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753436AbdGSLvC (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 19 Jul 2017 07:51:02 -0400
Date: Wed, 19 Jul 2017 13:50:56 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Jaya Durga <rjdurga@gmail.com>
Cc: devel@driverdev.osuosl.org, lars@metafoo.de,
        Michael.Hennerich@analog.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, pmeerw@pmeerw.net, knaack.h@gmx.de,
        jic23@kernel.org
Subject: Re: [PATCH v3 3/3] Staging: iio: adc: ad7280a.c: Fixed Macro
 argument reuse
Message-ID: <20170719115056.GA16281@kroah.com>
References: <1500380584-27074-4-git-send-email-rjdurga@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1500380584-27074-4-git-send-email-rjdurga@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, Jul 18, 2017 at 05:53:04PM +0530, Jaya Durga wrote:
> CHECK: Macro argument reuse 'addr' - possible side-effects?
> 
> convert AD7280A_DEVADDR to ad7280a_devaddr static function
> to fix checkpath check
> 
> v3: small style changes
> 
> Signed-off-by: Jaya Durga <rjdurga@gmail.com>
> ---
>  drivers/staging/iio/adc/ad7280a.c | 21 +++++++++++++--------
>  1 file changed, 13 insertions(+), 8 deletions(-)

Where are patches 1-2 of this series?

Always resend the whole series, otherwise maintainers get _very_
confused...

thanks,

greg k-h
