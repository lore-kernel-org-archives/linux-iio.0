Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga17.intel.com ([192.55.52.151]:61056 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751994AbeESNR4 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 19 May 2018 09:17:56 -0400
Date: Sat, 19 May 2018 21:16:55 +0800
From: kbuild test robot <fengguang.wu@intel.com>
To: William Breathitt Gray <vilhelm.gray@gmail.com>
Cc: kbuild-all@01.org, jic23@kernel.org, benjamin.gaignard@st.com,
        fabrice.gasnier@st.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [RFC PATCH] counter: 104-quad-8: quad8_ops can be static
Message-ID: <20180519131655.GA57734@ivb43>
References: <881ede525a87ef68fad76cc757ce0ba72df03e5a.1526487615.git.vilhelm.gray@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <881ede525a87ef68fad76cc757ce0ba72df03e5a.1526487615.git.vilhelm.gray@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


Fixes: b3822048aa0b ("counter: 104-quad-8: Add Generic Counter interface support")
Signed-off-by: kbuild test robot <fengguang.wu@intel.com>
---
 104-quad-8.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/counter/104-quad-8.c b/drivers/counter/104-quad-8.c
index 7c72fb7..8696a512 100644
--- a/drivers/counter/104-quad-8.c
+++ b/drivers/counter/104-quad-8.c
@@ -800,7 +800,7 @@ static int quad8_action_get(struct counter_device *counter,
 	return 0;
 }
 
-const struct counter_ops quad8_ops = {
+static const struct counter_ops quad8_ops = {
 	.signal_read = quad8_signal_read,
 	.count_read = quad8_count_read,
 	.count_write = quad8_count_write,
