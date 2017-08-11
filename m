Return-Path: <SRS0=SqLp=7N=collabora.com=thierry.escande@kernel.org>
From: Thierry Escande <thierry.escande@collabora.com>
To: Benson Leung <bleung@chromium.org>,
	Lee Jones <lee.jones@linaro.org>,
	Jonathan Cameron <jic23@kernel.org>
Cc: Joseph Lo <josephl@nvidia.com>,
	Gwendal Grignou <gwendal@chromium.org>,
	Douglas Anderson <dianders@chromium.org>,
	Daniel Hung-yu Wu <hywu@google.com>,
	Vincent Palatin <vpalatin@chromium.org>,
	Wei-Ning Huang <wnhuang@google.com>,
	linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org
Subject: [PATCH v2 5/8] mfd: cros_ec: fail early if we cannot identify the EC
Date: Fri, 11 Aug 2017 16:23:02 +0200
Message-Id: <1502461385-27564-6-git-send-email-thierry.escande@collabora.com>
In-Reply-To: <1502461385-27564-1-git-send-email-thierry.escande@collabora.com>
References: <1502461385-27564-1-git-send-email-thierry.escande@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset = "utf-8"
List-ID: <linux-iio@vger.kernel.org>

From: Vincent Palatin <vpalatin@chromium.org>

If we cannot communicate with the EC chip to detect the protocol version
and its features, it's very likely useless to continue. Else we will
commit all kind of uninformed mistakes (using the wrong protocol, the
wrong buffer size, mixing the EC with other chips).

Signed-off-by: Vincent Palatin <vpalatin@chromium.org>
Signed-off-by: Thierry Escande <thierry.escande@collabora.com>
Acked-by: Benson Leung <bleung@chromium.org>
---
 drivers/mfd/cros_ec.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/mfd/cros_ec.c b/drivers/mfd/cros_ec.c
index b0ca5a4c..c5528ae 100644
--- a/drivers/mfd/cros_ec.c
+++ b/drivers/mfd/cros_ec.c
@@ -112,7 +112,11 @@ int cros_ec_register(struct cros_ec_device *ec_dev)
 
 	mutex_init(&ec_dev->lock);
 
-	cros_ec_query_all(ec_dev);
+	err = cros_ec_query_all(ec_dev);
+	if (err) {
+		dev_err(dev, "Cannot identify the EC: error %d\n", err);
+		return err;
+	}
 
 	if (ec_dev->irq) {
 		err = request_threaded_irq(ec_dev->irq, NULL, ec_irq_thread,
-- 
2.7.4
