Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:54191 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754344AbdLDOPI (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 4 Dec 2017 09:15:08 -0500
From: Quentin Schulz <quentin.schulz@free-electrons.com>
To: sre@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        wens@csie.org, linux@armlinux.org.uk,
        maxime.ripard@free-electrons.com, jic23@kernel.org,
        lee.jones@linaro.org
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-iio@vger.kernel.org, icenowy@aosc.io,
        linux-sunxi@googlegroups.com, thomas.petazzoni@free-electrons.com,
        Quentin Schulz <quentin.schulz@free-electrons.com>
Subject: [PATCH 6/8] mfd: axp20x: add battery power supply cell for AXP813
Date: Mon,  4 Dec 2017 15:12:52 +0100
Message-Id: <9b5e9ed623165d0586f086343a7c67bc5c18bbb5.1512396054.git-series.quentin.schulz@free-electrons.com>
In-Reply-To: <cover.4052f8c517c42db26a3cabe078cad333243d371c.1512396054.git-series.quentin.schulz@free-electrons.com>
References: <cover.4052f8c517c42db26a3cabe078cad333243d371c.1512396054.git-series.quentin.schulz@free-electrons.com>
In-Reply-To: <cover.4052f8c517c42db26a3cabe078cad333243d371c.1512396054.git-series.quentin.schulz@free-electrons.com>
References: <cover.4052f8c517c42db26a3cabe078cad333243d371c.1512396054.git-series.quentin.schulz@free-electrons.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

As axp20x-battery-power-supply now supports AXP813, add a cell for it.

Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
---
 drivers/mfd/axp20x.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
index 42e54d1..7566358 100644
--- a/drivers/mfd/axp20x.c
+++ b/drivers/mfd/axp20x.c
@@ -880,6 +880,9 @@ static struct mfd_cell axp813_cells[] = {
 		.name			= "axp20x-regulator",
 	}, {
 		.name			= "axp813-adc",
+	}, {
+		.name			= "axp20x-battery-power-supply",
+		.of_compatible		= "x-powers,axp813-battery-power-supply",
 	},
 };
 
-- 
git-series 0.9.1
