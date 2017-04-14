Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:49034 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751666AbdDNIRp (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 14 Apr 2017 04:17:45 -0400
Date: Fri, 14 Apr 2017 10:17:34 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Pushkar Jambhlekar <pushkar.iit@gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers/staging/iio: braces {} are not necessary for
 single statement blocks
Message-ID: <20170414081734.GD16598@kroah.com>
References: <1491799087-2742-1-git-send-email-pushkar.iit@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1491799087-2742-1-git-send-email-pushkar.iit@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, Apr 10, 2017 at 10:08:07AM +0530, Pushkar Jambhlekar wrote:
> Handling checkpatch.pl warning for if block. For single if statement block, braces are not neccessary. Making code consistent with linux kernel coding guidelines.

Pleasse wrap your changelog comments at 72 columns like git asked you to
do.

thanks,

greg k-h
