Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mx-out-2.rwth-aachen.de ([134.130.5.187]:53908 "EHLO
        mx-out-2.rwth-aachen.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S378409AbdEALUX (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 1 May 2017 07:20:23 -0400
From: =?UTF-8?q?Stefan=20Br=C3=BCns?= <stefan.bruens@rwth-aachen.de>
To: <linux-iio@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Marc Titinger <mtitinger@baylibre.com>,
        =?UTF-8?q?Stefan=20Br=C3=BCns?= <stefan.bruens@rwth-aachen.de>
Subject: [PATCH 1/2] iio: Documentation: Remove (partially) duplicate line
Date: Mon, 1 May 2017 13:19:41 +0200
In-Reply-To: <20170501111942.12736-1-stefan.bruens@rwth-aachen.de>
References: <20170501111942.12736-1-stefan.bruens@rwth-aachen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Message-ID: <075bf6a854ef42dda9078a575084ae72@rwthex-w2-b.rwth-ad.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: Stefan Brüns <stefan.bruens@rwth-aachen.de>
---
 Documentation/ABI/testing/sysfs-bus-iio-meas-spec | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio-meas-spec b/Documentation/ABI/testing/sysfs-bus-iio-meas-spec
index 1a6265e92e2f..6d47e548eee5 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio-meas-spec
+++ b/Documentation/ABI/testing/sysfs-bus-iio-meas-spec
@@ -5,4 +5,3 @@ Description:
                 Reading returns either '1' or '0'. '1' means that the
                 battery level supplied to sensor is below 2.25V.
                 This ABI is available for tsys02d, htu21, ms8607
-		This ABI is available for htu21, ms8607
-- 
2.12.2

