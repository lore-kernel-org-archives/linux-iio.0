Return-Path: <octavian.purdila@intel.com>
From: Octavian Purdila <octavian.purdila@intel.com>
To: jic23@kernel.org
Cc: lars@metafoo.de,
	pmeerw@pmeerw.net,
	robert.moore@intel.com,
	rafael.j.wysocki@intel.com,
	lenb@kernel.org,
	linux-api@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	Octavian Purdila <octavian.purdila@intel.com>
Subject: [RFC PATCH 2/3] ACPICA: Add _PLD front and back panel constants
Date: Mon, 27 Apr 2015 18:01:47 +0300
Message-Id: <1430146908-27919-3-git-send-email-octavian.purdila@intel.com>
In-Reply-To: <1430146908-27919-1-git-send-email-octavian.purdila@intel.com>
References: <1430146908-27919-1-git-send-email-octavian.purdila@intel.com>
List-ID: <linux-iio@vger.kernel.org>

Signed-off-by: Octavian Purdila <octavian.purdila@intel.com>
---
 include/acpi/acbuffer.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/acpi/acbuffer.h b/include/acpi/acbuffer.h
index 6b040f4..2be0270 100644
--- a/include/acpi/acbuffer.h
+++ b/include/acpi/acbuffer.h
@@ -139,6 +139,11 @@ struct acpi_pld_info {
 	u16 horizontal_offset;
 };
 
+enum {
+	ACPI_PLD_PANEL_FRONT = 4,
+	ACPI_PLD_PANEL_BACK
+};
+
 /*
  * Macros to:
  *     1) Convert a _PLD buffer to internal struct acpi_pld_info format - ACPI_PLD_GET*
-- 
1.9.1
