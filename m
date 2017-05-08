Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:42468 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751229AbdEHEcj (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 8 May 2017 00:32:39 -0400
Date: Mon, 8 May 2017 06:32:28 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Harinath Nampally <harinath922@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        knaack.h@gmx.de, pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: iio: meter: This patch fixes warnings found in
 ade7753.c
Message-ID: <20170508043228.GA1553@kroah.com>
References: <1494216977-26852-1-git-send-email-harinath922@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1494216977-26852-1-git-send-email-harinath922@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, May 08, 2017 at 12:16:17AM -0400, Harinath Nampally wrote:
> All below warnings are found and fixed by checkpatch.pl:
> CHECK: struct mutex definition without comment
> CHECK: Alignment should match open parenthesis
> WARNING: Symbolic permissions 'S_IWUSR | S_IRUGO' are not preferred.

You should only don "one thing" per patch, and no, "fix coding style
issues" is not "one thing" :)

Please break this up into multiple patches and send it as a patch
series.

thanks,

greg k-h
