Return-Path: <hns@goldelico.com>
From: "H. Nikolaus Schaller" <hns@goldelico.com>
To: Sebastian Reichel <sre@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Mark Rutland <mark.rutland@arm.com>,
	=?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>,
	Tony Lindgren <tony@atomide.com>,
	Russell King <linux@armlinux.org.uk>,
	Arnd Bergmann <arnd@arndb.de>,
	Michael Welling <mwelling@ieee.org>,
	=?UTF-8?q?Mika=20Penttil=C3=A4?= <mika.penttila@nextfour.com>,
	Javier Martinez Canillas <javier@osg.samsung.com>,
	Igor Grinberg <grinberg@compulab.co.il>,
	"Andrew F. Davis" <afd@ti.com>,
	Mark Brown <broonie@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	"H. Nikolaus Schaller" <hns@goldelico.com>,
	Alexander Stein <alexander.stein@systec-electronic.com>,
	Eric Engestrom <eric@engestrom.ch>,
	Hans de Goede <hdegoede@redhat.com>,
	Benjamin Tissoires <benjamin.tissoires@redhat.com>,
	Denis Carikli <denis@eukrea.com>,
	Petr Cvek <petr.cvek@tul.cz>
Cc: linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-omap@vger.kernel.org,
	letux-kernel@openphoenux.org,
	linux-iio@vger.kernel.org,
	kernel@pyra-handheld.com
Subject: [PATCH v8 6/8] dt-bindings: input: move ads7846 bindings to touchscreen subdirectory
Date: Tue, 22 Nov 2016 15:02:33 +0100
Message-Id: <cf15ffca0141acf56b737970eaccbfc52f5bbddb.1479823354.git.hns@goldelico.com>
In-Reply-To: <cover.1479823354.git.hns@goldelico.com>
References: <cover.1479823354.git.hns@goldelico.com>
In-Reply-To: <cover.1479823354.git.hns@goldelico.com>
References: <cover.1479823354.git.hns@goldelico.com>
List-ID: <linux-iio@vger.kernel.org>

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/input/{ => touchscreen}/ads7846.txt | 0
 1 file changed, 0 insertions(+), 0 deletions(-)
 rename Documentation/devicetree/bindings/input/{ => touchscreen}/ads7846.txt (100%)

diff --git a/Documentation/devicetree/bindings/input/ads7846.txt b/Documentation/devicetree/bindings/input/touchscreen/ads7846.txt
similarity index 100%
rename from Documentation/devicetree/bindings/input/ads7846.txt
rename to Documentation/devicetree/bindings/input/touchscreen/ads7846.txt
-- 
2.7.3
