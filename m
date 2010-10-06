Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from kroah.org ([198.145.64.141]:32808 "EHLO coco.kroah.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756602Ab0JFP2e (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Wed, 6 Oct 2010 11:28:34 -0400
Date: Wed, 6 Oct 2010 08:22:16 -0700
From: Greg KH <greg@kroah.com>
To: michael.hennerich@analog.com
Cc: drivers@analog.com, linux-iio@vger.kernel.org, jic23@cam.ac.uk
Subject: Re: [PATCH] staging: iio: adc: max1363: prevent buffer overflow
Message-ID: <20101006152216.GB6622@kroah.com>
References: <1286374537-16612-1-git-send-email-michael.hennerich@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1286374537-16612-1-git-send-email-michael.hennerich@analog.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, Oct 06, 2010 at 04:15:37PM +0200, michael.hennerich@analog.com =
wrote:
> From: Michael Hennerich <michael.hennerich@analog.com>
>=20
> ring->access.read_last() reads the entire datum from
> the ring including padding and time stamp.
>=20
> Acked-by: Jonathan Cameron <jic23@cam.ac.uk>
> Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>

I applied this, but now you get the following warning:
	drivers/staging/iio/adc/max1363_ring.c: In function =E2=80=98max1363_s=
ingle_channel_from_ring=E2=80=99:
	drivers/staging/iio/adc/max1363_ring.c:34:16: warning: unused variable=
 =E2=80=98numvals=E2=80=99

care to fix that now as well?

thanks,

greg k-h
