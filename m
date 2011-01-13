Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.work-microwave.de ([62.245.205.51]:59613 "EHLO
	work-microwave.de" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751194Ab1AMNXI (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 13 Jan 2011 08:23:08 -0500
Message-ID: <4D2EFA35.4040805@work-microwave.de>
Date: Thu, 13 Jan 2011 14:12:21 +0100
From: Roland Stigge <roland.stigge@work-microwave.de>
MIME-Version: 1.0
To: Roland Stigge <rst@work-microwave.de>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH 3/3] iio: Fixed documentation
References: <1294924192-28923-1-git-send-email-rst@work-microwave.de> <1294924192-28923-3-git-send-email-rst@work-microwave.de>
In-Reply-To: <1294924192-28923-3-git-send-email-rst@work-microwave.de>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 01/13/2011 02:09 PM, Roland Stigge wrote:
> Removed reference to named versions.

Signed-off-by: Roland Stigge <stigge@antcom.de>

Sorry.

> ---
>  drivers/staging/iio/Documentation/sysfs-bus-iio |    4 +---
>  1 files changed, 1 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/staging/iio/Documentation/sysfs-bus-iio b/driver=
s/staging/iio/Documentation/sysfs-bus-iio
> index e993fe2..8e5d8d1 100644
> --- a/drivers/staging/iio/Documentation/sysfs-bus-iio
> +++ b/drivers/staging/iio/Documentation/sysfs-bus-iio
> @@ -228,9 +228,7 @@ KernelVersion:	2.6.37
>  Contact:	linux-iio@vger.kernel.org
>  Description:
>  		Raw (unscaled, no bias etc.) output voltage for
> -		channel Y. In special cases where the channel does not
> -		correspond to externally available output one of the named
> -		versions may be used. The number must always be specified and
> +		channel Y.  The number must always be specified and
>  		unique if the output corresponds to a single channel.
> =20
>  What:		/sys/bus/iio/devices/deviceX/outY&Z_raw


--=20
Dipl.-Inf. Roland Stigge
SATCOM Technologies
**********************************************************
WORK Microwave GmbH
Raiffeisenstrasse 12
83607 Holzkirchen
Germany
Tel: +49 8024 6408-0
=46ax: +49 8024 6408-40
roland.stigge@work-microwave.de
http://www.work-microwave.de./

Gesch=C3=A4ftsf=C3=BChrer / Managing Directors:
Dr. Andreas Hausotter (CEO), Dr. G=C3=BCnter Prokoph (CTO)
Sitz / Reg. Office: Holzkirchen, Germany
Reg. HRB M=C3=BCnchen Nr. 79479
ISO 9001:2008 certificate

This message and any attachments may contain confidential information
and must not be disclosed to a third party without the prior written
consent of Work Microwave GmbH, Germany.
If you have received it erroneously, please discard it and contact us b=
y
return.
**********************************************************
