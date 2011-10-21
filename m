Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-50.csi.cam.ac.uk ([131.111.8.150]:53236 "EHLO
	ppsw-50.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751325Ab1JUNYe (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 21 Oct 2011 09:24:34 -0400
Message-ID: <4EA17297.2040700@cam.ac.uk>
Date: Fri, 21 Oct 2011 14:24:39 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: Michael Hennerich <michael.hennerich@analog.com>,
	linux-iio@vger.kernel.org,
	device-drivers-devel@blackfin.uclinux.org, drivers@analog.com
Subject: Re: [RFC 1/2] staging:iio: Do not use bitmasks for channel info addresses
References: <1319199855-24834-1-git-send-email-lars@metafoo.de>
In-Reply-To: <1319199855-24834-1-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/21/11 13:24, Lars-Peter Clausen wrote:
> Currently the iio framework uses bitmasks for the address field of channel info
> attributes. This is for historical reasons and no longer required since it will
> only ever query a single info attribute at once. This patch changes the code to
> use the non-shifted iio_chan_info_enum values for the info attribute address.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> 
> ---
> Runtime tested for some of th DACs. Others only compile tested.
> 
> I did not change the read_raw, write_raw and write_raw_get_fmt callbacks to
> use iio_chan_info_enum as the type for the mask attribute in this patch. But we
> probably want to do this at some point.
Agreed.  Should probably stop calling it mask as well :)

Still that can validly be a follow up patch if you don't want to
do it in here.

I have vaguely wondered in those functions whether it makes
sense to mash the shared and separate variants together
in the handling.  Other than lazy coding I can't actually
see when this would hurt and it would make the kernel query
interface simpler.  Hence your MASK macro in the next patch would
take the enum value and double it + add one or not to say if
it is shared or not.

One for a follow up patch I think.  Fiddly bit will be verifying
every driver does the right thing.  I suspect I for one may
have take advantage of the separation of these in a few
drivers.

Can't conceive of any reason what you have here could cause
any issues in drivers. Let us push this out asap.  I've just pulled
it into the github master branch.

I've tested on everything I have wired up today. max1363 (couple
of parts), tsl2563 and lis3l02dq.

Acked-by: Jonathan Cameron <jic23@cam.ac.uk>

Nice work cleanup.  Got to love the stupid code you can end up
with as it evolves sometimes.

Jonathan
