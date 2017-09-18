Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:36620 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752874AbdIRKGT (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 18 Sep 2017 06:06:19 -0400
Date: Mon, 18 Sep 2017 12:06:29 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Himanshi Jain <himshijain.hj@gmail.com>
Cc: outreachy-kernel@googlegroups.com, jic23@kernel.org,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-iio@vger.kernel.org, daniel.baluta@gmail.com,
        amsfield22@gmail.com, Michael.Hennerich@analog.com
Subject: Re: [PATCH] staging: iio: ade7753:  replace mlock with driver
 private lock
Message-ID: <20170918100629.GD24451@kroah.com>
References: <20170918065952.GA5386@himanshi-Inspiron-5558>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170918065952.GA5386@himanshi-Inspiron-5558>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, Sep 18, 2017 at 12:29:52PM +0530, Himanshi Jain wrote:
> Replace driver usage of mlock with driver private lock to meet the new
> model where usage of iio_dev->mlock is being redefined as protecting
> operating mode changes(changes between BUFFER* and DIRECT modes).

This is more complex than a "normal" outreachy coding style cleanup, so
I'll leave it to the IIO developers/maintainer to review/apply it.

thanks,

greg k-h
