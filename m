Return-Path: <hns@goldelico.com>
Subject: [PATCH v2 3/3] ARM: dts: omap5-uevm: enable iio gpadc for Palmas
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=us-ascii
From: H. Nikolaus Schaller <hns@goldelico.com>
In-Reply-To: <cover.1443973837.git.hns@goldelico.com>
Date: Sun, 4 Oct 2015 18:06:04 +0200
Cc: devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 linux-omap@vger.kernel.org,
 linux-iio@vger.kernel.org,
 Grazvydas Ignotas <notasas@gmail.com>
Message-Id: <15F7F07E-DD62-40D3-B481-B56E729FDC5D@goldelico.com>
References: <86F849CB-1A50-4BEB-99C6-79FF97971DCB@goldelico.com> <cover.1443973837.git.hns@goldelico.com>
To: Rob Herring <robh+dt@kernel.org>,
 Pawel Moll <pawel.moll@arm.com>,
 Mark Rutland <mark.rutland@arm.com>,
 Ian Campbell <ijc+devicetree@hellion.org.uk>,
 Kumar Gala <galak@codeaurora.org>,
 =?iso-8859-1?Q?Beno=EEt_Cousson?= <bcousson@baylibre.com>,
 Tony Lindgren <tony@atomide.com>,
 Russell King <linux@arm.linux.org.uk>,
 Marek Belisko <marek@goldelico.com>,
 Pradeep Goudagunta <pgoudagunta@nvidia.com>,
 Nikolaus Schaller <hns@goldelico.com>,
 Laxman Dewangan <ldewangan@nvidia.com>,
 gg@slimlogic.co.uk,
 jic23@jic23.retrosnub.co.uk
List-ID: <linux-iio@vger.kernel.org>

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
arch/arm/boot/dts/omap5-uevm.dts | 9 +++++++++
1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/omap5-uevm.dts =
b/arch/arm/boot/dts/omap5-uevm.dts
index 3b16e8f..c78ee2f 100644
--- a/arch/arm/boot/dts/omap5-uevm.dts
+++ b/arch/arm/boot/dts/omap5-uevm.dts
@@ -342,6 +342,15 @@

			ti,ldo6-vibrator;

+			gpadc {
+				compatible =3D "ti,palmas-gpadc";
+				interrupts =3D <18 0
+					      16 0
+					      17 0>;
+				ti,channel0-current-microamp =3D <5>;
+				ti,channel3-current-microamp =3D <10>;
+			};
+
			regulators {
				smps123_reg: smps123 {
					/* VDD_OPP_MPU */
--=20
2.5.1
