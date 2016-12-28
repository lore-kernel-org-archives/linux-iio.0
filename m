Return-Path: <SRS0=VrEV=YL=goldelico.com=hns@kernel.org>
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
	Petr Cvek <petr.cvek@tul.cz>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Hans Verkuil <hans.verkuil@cisco.com>,
	Nick Dyer <nick@shmanahar.org>,
	Siebren Vroegindeweij <siebren.vroegindeweij@hotmail.com>,
	Michel Verlaan <michel.verl@gmail.com>
Cc: linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-omap@vger.kernel.org,
	letux-kernel@openphoenux.org,
	linux-iio@vger.kernel.org,
	kernel@pyra-handheld.com
Subject: [PATCH v9 5/8] dt-bindings: input: move ads7846 bindings to touchscreen subdirectory
Date: Wed, 28 Dec 2016 15:53:20 +0100
Message-Id: <07298be658b70f006e6598e7888dd5b5f304f65c.1482936802.git.hns@goldelico.com>
In-Reply-To: <cover.1482936802.git.hns@goldelico.com>
References: <cover.1482936802.git.hns@goldelico.com>
In-Reply-To: <cover.1482936802.git.hns@goldelico.com>
References: <cover.1482936802.git.hns@goldelico.com>
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
