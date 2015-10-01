Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.lobby.jabatus.fr ([109.234.163.68]:44668 "EHLO
	mail.lobby.jabatus.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756458AbbJAON7 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 1 Oct 2015 10:13:59 -0400
From: Ludovic Tancerel <ludovic.tancerel@maplehightech.com>
To: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
	pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
	William.Markezana@meas-spec.com
Cc: ludovic.tancerel@maplehightech.com
Subject: [PATCH v4 7/7] Typo correction in ms5611 Kconfig
Date: Thu,  1 Oct 2015 16:13:42 +0200
Message-Id: <1443708822-8580-8-git-send-email-ludovic.tancerel@maplehightech.com>
In-Reply-To: <1443708822-8580-1-git-send-email-ludovic.tancerel@maplehightech.com>
References: <1443708822-8580-1-git-send-email-ludovic.tancerel@maplehightech.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: Ludovic Tancerel <ludovic.tancerel@maplehightech.com>
---
 drivers/iio/pressure/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/pressure/Kconfig b/drivers/iio/pressure/Kconfig
index 01e0b6a..53f9a44 100644
--- a/drivers/iio/pressure/Kconfig
+++ b/drivers/iio/pressure/Kconfig
@@ -53,9 +53,9 @@ config MPL3115
           will be called mpl3115.
 
 config MS5611
-	tristate "Measurement Specialities MS5611 pressure sensor driver"
+	tristate "Measurement Specialties MS5611 pressure sensor driver"
 	help
-	  Say Y here to build support for the Measurement Specialities
+	  Say Y here to build support for the Measurement Specialties
 	  MS5611 pressure and temperature sensor.
 
 	  To compile this driver as a module, choose M here: the module will
-- 
2.3.7

