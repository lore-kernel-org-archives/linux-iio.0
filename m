Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:44344 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751232AbdEHFnA (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 8 May 2017 01:43:00 -0400
Date: Mon, 8 May 2017 07:42:50 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: harinath Nampally <harinath922@gmail.com>
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        Michael.Hennerich@analog.com, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        jic23@kernel.org
Subject: Re: [PATCH] staging: iio: meter: This patch fixes warnings found in
 ade7753.c
Message-ID: <20170508054250.GA6678@kroah.com>
References: <1494216977-26852-1-git-send-email-harinath922@gmail.com>
 <20170508043228.GA1553@kroah.com>
 <CAAGUq_pQy5xnLgTW3D6eikR0O+Bh_iOh+fdvtFL=8GTssXXEtw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <CAAGUq_pQy5xnLgTW3D6eikR0O+Bh_iOh+fdvtFL=8GTssXXEtw@mail.gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, May 08, 2017 at 01:38:47AM -0400, harinath Nampally wrote:
> Hi Greg,
> 
> Thank you so much for your time to review. 
> Sure I will break up into multiple patches and create patch series.
> But I wonder 'one thing' per patch means one kind of warnings per patch?

Yes it does.

> For example if I have multiple fixes for similar warnings like 'Symbolic
> permissions'. Can they all go in a single patch.

Yes.

>  So patch 0/10 for all 'Symbolic permissions' and path 1/10 for all 'alignment
> warnings' and so on and so forth.

Yes, that is correct.

And note, the mailing lists reject html email, so you should fix up your
email client to not send that :)

thanks,

greg k-h
