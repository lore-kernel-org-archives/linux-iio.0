Return-Path: <MAILER-DAEMON>
From: "Andrew F. Davis" <afd@ti.com>
To: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>,
        Mark
 Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>, Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>,
        Peter
 Meerwald <pmeerw@pmeerw.net>
CC: <devicetree@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <linux-api@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Andrew F.
 Davis" <afd@ti.com>
Subject: [PATCH v3 1/5] iio: Make IIO value formating function globally available.
Date: Mon, 14 Dec 2015 16:35:57 -0600
Message-ID: <1450132561-5245-2-git-send-email-afd@ti.com>
In-Reply-To: <1450132561-5245-1-git-send-email-afd@ti.com>
References: <1450132561-5245-1-git-send-email-afd@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

Make IIO value formating function globally available to allow IIO drivers
to output values as the core does.

Signed-off-by: Andrew F. Davis <afd@ti.com>
---
 drivers/iio/industrialio-core.c | 1 +
 include/linux/iio/iio.h         | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index 208358f..eb5909d 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -470,6 +470,7 @@ ssize_t iio_format_value(char *buf, unsigned int type, int size, int *vals)
 		return 0;
 	}
 }
+EXPORT_SYMBOL_GPL(iio_format_value);
 
 static ssize_t iio_read_channel_info(struct device *dev,
 				     struct device_attribute *attr,
diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
index 19c94c9..b589411 100644
--- a/include/linux/iio/iio.h
+++ b/include/linux/iio/iio.h
@@ -636,6 +636,8 @@ static inline struct dentry *iio_get_debugfs_dentry(struct iio_dev *indio_dev)
 }
 #endif
 
+ssize_t iio_format_value(char *buf, unsigned int type, int size, int *vals);
+
 int iio_str_to_fixpoint(const char *str, int fract_mult, int *integer,
 	int *fract);
 
-- 
2.6.4
