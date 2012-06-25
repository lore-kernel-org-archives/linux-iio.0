Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([87.118.82.44]:55287 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756972Ab2FYVMT (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Mon, 25 Jun 2012 17:12:19 -0400
From: Peter Meerwald <pmeerw@pmeerw.net>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: linux-iio@vger.kernel.org, Peter Meerwald <pmeerw@pmeerw.net>
Subject: [PATCH 5/7] iio staging: fix warning 'static but used in inline function'
Date: Mon, 25 Jun 2012 23:12:15 +0200
Message-Id: <1340658737-5529-5-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1340658737-5529-1-git-send-email-pmeerw@pmeerw.net>
References: <1340658737-5529-1-git-send-email-pmeerw@pmeerw.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

iio_utils.h:367:10: warning: =E2=80=98iioutils_break_up_name=E2=80=99 i=
s static but used in inline function =E2=80=98build_channel_array=E2=80=
=99 which is not static [enabled by default]

Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
Acked-by: Jonathan Cameron <jic23@kernel.org>

---
 drivers/staging/iio/Documentation/iio_utils.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/iio/Documentation/iio_utils.h b/drivers/st=
aging/iio/Documentation/iio_utils.h
index d9439f8..9c7a5aa 100644
--- a/drivers/staging/iio/Documentation/iio_utils.h
+++ b/drivers/staging/iio/Documentation/iio_utils.h
@@ -27,7 +27,7 @@ const char *iio_dir =3D "/sys/bus/iio/devices/";
  * @full_name: the full channel name
  * @generic_name: the output generic channel name
  **/
-static int iioutils_break_up_name(const char *full_name,
+inline int iioutils_break_up_name(const char *full_name,
 				  char **generic_name)
 {
 	char *current;
--=20
1.7.9.5

