Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:48756 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751130Ab1LJCwS (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 9 Dec 2011 21:52:18 -0500
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 8964A21090
	for <linux-iio@vger.kernel.org>; Fri,  9 Dec 2011 21:52:18 -0500 (EST)
Date: Fri, 9 Dec 2011 07:11:02 -0800
From: Greg KH <greg@kroah.com>
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Greg Kroah-Hartman <gregkh@suse.de>,
	Jonathan Cameron <jic23@kernel.org>,
	devel@driverdev.osuosl.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH 3/3] staging:iio: Fix scan mask update
Message-ID: <20111209151102.GA18821@kroah.com>
References: <1323365753-7645-1-git-send-email-lars@metafoo.de>
 <1323365753-7645-3-git-send-email-lars@metafoo.de>
 <20111208201841.GA338@kroah.com>
 <4EE1D9B9.3000309@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <4EE1D9B9.3000309@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, Dec 09, 2011 at 10:49:45AM +0100, Lars-Peter Clausen wrote:
> On 12/08/2011 09:18 PM, Greg KH wrote:
> > On Thu, Dec 08, 2011 at 06:35:53PM +0100, Lars-Peter Clausen wrote:
> >> When updating the scan mask we have to check the actual scan mask =
for if the
> >> channel is already enabled, not the matching scan mask from the av=
ailable
> >> scan masks. The bit will already be set there and as a result the =
actual
> >> scan mask will not get updated and the channel stays disabled.
> >>
> >> Also fix the return value of iio_scan_el_store which would return =
1 instead of
> >> the number of bytes written if the channel was already active in t=
he scan mask.
> >=20
> > You just added a complier warning with this patch:
> >   CC [M]  drivers/staging/iio/industrialio-buffer.o
> > drivers/staging/iio/industrialio-buffer.c: In function =E2=80=98iio=
_scan_mask_query=E2=80=99:
> > drivers/staging/iio/industrialio-buffer.c:621:8: warning: unused va=
riable =E2=80=98mask=E2=80=99 [-Wunused-variable]
> >=20
> > So I didn't apply it.
>=20
> Actually you did. At least it is in staging-next. Should I resend a u=
pdated
> patch or just a patch removing the now unused mask variable.

Ugh, you are right, I was messing with my scripts to apply patches at
the time, and forgot to delete this branch.

So, please send a follow-on patch to fix the warning.

greg k-h
