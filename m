Return-Path: <pmeerw@pmeerw.net>
From: Peter Meerwald <pmeerw@pmeerw.net>
To: linux-iio@vger.kernel.org
Cc: jic23@cam.ac.uk,
	Peter Meerwald <pmeerw@pmeerw.net>
Subject: [PATCH 5/7] iio staging: fix warning 'static but used in inline function'
Date: Mon, 25 Jun 2012 21:11:43 +0200
Message-Id: <1340651505-31081-5-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1340651505-31081-1-git-send-email-pmeerw@pmeerw.net>
References: <1340651505-31081-1-git-send-email-pmeerw@pmeerw.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

iio_utils.h:367:10: warning: =E2=80=98iioutils_break_up_name=E2=80=99 is =
static but used in inline function =E2=80=98build_channel_array=E2=80=99 =
which is not static [enabled by default]

Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
---
 drivers/staging/iio/Documentation/iio_utils.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/iio/Documentation/iio_utils.h b/drivers/stag=
ing/iio/Documentation/iio_utils.h
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
