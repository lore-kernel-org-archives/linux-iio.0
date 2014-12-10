Return-Path: <irina.tirdea@intel.com>
From: Irina Tirdea <irina.tirdea@intel.com>
To: Jonathan Cameron <jic23@kernel.org>,
	linux-iio@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Daniel Baluta <daniel.baluta@intel.com>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Irina Tirdea <irina.tirdea@intel.com>
Subject: [PATCH v2 2/4] iio: accel: kxcjk-1013: only set power state if CONFIG_PM is defined
Date: Wed, 10 Dec 2014 18:23:52 +0200
Message-Id: <1418228634-10505-3-git-send-email-irina.tirdea@intel.com>
In-Reply-To: <1418228634-10505-1-git-send-email-irina.tirdea@intel.com>
References: <1418228634-10505-1-git-send-email-irina.tirdea@intel.com>
List-ID: <linux-iio@vger.kernel.org>

When CONFIG_PM is not defined and the driver tries to power off the device,
kxcjk1013_set_power_state will call pm_runtime_put_autosuspend, which is
not implemented (wil return -ENOSYS).

Only call pm_runtime calls to change power state  when CONFIG_PM is defined.

Signed-off-by: Irina Tirdea <irina.tirdea@intel.com>
Reviewed-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/iio/accel/kxcjk-1013.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iio/accel/kxcjk-1013.c b/drivers/iio/accel/kxcjk-1013.c
index aed3777..7b0a9da 100644
--- a/drivers/iio/accel/kxcjk-1013.c
+++ b/drivers/iio/accel/kxcjk-1013.c
@@ -376,6 +376,7 @@ static int kxcjk1013_get_startup_times(struct kxcjk1013_data *data)
 
 static int kxcjk1013_set_power_state(struct kxcjk1013_data *data, bool on)
 {
+#ifdef CONFIG_PM
 	int ret;
 
 	if (on)
@@ -389,6 +390,7 @@ static int kxcjk1013_set_power_state(struct kxcjk1013_data *data, bool on)
 			"Failed: kxcjk1013_set_power_state for %d\n", on);
 		return ret;
 	}
+#endif
 
 	return 0;
 }
-- 
1.7.9.5
