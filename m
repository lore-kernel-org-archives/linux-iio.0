Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:57631 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750855Ab1LHUYx (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 8 Dec 2011 15:24:53 -0500
Received: from compute4.internal (compute4.nyi.mail.srv.osa [10.202.2.44])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id D5C55211FA
	for <linux-iio@vger.kernel.org>; Thu,  8 Dec 2011 15:24:52 -0500 (EST)
Date: Thu, 8 Dec 2011 12:18:41 -0800
From: Greg KH <greg@kroah.com>
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Greg Kroah-Hartman <gregkh@suse.de>,
	Jonathan Cameron <jic23@kernel.org>,
	devel@driverdev.osuosl.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH 3/3] staging:iio: Fix scan mask update
Message-ID: <20111208201841.GA338@kroah.com>
References: <1323365753-7645-1-git-send-email-lars@metafoo.de>
 <1323365753-7645-3-git-send-email-lars@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1323365753-7645-3-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, Dec 08, 2011 at 06:35:53PM +0100, Lars-Peter Clausen wrote:
> When updating the scan mask we have to check the actual scan mask for=
 if the
> channel is already enabled, not the matching scan mask from the avail=
able
> scan masks. The bit will already be set there and as a result the act=
ual
> scan mask will not get updated and the channel stays disabled.
>=20
> Also fix the return value of iio_scan_el_store which would return 1 i=
nstead of
> the number of bytes written if the channel was already active in the =
scan mask.

You just added a complier warning with this patch:
  CC [M]  drivers/staging/iio/industrialio-buffer.o
drivers/staging/iio/industrialio-buffer.c: In function =E2=80=98iio_sca=
n_mask_query=E2=80=99:
drivers/staging/iio/industrialio-buffer.c:621:8: warning: unused variab=
le =E2=80=98mask=E2=80=99 [-Wunused-variable]

So I didn't apply it.

Care to try again and be more careful in the future?

thanks,

greg k-h
