Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-081.synserver.de ([212.40.185.81]:1043 "EHLO
	smtp-out-081.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752593Ab1LIJtU (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 9 Dec 2011 04:49:20 -0500
Message-ID: <4EE1D9B9.3000309@metafoo.de>
Date: Fri, 09 Dec 2011 10:49:45 +0100
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: Greg Kroah-Hartman <gregkh@suse.de>,
	Jonathan Cameron <jic23@kernel.org>,
	devel@driverdev.osuosl.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH 3/3] staging:iio: Fix scan mask update
References: <1323365753-7645-1-git-send-email-lars@metafoo.de> <1323365753-7645-3-git-send-email-lars@metafoo.de> <20111208201841.GA338@kroah.com>
In-Reply-To: <20111208201841.GA338@kroah.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 12/08/2011 09:18 PM, Greg KH wrote:
> On Thu, Dec 08, 2011 at 06:35:53PM +0100, Lars-Peter Clausen wrote:
>> When updating the scan mask we have to check the actual scan mask fo=
r if the
>> channel is already enabled, not the matching scan mask from the avai=
lable
>> scan masks. The bit will already be set there and as a result the ac=
tual
>> scan mask will not get updated and the channel stays disabled.
>>
>> Also fix the return value of iio_scan_el_store which would return 1 =
instead of
>> the number of bytes written if the channel was already active in the=
 scan mask.
>=20
> You just added a complier warning with this patch:
>   CC [M]  drivers/staging/iio/industrialio-buffer.o
> drivers/staging/iio/industrialio-buffer.c: In function =E2=80=98iio_s=
can_mask_query=E2=80=99:
> drivers/staging/iio/industrialio-buffer.c:621:8: warning: unused vari=
able =E2=80=98mask=E2=80=99 [-Wunused-variable]
>=20
> So I didn't apply it.

Actually you did. At least it is in staging-next. Should I resend a upd=
ated
patch or just a patch removing the now unused mask variable.

Thanks,
- Lars
