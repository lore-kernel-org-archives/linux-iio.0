Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:51754 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751276Ab3KILO0 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 9 Nov 2013 06:14:26 -0500
Message-ID: <527E275C.9030503@kernel.org>
Date: Sat, 09 Nov 2013 12:15:24 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org
Subject: Re: [PATCH 1/4] iio: Fix mag3110 scan_type
References: <1383008397-8721-1-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1383008397-8721-1-git-send-email-pmeerw@pmeerw.net>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 10/29/13 00:59, Peter Meerwald wrote:
> last argument of IIO_ST is shift, not endianness
> 
> Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
applied to the fixes-togreg branch of iio.git

Hmm.  Really should finish off the removal of that Macro at some point.
When I originally introduced that Arnd Bergman said it was a bad
idea.  How right he was ;)
> --- drivers/iio/magnetometer/mag3110.c | 7 ++++++- 1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/magnetometer/mag3110.c b/drivers/iio/magnetometer/mag3110.c index 783c5b4..becf544 100644 
> --- a/drivers/iio/magnetometer/mag3110.c +++ b/drivers/iio/magnetometer/mag3110.c @@ -250,7 +250,12 @@ done: 
> .info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SAMP_FREQ) | \ BIT(IIO_CHAN_INFO_SCALE), \ .scan_index = idx, \ -
> .scan_type = IIO_ST('s', 16, 16, IIO_BE), \ +	.scan_type = { \ +		.sign = 's', \ +		.realbits = 16, \ +
> .storagebits = 16, \ +		.endianness = IIO_BE, \ +	}, \ }
> 
> static const struct iio_chan_spec mag3110_channels[] = {
> 
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJSfidbAAoJEFSFNJnE9BaIhYUP/3rg0WHJIcuPWP30rT46W1DJ
7EwLkyy25UlfvUmiOqblFit79fqM7ezidAuvGhTJP36H00sMRFLuh0gMCCy2qISF
yKxyj2RfxedQ0AZO9cJFjDc133rSbhhPeyKgtg5jEwHLLSyc5YSVR173PMDa7g90
xuRPwQxIYlBwxwuY2u22nE/L7DeEnrBwVGK1HtHnc2SsWTTCXKekftILtaaqXlko
3SBUwp/zV3TmD2IEH/CYLoquabgt5jY9A3Wdlxw7M3jYdfsUTbJrgJIsDbbviH+E
EhKopNcASnkK7ToI2X/wp2EoQUyGKn392PwnPfHwKhAQ7/D0E9G/DAhK6FIZHvtv
aDSPQ5FRUWJft9cLWT3IjzsmHswjXsqCuTsFur5YI4AYaibslx78Isyu2nNtSMmj
hujVNOvGklnmUygEMhUd4T1D7bt5c2x/7IzCFfUvJo+bywhI0Zxm/92PikToROJu
pgBjhRzCwwnW/GYp7UOshTUFuG0oQvZlo2x0OQDT6fAPTZexVx2fuJzRIjF8hBVw
6E3c/jro0p0fvjWlYgW1H1SaNPiQ8ORP5EQNuGqoympZQSpy2fOnqPtm2gi3DH7C
IVzXez37axNPDtyIP20JyUCCOMHdWjMUOgrYCdPFY9t+M4apXVSqzw9Y6XVhkdI6
YaVAeFlvGfm7b8ktLPBT
=CDMK
-----END PGP SIGNATURE-----
