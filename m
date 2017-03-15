Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:58673 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751866AbdCOK4c (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 15 Mar 2017 06:56:32 -0400
From: Quentin Schulz <quentin.schulz@free-electrons.com>
To: icenowy@aosc.xyz, bonbons@linux-vserver.org, sre@kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com, wens@csie.org,
        linux@armlinux.org.uk, maxime.ripard@free-electrons.com,
        jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, lee.jones@linaro.org
Cc: Quentin Schulz <quentin.schulz@free-electrons.com>,
        liam@networkimprov.net, thomas.petazzoni@free-electrons.com,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-iio@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: [PATCH v4 02/18] power: supply: power_supply_core: add constant-charge-current optional property
Date: Wed, 15 Mar 2017 11:55:21 +0100
Message-Id: <20170315105537.22349-3-quentin.schulz@free-electrons.com>
In-Reply-To: <20170315105537.22349-1-quentin.schulz@free-electrons.com>
References: <20170315105537.22349-1-quentin.schulz@free-electrons.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This adds the constant-charge-current property to the list of optional
properties for the battery.

The constant charge current is critical for batteries as they can't
handle all charge currents.

Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
---

v4:
 - switch from constant-charge-current-microamp to constant-charge-microamp,

added in v3

 drivers/power/supply/power_supply_core.c | 3 +++
 include/linux/power_supply.h             | 1 +
 2 files changed, 4 insertions(+)

diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/supply/power_supply_core.c
index ced8fef..5be5615 100644
--- a/drivers/power/supply/power_supply_core.c
+++ b/drivers/power/supply/power_supply_core.c
@@ -498,6 +498,7 @@ int power_supply_get_battery_info(struct power_supply *psy,
 	info->energy_full_design_uwh = -EINVAL;
 	info->charge_full_design_uah = -EINVAL;
 	info->voltage_min_design_uv  = -EINVAL;
+	info->constant_charge_ua  = -EINVAL;
 
 	if (!psy->of_node) {
 		dev_warn(&psy->dev, "%s currently only supports devicetree\n",
@@ -522,6 +523,8 @@ int power_supply_get_battery_info(struct power_supply *psy,
 			     &info->charge_full_design_uah);
 	of_property_read_u32(battery_np, "voltage-min-design-microvolt",
 			     &info->voltage_min_design_uv);
+	of_property_read_u32(battery_np, "constant-charge-microamp",
+			     &info->constant_charge_ua);
 
 	return 0;
 }
diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
index e84f1d3..13bff00 100644
--- a/include/linux/power_supply.h
+++ b/include/linux/power_supply.h
@@ -301,6 +301,7 @@ struct power_supply_battery_info {
 	int energy_full_design_uwh;	/* microWatt-hours */
 	int charge_full_design_uah;	/* microAmp-hours */
 	int voltage_min_design_uv;	/* microVolts */
+	int constant_charge_ua;		/* microAmps */
 };
 
 extern struct atomic_notifier_head power_supply_notifier;
-- 
2.9.3

