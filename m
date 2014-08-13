Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wi0-f180.google.com ([209.85.212.180]:39264 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751024AbaHMMBD (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 13 Aug 2014 08:01:03 -0400
Received: by mail-wi0-f180.google.com with SMTP id n3so667268wiv.13
        for <linux-iio@vger.kernel.org>; Wed, 13 Aug 2014 05:01:02 -0700 (PDT)
From: Michal Simek <michal.simek@xilinx.com>
To: linux-kernel@vger.kernel.org, monstr@monstr.eu
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH] iio: adc: xilinx: Remove .owner field for driver
Date: Wed, 13 Aug 2014 14:00:59 +0200
Message-Id: <32522124850adfda5c6cb8a7759d0e3a63893c1e.1407931250.git.michal.simek@xilinx.com>
Content-Type: multipart/signed;
    boundary="=_mimegpg-monstr-desktop-20897-1407931259-0001";
    micalg=pgp-sha1; protocol="application/pgp-signature"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This is a MIME GnuPG-signed message.  If you see this text, it means that
your E-mail or Usenet software does not support MIME signed messages.
The Internet standard for MIME PGP messages, RFC 2015, was published in 1996.
To open this message correctly you will need to install E-mail or Usenet
software that supports modern Internet standards.

--=_mimegpg-monstr-desktop-20897-1407931259-0001

There is no need to init .owner field.

Based on the patch from Peter Griffin <peter.griffin@linaro.org>
"mmc: remove .owner field for drivers using module_platform_driver"

This patch removes the superflous .owner field for drivers which
use the module_platform_driver API, as this is overriden in
platform_driver_register anyway."

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

 drivers/iio/adc/xilinx-xadc-core.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/iio/adc/xilinx-xadc-core.c b/drivers/iio/adc/xilinx-xadc-core.c
index fd2745c62943..92541a80b041 100644
--- a/drivers/iio/adc/xilinx-xadc-core.c
+++ b/drivers/iio/adc/xilinx-xadc-core.c
@@ -1322,7 +1322,6 @@ static struct platform_driver xadc_driver = {
 	.remove = xadc_remove,
 	.driver = {
 		.name = "xadc",
-		.owner = THIS_MODULE,
 		.of_match_table = xadc_of_match_table,
 	},
 };
--
1.8.2.3


--=_mimegpg-monstr-desktop-20897-1407931259-0001
Content-Type: application/pgp-signature
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAlPrU3sACgkQykllyylKDCEIGACfcbsSTD+c9C2fS97b+98ozBgo
a+QAn3vtUNbvXIatTNkseAOjThunRf/1
=WAD4
-----END PGP SIGNATURE-----

--=_mimegpg-monstr-desktop-20897-1407931259-0001--
