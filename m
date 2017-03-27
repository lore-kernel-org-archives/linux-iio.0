Return-Path: <SRS0=6mYY=3E=axentia.se=peda@kernel.org>
From: Peter Rosin <peda@axentia.se>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: Peter Rosin <peda@axentia.se>, Wolfram Sang <wsa@the-dreams.de>, "Rob
 Herring" <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, "Jonathan
 Cameron" <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>, "Lars-Peter
 Clausen" <lars@metafoo.de>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Jonathan Corbet <corbet@lwn.net>, <linux-i2c@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-iio@vger.kernel.org>, <linux-doc@vger.kernel.org>, Andrew Morton
	<akpm@linux-foundation.org>, Colin Ian King <colin.king@canonical.com>, "Paul
 Gortmaker" <paul.gortmaker@windriver.com>
Subject: [PATCH v11 01/12] devres: trivial whitespace fix
Date: Mon, 27 Mar 2017 14:17:38 +0200
Message-ID: <1490617069-13119-2-git-send-email-peda@axentia.se>
In-Reply-To: <1490617069-13119-1-git-send-email-peda@axentia.se>
References: <1490617069-13119-1-git-send-email-peda@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

Everything else is indented with two spaces, so fix the odd one out.

Acked-by: Jonathan Cameron <jic23@kernel.org>
Signed-off-by: Peter Rosin <peda@axentia.se>
---
 Documentation/driver-model/devres.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/driver-model/devres.txt b/Documentation/driver-model/devres.txt
index bf34d5b3a733..efb8200819d6 100644
--- a/Documentation/driver-model/devres.txt
+++ b/Documentation/driver-model/devres.txt
@@ -335,7 +335,7 @@ MEM
   devm_kzalloc()
 
 MFD
- devm_mfd_add_devices()
+  devm_mfd_add_devices()
 
 PER-CPU MEM
   devm_alloc_percpu()
-- 
2.1.4
