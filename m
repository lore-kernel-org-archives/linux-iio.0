Return-Path: <ldewangan@nvidia.com>
From: Laxman Dewangan <ldewangan@nvidia.com>
To: <jic23@kernel.org>, <corbet@lwn.net>, <knaack.h@gmx.de>,
	<lars@metafoo.de>, <pmeerw@pmeerw.net>
CC: <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-iio@vger.kernel.org>, Laxman Dewangan <ldewangan@nvidia.com>
Subject: [PATCH 3/3] iio: Add resource managed APIs devm_iio_channel_{get,release) in devres
Date: Wed, 6 Apr 2016 16:01:08 +0530
Message-ID: <1459938668-9180-3-git-send-email-ldewangan@nvidia.com>
In-Reply-To: <1459938668-9180-1-git-send-email-ldewangan@nvidia.com>
References: <1459938668-9180-1-git-send-email-ldewangan@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

Add following APIs in the list of managed resources of IIO:
	devm_iio_channel_get()
	devm_iio_channel_get_all()
	devm_iio_channel_release()
	devm_iio_channel_release_all()

Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
---
 Documentation/driver-model/devres.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/driver-model/devres.txt b/Documentation/driver-model/devres.txt
index 73b98df..bdc2dfb 100644
--- a/Documentation/driver-model/devres.txt
+++ b/Documentation/driver-model/devres.txt
@@ -267,6 +267,10 @@ IIO
   devm_iio_kfifo_free()
   devm_iio_trigger_alloc()
   devm_iio_trigger_free()
+  devm_iio_channel_get()
+  devm_iio_channel_release()
+  devm_iio_channel_get_all()
+  devm_iio_channel_release_all()
 
 IO region
   devm_release_mem_region()
-- 
2.1.4
