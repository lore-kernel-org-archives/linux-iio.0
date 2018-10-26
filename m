Return-Path: <SRS0=9Qln=NG=st.com=denis.ciocca@kernel.org>
From: Denis CIOCCA <denis.ciocca@st.com>
To: Martin Kelly <martin@martingkelly.com>,
        "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>
CC: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>,
        Jonathan Cameron
	<jic23@kernel.org>, Rob Herring <robh+dt@kernel.org>
Subject: RE: [PATCH v2 1/4] iio: magnetometer: add clarifying comment
Date: Fri, 26 Oct 2018 18:24:41 +0000
Message-ID: <405cfbe9c82c430682409372aaea4f21@SFHDAG2NODE1.st.com>
References: <20181026023812.29720-1-martin@martingkelly.com>
In-Reply-To: <20181026023812.29720-1-martin@martingkelly.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

Hi Martin,

All the series [v2 / 4 patches] looks good to me. Thanks

Denis


-----Original Message-----
From: Martin Kelly <martin@martingkelly.com>=20
Sent: Thursday, October 25, 2018 7:38 PM
To: linux-iio@vger.kernel.org; devicetree@vger.kernel.org
Cc: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>; Denis CIOCCA <denis.ci=
occa@st.com>; Jonathan Cameron <jic23@kernel.org>; Rob Herring <robh+dt@ker=
nel.org>; Martin Kelly <martin@martingkelly.com>
Subject: [PATCH v2 1/4] iio: magnetometer: add clarifying comment

From: Martin Kelly <martin@martingkelly.com>

Add a comment clarifying better when to use <device_name> vs <device_name>-=
magn in compatibility strings.

Signed-off-by: Martin Kelly <martin@martingkelly.com>
---
 drivers/iio/magnetometer/st_magn_spi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iio/magnetometer/st_magn_spi.c b/drivers/iio/magnetome=
ter/st_magn_spi.c
index 7b7cd08fcc32..15bb09267098 100644
--- a/drivers/iio/magnetometer/st_magn_spi.c
+++ b/drivers/iio/magnetometer/st_magn_spi.c
@@ -23,6 +23,8 @@
  * For new single-chip sensors use <device_name> as compatible string.
  * For old single-chip devices keep <device_name>-magn to maintain
  * compatibility
+ * For multi-chip devices, use <device_name>-magn to distinguish which
+ * capability is being used
  */
 static const struct of_device_id st_magn_of_match[] =3D {
 	{
--
2.11.0
